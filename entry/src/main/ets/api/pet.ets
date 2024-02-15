import { PetListParam } from '../common/param/PetParam';
import instance from '../utils/http/axios'


export function petList(params: PetListParam) {
  return instance.get(`v1/pet`, { params })
}

export function petCreate(data: {
  nick_name: string,
  intro: string,
  birth_date: number,
  sex: number,
}) {
  return instance.post(`v1/pet`, data)
}

export function petUploadAvatar(petId: number, data: { file_name: string }) {
  return instance.post(`v1/pet/avatar/${petId}`, data)
}


export function petEdit(petId: number, data: {
  nick_name: string,
  intro: string,
  birth_date: number,
  sex: number,
}) {
  return instance.put(`v1/pet/${petId}`, data)
}


export function petDelete(petId: number) {
  return instance.delete(`v1/pet/${petId}`)
}
