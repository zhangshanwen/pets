/**
 * Login page component.
 */
import { EditInputComponent } from '../components/EditInputComponent';
import { PasswordTextInput } from './components/PasswordTextInput';
import { UsernameLoginButton } from './components/UsernameLoginButton';
import router from '@ohos.router';
import { CommonConstants } from '../../common/constants/CommonConstants';


// 登录模块
@Component
export struct LoginByUsernameComponent {
  @State username: string = '';
  @State password: string = '';
  controller: TextInputController = new TextInputController()

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
          PasswordTextInput({ password: $password })
          Row() {
            Text() {
              Span('前去注册')
            }.margin({ left: '1vp' }).backgroundColor('#F1F3F5').fontColor('#007DFF').onClick(() => {
              router.pushUrl({ url: CommonConstants.REGISTER_PAGE_URL })
            })
          }.margin({ bottom: '28vp', top: '28vp' }).width("100%")

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
        UsernameLoginButton({ username: this.username, password: this.password })
      }

    }
  }
}

