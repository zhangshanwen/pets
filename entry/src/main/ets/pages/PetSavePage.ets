import { EditInputComponent } from '../view/components/EditInputComponent';
import { EditInputAreaComponent } from '../view/components/EditInputAreaComponent';
import { EditDateComponent } from '../view/components/EditDateComponent';
import router from '@ohos.router';
import { AvatarUploadComponent } from '../view/components/AvatarUploadComponent';
import { SelectComponent } from '../view/components/SelectComponent';
import { Pet } from '../common/bean/ListItemData';
import { petCreate, petDelete, petEdit, petUploadAvatar } from '../api/pet';
import { DialogShow } from '../utils/dialog';
import { getFileSteam } from '../utils/file';
import { uploadByAli } from '../api/media';


@Entry
@Component
struct PetSavePage {
  controller: TextInputController = new TextInputController()
  pet: Pet = new Pet()
  @State isCreate: boolean = true
  @State nickName: string = ''
  @State intro: string = ''
  @State birthDate: number = 0
  @State avatar: string = ''
  @State uri: string = ''
  @State uploadUrl: string = ''
  @State fileId: string = ''
  @State selectOptions: Array<SelectOption> = [{ value: "保密" }, { value: "弟弟" }, { value: "妹妹" }]
  @State selectIndex: number = 0

  onPageShow() {
    if (router.getParams()) {
      this.pet = router.getParams()["pet"]
      this.isCreate = false
      this.nickName = this.pet.nick_name
      this.intro = this.pet.intro
      this.birthDate = this.pet.birth_date
      this.avatar = this.pet.avatar
      this.fileId = this.pet.file_id
      this.selectIndex = this.pet.sex
    }
  }

  save() {
    if (this.isCreate) {
      // 先创建宠物
      petCreate({ nick_name: this.nickName, intro: this.intro, birth_date: this.birthDate, sex: this.selectIndex })
        .then(async (res) => {
          const stream = getFileSteam(this.uri)
          await uploadByAli(this.uploadUrl, stream)
          await petUploadAvatar(res.data.id, { file_name: this.fileId })
          setTimeout(() => {
            router.back()
          }, 500)
        })
    } else {
      petEdit(this.pet.id, {
        nick_name: this.nickName,
        intro: this.intro,
        birth_date: this.birthDate,
        sex: this.selectIndex
      }).then(async (res) => {
        if (this.pet.file_id != this.fileId && this.fileId != '') {
          const stream = getFileSteam(this.uri)
          await uploadByAli(this.uploadUrl, stream)
          await petUploadAvatar(this.pet.id, { file_name: this.fileId })
        }
        setTimeout(() => {
          router.back()
        }, 500)
      })
    }

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
          Text(this.isCreate ? "创建宠物" : "修改宠物信息")
            .fontSize('20fp')
            .fontColor('#182431')
            .fontWeight(500)
        }.width("60%")

        Blank()
        Row() {
          Button("保存").onClick(() => {
            this.save()
          }).fontColor(Color.Blue).backgroundColor(0xffffff)
            .margin({ right: 10 })
          if (!this.isCreate) {
            Button("删除").onClick(() => {
              petDelete(this.pet.id).then(() => {
                router.back()
              })
            }).backgroundColor(0xffffff).fontColor(Color.Red).margin({ right: 10 })
          }
        }.width("30%")
      }.height('56vp').align(Alignment.Start).width("100%")


      //头像
      AvatarUploadComponent({ avatar: $avatar, fileId: $fileId, uri: $uri, uploadUrl: $uploadUrl })
        .height("10%")
        .margin({ top: "10vp" })

      // 昵称
      EditInputComponent({ text: "昵称", placeholder: "请输入昵称", value: $nickName }).margin({ top: "10vp" })

      // 简介
      EditInputAreaComponent({ text: "简介", placeholder: "请输入简介", value: $intro }).margin({ top: "10vp" })

      //性别
      SelectComponent({
        text: "性别",
        placeholder: "请选择性别",
        selectOptions: $selectOptions,
        selectIndex: $selectIndex
      }).margin({ top: "10vp" })


      // 出生日期
      EditDateComponent({ text: "生日", placeholder: "请选择出生日期", value: $birthDate }).margin({ top: "10vp" })
    }

  }
}
