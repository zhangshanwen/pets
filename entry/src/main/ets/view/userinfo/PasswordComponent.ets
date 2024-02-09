import router from '@ohos.router'
import { UserInfo } from '../../common/bean/ListItemData'
import { CommonConstants } from '../../common/constants/CommonConstants'
import { ChevronRightIconComponent } from '../components/ChevronRightIconComponent'


@Component
export struct PasswordComponent {
  @Consume user: UserInfo

  build() {

    Row() {
      Text() {
        Span('密码')
      }.width("70%")

      Row() {
        Text() {
          Span(this.user.has_password ? "已设置" : "未设置")
        }

        ChevronRightIconComponent()
      }.width("30%")

    }.height("100%").onClick(() => {
      router.pushUrl({
        url: CommonConstants.SET_PASSWORD_PAGE_URL,
        params: { hasPassword: this.user.has_password }
      })
    })
  }
}