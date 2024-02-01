@Component
export struct PhoneNumberTextInput {
  @Link phoneNumber: string

  build() {
    TextInput({ placeholder: '请输入手机号', text: this.phoneNumber })
      .width('100%')
      .height('48vp')
      .placeholderColor('#99182431')
      .placeholderFont({ size: '16fp' })
      .backgroundColor('#00FFFFFF')
      .fontSize('16fp')
      .padding({ left: '0vp' })
      .border({
        width: { bottom: '1vp' },
        color: '#33000000',
        radius: '0vp'
      })
      .onChange((value: string) => {
        this.phoneNumber = value;
      })

  }
}