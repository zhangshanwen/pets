export function formatBirthDate(n: number): string {
  const timer = new Date(n * 1000)

  const year = timer.getFullYear()
  const month = timer.getMonth() + 1 // 由于月份从0开始，因此需加1
  const day = timer.getDate()
  return `${pad(year, 4)}-${pad(month)}-${pad(day)}`

}

function pad(timeEl, total = 2, str = '0') {
  return timeEl.toString().padStart(total, str)
}