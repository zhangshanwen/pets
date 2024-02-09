export function DialogShow(title: string, message: string) {
  AlertDialog.show(
    {
      title: title,
      message: message,
      autoCancel: true,
      gridCount: 4,
      offset: { dx: 0, dy: -20 },
      confirm: {
        value: '确认',
        action: () => {
        }
      },
    }
  )
}