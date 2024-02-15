import { UserInfo } from '../../../common/bean/ListItemData'

@Component
export struct UsernameComponent {
  @Consume user: UserInfo

  build() {
    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      Text() {
        Span('用户名')
      }.height("100%")

      Text() {
        Span(this.user.username)
      }.height("100%").margin({ right: "10vp" })
    }
  }
}