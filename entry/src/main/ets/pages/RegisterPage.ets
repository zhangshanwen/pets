import MediaQueryModel from '../model/MediaQueryModel';
import { TitleComponent } from '../view/components/TitleComponent';
import { LoginComponent } from '../view/login/LoginComponent';
import { RegisterComponent } from '../view/register/RegisterComponent';


@Entry
@Component
struct RegisterPage {
  build() {
    Column() {
      TitleComponent({ title: "注册" })
      Scroll() {
        Column() {
          RegisterComponent()
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