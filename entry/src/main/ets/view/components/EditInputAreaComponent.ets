@Component
export struct EditInputAreaComponent {
  @Prop text: string
  @Prop placeholder: string
  @Link value: string
  @State isEdit: boolean = false
  controller: TextAreaController = new TextAreaController()

  build() {

    Row() {
      Text() {
        Span(this.text)
      }.width("30%").direction(Direction.Ltr)

      Row() {
        TextArea({
          text: this.value,
          placeholder: this.placeholder,
          controller: this.controller
        })
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14})
          .caretColor(Color.Blue)
          .fontSize(14)
          .fontColor(Color.Black)
          .onChange((value: string) => {
            this.value = value
          })
      }.width("70%").direction(Direction.Rtl)
    }.margin({ top: '10vp' })
  }
}