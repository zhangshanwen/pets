import { ChevronRightIconComponent } from '../../components/ChevronRightIconComponent'
import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'

@Component
export struct FeedbackComponent {
  clickFunc() {
    router.pushUrl({ url: CommonConstants.FEEDBACK_LIST_PAGE_URL })
  }

  build() {
    Row() {
      Text() {
        Span('反馈与建议')
      }.width("80%").onClick(() => {
        this.clickFunc()
      })

      Row() {
        Blank()
        ChevronRightIconComponent()
      }.width("20%").onClick(() => {
        this.clickFunc()
      })

    }.height("100%").onClick(() => {
      this.clickFunc()
    })
  }
}