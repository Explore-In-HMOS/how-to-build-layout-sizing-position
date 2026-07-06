import { LayoutState } from '../model/LayoutState';

@Component
export struct TopBar {
  @Consume layoutState: LayoutState;

  build() {
    Row() {
      Text(`${this.layoutState.moduleNames[this.layoutState.currentModule - 1]} ${this.layoutState.currentModule}/8`)
        .fontSize($r('app.float.font_small'))
        .fontColor($r('app.color.text_secondary'))
        .padding({ left: 8, right: 8, top: 3, bottom: 3 })
        .backgroundColor($r('app.color.top_bar_background'))
        .borderRadius(10)

      Blank()

      Circle({ width: 6, height: 6 })
        .fill(
          this.layoutState.clipStatus === 'Safe' ? $r('app.color.status_safe') :
            this.layoutState.clipStatus === 'Warning' ? $r('app.color.status_warning') : $r('app.color.status_critical')
        )
        .margin({ right: 8 })
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 5 })
  }
}