import { getMediaIds, uploadByAli } from '../../api/media'
import { getFileSteam } from '../../utils/file'
import { pickPhoto } from '../../utils/media'

@Component
export struct AvatarUploadComponent {
  @Link avatar: string
  @Link fileId: string
  @Link uri: string
  @Link uploadUrl: string
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
            await pickPhoto(this.num).then(res => {
              this.uri = res.photoUris[0]
            }).catch(() => {
            })

            getMediaIds({ num: this.num, bucket_type: 2 }).then( (resp) => {
              // 获取到fileId
              let item = resp.data.list[0]
              this.uploadUrl = item.upload_url
              this.fileId = item.file_id
              this.avatar = this.uri


            })
          })
      }.width("20%").backgroundColor("#F9F9F9")
    }
  }
}