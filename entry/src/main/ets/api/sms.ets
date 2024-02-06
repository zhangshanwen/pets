
import instance from '../utils/http/axios'

export function msgSend(data: { phone_number: string }) {
  return instance.post(`v1/sms/send`, data)
}