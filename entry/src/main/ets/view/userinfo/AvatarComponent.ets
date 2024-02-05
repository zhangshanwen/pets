import { UserInfo } from '../../common/bean/ListItemData'

@Component
export struct AvatarComponent {
  @Consume user: UserInfo

  build() {

    Row() {
      Text() {
        Span('头像')
      }.width("70%").direction(Direction.Ltr)
      Row() {
        Image(this.user.avatar).objectFit(ImageFit.Contain)
      }.width("30%").direction(Direction.Rtl)
    }.height("100%")
  }
}