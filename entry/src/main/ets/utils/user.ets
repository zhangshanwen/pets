import router from '@ohos.router';
import { getUser } from '../api/user';
import { UserInfo } from '../common/bean/ListItemData';
import { CommonConstants } from '../common/constants/CommonConstants';
import { readFile, writeFile } from './file'

const petsAuthorization = 'pets_authorization'
const petsUserInfo = 'pets_user_info'
const authorization = 'authorization'


export function saveAuthorization(res) {
  AppStorage.SetOrCreate(petsAuthorization, res.data.authorization);
  console.log("保存登录token", res.data.authorization)
  writeFile(authorization, res.data.authorization)
  router.pushUrl({
    url: CommonConstants.HOME_PAGE_URL
  })
}

export function getAuthorization(): string {
  let token: string = AppStorage.Get(petsAuthorization)
  if (!token) {
    token = readFile(authorization)
    if (token) {
      AppStorage.SetOrCreate(petsAuthorization, token);
    }
  }
  return token
}

export async function getUserInfo(): Promise<UserInfo> {
  var userInfo: UserInfo = AppStorage.Get(petsUserInfo)
  if (!userInfo || !userInfo.phone_number) {
    await getUser().then((res => {
      userInfo = res.data
      AppStorage.SetOrCreate(petsUserInfo, userInfo)
    })).catch()
  }
  if (userInfo.avatar == '') {
    // @ts-ignore
    userInfo.avatar = $r('app.media.cat')
  }
  return userInfo
}