import instance from '../utils/http/axios'
import { upload } from './media'


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
export function registerUser(data) {
  return instance.post(`v1/user/register`, data)
}


export function uploadAvatar(fileName: string) {
  return upload("v1/user/avatar", fileName)
}
