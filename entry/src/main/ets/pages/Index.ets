import { LayoutState } from '../model/LayoutState';
import { TopBar } from '../components/TopBar';
import { TestComponent } from '../components/TestComponent';
import { DebugOverlay } from '../components/DebugOverlay';
import { BottomPanel } from '../components/BottomPanel';

@Entry
@Component
struct CalibrationPage {
  @Provide layoutState: LayoutState = new LayoutState();

  private swipeStartY: number = 0;
  @State showPanel: boolean = true;
  private screenSize: number = 230;

  build() {
    Stack({ alignContent: Alignment.Center }) {

      Column()
        .width(this.screenSize)
        .height(this.screenSize)
        .backgroundColor($r('app.color.background_dark'))
        .borderRadius(this.screenSize / 2)
        .clip(true)

      Stack({ alignContent: Alignment.Center }) {
        DebugOverlay({ screenSize: this.screenSize })
        TestComponent()
      }
      .width(this.screenSize)
      .height(this.screenSize)
      .alignContent(Alignment.Center)

      TopBar()
        .position({ x: 0, y: 5 })
        .width(this.screenSize)
        .opacity(0.8)

      if (this.showPanel) {
        BottomPanel()
          .width('88%')
          .opacity(0.92)
          .position({
            x: (this.screenSize - (this.screenSize * 0.88)) / 2,
            y: this.screenSize * 0.3
          })
          .borderRadius($r('app.float.radius_panel'))
      }

      Column()
        .width(this.screenSize)
        .height(this.screenSize)
        .borderRadius(this.screenSize / 2)
        .backgroundColor($r('app.color.transparent'))
        .onClick(() => {
          this.showPanel = !this.showPanel;
        })
        .hitTestBehavior(HitTestMode.Transparent)

      Column()
        .width(this.screenSize)
        .height(this.screenSize)
        .borderRadius(this.screenSize / 2)
        .backgroundColor($r('app.color.transparent'))
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down) {
            this.swipeStartY = event.touches[0].y;
          } else if (event.type === TouchType.Up) {
            const deltaY: number = event.touches[0].y - this.swipeStartY;
            if (deltaY < -40) {
              this.previousModule();
            } else if (deltaY > 40) {
              this.nextModule();
            }
          }
        })
        .hitTestBehavior(HitTestMode.Transparent)

      Column()
        .width(this.screenSize)
        .height(this.screenSize)
        .borderRadius(this.screenSize / 2)
        .backgroundColor($r('app.color.transparent'))
        .gesture(
          LongPressGesture({ duration: 1500 })
            .onAction(() => {
              this.resetToDefault();
            })
        )
        .hitTestBehavior(HitTestMode.Transparent)

      if (!this.showPanel) {
        Column() {
          Text($r('app.string.symbol_gear'))
            .fontSize(18)
            .opacity(0.6)
        }
        .position({ x: this.screenSize - 35, y: this.screenSize - 35 })
        .onClick(() => {
          this.showPanel = true;
        })
      }
    }
    .width(this.screenSize)
    .height(this.screenSize)
  }

  private nextModule(): void {
    let newModule: number = this.layoutState.currentModule + 1;
    if (newModule > 8) { newModule = 1 };
    this.layoutState.currentModule = newModule;
  }

  private previousModule(): void {
    let newModule: number = this.layoutState.currentModule - 1;
    if (newModule < 1) { newModule = 8 };
    this.layoutState.currentModule = newModule;
  }

  private resetToDefault(): void {
    this.layoutState.currentModule = 1;
    this.layoutState.explicitWidth = 90;
    this.layoutState.explicitHeight = 90;
    this.layoutState.minWidth = 30;
    this.layoutState.maxWidth = 120;
    this.layoutState.layoutWeight = 1;
    this.layoutState.marginType = 'UNIFORM';
    this.layoutState.bottomOffset = 0;
    this.layoutState.positionX = 115;
    this.layoutState.positionY = 115;
    this.layoutState.offsetX = 0;
    this.layoutState.offsetY = 0;
    this.layoutState.safeAreaEnabled = true;
    this.layoutState.showCoordinates = true;
    this.layoutState.clipStatus = 'Safe';
    this.layoutState.clipDepth = 0;
    this.showPanel = true;
  }
}