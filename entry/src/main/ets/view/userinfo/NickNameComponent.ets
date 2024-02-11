import { UserInfo } from '../../common/bean/ListItemData'
import { ChevronRightIconComponent } from '../components/ChevronRightIconComponent'
import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'

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
    Row() {
      Text() {
        Span('昵称')
      }.width("75%").onClick(() => {
        this.clickFunc()
      })
      Row() {
        Text() {
          Span(this.user.nick_name)
        }
        Blank()
        ChevronRightIconComponent()
      }.width("25%").onClick(() => {
        this.clickFunc()
      })

    }.height("100%").onClick(()=>{
      this.clickFunc()
    })
  }
}