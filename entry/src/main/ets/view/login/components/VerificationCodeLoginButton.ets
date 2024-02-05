import { userLoginByCode } from '../../../api/user';
import { checkPhoneNumber } from '../../../utils/check'
import { saveAuthorization } from '../../../utils/user';

// 验证码登录按钮
@Component
export struct VerificationCodeLoginButton {
  @Prop phoneNumber: string;
  @Prop verificationCode: string;

  build() {
    Button('登录')
      .width('100%')
      .height('40vp')
      .borderRadius('20vp')
      .fontSize('16fp')
      .margin({ top: '12vp' })
      .fontWeight(500)
      .enabled(checkPhoneNumber(this.phoneNumber))
      .fontColor(checkPhoneNumber(this.phoneNumber) ?
      Color.White : '#66FFFFFF')
      .backgroundColor(checkPhoneNumber(this.phoneNumber) ?
        '#007DFF' : '#66007DFF')
      .onClick(() => {
        userLoginByCode({ phone_number: this.phoneNumber, code: this.verificationCode }).then((res) => {
          // 保存登录态
          saveAuthorization(res)
          console.log("登录成功")
        }).catch()
      })
  }
}