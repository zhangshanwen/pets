import instance from '../utils/http/axios'


/**
 * 根据用户id请求用户数据
 * @param userId
 * @returns
 */
export function userLogin(data: {
  phone_number: string,
  password: string
}) {
  return instance.post(`v1/user/login`, data)
}

export function userLoginByCode(data: {
  phone_number: string,
  code: string
}) {
  return instance.post(`v1/user/login/code`, data)
}

/**
 * 根据用户id请求用户数据
 * @param userId
 * @returns
 */
export function getUserById(userId) {
  return instance.get(`v1/user/get/${userId}`)
}

/**
 * 请求用户数据
 * @param userId
 * @returns
 */
export function getUser() {
  return instance.get('v1/user')
}

/**
 * 用户数据保存
 * @param userId
 * @returns
 */
export function registerUser(data: {
  username: string,
  password: string
}) {
  return instance.post(`v1/user/register`, data)
}


export function userLoginByUsername(data: {
  username: string,
  password: string
}) {
  return instance.post(`v1/user/login/username`, data)
}

export function uploadAvatar(data: { fileName: string }) {
  return instance.post("v1/user/avatar", data)
}

export function userLogout() {
  return instance.get("v1/user/logout")
}

export function userSavePassword(data: {
  password: string,
}) {
  return instance.put("v1/user/password", data)
}

export function userSaveNickName(data: {
  nick_name: string,
}) {
  return instance.put("v1/user/nickname", data)
}

