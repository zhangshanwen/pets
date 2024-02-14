export function checkPhoneNumber(phoneNumber: string): boolean {
  return (/^1[3456789]\d{9}$/.test(phoneNumber))
}

export function isLoginButtonClickable(phoneNumber: string, password: string): boolean {
  return checkPhoneNumber(phoneNumber) && password !== '';
}

export function checkVerifyCode(code: string): boolean {
  return (/^\d{6}$/.test(code));
}