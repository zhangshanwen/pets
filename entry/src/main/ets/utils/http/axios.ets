import axios from '@ohos/axios'
import { AxiosResponse, InternalAxiosRequestConfig, AxiosError } from '@ohos/axios'

import router from '@ohos.router';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { getAuthorization, saveAuthorization } from '../user';

const instance = axios.create({
  baseURL: "http://192.168.1.3:17017/api/"
});


instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  // 对请求数据做点什么
  let token = getAuthorization();
  if (token) {
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
instance.interceptors.response.use( (res: AxiosResponse) => {
  console.log("返回响应", JSON.stringify(res.data))
  // console.log("返回响应请求", JSON.stringify(res.request))
  if (res.status === 200) {
    // 获取返回数据,将返回的json数据解析成事先预定好的响应格式
    // 这里建议和后端的保持一致
    if (res.data.code == -1) {
      // 登录检验失败,删除登录态
      // TODO 使用freshToken 重新刷新
      router.pushUrl({
        url: CommonConstants.LOGIN_PAGE_URL
      })
    } else if (res.data.code == 1) {
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