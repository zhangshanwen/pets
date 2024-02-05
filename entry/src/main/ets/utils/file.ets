import fs from '@ohos.file.fs';
import common from '@ohos.app.ability.common';

export function readFile(filename: string): string {
  let context = getContext(this) as common.UIAbilityContext;
  let filesDir = context.filesDir;
  let file = fs.openSync(filesDir + "/" + filename, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
  // 写入一段内容至文件
  // 从文件读取一段内容
  let buf = new ArrayBuffer(1024);
  let readLen = fs.readSync(file.fd, buf, { offset: 0 });
  // 关闭文件
  fs.closeSync(file);
  return String.fromCharCode.apply(null, new Uint8Array(buf.slice(0, readLen)))
}


export function writeFile(filename: string, content: string) {
  // 新建并打开文件
  let context = getContext(this) as common.UIAbilityContext;
  let filesDir = context.filesDir;
  let file = fs.openSync(filesDir + "/" + filename, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
  fs.writeSync(file.fd, content);
  // 关闭文件
  fs.closeSync(file);
}