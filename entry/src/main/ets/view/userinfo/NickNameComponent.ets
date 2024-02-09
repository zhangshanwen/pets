import { UserInfo } from '../../common/bean/ListItemData'
import { ChevronRightIconComponent } from '../components/ChevronRightIconComponent'

@Component
export struct NickNameComponent {
  @Consume user: UserInfo

  build() {
    Row() {
      Text() {
        Span('昵称')
      }.width("80%")

      Row() {
        Text() {
          Span(this.user.nick_name)
        }

        Blank()

        ChevronRightIconComponent()
      }.width("20%")

    }.height("100%")
  }
}