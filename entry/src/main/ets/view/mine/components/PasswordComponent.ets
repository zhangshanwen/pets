import router from '@ohos.router'
import { UserInfo } from '../../../common/bean/ListItemData'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import { ChevronRightIconComponent } from '../../components/ChevronRightIconComponent'


@Component
export struct PasswordComponent {
  @Consume user: UserInfo

  clickFunc() {
    router.pushUrl({
      url: CommonConstants.SET_PASSWORD_PAGE_URL,
      params: { hasPassword: this.user.has_password }
    })
  }

  build() {

    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      Text() {
        Span('密码')
      }.height("100%")

      Row() {
        Text() {
          Span(this.user.has_password ? "已设置" : "未设置")
        }.height("100%")

        ChevronRightIconComponent()
      }.height("100%").align(Alignment.Center)
    }.onClick(() => {
      this.clickFunc()
    })
  }
}