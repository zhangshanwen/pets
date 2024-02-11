import promptAction from '@ohos.promptAction';
import { userSaveNickName } from '../api/user'
import { EditInputComponent } from '../view/components/EditInputComponent'
import router from '@ohos.router'
import { UserInfo } from '../common/bean/ListItemData';
import { getUserInfo, setUserInfo } from '../utils/user';

@Entry
@Component
export struct SetUserNickName {
  @State nick_name: string = ''

  onPageShow() {
    this.nick_name = router.getParams()['nick_name']
  }

  save() {
    userSaveNickName({ nick_name: this.nick_name }).then(() => {
      promptAction.showToast({
        message: '设置成功',
        duration: 2000,
      });
      getUserInfo().then((res: UserInfo) => {
        res.nick_name = this.nick_name
        setUserInfo(res)
      })
      router.back();

    })
  }

  build() {
    Column() {
      Row() {
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
          Text("设置昵称")
            .fontSize('20fp')
            .fontColor('#182431')
            .fontWeight(500)
        }.width("80%")

        Blank()
        Row() {
          Button("保存", { type: ButtonType.Capsule, stateEffect: true }).onClick(() => {
            this.save()
          })
        }.width("20%")
      }.height("15%")

      EditInputComponent({ text: "昵称", placeholder: "填写昵称", value: $nick_name })
    }
  }
}