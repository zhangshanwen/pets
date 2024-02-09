import { UserInfo } from '../../common/bean/ListItemData'
import { ChevronRightIconComponent } from '../components/ChevronRightIconComponent'
import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'

@Component
export struct PetComponent {
  @Consume user: UserInfo

  build() {
    Row() {
      Text() {
        Span('我的宠物')
      }.width("70%").onClick(()=>{
        router.pushUrl({url:CommonConstants.PETS_PAGE_URL})
      })
      Row() {
        ChevronRightIconComponent()
      }.width("30%").direction(Direction.Rtl).onClick(()=>{
        router.pushUrl({url:CommonConstants.PETS_PAGE_URL})
      })

    }.height("100%").onClick(()=>{
      console.log("点击了我的宠物")
      router.pushUrl({url:CommonConstants.PETS_PAGE_URL})
    })
  }
}