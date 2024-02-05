import http from '@ohos.net.http';
//导入封装好的请求
import { request } from '../utils/http/request'


/**
 * 根据用户id请求用户数据
 * @param userId
 * @returns
 */
export function userLogin(data: {
  phone_number: string,
  password: string
}) {
  return request(`v1/user/login`, http.RequestMethod.POST, data)
}

export function userLoginByCode(data: {
  phone_number: string,
  code: string
}) {
  return request(`v1/user/login/code`, http.RequestMethod.POST, data)
}

/**
 * 根据用户id请求用户数据
 * @param userId
 * @returns
 */
export function getUserById(userId) {
  return request(`v1/user/get/${userId}`, http.RequestMethod.GET)
}

/**
 * 请求用户数据
 * @param userId
 * @returns
 */
export function getUser() {
  return request('v1/user', http.RequestMethod.GET)
}

/**
 * 用户数据保存
 * @param userId
 * @returns
 */
export function registerUser(data) {
  return request(`v1/user/register`, http.RequestMethod.POST, data)
}
