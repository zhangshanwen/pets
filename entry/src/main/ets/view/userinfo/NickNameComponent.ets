import { UserInfo } from '../../common/bean/ListItemData'
import { ChevronRightIconComponent } from '../components/ChevronRightIconComponent'

@Component
export struct NickNameComponent {
  @Consume user: UserInfo

  build() {
    Row() {
      Text() {
        Span('昵称')
      }.width("70%")

      Row() {
        ChevronRightIconComponent()
        Text() {
          Span(this.user.nick_name)
        }

      }.width("30%").direction(Direction.Rtl)

    }.height("100%")
  }
}