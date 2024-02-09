import router from '@ohos.router'
import { EditInputComponent } from '../view/components/EditInputComponent'
import { SaveTitleComponent } from '../view/components/SaveTileComponent'

@Entry
@Component
export struct SetPasswordPage {
  @State originPassword: string = ''
  @State newPassword: string = ''
  @State verifyPassword: string = ''
  @State hasPassword: boolean = true

  onPageShow() {
    this.hasPassword = router.getParams()["hasPassword"]
  }

  build() {
    Column() {
      SaveTitleComponent({ title: "设置密码", clickFunc: $savePassword })
      if (this.hasPassword) {
        // 原密码
        EditInputComponent({ text: "原密码", placeholder: "填写原密码", value: $originPassword })
      }
      // 新密码
      EditInputComponent({ text: "新密码", placeholder: "填写新密码", value: $newPassword })
      // 确认密码
      EditInputComponent({ text: "确认密码", placeholder: "填写确认密码", value: $verifyPassword })
    }
  }
}