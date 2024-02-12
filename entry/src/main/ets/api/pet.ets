import { PetListParam } from '../common/param/PetParam';
import instance from '../utils/http/axios'
import { upload } from './media';


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

export function petUploadAvatar(petId: number, fileName: string) {
  return upload(`v1/pet/avatar/${petId}`, fileName)
}


export function petEdit(petId: number, data: {
  nick_name: string,
  intro: string,
  birth_date: number,
  sex: number,
}) {
  return instance.put(`v1/pet/${petId}`, data)
}
