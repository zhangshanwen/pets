import { TitleComponent } from './TitleComponent'

@Component
export struct SaveTitleComponent {
  @Prop title: string
  @Link clickFunc: Function

  build() {
    Row() {
      TitleComponent({ title: this.title })
      Blank()
      Button("保存", { type: ButtonType.Capsule, stateEffect: true }).onClick(() => {
        this.clickFunc()
      })
    }
  }
}