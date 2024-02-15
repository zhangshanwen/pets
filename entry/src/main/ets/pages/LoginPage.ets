import MediaQueryModel from '../model/MediaQueryModel';
import { LoginByUsernameComponent } from '../view/login/LoginByUserNameComponent';
import { LoginComponent } from '../view/login/LoginComponent';


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
          // LoginComponent()
          LoginByUsernameComponent()
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