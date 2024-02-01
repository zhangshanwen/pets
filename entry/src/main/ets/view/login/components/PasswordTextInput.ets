@Component
export struct PasswordTextInput {
  @Link password: string

  build() {
    TextInput({ placeholder: '请输入密码', text: this.password })
      .width('100%')
      .height('48vp')
      .placeholderColor('#99182431')
      .placeholderFont({ size: '16fp' })
      .fontSize('16fp')
      .backgroundColor('#00FFFFFF')
      .type(InputType.Password)
      .padding({ left: '0vp' })
      .border({
        width: { bottom: '1vp' },
        color: '#33000000',
        radius: '0vp'
      })
      .onChange((value: string) => {
        this.password = value;
      })
  }
}