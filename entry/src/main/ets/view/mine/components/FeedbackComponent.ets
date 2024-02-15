import { ChevronRightIconComponent } from '../../components/ChevronRightIconComponent'
import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'

@Component
export struct FeedbackComponent {
  clickFunc() {
    router.pushUrl({ url: CommonConstants.FEEDBACK_LIST_PAGE_URL })
  }

  build() {
    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      Text() {
        Span('反馈与建议')
      }.height("100%")

      Row() {

        ChevronRightIconComponent()
      }.height("100%").align(Alignment.Center)
    }.onClick(() => {
      this.clickFunc()

    })
  }
}