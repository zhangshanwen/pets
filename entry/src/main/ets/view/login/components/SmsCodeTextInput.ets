import { msgSend } from '../../../api/sms';

@Component
export struct SmsCodeTextInput {
  @Link verificationCode: string
  @Prop phoneNumber: string
  @Link timeRemaining: number;

  aboutToAppear() {
    this.setCodeInterval()
  }

  setCodeInterval() {
    let interval = setInterval(() => {
      this.timeRemaining -= 1
      if (this.timeRemaining == 0) {
        clearInterval(interval)
      }
    }, 1000)
  }

  build() {
    Row() {
      TextInput({ placeholder: '请输入验证码', text: this.verificationCode })
        .width('70%')
        .height('48vp')
        .placeholderColor('#99182431')
        .placeholderFont({ size: '16fp' })
        .fontSize('16fp')
        .backgroundColor('#00FFFFFF')
        .padding({ left: '0vp' })
        .border({
          width: { bottom: '1vp' },
          color: '#33000000',
          radius: '0vp'
        })
        .margin({ bottom: '28vp' })
        .onChange((value: string) => {
          if (value.length > 6) {
            return
          }
          this.verificationCode = value;
        })
      Text() {
        if (this.timeRemaining > 0) {
          Span(`重新发送(${this.timeRemaining}s)`).fontColor('#8ACFDB')
        } else {
          Span(`获取验证码`).fontColor('#007DFF').onClick(() => {
            msgSend({ phone_number: this.phoneNumber }).then(() => {
              this.timeRemaining = 60
              this.setCodeInterval()
            }).catch()
          })
        }
      }.backgroundColor('#F1F3F5')

    }.width('100%')
  }
}
