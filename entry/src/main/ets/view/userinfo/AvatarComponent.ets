import { getMediaIds } from '../../api/media'
import { uploadAvatar } from '../../api/user'
import { UserInfo } from '../../common/bean/ListItemData'
import { copyUriFileToInternalUri } from '../../utils/file'
import { pickPhoto } from '../../utils/media'

@Component
export struct AvatarComponent {
  @Consume user: UserInfo
  @State num: number = 1

  build() {
    Row() {
      Text() {
        Span('头像')
      }.width("80%")

      Row() {
        Image(this.user.avatar).objectFit(ImageFit.Contain).onClick(async () => {
          let uri;
          await pickPhoto(this.num).then(res => {
            uri = res.photoUris[0]
          }).catch(() => {
          })
          getMediaIds({ num: this.num }).then((resp) => {
            // 获取到fileId
            let file_ids = resp.data.file_ids
            const fileName = `${file_ids[0]}.jpeg`
            copyUriFileToInternalUri(uri, fileName)
            uploadAvatar(fileName).then(() => {
              this.user.avatar = uri
            })
          })
        })
      }.width("20%")
    }.height("100%")
  }
}