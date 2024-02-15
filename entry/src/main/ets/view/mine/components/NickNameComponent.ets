import { UserInfo } from '../../../common/bean/ListItemData'
import { ChevronRightIconComponent } from '../../components/ChevronRightIconComponent'
import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'

@Component
export struct NickNameComponent {
  @Consume user: UserInfo

  clickFunc() {
    router.pushUrl({
      url: CommonConstants.SET_USER_NICKNAME_PAGE_URL,
      params: { nick_name: this.user.nick_name }
    })
  }

  build() {

    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      Text() {
        Span('昵称')
      }.height("100%")

      Row() {
        Text() {
          Span(this.user.nick_name)
        }.height("100%").onClick(() => {
          this.clickFunc()
        })

        ChevronRightIconComponent()
      }.height("100%").align(Alignment.Center)
    }.onClick(() => {
      this.clickFunc()
    })
  }
}