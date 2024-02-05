import { userLogin } from '../../../api/user';
import { isLoginButtonClickable } from '../../../utils/check'
import { saveAuthorization } from '../../../utils/user';

@Component
export struct PasswordLoginButton {
  @Prop phoneNumber: string;
  @Prop password: string;

  build() {
    Button('登录')
      .width('100%')
      .height('40vp')
      .borderRadius('20vp')
      .fontSize('16fp')
      .margin({ top: '12vp' })
      .fontWeight(500)
      .enabled(isLoginButtonClickable(this.phoneNumber, this.password))
      .fontColor(isLoginButtonClickable(this.phoneNumber, this.password) ?
      Color.White : '#66FFFFFF')
      .backgroundColor(isLoginButtonClickable(this.phoneNumber, this.password) ?
        '#007DFF' : '#66007DFF')
      .onClick(() => {
        // router.pushUrl({
        //   url: CommonConstants.MINE_PAGE_URL
        // });
        userLogin({
          phone_number: this.phoneNumber,
          password: this.password }).then((res) => {
          // 保存用户登录信息
          saveAuthorization(res)
          console.log("登录成功")
        }).catch(err => {
        })
      })
  }
}

