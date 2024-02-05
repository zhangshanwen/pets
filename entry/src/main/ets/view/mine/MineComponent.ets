import { UserInfo } from '../../common/bean/ListItemData'
import { UserInfoComponent } from './components/UserInfoComponent'

@Component
export struct MineComponent {
  @Consume user: UserInfo

  build() {
    Column() {
      UserInfoComponent()
    }.width('100%').height('100%')
  }
}