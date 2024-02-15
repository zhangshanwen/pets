import { UserInfo } from '../../../common/bean/ListItemData'
import { ChevronRightIconComponent } from '../../components/ChevronRightIconComponent'
import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'

@Component
export struct PetComponent {
  @Consume user: UserInfo

  clickFunc() {
    router.pushUrl({ url: CommonConstants.PETS_PAGE_URL })
  }

  build() {


    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      Text() {
        Span('我的宠物')
      }.height("100%")

      Row() {
        ChevronRightIconComponent()
      }.height("100%").align(Alignment.Center)
    }.onClick(() => {
      this.clickFunc()
    })
  }
}