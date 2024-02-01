import http from '@ohos.net.http';
//导入封装好的请求
import { request } from '../utils/http/request'

export function msgSend(data: { phone_number: string }) {
  return request(`v1/sms/send`, http.RequestMethod.POST, data)
}