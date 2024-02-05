import router from '@ohos.router';
import MediaQueryModel from '../model/MediaQueryModel';
import { PrivacyStatementComponent } from '../view/PrivacyStatementComponent';
import { LoginComponent } from '../view/login/LoginComponent';
import { TitleComponent } from '../view/components/TitleComponent'


@Entry
@Component
struct LoginPage {
  aboutToAppear() {
    MediaQueryModel.register();
  }

  aboutToDisappear() {
    MediaQueryModel.unRegister();
  }

  build() {
    Column() {
      TitleComponent({title:'登录'})

      Scroll() {
        Column() {
          LoginComponent()

          Blank()

          PrivacyStatementComponent()
        }
        .height('100%')
        .constraintSize({ minHeight: '304vp' })
        .alignItems(HorizontalAlign.Start)
        .padding('24vp')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .backgroundColor('#f1f3f5')
  }
}