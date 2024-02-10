import prompt from '@system.prompt'
import { userSavePassword } from '../api/user'
import { DialogShow } from '../utils/dialog'
import { EditInputComponent } from '../view/components/EditInputComponent'
import { SaveTitleComponent } from '../view/components/SaveTileComponent'

@Entry
@Component
export struct SetPasswordPage {
  @State password: string = ''
  @State verifyPassword: string = ''
  @State hasPassword: boolean = true

  onPageShow() {
  }

  savePassword() {
    if (!this.password) {
      DialogShow("提示", "请输入新密码")
      return
    } else if (this.password != this.verifyPassword) {
      DialogShow("提示", "两次输入不一致")
      return
    }
    userSavePassword({ password: this.password }).then(() => {
      prompt.showToast({
        message: '设置密码成功',
        duration: 2000,
      });
    })
  }

  build() {
    Column() {
      SaveTitleComponent({ title: "设置密码", clickFunc: this.savePassword })

      // 新密码
      EditInputComponent({ text: "新密码", placeholder: "填写新密码", value: $newPassword })
      // 确认密码
      EditInputComponent({ text: "确认密码", placeholder: "填写确认密码", value: $verifyPassword })
    }
  }
}