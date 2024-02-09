import { FormData, AxiosResponse, AxiosProgressEvent, AxiosError } from '@ohos/axios'
import { copyUrisFileToInternalUri } from '../utils/file';
import instance from '../utils/http/axios';

export function upload(url, fileName: string) {
  let fd = new FormData()
  fd.append("file", `internal://cache/${fileName}`)
  return instance.post(url, fd, {
    headers: { 'Content-Type': 'multipart/form-data' },
    context: getContext(this),
    onUploadProgress: (progressEvent: AxiosProgressEvent): void => {
      // console.info(progressEvent && progressEvent.loaded && progressEvent.total ? Math.ceil(progressEvent.loaded / progressEvent.total * 100) + '%' : '0%');
    },
  })
}

export async function uploadFiles(url, uriArr: Array<string>, fileIds: Array<string>) {

  copyUrisFileToInternalUri(uriArr, fileIds)
  let fd = new FormData()

  for (let i = 0; i < fileIds.length; i++) {
    fd.append("files", `internal://cache/${fileIds[i]}`)
  }
  return instance.post(url, fd, {
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

export function uploadMedia(uriArr: Array<string>, fileIds: Array<string>) {
  return uploadFiles("v1/media", uriArr, fileIds)
}