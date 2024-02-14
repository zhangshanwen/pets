import router from '@ohos.router'
import { DialogShow } from '../utils/dialog'
import { feedbackDelete, feedbackInfo } from '../api/feedback'

@Entry
@Component
struct FeedInfoPage {
  @State infoId: number = 0
  @State content: string = ''
  @State medias: Array<string> = []

  onPageShow() {
    const param = router.getParams()
    if (!param) {
      DialogShow("错误", "请求异常")
      setTimeout(() => {
        router.back()
      }, 500)
    }
    this.infoId = param["infoId"]
    this.loadData()
  }

  loadData() {
    feedbackInfo(this.infoId).then((res) => {
      this.content = res.data.content
      this.medias = res.data.medias
    })
  }

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
        Button("删除", { type: ButtonType.Capsule, stateEffect: true }).onClick(async () => {
          await  feedbackDelete(this.infoId)
          router.back()
        })
      }.width("100%").height("10%")

      Text(this.content).margin({ top: "10vp" })

      Column({ space: 5 }) {
        Grid() {
          ForEach(this.medias, (imageUri) => {
            GridItem() {
              Image(imageUri)
            }.width("100vp").height("100vp").backgroundColor("#99182431")
          }
          )
        }.columnsTemplate('1fr 1fr 1fr').columnsGap(10)
        .rowsGap(10).margin({ top: "10vp", left: "10vp", right: "10vp" })
      }.margin({ top: "20vp" }).height("30%")

    }
  }
}
