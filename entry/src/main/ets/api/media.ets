import axios from '@ohos/axios'
import instance from '../utils/http/axios';


export function getMediaIds(params: {
  num: number,
  bucket_type: number
}) {
  // bucket_type 0 media 1 用户头像 2 宠物头像
  return instance.get("v1/media/ids", { params })
}


export function uploadByAli(url: string, file) {
  const config = {
    headers: {
      'Content-Type': 'application/octet-stream'
    }
  };
  return axios.put(url, file, config)


}