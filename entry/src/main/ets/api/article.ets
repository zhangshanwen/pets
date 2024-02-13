import { ArticleListParam } from '../common/param/ArticleParam'
import instance from '../utils/http/axios'

export function articleCreate(data: {
  file_ids: Array<string>,
  pet_ids: Array<number>,
  content: string,
  category: string,
}) {
  return instance.post(`v1/article`, data)
}

export function articleList(params: ArticleListParam) {
  return instance.get(`v1/article`, { params })
}

export function articleInfo(infoId: number) {
  return instance.get(`v1/article/${infoId}`)
}
export function articleDelete(infoId: number) {
  return instance.delete(`v1/article/${infoId}`)
}