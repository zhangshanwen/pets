import router from '@ohos.router'
import { Pet } from '../common/bean/ListItemData'
import { ArticleInfo } from '../api/article'

import { TitleComponent } from '../view/components/TitleComponent'
import { DialogShow } from '../utils/dialog'

@Entry
@Component
struct ArticleInfoPage {
  @State infoId: number = 0
  @State ownerId: number = 0
  @State ownerNickName: string = ''
  @State ownerAvatar: string = ''
  @State medias: Array<string> = []
  @State pets: Array<Pet> = []
  @State content: string = ''
  @State categories: Array<string> = []
  scroller: Scroller = new Scroller()

  onPageShow() {
    const param = router.getParams()
    if (!param) {
      DialogShow("错误", "请求异常")
      setTimeout(() => {
        router.back()
      }, 500)
    }
    this.infoId = param["infoId"]
    this.loadData()
  }

  loadData() {
    ArticleInfo(this.infoId).then((res) => {
      this.ownerId = res.data.owner_id
      this.ownerNickName = res.data.owner_nick_name
      this.ownerAvatar = res.data.owner_avatar
      this.pets = res.data.pets
      this.content = res.data.content
      this.categories = res.data.categories
      this.medias = res.data.medias
    })
  }

  build() {
    Column() {

      TitleComponent({ title: "详情" })
      Scroll(this.scroller) {
        Column() {
          Row() {
            Image(this.ownerAvatar ? $r('app.media.cat') : this.ownerAvatar).width("60vp").height("60vp")
            Text() {
              Span(`发布者 :${this.ownerNickName}`)
            }.margin({ left: "10vp" })
          }.width("100%").align(Alignment.Start)

          Text(this.content).margin({ top: "10vp" })

          Column({ space: 5 }) {
            Grid() {
              ForEach(this.medias, (imageUri) => {
                GridItem() {
                  Image(imageUri)
                }.width("100vp").height("100vp").backgroundColor("#99182431")
              }
              )
            }.columnsTemplate('1fr 1fr 1fr').columnsGap(10)
            .rowsGap(10).margin({ top: "10vp", left: "10vp", right: "10vp" })
          }.margin({ top: "20vp" }).height("30%")

          Text() {
            Span("宠物")
          }.align(Alignment.Start).width("100%").margin({ left: "10vp" })

          Column({ space: 5 }) {
            Grid() {
              ForEach(this.pets, (pet: Pet) => {
                GridItem() {
                  Column() {
                    Image(pet.avatar === '' ? $r('app.media.cat_1') : pet.avatar)
                    Text(`昵称: ${pet.nick_name}`)
                  }
                }.width("50vp").height("50vp").backgroundColor("#99182431")
              }
              )
            }.columnsTemplate('1fr 1fr 1fr').columnsGap(10)
            .rowsGap(10).margin({ top: "10vp", left: "10vp", right: "10vp" })
          }.margin({ top: "5vp" }).height("30%")

        }
      }

    }

  }
}
