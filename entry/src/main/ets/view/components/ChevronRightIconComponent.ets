@Component
export struct ChevronRightIconComponent {
  build() {
    Image($r('app.media.chevron_right_icon'))
      .width('24vp')
      .height('24vp')
  }
}