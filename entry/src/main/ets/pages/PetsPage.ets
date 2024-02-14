import { TitleComponent } from '../view/components/TitleComponent'
import { Pet } from '../common/bean/ListItemData';
import { petList } from '../api/pet';
import { PetListParam } from '../common/param/PetParam';
import { PetCardComponent } from '../view/pet/PetCardComponent';
import { PetAddButtonComponent } from '../view/pet/PetAddButtonComponent';
import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';


@Entry
@Component
struct PetsPage {
  @State form: PetListParam = new PetListParam();
  @State pets: Array<Pet> = []
  @State total: number = 0
  @State isGetAll: boolean = false;

  onPageShow() {
    this.isGetAll = false
    this.pets = []
    this.form = new PetListParam()
    this.loadData()
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
      TitleComponent({ title: "我的宠物" })
      // 获取所有宠物卡片
      Stack() {
        List({ space: 20, initialIndex: 0 }) {
          ForEach(this.pets, (item: Pet) => {

            ListItem() {
              PetCardComponent({ pet: item })
            }.align(Alignment.Center).onClick(() => {
              router.pushUrl({ url: CommonConstants.PET_SAVE_PAGE_URL, params: { pet: item } })
            })
          }, (item: Pet) => item.id.toString())
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

        PetAddButtonComponent().zIndex(2).position({ x: '80%', y: '80%' })
      }

    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xDCDCDC)
    .padding({ top: 5 })
  }
}
