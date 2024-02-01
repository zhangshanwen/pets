/**
 * Login page component.
 */
import { PasswordLoginButton } from './components/PasswordLoginButton';
import { PasswordTextInput } from './components/PasswordTextInput';
import { PhoneNumberTextInput } from './components/PhoneNumberTextInput';
import { SmsCodeTextInput } from './components/SmsCodeTextInput';
import { VerificationCodeLoginButton } from './components/VerificationCodeLoginButton';
import { VerificationCodeMsgSendButton } from './components/VerificationCodeMsgSendButton';

// 登录模块
@Component
export struct LoginComponent {
  @StorageProp('isMinHeight') isMinHeight: boolean = false;
  @State phoneNumber: string = '';
  @State password: string = '';
  @State verificationCode: string = '';
  @State verificationCodeType: boolean = false;
  @State isSendCode: boolean = false;
  @State timeRemaining: number = 60;

  build() {
    GridRow({
      columns: {
        sm: 4,
        md: 8,
        lg: 12
      },
      gutter: { x: vp2px(12) },
      breakpoints: { value: ['320vp', '600vp', '820vp'] }
    }) {
      GridCol({
        span: {
          sm: 4,
          md: 6,
          lg: 8
        },
        offset: {
          sm: 1,
          md: 1,
          lg: 2
        }
      }) {
        Column() {
          PhoneNumberTextInput({ phoneNumber: $phoneNumber })
          if (!this.verificationCodeType) {
            PasswordTextInput({ password: $password })
          } else if (this.verificationCodeType && this.isSendCode) {
            SmsCodeTextInput({
              verificationCode: $verificationCode,
              phoneNumber: this.phoneNumber,
              timeRemaining: $timeRemaining
            })
          } else {

          }
          Row() {
            Image($r('app.media.repeat'))
              .width('24vp')
              .height('24vp')
            Text() {
              if (this.verificationCodeType) {
                Span('密码登录')
              } else {
                Span('验证码登录')
              }
            }.margin({ left: '1vp' }).backgroundColor('#F1F3F5').fontColor('#007DFF').onClick(() => {
              this.verificationCodeType = !this.verificationCodeType
            })
          }.margin({ bottom: '28vp', top: '28vp' })

        }
      }

      GridCol({
        span: {
          sm: 4,
          md: this.isMinHeight ? 3 : 6,
          lg: 8
        },
        offset: {
          sm: 0,
          md: 2,
          lg: 4
        }
      }) {
        if (this.verificationCodeType && this.isSendCode) {
          VerificationCodeLoginButton({ phoneNumber: this.phoneNumber, verificationCode: this.verificationCode })
        } else if (this.verificationCodeType && !this.isSendCode) {
          VerificationCodeMsgSendButton({ phoneNumber: this.phoneNumber, isSendCode: $isSendCode })
        } else {
          PasswordLoginButton({ phoneNumber: this.phoneNumber, password: this.password })
        }
      }

    }
  }
}

