import { Article } from '../../../common/bean/ListItemData'

@Component
export struct ArticleComponent {
  @ObjectLink article: Article

  formatCategory(category: string) {
    if (category === "2") {
      return "经验"
    } else if (category === "3") {
      return "精华"
    }
    return "日常"
  }

  build() {
    Column() {
      Image(this.article.cover === "" ? $r("app.media.cat") : this.article.cover)
      Text() {
        Span(this.article.content)
      }.margin({ top: "10vp" }).textOverflow({ overflow: TextOverflow.Ellipsis }).maxLines(1)

      // Row() {
      //   ForEach(this.article.categories, (category) => {
      //     Text() {
      //       Span(this.formatCategory(category)).fontColor(Color.Blue)
      //     }
      //   })
      // }.margin({ top: "10vp" })
    }
  }
}