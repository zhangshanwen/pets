import axios from '@ohos/axios'
import { AxiosResponse, InternalAxiosRequestConfig, AxiosError } from '@ohos/axios'

import router from '@ohos.router';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { getAuthorization } from '../user';

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
instance.interceptors.response.use((res: AxiosResponse) => {
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
      throw new Error(res.data.msg)
    }

    return res.data
  } else {
    throw new Error('系统错误');
  }
  console.log(`res==========>${res}`)
  // 对响应数据做点什么
  return res.data;
}, (error: AxiosError) => {
  // 对响应错误做点什么
  AlertDialog.show({
    title: '系统错误',
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
  return Promise.reject(error);
});

export default instance;
