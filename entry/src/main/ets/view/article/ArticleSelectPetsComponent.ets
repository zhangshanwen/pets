import { petList } from '../../api/pet';
import { Pet } from '../../common/bean/ListItemData'
import { PetListParam } from '../../common/param/PetParam';
import { DialogShow } from '../../utils/dialog';

@CustomDialog
export struct ArticleSelectPetsComponent {
  @State form: PetListParam = new PetListParam();
  @State selectingPets: Array<Pet> = [] // 当前选择的宠物列表
  @Link selectedPets: Array<Pet> // 已经选择的宠物列表
  @State pets: Array<Pet> = [] // 需要请求的宠物列表
  @State isGetAll: boolean = false
  @State total: number = 0
  controller?: CustomDialogController
  confirm: () => void = () => {
    this.selectedPets = [...this.selectingPets]
  }

  aboutToAppear() {
    this.selectingPets = [...this.selectedPets]
    this.loadData()
  }

  isSelected(pet: Pet) {
    return this.selectingPets.filter((item) => {
      return item.id == pet.id
    }).length > 0
  }

  Selected(pet: Pet) {
    if (!this.isSelected(pet)) {
      this.selectingPets.push(pet)
    }
  }

  unSelected(pet: Pet) {
    if (this.isSelected(pet)) {
      this.selectingPets = this.selectingPets.filter((item) => {
        return item.id != pet.id
      })
    }
  }

  loadData() {
    if (this.isGetAll) {
      return
    }
    petList(this.form).then((res) => {
      for (let i = 0; i < res.data.list.length; i++) {
        this.pets.push(res.data.list[i])
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
        Flex({ justifyContent: FlexAlign.SpaceAround }) {
          Button('保存')
            .onClick(() => {
              this.confirm()
              this.controller.close()

            }).backgroundColor(0xffffff).fontColor(Color.Blue)
          Button('取消')
            .onClick(() => {
              this.controller.close()

            }).backgroundColor(0xffffff).fontColor(Color.Black)

        }.margin({ bottom: 10, top: 10 })
      }

      Grid() {
        ForEach(this.pets, (pet: Pet) => {
          GridItem() {
            Column() {
              Image(pet.avatar === '' ? $r('app.media.cat_1') : pet.avatar).width("80%").height("80%")
              Text(`昵称: ${pet.nick_name}`)
            }.onClick(() => {

              if (this.isSelected(pet)) {
                this.unSelected(pet)
                return
              }
              if (this.selectingPets.length >= 6) {
                DialogShow("错误", "最多可选6只宠物")
                return
              }
              this.Selected(pet)
            }).border({ width: this.isSelected(pet) ? "2vp" : 0, color: Color.Blue })
          }.width("30%").height("30%")
        }
        )
      }
      .columnsTemplate('1fr 1fr 1fr')
      .columnsGap(5)
      .rowsGap(5)
      .margin({ top: "10vp", left: "10vp", right: "10vp", bottom: "10vp", })
      .height("80%")

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

    }.height("80%").borderRadius(10)

  }
}