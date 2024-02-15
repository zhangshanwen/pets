/**
 * Login page component.
 */

import router from '@ohos.router';
import { registerUser } from '../../api/user';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { isLoginByUsernameButtonClickable } from '../../utils/check';
import { DialogShow } from '../../utils/dialog';


// 登录模块
@Component
export struct RegisterComponent {
  @State username: string = '';
  @State password: string = '';

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
          TextInput({ placeholder: '请输入用户名', text: this.username })
            .width('100%')
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
            .onChange((value: string) => {
              this.username = value;
            })
          Text() {
            Span("4到16位（字母，数字，下划线)").fontSize("10vp").fontColor(Color.Gray)
          }.margin({ top: "1vp" })

          TextInput({ placeholder: '请输入密码', text: this.password })
            .width('100%')
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
            .onChange((value: string) => {
              this.password = value;
            })
          Text() {
            Span("4-16位 至少有一位字母").fontSize("10vp").fontColor(Color.Gray)
          }.margin({ top: "1vp" })
        }
      }

      GridCol({
        span: {
          sm: 4,
          md: 6,
          lg: 8
        },
        offset: {
          sm: 0,
          md: 2,
          lg: 4
        }
      }) {
        Button('注册')
          .width('100%')
          .height('40vp')
          .borderRadius('20vp')
          .fontSize('16fp')
          .margin({ top: '12vp' })
          .fontWeight(500)
          .enabled(isLoginByUsernameButtonClickable(this.username, this.password))
          .fontColor(isLoginByUsernameButtonClickable(this.username, this.password) ?
          Color.White : '#66FFFFFF')
          .backgroundColor(isLoginByUsernameButtonClickable(this.username, this.password) ?
            '#007DFF' : '#66007DFF')
          .onClick(() => {
            registerUser({
              username: this.username,
              password: this.password }).then((res) => {

              AlertDialog.show(
                {
                  title: "提示",
                  message: "注册成功,是否前往登录",
                  autoCancel: true,
                  alignment: DialogAlignment.Bottom,
                  gridCount: 4,
                  offset: { dx: 0, dy: -20 },
                  primaryButton: {
                    value: '确认',
                    action: () => {
                      router.clear()
                      router.pushUrl({
                        url: CommonConstants.LOGIN_PAGE_URL
                      })
                    }
                  },
                  secondaryButton: {
                    value: '取消',
                    action: () => {
                    }
                  },
                  cancel: () => {
                    console.info('Closed callbacks')
                  }
                }
              )


            })
          }

          )
      }

    }
  }
}

