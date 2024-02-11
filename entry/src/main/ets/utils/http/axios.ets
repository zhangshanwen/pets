import axios from '@ohos/axios'
import { AxiosResponse, InternalAxiosRequestConfig, AxiosError } from '@ohos/axios'

import router from '@ohos.router';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { getAuthorization, getRefreshToken, saveAuthorization } from '../user';

const refreshUri = "v1/user/refresh"
const instance = axios.create({
  baseURL: "http://192.168.1.3:17017/api/"
});


instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  // 对请求数据做点什么
  let token = getAuthorization();
  if (!config.headers["Authorization"] && token) {
    config.headers["Authorization"] = token
    if (!config.headers['Content-Type']) {
      if (["post", "put"].lastIndexOf(config.method) >= 0) {
        config.headers['Content-Type'] = 'application/json'
      }
    }
  }
  return config;
}, (error: AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error);
});
// 添加响应拦截器
instance.interceptors.response.use(async (res: AxiosResponse) => {
  console.log(`${res.config.url} 返回响应:${res.status}`, JSON.stringify(res.data))
  if (res.status === 200) {
    // 获取返回数据,将返回的json数据解析成事先预定好的响应格式
    // 这里建议和后端的保持一致
    if (res.data.code == -1) {
      if (res.config.url === refreshUri) {
        return
      }
      var newRes ;
      // 登录检验失败,删除登录态
      await instance.get(refreshUri, { headers: { 'refresh_token': getRefreshToken() } }).then((refreshRes) => {
        saveAuthorization(refreshRes.data.authorization, refreshRes.data.refresh_token)
        newRes =  instance.request(res.config)
      }).catch(() => {
        router.pushUrl({
          url: CommonConstants.LOGIN_PAGE_URL
        })
      })
      return newRes
    } else if (res.data.code == 1) {
      if (res.config.url === refreshUri) {
        return
      }
      showTip(res.data.msg)
      throw new Error(res.data.msg)
    }
    return res.data
  } else {
    showTip("系统错误")
    throw new Error('系统错误');
  }
  return res.data;
}, (error: AxiosError) => {
  // 对响应错误做点什么
  console.log(`${error.message}${error.request.config.url}`,"---------AxiosError--------")

  showTip("系统错误")
  return Promise.reject(error);
});

export default instance;

function showTip(msg: string) {
  AlertDialog.show({
    title: msg,
    message: '',
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 3,
    confirm: {
      value: '确认',
      action: () => {
      }
    },
  })
}