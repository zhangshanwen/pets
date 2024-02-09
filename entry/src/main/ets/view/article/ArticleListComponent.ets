import { ArticleList } from '../../api/article';
import { Article } from '../../common/bean/ListItemData'
import { ArticleListParam } from '../../common/param/ArticleParam';
import { ArticleComponent } from './components/ArticleComponent';

@Component
export struct ArticleListComponent {
  @State Articles: Array<Article> = []
  @State form: ArticleListParam = new ArticleListParam();
  @State total: number = 0
  @State isGetALl: boolean = false

  loadData() {
    ArticleList(this.form).then((res) => {
      for (let i = 0; i < res.data.list.length; i++) {
        this.Articles.push(res.data.list[i])
      }

      this.total = res.data.pagination.total
      if (this.form.page_index * this.form.page_size >= this.total) {
        this.isGetALl = true
      }
    })
  }

  aboutToAppear() {
    this.loadData()
  }

  build() {
    Stack() {
      List({ space: 20, initialIndex: 0 }) {
        ForEach(this.Articles, (item: Article) => {
          ListItem() {
            ArticleComponent({ article: item })
          }
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