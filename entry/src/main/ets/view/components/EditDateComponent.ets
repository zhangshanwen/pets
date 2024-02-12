import { formatBirthDate } from '../../utils/format'

@Component
export struct EditDateComponent {
  @Prop text: string
  @Prop placeholder: string
  @Link value: number
  selectedDate: Date = new Date()
  @State isEdit: boolean = false

  build() {

    Row() {
      Text() {
        Span(this.text)
      }.width("30%")

      Row() {
        Text() {
          Span(this.value == 0 ? `${this.placeholder}` : formatBirthDate(this.value))
        }.fontSize(14)
        .fontColor(Color.Black).onClick(() => {
          DatePickerDialog.show({
            end: new Date(),
            selected: this.selectedDate,
            lunar: false,
            onAccept: (value: DatePickerResult) => {
              this.selectedDate.setFullYear(value.year, value.month, value.day)
              console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
              this.value = parseInt((this.selectedDate.getTime() / 1000).toString())
            }
          })
        })
      }.width("70%")
    }.margin({ top: '10vp' })
  }
}