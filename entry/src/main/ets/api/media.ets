import { FormData, AxiosResponse, AxiosProgressEvent, AxiosError } from '@ohos/axios'
import instance from '../utils/http/axios';

export function upload(uri, fileName: string) {
  let fd = new FormData()
  fd.append("file", `internal://cache/${fileName}`)
  return instance.post(uri, fd, {
    headers: { 'Content-Type': 'multipart/form-data' },
    context: getContext(this),
    onUploadProgress: (progressEvent: AxiosProgressEvent): void => {
      // console.info(progressEvent && progressEvent.loaded && progressEvent.total ? Math.ceil(progressEvent.loaded / progressEvent.total * 100) + '%' : '0%');
    },
  })
}

export function getMediaIds(params: { num: number }) {
  return instance.get("v1/media/ids", { params })
}