export function checkPhoneNumber(phoneNumber: string): boolean {
  return (/^1[3456789]\d{9}$/.test(phoneNumber))
}

export function isLoginButtonClickable(phoneNumber: string, password: string): boolean {
  return checkPhoneNumber(phoneNumber) && password !== '';
}
export function isLoginByUsernameButtonClickable(username: string, password: string): boolean {
  return username.length>=4 && username.length<=16 &&  password.length>=4 && password.length<=16 ;
}

export function checkVerifyCode(code: string): boolean {
  return (/^\d{6}$/.test(code));
}