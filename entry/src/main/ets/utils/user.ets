import router from '@ohos.router';
import { getUser } from '../api/user';
import { UserInfo } from '../common/bean/ListItemData';
import { CommonConstants } from '../common/constants/CommonConstants';
import { readFile, writeFile } from './file'

const petsAuthorization = 'pets_authorization'
const petsRefreshToken = 'pets_refresh_token'
const petsUserInfo = 'pets_user_info'
const authorization = 'authorization'
const refreshToken = 'refresh_token'


export function saveAuthorization(res) {
  console.log("保存登录token", res.data.authorization)
  console.log("保存登录refresh_token", res.data.refresh_token)
  AppStorage.SetOrCreate(petsAuthorization, res.data.authorization);
  AppStorage.SetOrCreate(petsRefreshToken, res.data.refresh_token);
  writeFile(authorization, res.data.authorization)
  writeFile(refreshToken, res.data.refresh_token)
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
export function getRefreshToken(): string {
  let token: string = AppStorage.Get(petsRefreshToken)
  if (!token) {
    token = readFile(refreshToken)
    if (token) {
      AppStorage.SetOrCreate(petsRefreshToken, token);
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