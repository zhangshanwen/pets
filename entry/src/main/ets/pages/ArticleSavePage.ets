import { pickPhoto } from '../utils/media'
import router from '@ohos.router'
import { Pet } from '../common/bean/ListItemData'
import { petList } from '../api/pet'
import { PetListParam } from '../common/param/PetParam'
import { getMediaIds, uploadMedia } from '../api/media'
import { ArticleCreate } from '../api/article'
import { CommonConstants } from '../common/constants/CommonConstants'

@Entry
@Component
struct ArticleSavePage {
  controller: TextAreaController = new TextAreaController()
  @State text: string = ''
  @State imagesColumn: Array<string> = ["add"]
  @State imagesIndex: number = 0
  @State imagesMaxLength: number = 9
  @State petsOptions: Array<SelectOption> = []
  @State form: PetListParam = new PetListParam();
  @State selectIndex: number = -1
  @State petsOptionIds: Array<number> = []
  @State selectUri: any = ""
  petIds: Array<number> = []
  selectPetIds: Array<number> = []

  onPageShow() {
    this.loadData()
  }

  loadData() {
    petList(this.form).then((res) => {
      for (let i = 0; i < res.data.list.length; i++) {
        var pet: Pet = res.data.list[i]
        this.petIds.push(pet.id)
        this.petsOptions.push({
          value: pet.nick_name,
          icon: pet.avatar == "" ? $r('app.media.cat_1') : pet.avatar
        })
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
        Button("保存", { type: ButtonType.Capsule, stateEffect: true }).onClick(() => {
          var uriArr = this.imagesColumn.filter((item) => item != "add")
          getMediaIds({
            num: uriArr.length
          }).then(async (resp) => {
            let file_ids: Array<string> = resp.data.file_ids
            file_ids = file_ids.map((item) => item + ".jpg")
            await uploadMedia(uriArr, file_ids).then(() => {
              ArticleCreate({
                content: this.text,
                file_ids: file_ids,
                pet_ids: this.selectPetIds,
              }).then(() => {
                router.pushUrl({ url: CommonConstants.HOME_PAGE_URL, params: {  category: "0" } })
              })
            }).catch()

          })
        })
      }.width("100%").height("10%")

      Column() {
        Row() {
          if (this.selectUri) {
            Image(this.selectUri).height("20vp").height("20vp")
          }
          Select(this.petsOptions)
            .value('选择宠物')
            .font({ size: 20, weight: 500 })
            .fontColor('#182431')
            .selectedOptionFont({ size: 20, weight: 400 })
            .optionFont({ size: 20, weight: 400 })
            .onSelect((index: number) => {
              this.selectIndex = index
              this.selectUri = this.petsOptions[index].icon
              this.selectPetIds = [this.petIds[index]]
            })
        }
      }.width("100%").height("10%")

      TextArea({ text: this.text, placeholder: "请输入", controller: this.controller })
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: 14 })
        .caretColor(Color.Blue)
        .fontSize(14)
        .margin({ top: "20vp" })
        .fontColor(Color.Black)
        .onChange((value: string) => {
          this.text = value
        })
      Column({ space: 5 }) {
        Grid() {
          ForEach(this.imagesColumn, (imageUri) => {
            GridItem() {
              if (imageUri === "add") {
                Column() {
                  Image($r("app.media.plus_icon")).width("30vp").height("30vp").opacity(0.1)
                }

                .onClick(async () => {
                  this.imagesColumn = []
                  await pickPhoto(this.imagesMaxLength).then(res => {
                    for (let i = 0; i < res.photoUris.length; i++) {
                      this.imagesColumn.push(res.photoUris[i])
                    }
                    if (res.photoUris.length < this.imagesMaxLength) {
                      this.imagesColumn.push("add")
                    }
                  }).catch(() => {
                  })
                })
              } else {
                Image(imageUri)
              }
            }.width("100vp").height("100vp").backgroundColor("#99182431")
          }
          )
        }.columnsTemplate('1fr 1fr 1fr').columnsGap(10)
        .rowsGap(10).margin({ top: "10vp", left: "10vp", right: "10vp" })
      }.margin({ top: "20vp" })
    }
  }
}
