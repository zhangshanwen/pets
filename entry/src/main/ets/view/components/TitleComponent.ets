import router from '@ohos.router';

@Component
export struct TitleComponent {
  @Prop title: string

  build() {
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
    }
    .width('100%')
    .height('56vp')
  }
}