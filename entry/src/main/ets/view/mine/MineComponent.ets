import { UserInfo } from '../../common/bean/ListItemData'
import { TitleComponent } from '../components/TitleComponent'
import { AvatarComponent } from '../userinfo/AvatarComponent'
import { LogoutComponent } from '../userinfo/LogoutComponent'
import { NickNameComponent } from '../userinfo/NickNameComponent'
import { PasswordComponent } from '../userinfo/PasswordComponent'
import { PetComponent } from '../userinfo/PetComponent'
import { PhoneNumberComponent } from '../userinfo/PhoneNumberComponent'

@Component
export struct MineComponent {
  @Consume user: UserInfo

  build() {
    Column() {
      Column() {
        Row() {
          Text("个人信息")
            .fontSize('20fp')
            .fontColor('#182431')
            .fontWeight(500).width("90%")
          LogoutComponent().width("10%")
        }.width("100%").height('10%')
        // 头像
        AvatarComponent().height("10%").backgroundColor("#66FFFFFF").margin({ top: "1vp" })
        // 昵称
        NickNameComponent().height("10%").backgroundColor("#66FFFFFF").margin({ top: "1vp" })
        // 手机号
        PhoneNumberComponent().height("10%").backgroundColor("#66FFFFFF").margin({ top: "1vp" })
        // 密码
        PasswordComponent().height("10%").backgroundColor("#66FFFFFF").margin({ top: "1vp" })
        // 我的宠物
        PetComponent().height("10%").backgroundColor("#66FFFFFF").margin({ top: "1vp" })
      }
    }.backgroundColor("#f1f3f5").height("100%")
  }
}