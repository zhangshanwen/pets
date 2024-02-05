import { UserInfo } from '../../../common/bean/ListItemData'
import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'

@Component
export struct UserInfoComponent {
  @Consume user: UserInfo

  build() {
    Row() {
      Image(this.user.avatar).objectFit(ImageFit.Contain).width('15%').margin({ left: '10vp' })
      Column() {
        Text() {
          Span(`${this.user.nick_name}`).fontSize('25vp')
        }.margin({ bottom: '5vp' }).align(Alignment.TopStart).onClick(() => {
          router.pushUrl({
            url:CommonConstants.USER_INFO_PAGE_URL
          })
        })

        Text() {
          Span(`手机号: ${this.user.phone_number}`)
        }.margin({ left: '10vp' })
      }
    }.width('100%').height("20%")
  }
}