import { pickPhoto } from '../utils/media'
import router from '@ohos.router'
import { Pet, selectOptions } from '../common/bean/ListItemData'
import { petList } from '../api/pet'
import { PetListParam } from '../common/param/PetParam'
import { getMediaIds, uploadMedia } from '../api/media'
import { articleCreate } from '../api/article'
import { CommonConstants } from '../common/constants/CommonConstants'
import { ArticleSelectPetsComponent } from '../view/article/ArticleSelectPetsComponent'
import { DialogShow } from '../utils/dialog'

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
  @State category: string = '日常'
  @State categoriesOptions: Array<SelectOption> = [{ value: '日常' }, { value: '经验' }]
  @State selectUri: any = ""
  @State selectedPets: Array<Pet> = []
  dialogController: CustomDialogController = new CustomDialogController({
    builder: ArticleSelectPetsComponent({
      selectedPets: $selectedPets,
    }),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false,
  })

  onPageShow() {
  }

  getUploadCategory() {
    return (this.categoriesOptions.findIndex((ele) => {
      return ele.value == this.category
    }) + 1).toString()
  }

  aboutToDisappear() {
    this.dialogController = null // 将dialogController置空
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
        Text('发布')
          .fontSize('20fp')
          .fontColor('#182431')
          .fontWeight(500)
        Blank()
        Button("保存", { type: ButtonType.Capsule, stateEffect: true }).onClick(async () => {
          if (!this.text) {
            DialogShow("错误", "请输入内容")
            return
          }
          if (uriArr.length <= 0) {
            DialogShow("错误", "至少上传一张图片")
            return
          }
          var uriArr = this.imagesColumn.filter((item) => item != "add")
          let file_ids: Array<string>;
          const resp = await  getMediaIds({ num: uriArr.length })
          file_ids = resp.data.file_ids.map((item) => item + ".jpg")
          await uploadMedia(uriArr, file_ids)
          await articleCreate({
            content: this.text,
            file_ids: file_ids,
            pet_ids: this.selectedPets.map(item => item.id),
            category: this.getUploadCategory()
          })
          router.pushUrl({ url: CommonConstants.HOME_PAGE_URL, params: { category: "0" } })
        })
      }.width("100%").height("10%")


      Row() {
        Text() {
          Span("选择宠物").fontColor(Color.Blue).onClick(() => {
            this.dialogController.open()
          })
        }.margin({ left: "10vp" })

      }.width("100%").height("10%").align(Alignment.Start)

      if (
        this.selectedPets.length > 0
      ) {
        Column() {
          Grid() {
            ForEach(this.selectedPets, (pet: Pet) => {
              GridItem() {
                Column() {
                  Image(pet.avatar === '' ? $r('app.media.cat_1') : pet.avatar).width("80%").height("80%")
                  Text(`昵称: ${pet.nick_name}`)
                }
              }.width("33%").height("33%")
            }
            )
          }.columnsTemplate('1fr 1fr 1fr').columnsGap(10)
          .rowsGap(10)
        }.height("30%").width("100%")
      }
      Row() {
        Text() {
          Span("类型")
        }.margin({ left: '10vp', right: '10vp' })

        Select(this.categoriesOptions)
          .value(this.category)
          .font({ size: 20, weight: 500 })
          .fontColor(Color.Blue)
          .selectedOptionFont({ size: 20, weight: 400 })
          .optionFont({ size: 20, weight: 400 })
          .onSelect((index: number, value: string) => {
            this.category = value
          })
      }.width("100%").align(Alignment.Start)


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
