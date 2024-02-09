@Component
export struct EditDateComponent {
  @Prop text: string
  @Prop placeholder: string
  @Link value: string
  selectedDate: Date = new Date()
  @State isEdit: boolean = false

  build() {

    Row() {
      Text() {
        Span(this.text)
      }.width("30%")

      Row() {
        Text() {
          Span(this.value == "" ? `${this.placeholder}` : this.value)
        }.fontSize(14)
        .fontColor(Color.Black).onClick(() => {
          DatePickerDialog.show({
            start: new Date("2000-1-1"),
            end: new Date("2100-12-31"),
            selected: this.selectedDate,
            lunar: false,
            onAccept: (value: DatePickerResult) => {
              this.selectedDate.setFullYear(value.year, value.month, value.day)
              console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
            },
            onCancel: () => {
              console.info("DatePickerDialog:onCancel()")
            },
            onChange: (value: DatePickerResult) => {
              console.info("DatePickerDialog:onChange()" + JSON.stringify(value))
            }
          })
        })
      }.width("70%")
    }.margin({ top: '10vp' })
  }
}