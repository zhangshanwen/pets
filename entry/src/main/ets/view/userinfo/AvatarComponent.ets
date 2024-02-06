import { getMediaIds, mediaUpload } from '../../api/media'
import { upload } from '../../api/media_copy'
import { UserInfo } from '../../common/bean/ListItemData'
import { copyUriFileToInternalUri } from '../../utils/file'
import { pickPhoto } from '../../utils/media'

@Component
export struct AvatarComponent {
  @Consume user: UserInfo

  build() {
    Row() {
      Text() {
        Span('头像')
      }.width("70%").direction(Direction.Ltr)

      Row() {
        Image(this.user.avatar).objectFit(ImageFit.Contain).onClick(() => {
          pickPhoto(1).then((res => {
            let num = res.photoUris.length
            getMediaIds({ num: num }).then((resp) => {
              // 获取到fileId
              let file_ids = resp.data.file_ids
              copyUriFileToInternalUri(res.photoUris[0], file_ids[0])
              upload(file_ids[0])
            }).catch()
          })).catch((err) => {
            console.log(err, "---------------")
          })
        })
      }.width("30%").direction(Direction.Rtl)
    }.height("100%")
  }
}