import router from '@ohos.router';
import MediaQueryModel from '../model/MediaQueryModel';
import { CommonConstants } from '../common/constants/CommonConstants';
import { PrivacyStatementComponent } from '../view/PrivacyStatementComponent';
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
      this.Title()

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

  @Builder Title() {
    Row() {
      Image($r('app.media.ic_back'))
        .width('24vp')
        .height('24vp')
        .margin({
          left: '24vp',
          right: '16vp'
        })
        .onClick(() => {
          router.back();
        })

      Text('登录')
        .fontSize('20fp')
        .fontColor('#182431')
        .fontWeight(500)
    }
    .width('100%')
    .height('56vp')
  }
}