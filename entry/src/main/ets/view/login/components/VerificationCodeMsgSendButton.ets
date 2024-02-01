import { msgSend } from '../../../api/sms';
import { checkPhoneNumber } from '../../../utils/check'

@Component
export struct VerificationCodeMsgSendButton {
  @Prop phoneNumber: string;
  @Link isSendCode: boolean ;

  build() {
    Button('验证并登录')
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
        msgSend({ phone_number: this.phoneNumber }).then(() => {
          this.isSendCode = true
        }).catch()
      })
  }
}