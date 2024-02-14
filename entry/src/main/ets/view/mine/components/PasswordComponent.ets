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
    Row() {
      Text() {
        Span('密码')
      }.width("80%").onClick(() => {
        this.clickFunc()
      })


      Row() {
        Text() {
          Span(this.user.has_password ? "已设置" : "未设置")

        }

        Blank()

        ChevronRightIconComponent()
      }.width("20%").onClick(() => {
        this.clickFunc()
      })

    }.height("100%").onClick(() => {
      router.pushUrl({
        url: CommonConstants.SET_PASSWORD_PAGE_URL,
        params: { hasPassword: this.user.has_password }
      })
    })
  }
}