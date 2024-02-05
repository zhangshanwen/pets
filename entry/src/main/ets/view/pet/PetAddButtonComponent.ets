@Component
export struct PetAddButtonComponent {
  build() {
    Column() {
      Image($r('app.media.plus_icon')).height('50vp').height('50vp').opacity(0.5)
    }

  }
}