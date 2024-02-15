import fs from '@ohos.file.fs';
import common from '@ohos.app.ability.common';

export function readFile(filename: string): string {
  let context = getContext(this) as common.UIAbilityContext;
  let filesDir = context.filesDir;
  let file = fs.openSync(filesDir + "/" + filename, fs.OpenMode.READ_ONLY | fs.OpenMode.CREATE);
  let stat = fs.statSync(file.fd);
  let buf = new ArrayBuffer(stat.size);
  let readLen = fs.readSync(file.fd, buf);
  // 关闭文件
  fs.closeSync(file);
  return String.fromCharCode.apply(null, new Uint8Array(buf.slice(0, readLen)))
}


export function copyUriFileToInternalUri(uri: string, fileId: string) {
  let context = getContext(this) as common.UIAbilityContext;
  var file = fs.openSync(uri, fs.OpenMode.READ_ONLY);
  const filePath = context.cacheDir + "/" + fileId
  fs.copyFileSync(file.fd, filePath)
  return
}


export function getFileSteam(uri: string) {
  var file = fs.openSync(uri, fs.OpenMode.READ_ONLY);
  let stat = fs.statSync(file.fd);
  let buf = new ArrayBuffer(stat.size);
  fs.readSync(file.fd, buf)
  return buf
}

export function copyUrisFileToInternalUri(uris: Array<string>, fileIds: Array<string>) {
  let context = getContext(this) as common.UIAbilityContext;
  for (let i = 0; i < uris.length; i++) {
    var file = fs.openSync(uris[i], fs.OpenMode.READ_ONLY);
    const filePath = context.cacheDir + "/" + fileIds[i]
    fs.copyFileSync(file.fd, filePath)
  }

  return
}


export function writeFile(filename: string, content: string) {
  let context = getContext(this) as common.UIAbilityContext;
  let filesDir = context.filesDir;
  let file = fs.openSync(filesDir + "/" + filename, fs.OpenMode.WRITE_ONLY | fs.OpenMode.CREATE)
  fs.writeSync(file.fd, content, { offset: 0 });
  fs.closeSync(file);
}

export function removeFile(filename: string) {
  let context = getContext(this) as common.UIAbilityContext;
  let filesDir = context.filesDir;
  fs.rmdirSync(filesDir + "/" + filename)
}
