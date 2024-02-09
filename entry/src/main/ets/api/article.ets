import { ArticleListParam } from '../common/param/ArticleParam'
import instance from '../utils/http/axios'

export function ArticleCreate(data: {
  file_ids: Array<string>,
  pet_ids: Array<number>,
  content: string
}) {
  return instance.post(`v1/article`, data)
}

export function ArticleList(params: ArticleListParam) {
  return instance.get(`v1/article`, { params })
}