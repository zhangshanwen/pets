import { FeedbackListParam } from '../common/param/FeedbackParam'
import instance from '../utils/http/axios'

export function feedbackCreate(data: {
  file_ids: Array<string>,
  content: string,
}) {
  return instance.post(`v1/feedback`, data)
}

export function feedbackList(params: FeedbackListParam) {
  return instance.get(`v1/feedback`, { params })
}

export function feedbackInfo(infoId: number) {
  return instance.get(`v1/feedback/${infoId}`)
}

export function feedbackDelete(infoId: number) {
  return instance.delete(`v1/feedback/${infoId}`)
}