@Component
export struct SelectComponent {
  @Prop text: string
  @Prop placeholder: string
  @Link selectOptions: Array<SelectOption>
  @Link selectIndex: number

  build() {

    Row() {
      Text() {
        Span(this.text)
      }.width("30%")

      Row() {
        Select(this.selectOptions)
          .value(this.placeholder)
          .fontColor('#182431')
          .onSelect((index: number) => {
            this.selectIndex = index

          })
      }.width("70%")
    }
  }
}