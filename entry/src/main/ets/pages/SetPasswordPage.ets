import prompt from '@system.prompt'
import { userSavePassword } from '../api/user'
import { DialogShow } from '../utils/dialog'
import { EditInputComponent } from '../view/components/EditInputComponent'
import router from '@ohos.router'

@Entry
@Component
export struct SetPasswordPage {
  @State hasPassword: boolean = true
  @State password: string = ''
  @State verifyPassword: string = ''


  onPageShow() {
  }

  save() {
 
    if (!this.password) {
      DialogShow("提示", "请输入新密码")
      return
    } else if (this.password != this.verifyPassword) {
      DialogShow("提示", "两次输入不一致")
      return
    }
    userSavePassword({ password: this.password }).then(() => {
      prompt.showToast({
        message: '设置成功',
        duration: 2000,
      });
      router.back();
    })
  }

  build() {
    Column() {
      Row() {
        Row() {
          Image($r('app.media.ic_back'))
            .width('24vp')
            .height('24vp')
            .margin({
              left: '24vp',
              right: '16vp'
            })
            .onClick(() => {
              router.back();
            })
          Text("设置密码")
            .fontSize('20fp')
            .fontColor('#182431')
            .fontWeight(500)
        }.width("80%")

        Blank()
        Row() {
          Button("保存", { type: ButtonType.Capsule, stateEffect: true }).onClick(() => {
            this.save()
          })
        }.width("20%")
      }.height("15%")

      // 新密码
      EditInputComponent({ text: "新密码", placeholder: "填写新密码", value: $password })
      // 确认密码
      EditInputComponent({ text: "确认密码", placeholder: "填写确认密码", value: $verifyPassword })
    }
  }
}