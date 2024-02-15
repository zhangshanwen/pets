import { userLogin, userLoginByUsername } from '../../../api/user';
import { CommonConstants } from '../../../common/constants/CommonConstants';
import { isLoginByUsernameButtonClickable } from '../../../utils/check'
import { saveAuthorization } from '../../../utils/user';
import router from '@ohos.router';

@Component
export struct UsernameLoginButton {
  @Prop username: string;
  @Prop password: string;

  build() {
    Button('登录')
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
        userLoginByUsername({
          username: this.username,
          password: this.password }).then((res) => {
          // 保存用户登录信息
          saveAuthorization(res.data.authorization, res.data.refresh_token)
          console.log("登录成功")
          router.pushUrl({
            url: CommonConstants.HOME_PAGE_URL
          })
        })
      })
  }
}

