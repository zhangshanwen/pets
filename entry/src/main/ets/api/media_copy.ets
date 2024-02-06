import { FormData, AxiosResponse, AxiosProgressEvent, AxiosError } from '@ohos/axios'
import instance from '../utils/http/axios';

export function upload(fileId: string) {
  let fd = new FormData()
  fd.append("file", `internal://cache/` + fileId)
  instance.post("v1/media", fd, {
    headers: { 'Content-Type': 'multipart/form-data' },
    context: getContext(this),
    onUploadProgress: (progressEvent: AxiosProgressEvent): void => {
      // console.info(progressEvent && progressEvent.loaded && progressEvent.total ? Math.ceil(progressEvent.loaded / progressEvent.total * 100) + '%' : '0%');
    },
  })
}