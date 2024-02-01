export function checkPhoneNumber(phoneNumber: string): boolean {
  return phoneNumber !== '';
}

export function isLoginButtonClickable(phoneNumber: string, password: string): boolean {
  return checkPhoneNumber(phoneNumber) && password !== '';
}

export function checkVerifyCode(code: string): boolean {
  return code !== '';
}