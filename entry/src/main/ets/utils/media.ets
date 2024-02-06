import picker from '@ohos.file.picker';

export function pickPhoto(maxNumber: number) {
  let options = new picker.PhotoSelectOptions();
  options.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
  options.maxSelectNumber = maxNumber;
  let photoPicker = new picker.PhotoViewPicker();
  return photoPicker.select(options)
}