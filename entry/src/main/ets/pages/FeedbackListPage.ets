import { TitleComponent } from '../view/components/TitleComponent'
import { Feedback, Pet } from '../common/bean/ListItemData';
import { petList } from '../api/pet';
import { PetListParam } from '../common/param/PetParam';
import { PetCardComponent } from '../view/pet/PetCardComponent';
import { PetAddButtonComponent } from '../view/pet/PetAddButtonComponent';
import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import { FeedbackListParam } from '../common/param/FeedbackParam';
import { feedbackList } from '../api/feedback';


@Entry
@Component
struct FeedbackListPage {
  @State form: FeedbackListParam = new FeedbackListParam();
  @State arr: Array<Feedback> = []
  @State total: number = 0
  @State isGetAll: boolean = false;

  onPageShow() {
    this.isGetAll = false
    this.arr = []
    this.form = new FeedbackListParam()
    this.loadData()
  }

  loadData() {
    if (this.isGetAll) {
      return
    }
    feedbackList(this.form).then((res) => {
      for (let i = 0; i < res.data.list.length; i++) {
        this.arr.push(res.data.list[i])
      }

      this.total = res.data.pagination.total
      if (this.form.page_index * this.form.page_size >= this.total) {
        this.isGetAll = true
      }
    })
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_back'))
          .width('24vp')
          .height('24vp')
          .margin({
            left: '24vp',
            right: '16vp'
          })
          .onClick(() => {
            router.back();
          })
        Blank()
        Button("反馈", { type: ButtonType.Capsule, stateEffect: true }).onClick(() => {
          router.pushUrl({ url: CommonConstants.FEEDBACK_PAGE_URL })
        })
      }.width("100%").height("10%")

      List({ space: 20, initialIndex: 0 }) {
        ForEach(this.arr, (item: Feedback) => {

          ListItem() {
            Text() {
              Span(item.content).margin({ left: "10vp" })
            }.onClick(() => {
              router.pushUrl({ url: CommonConstants.FEEDBACK_INFO_PAGE_URL, params: { infoId: item.id } })

            })
          }.align(Alignment.Start)
        })
      }
      .listDirection(Axis.Vertical) // 排列方向
      .divider({ strokeWidth: 2, color: 0xFFFFFF}) // 每行之间的分界线
      .edgeEffect(EdgeEffect.Spring) // 滑动到边缘无效果
      .onReachEnd(() => {
        this.form.page_index += 1
        this.loadData()
      })
      .width('90%')
      .height('90%')


      if (!this.isGetAll) {
        Column() {
          Text() {
            Span("加载更多...").onClick(() => {
              this.form.page_index += 1
              this.loadData()
            }).fontColor(Color.Blue)
          }
        }.width("100%").height("5%")
      }

    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xDCDCDC)
    .padding({ top: 5 })
  }
}
