import http from '@ohos.net.http';
import { PetListParam } from '../common/param/PetParam';
//导入封装好的请求
import  instance from '../utils/http/axios'


export function petList(params: PetListParam) {
  return instance.get(`v1/pet`, { params })
}

export function petCreate(data: {
  page_index: number,
  page_size: number,
  nick_name: string
}) {
  return instance.post(`v1/pet`,  data)
}