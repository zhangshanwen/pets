import { UserInfo } from '../common/bean/ListItemData'
import { getUserInfo } from '../utils/user'
import { MineComponent } from '../view/mine/MineComponent'
import { ArticleListComponent } from '../view/article/ArticleListComponent'
import router from '@ohos.router'
import { CommonConstants } from '../common/constants/CommonConstants'


@Entry
@Component
struct HomePage {
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#007DFF'
  @State category: string = ''
  @State currentIndex: number = 0
  private controller: TabsController = new TabsController()
  @Provide user: UserInfo = new UserInfo()
  @State uid: number = 0

  onPageShow() {
    const param = router.getParams()
    if (param) {
      this.category = param['category']
    }
    console.log("进入homepage页面");
    getUserInfo().then((res) => {
      this.user = res
      this.uid = this.user.id
    }).catch((err) => {
      console.log("请求异常", err.message)
    })
  }

  @Builder TabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color('#007DFF')
        .opacity(this.currentIndex === index ? 1 : 0)
    }.width('100%')
  }

  @Builder TabPlus(index) {
    Column() {
      Image($r("app.media.plus_icon"))
        .width(this.currentIndex == index ? "40vp" : "50vp")
        .height(this.currentIndex == index ? "40vp" : "50vp")
    }.width('100%').onClick(() => {
      console.log("点击了plus")
      this.currentIndex = index
      router.pushUrl({ url: CommonConstants.ARTICLE_SAVE_PAGE_URL })
    })
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {

        TabContent() {
          ArticleListComponent({ category: this.category, uid: this.uid })
        }.tabBar(this.TabBuilder(0, '首页'))

        TabContent() {
        }.tabBar(this.TabPlus(1))

        TabContent() {
          MineComponent()
        }.tabBar(this.TabBuilder(2, '我'))

      }
      .vertical(false)
      .barPosition(BarPosition.End)
      .barMode(BarMode.Fixed)
      .barWidth(360)
      .barHeight(56)
      .animationDuration(400)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F3F5')
    }.width('100%')
  }
}