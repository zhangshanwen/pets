import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
@Component
export struct PetAddButtonComponent {
  build() {
    Column() {
      Image($r('app.media.plus_icon')).height('50vp').height('50vp').opacity(0.5).onClick(()=>{
        router.pushUrl({url:CommonConstants.PET_SAVE_PAGE_URL})
      })
    }

  }
}