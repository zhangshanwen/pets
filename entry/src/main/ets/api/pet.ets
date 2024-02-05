import http from '@ohos.net.http';
import { PetListParam } from '../common/param/PetParam';
//导入封装好的请求
import { request } from '../utils/http/request'


export function petList(data: PetListParam) {
  return request(`v1/pet`, http.RequestMethod.GET, data)
}

export function petCreate(data: {
  page_index: number,
  page_size: number,
  nick_name: string
}) {
  return request(`v1/pet`, http.RequestMethod.POST, data)
}