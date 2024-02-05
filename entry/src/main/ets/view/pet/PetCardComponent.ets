import { Pet } from '../../common/bean/ListItemData'
import { formatBirthDate } from '../../utils/format'

@Component
export struct PetCardComponent {
  @ObjectLink  pet: Pet

  build() {
    // 头像
    Column() {
      if(this.pet.id>0){
        Image($r('app.media.cat_1'))
        Text(`昵称: ${this.pet.nick_name}`)
        Text(`性别: ${this.pet.sex == 0 ? '弟弟' : '妹妹'}`)
        Text(`出生日期: ${formatBirthDate(this.pet.birth_date)}`)
        Text(`简介: ${this.pet.intro}`)
      }else{
        Text(){
          Span('没有更多了...')
        }
      }
    }.backgroundColor(0xFFFFFF)

  }
}