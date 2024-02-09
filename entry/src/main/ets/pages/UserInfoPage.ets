import { UserInfo } from '../common/bean/ListItemData'
import { getUserInfo } from '../utils/user'
import { TitleComponent } from '../view/components/TitleComponent'
import { AvatarComponent } from '../view/userinfo/AvatarComponent'
import { LogoutComponent } from '../view/userinfo/LogoutComponent'
import { NickNameComponent } from '../view/userinfo/NickNameComponent'
import { PasswordComponent } from '../view/userinfo/PasswordComponent'
import { PetComponent } from '../view/userinfo/PetComponent'
import { PhoneNumberComponent } from '../view/userinfo/PhoneNumberComponent'


@Entry
@Component
struct UserInfoPage {
  @Provide user: UserInfo = new UserInfo()
  onPageShow() {
    getUserInfo().then((res) => {
      this.user = res
    })
  }

  build() {
    Column() {
      Column() {
        TitleComponent({ title: "个人信息" })
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
      }.height("90%")
      // 登出
      LogoutComponent().height("10%")
    }.backgroundColor("#f1f3f5")
  }
}

