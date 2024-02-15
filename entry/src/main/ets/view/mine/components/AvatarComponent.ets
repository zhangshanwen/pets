import { getMediaIds, uploadByAli } from '../../../api/media'
import { uploadAvatar } from '../../../api/user'
import { UserInfo } from '../../../common/bean/ListItemData'
import { copyUriFileToInternalUri, getFileSteam } from '../../../utils/file'
import { pickPhoto } from '../../../utils/media'

@Component
export struct AvatarComponent {
  @Consume user: UserInfo
  @State num: number = 1

  build() {

    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      Text() {
        Span('头像')
      }.height("100%")

      Image(this.user.avatar).objectFit(ImageFit.Contain).onClick(async () => {
        let uri;
        await pickPhoto(this.num).then(res => {
          uri = res.photoUris[0]
        }).catch(() => {
        })
        getMediaIds({ num: this.num, bucket_type: 1 }).then(async (resp) => {
          // 获取到fileId
          let item = resp.data.list[0]
          const stream = getFileSteam(uri)
          await uploadByAli(item.upload_url, stream)
          await uploadAvatar({ fileName: item.file_id })
          this.user.avatar = uri

        })
      }).height("100%")
    }
  }
}