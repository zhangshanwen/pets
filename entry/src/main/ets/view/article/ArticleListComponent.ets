import { articleList } from '../../api/article';
import { Article, selectOptions } from '../../common/bean/ListItemData'
import { ArticleListParam } from '../../common/param/ArticleParam';
import { ArticleComponent } from './components/ArticleComponent';
import router from '@ohos.router';
import { CommonConstants } from '../../common/constants/CommonConstants';

@Component
export struct ArticleListComponent {
  @State Articles: Array<Article> = []
  @State form: ArticleListParam = new ArticleListParam();
  @State total: number = 0
  @State isGetAll: boolean = false
  @State categories: Array<selectOptions> = [{ label: '日常', value: '1' }, { label: '经验', value: '2' }, {
    label: '我的',
    value: '0'
  }]
  @Prop category: string
  @Prop uid: number

  aboutToAppear() {
    if (this.category) {
      this.form.category = this.category
    }
    this.loadData()
  }


  loadData() {
    if (this.isGetAll) {
      return
    }
    articleList(this.form).then((res) => {
      for (let i = 0; i < res.data.list.length; i++) {
        this.Articles.push(res.data.list[i])
      }

      this.total = res.data.pagination.total
      if (this.form.page_index * this.form.page_size >= this.total) {
        this.isGetAll = true
      }
    })
  }

  build() {
    Column() {
      Flex() {
        ForEach(this.categories, (item: selectOptions) => {
          Text() {
            Span(item.label)
          }
          .fontSize(this.form.category === item.value ? 20 : 16)
          .width("100%")
          .fontColor(this.form.category === item.value ? Color.Blue : Color.Gray)
          .flexBasis('auto')
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.Articles = []
            this.isGetAll = false
            this.form.page_index = 1
            this.form.category = item.value
            this.loadData()
          })
        })
      }.margin({ bottom: "10vp" })

      Stack() {

        List({ space: 20, initialIndex: 0 }) {
          ForEach(this.Articles, (item: Article) => {
            ListItem() {
              ArticleComponent({ article: item })
            }.onClick(() => {
              router.pushUrl({ url: CommonConstants.ARTICLE_INFO_PAGE_URL, params: { infoId: item.id, uid: this.uid } })
            })
          }, (item: Article) => item.id.toString())
        }
        .listDirection(Axis.Vertical) // 排列方向
        .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .edgeEffect(EdgeEffect.Spring) // 滑动到边缘无效果
        .onReachEnd(() => {
          this.form.page_index += 1
          this.loadData()
        })
        .width('90%')
        .height('90%')
        .zIndex(1)
      }
    }

  }
}