import router from '@ohos.router';
import { getUser } from '../api/user';
import { UserInfo } from '../common/bean/ListItemData';
import { CommonConstants } from '../common/constants/CommonConstants';
import { readFile, writeFile } from './file'

const UserInfoKey = 'user_info'
const AuthorizationKey = 'authorization'
const RefreshTokenKey = 'refresh_token'


export function saveAuthorization(token: string, refreshToken: string) {
  AppStorage.SetOrCreate(AuthorizationKey, token);
  AppStorage.SetOrCreate(RefreshTokenKey, refreshToken);
  writeFile(AuthorizationKey, token)
  writeFile(RefreshTokenKey, refreshToken)

}

export function getAuthorization(): string {
  let token: string = AppStorage.Get(AuthorizationKey)
  if (!token) {
    token = readFile(AuthorizationKey)
    if (token) {
      AppStorage.SetOrCreate(AuthorizationKey, token);
    }
  }
  return token
}

export function getRefreshToken(): string {
  let token: string = AppStorage.Get(RefreshTokenKey)
  if (!token) {
    token = readFile(RefreshTokenKey)
    if (token) {
      AppStorage.SetOrCreate(RefreshTokenKey, token);
    }
  }
  return token
}

export async function getUserInfo(): Promise<UserInfo> {
  var userInfo: UserInfo = AppStorage.Get(UserInfoKey)
  if (!userInfo || !userInfo.phone_number) {
    await getUser().then((res => {
      userInfo = res.data
      AppStorage.SetOrCreate(UserInfoKey, userInfo)
    })).catch()
  }
  if (userInfo.avatar == '') {
    // @ts-ignore
    userInfo.avatar = $r('app.media.cat')
  }
  return userInfo
}

export async function setUserInfo(userInfo: UserInfo) {
  AppStorage.SetOrCreate(UserInfoKey, userInfo)
  return
}
