/**
 * Login page component.
 */
import { PasswordLoginButton } from './PasswordLoginButton';
import { VerificationCodeLoginButton } from './VerificationCodeLoginButton';
import { VerificationCodeMsgSendButton } from './VerificationCodeMsgSendButton';

@Component
export struct LoginComponent {
  @StorageProp('isMinHeight') isMinHeight: boolean = false;
  @State phoneNumber: string = '';
  @State password: string = '';
  @State verificationCode: string = '';
  @State verificationCodeType: boolean = false;
  @State isSendCode: boolean = false;

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
          TextInput({ placeholder: '请输入手机号', text: this.phoneNumber })
            .width('100%')
            .height('48vp')
            .placeholderColor('#99182431')
            .placeholderFont({ size: '16fp' })
            .backgroundColor('#00FFFFFF')
            .fontSize('16fp')
            .padding({ left: '0vp' })
            .border({
              width: { bottom: '1vp' },
              color: '#33000000',
              radius: '0vp'
            })
            .onChange((value: string) => {
              this.phoneNumber = value;
            })

          TextInput({ placeholder: '请输入密码', text: this.password })
            .width('100%')
            .height('48vp')
            .placeholderColor('#99182431')
            .placeholderFont({ size: '16fp' })
            .fontSize('16fp')
            .backgroundColor('#00FFFFFF')
            .type(InputType.Password)
            .padding({ left: '0vp' })
            .border({
              width: { bottom: '1vp' },
              color: '#33000000',
              radius: '0vp'
            })
            .margin({ bottom: '28vp' })
            .onChange((value: string) => {
              this.password = value;
            })
          Row() {
            Image($r('app.media.repeat'))
              .width('24vp')
              .height('24vp')
            Text() {
              if (this.verificationCodeType) {
                Span('验证码登录')
              } else {
                Span('密码登录')
              }
            }.margin({ left: '1vp' }).onClick(() => {
              this.verificationCodeType = !this.verificationCodeType
            })
          }.margin({ bottom: '28vp' })

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
          VerificationCodeMsgSendButton({ phoneNumber: this.phoneNumber, isSendCode: $this.isSendCode })
        } else {
          PasswordLoginButton({ phoneNumber: this.phoneNumber, password: this.password })
        }
      }

    }
  }
}

