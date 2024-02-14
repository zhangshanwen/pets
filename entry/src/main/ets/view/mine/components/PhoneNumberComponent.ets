import { UserInfo } from '../../../common/bean/ListItemData'

@Component
export struct PhoneNumberComponent {
  @Consume user: UserInfo

  build() {

    Row() {
      Text() {
        Span('手机号')
      }.width("70%")
      Text() {
        Span(this.user.phone_number)
      }.width("30%")
    }.height("100%")
  }
}