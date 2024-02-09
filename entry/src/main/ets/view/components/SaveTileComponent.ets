import router from '@ohos.router'

@Component
export struct SaveTitleComponent {
  @Prop title: string
  clickFunc: Function

  build() {
    Row() {
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
        Text(this.title)
          .fontSize('20fp')
          .fontColor('#182431')
          .fontWeight(500)
      }.width("80%")

      Blank()
      Row() {
        Button("保存", { type: ButtonType.Capsule, stateEffect: true }).onClick(() => {
          this.clickFunc()
        })
      }.width("20%")
    }.height("15%")
  }
}