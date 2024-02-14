import { UserInfo } from '../../common/bean/ListItemData'
import { AvatarComponent } from './components/AvatarComponent'
import { FeedbackComponent } from './components/FeedbackComponent'
import { LogoutComponent } from './components/LogoutComponent'
import { NickNameComponent } from './components/NickNameComponent'
import { PasswordComponent } from './components/PasswordComponent'
import { PetComponent } from './components/PetComponent'
import { PhoneNumberComponent } from './components/PhoneNumberComponent'

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
        // 反馈与建议
        FeedbackComponent().height("10%").backgroundColor("#66FFFFFF").margin({ top: "1vp" })
      }
    }.backgroundColor("#f1f3f5").height("100%")
  }
}