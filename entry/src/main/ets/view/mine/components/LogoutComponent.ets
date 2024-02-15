import { userLogout } from '../../../api/user'
import { DelAuthorization, saveAuthorization } from '../../../utils/user'
import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'

@Component
export struct LogoutComponent {
  build() {
    Row() {
      Text() {
        Span("登出")
      }.onClick(() => {
        userLogout().then(() => {
          DelAuthorization()
          router.pushUrl({ url: CommonConstants.LOGIN_PAGE_URL })
        }).catch()
      })
    }
  }
}