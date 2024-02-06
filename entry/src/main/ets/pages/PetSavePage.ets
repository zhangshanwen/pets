import { TitleComponent } from '../view/components/TitleComponent'
import { EditInputComponent } from '../view/components/EditInputComponent';
import { EditInputAreaComponent } from '../view/components/EditInputAreaComponent';


@Entry
@Component
struct PetSavePage {
  controller: TextInputController = new TextInputController()
  @State petId: number = 0
  @State nickName: string = ''
  @State intro: string = ''

  build() {
    Column() {
      TitleComponent({ title: this.petId == 0 ? "创建宠物" : "修改宠物信息" })

      // 昵称
      EditInputComponent({ text: "昵称", placeholder: "请输入昵称", value: $nickName })

      // 简介
      EditInputAreaComponent({ text: "简介", placeholder: "请输入简介", value: $intro })
    }

  }
}
