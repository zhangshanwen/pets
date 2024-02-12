import { Pet } from '../../common/bean/ListItemData'
import { formatBirthDate } from '../../utils/format'

@Component
export struct PetCardComponent {
  @ObjectLink pet: Pet

  getSex() {
    const sex = this.pet.sex
    if (sex == 1) {
      return "弟弟"
    } else if (sex == 2) {
      return "妹妹"
    }
    return "保密"
  }

  build() {
    // 头像
    Column() {
      Image(this.pet.avatar === '' ? $r('app.media.cat_1') : this.pet.avatar)
      Text(`昵称: ${this.pet.nick_name}`)
      Text(`性别: ${this.getSex()}`)
      Text(`出生日期: ${formatBirthDate(this.pet.birth_date)}`)
      Text(`简介: ${this.pet.intro}`)
    }.backgroundColor(0xFFFFFF)

  }
}