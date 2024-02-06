import { getAuthorization } from '../utils/user';
import common from '@ohos.app.ability.common';
import request from '@ohos.request';
import fs from '@ohos.file.fs';
import instance from '../utils/http/axios';

export function mediaUpload(fileName: string, fileType: string) {
  // 获取应用文件路径
  let context = getContext(this) as common.UIAbilityContext;
  let cacheDir = context.cacheDir;
  // 新建一个本地应用文件
  let file = fs.openSync(cacheDir + '/test.txt', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
  fs.writeSync(file.fd, 'upload file test');
  fs.closeSync(file);
  // 上传任务配置项
  let uploadConfig = {
    url: 'http://192.168.1.3:17017/api/v1/media',
    header: { Authorization: getAuthorization() },
    method: 'POST',
    files: [
      { filename: fileName, name:fileName, uri: `internal://cache/${fileName}`, type: fileType }
    ],
    data: []
  }

  request.uploadFile(context, uploadConfig)
    .then((uploadTask) => {
      console.log(`${uploadTask}`,"-----------uploadTask---------")
    })
}

export function getMediaIds(params: { num: number }) {
  return instance.get(`v1/media/ids`, { params })
}



