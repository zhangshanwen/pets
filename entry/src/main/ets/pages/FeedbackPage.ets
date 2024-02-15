import { pickPhoto } from '../utils/media'
import router from '@ohos.router'
import { getMediaIds, uploadByAli } from '../api/media'
import { DialogShow } from '../utils/dialog'
import { feedbackCreate } from '../api/feedback'
import { getFileSteam } from '../utils/file'

@Entry
@Component
struct FeedbackPage {
  controller: TextAreaController = new TextAreaController()
  @State text: string = ''
  @State imagesColumn: Array<string> = ["add"]
  @State imagesIndex: number = 0
  @State imagesMaxLength: number = 3

  build() {
    Column() {

      Row() {
        Image($r('app.media.ic_back'))
          .width('24vp')
          .height('24vp')
          .margin({
            left: '24vp',
            right: '16vp'
          })
          .onClick(() => {
            router.back();
          })
        Blank()
        Button("保存", { type: ButtonType.Capsule, stateEffect: true }).onClick(async () => {
          if (!this.text) {
            DialogShow("错误", "请输入反馈内容")
            return
          }
          var uriArr = this.imagesColumn.filter((item) => item != "add")
          let file_ids: Array<any>;
          if (uriArr.length > 0) {
            const resp = await  getMediaIds({ num: uriArr.length, bucket_type: 0 })
            file_ids = resp.data.list
            for (let i = 0; i < resp.data.list.length; i++) {
              await uploadByAli(resp.data.list[i].upload_url, getFileSteam(uriArr[i]))
            }
          }
          await feedbackCreate({ content: this.text, file_ids: file_ids })
          router.back()
        })
      }.width("100%").height("10%")

      TextArea({ text: this.text, placeholder: "请输入您宝贵的反馈或者建议", controller: this.controller })
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: 14 })
        .caretColor(Color.Blue)
        .fontSize(14)
        .margin({ top: "20vp" })
        .fontColor(Color.Black)
        .onChange((value: string) => {
          this.text = value
        })
      Column({ space: 5 }) {
        Grid() {
          ForEach(this.imagesColumn, (imageUri) => {
            GridItem() {
              if (imageUri === "add") {
                Column() {
                  Image($r("app.media.plus_icon")).width("30vp").height("30vp").opacity(0.1)
                }

                .onClick(async () => {
                  this.imagesColumn = []
                  await pickPhoto(this.imagesMaxLength).then(res => {
                    for (let i = 0; i < res.photoUris.length; i++) {
                      this.imagesColumn.push(res.photoUris[i])
                    }
                    if (res.photoUris.length < this.imagesMaxLength) {
                      this.imagesColumn.push("add")
                    }
                  }).catch(() => {
                  })
                })
              } else {
                Image(imageUri)
              }
            }.width("100vp").height("100vp").backgroundColor("#99182431")
          }
          )
        }.columnsTemplate('1fr 1fr 1fr').columnsGap(10)
        .rowsGap(10).margin({ top: "10vp", left: "10vp", right: "10vp" })
      }.margin({ top: "20vp" })
    }
  }
}
