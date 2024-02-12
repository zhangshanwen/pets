import { getMediaIds } from '../../api/media'
import { uploadAvatar } from '../../api/user'
import { UserInfo } from '../../common/bean/ListItemData'
import { copyUriFileToInternalUri } from '../../utils/file'
import { pickPhoto } from '../../utils/media'

@Component
export struct AvatarUploadComponent {
  @Link avatar: string
  @Link fileId: string
  @State num: number = 1

  build() {
    Row() {
      Text() {
        Span('头像')
      }.width("80%")

      Row() {
        Image(this.avatar === "" ? $r("app.media.plus_icon") : this.avatar)
          .objectFit(ImageFit.Contain)
          .opacity(this.avatar === "" ? 0.1 : 1)
          .onClick(async () => {
            let uri;
            await pickPhoto(this.num).then(res => {
              uri = res.photoUris[0]
            }).catch(() => {
            })
            getMediaIds({ num: this.num }).then((resp) => {
              // 获取到fileId
              let file_ids = resp.data.file_ids
              this.fileId = `${file_ids[0]}.jpeg`
              this.avatar = uri
              copyUriFileToInternalUri(uri, this.fileId)

            })
          })
      }.width("20%").backgroundColor("#F9F9F9")
    }
  }
}