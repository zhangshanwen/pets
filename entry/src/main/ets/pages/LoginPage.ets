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
      Text("登录")
        .fontSize('20fp')
        .fontColor('#182431')
        .fontWeight(500)
        .width('100%')
        .height('56vp')
        .margin({left:'20vp'})

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