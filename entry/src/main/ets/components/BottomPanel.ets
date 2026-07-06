import { LayoutState } from '../model/LayoutState';

@Component
export struct BottomPanel {
  @Consume layoutState: LayoutState;

  build() {
    Column() {
      Row() {
        Text(this.getShortModuleName())
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.text_primary'))
        Blank()
        Text($r('app.string.symbol_close'))
          .fontSize(12)
          .fontColor($r('app.color.button_close'))
          .width(20)
          .height(20)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .margin({ bottom: 6 })

      if (this.layoutState.currentModule === 1) {
        this.SizeControls();
      } else if (this.layoutState.currentModule === 2) {
        this.SizingControls();
      } else if (this.layoutState.currentModule === 3) {
        this.MarginTypeControls();
      } else if (this.layoutState.currentModule === 4) {
        this.BottomOffsetControls();
      } else if (this.layoutState.currentModule === 5) {
        this.PositionControls();
      } else if (this.layoutState.currentModule === 6) {
        this.OffsetControls();
      } else if (this.layoutState.currentModule === 7) {
        this.LocationControls();
      } else if (this.layoutState.currentModule === 8) {
        this.SafeAreaControls();
      }

      Text(this.getShortHint())
        .fontSize(8)
        .fontColor($r('app.color.text_dark'))
        .margin({ top: 6 })
        .textAlign(TextAlign.Center)
        .width('100%')
        .maxLines(1)
    }
    .width('100%')
    .padding(10)
    .backgroundColor($r('app.color.panel_background'))
    .backdropBlur(12)
    .borderRadius(14)
    .border({ width: 0.3, color: $r('app.color.border_dark') })
  }

  private getShortModuleName(): string {
    const names: Record<number, string> = {
      1: 'Size', 2: 'Sizing', 3: 'Margin', 4: 'BtmOff',
      5: 'Pos', 6: 'Offset', 7: 'Loc', 8: 'Safe'
    };
    return names[this.layoutState.currentModule] || 'Size';
  }

  private getShortHint(): string {
    const hints: Record<number, string> = {
      1: 'W/H',
      2: 'Min/Max',
      3: 'Uniform | H | V | Individual',
      4: '↑ bezel',
      5: 'X/Y',
      6: 'ΔX/ΔY - live offset',
      7: 'real-time coords',
      8: 'protect round edges'
    };
    return hints[this.layoutState.currentModule] || 'swipe ↑↓';
  }

  @Builder
  SizeControls() {
    Column() {
      Row() {
        Text($r('app.string.label_width'))
          .fontSize(10)
          .fontColor($r('app.color.size_color'))
          .width(20)
        Slider({ value: this.layoutState.explicitWidth, min: 40, max: 150, step: 5 })
          .onChange((value: number) => { this.layoutState.explicitWidth = value; })
          .layoutWeight(1)
          .trackThickness(2)
          .blockSize({ width: 12, height: 12 })
        Text(`${this.layoutState.explicitWidth}`)
          .fontSize(9)
          .fontColor($r('app.color.text_hint'))
          .width(25)
      }
      .width('100%')
      .height(20)

      Row() {
        Text($r('app.string.label_height'))
          .fontSize(10)
          .fontColor($r('app.color.size_color'))
          .width(20)
        Slider({ value: this.layoutState.explicitHeight, min: 40, max: 150, step: 5 })
          .onChange((value: number) => { this.layoutState.explicitHeight = value; })
          .layoutWeight(1)
          .trackThickness(2)
          .blockSize({ width: 12, height: 12 })
        Text(`${this.layoutState.explicitHeight}`)
          .fontSize(9)
          .fontColor($r('app.color.text_hint'))
          .width(25)
      }
      .width('100%')
      .height(20)
      .margin({ top: 4 })
    }
  }

  @Builder
  SizingControls() {
    Column() {
      Row() {
        Text($r('app.string.label_min'))
          .fontSize(9)
          .fontColor($r('app.color.sizing_color'))
          .width(28)
        Slider({ value: this.layoutState.minWidth, min: 20, max: 80, step: 5 })
          .onChange((value: number) => { this.layoutState.minWidth = value; })
          .layoutWeight(1)
          .trackThickness(2)
          .blockSize({ width: 12, height: 12 })
        Text(`${this.layoutState.minWidth}`)
          .fontSize(9)
          .fontColor($r('app.color.text_hint'))
          .width(25)
      }
      .width('100%')
      .height(20)

      Row() {
        Text($r('app.string.label_max'))
          .fontSize(9)
          .fontColor($r('app.color.sizing_color'))
          .width(28)
        Slider({ value: this.layoutState.maxWidth, min: 70, max: 160, step: 5 })
          .onChange((value: number) => { this.layoutState.maxWidth = value; })
          .layoutWeight(1)
          .trackThickness(2)
          .blockSize({ width: 12, height: 12 })
        Text(`${this.layoutState.maxWidth}`)
          .fontSize(9)
          .fontColor($r('app.color.text_hint'))
          .width(25)
      }
      .width('100%')
      .height(20)
      .margin({ top: 4 })

      Row() {
        Text($r('app.string.label_weight'))
          .fontSize(9)
          .fontColor($r('app.color.sizing_color'))
          .width(28)
        Slider({ value: this.layoutState.layoutWeight, min: 0.5, max: 3, step: 0.5 })
          .onChange((value: number) => { this.layoutState.layoutWeight = value; })
          .layoutWeight(1)
          .trackThickness(2)
          .blockSize({ width: 12, height: 12 })
        Text(this.layoutState.layoutWeight.toFixed(1))
          .fontSize(9)
          .fontColor($r('app.color.text_hint'))
          .width(25)
      }
      .width('100%')
      .height(20)
      .margin({ top: 4 })
    }
  }

  @Builder
  MarginTypeControls() {
    Column() {
      Row() {
        this.MarginTypeButton('U', 'UNIFORM')
        this.MarginTypeButton('H', 'HORIZONTAL')
        this.MarginTypeButton('V', 'VERTICAL')
        this.MarginTypeButton('I', 'INDIVIDUAL')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .height(36)

      if (this.layoutState.marginType === 'INDIVIDUAL') {
        Column() {
          Divider().height(1).color($r('app.color.border_dark')).margin({ top: 8, bottom: 8 })

          Row() {
            Text($r('app.string.label_left'))
              .fontSize(9)
              .fontColor($r('app.color.margin_color'))
              .width(35)
            Slider({ value: this.layoutState.marginLeft, min: 0, max: 40, step: 2 })
              .onChange((value: number) => { this.layoutState.marginLeft = value; })
              .layoutWeight(1)
              .trackThickness(2)
              .blockSize({ width: 12, height: 12 })
            Text(`${this.layoutState.marginLeft}`)
              .fontSize(9)
              .fontColor($r('app.color.text_hint'))
              .width(25)
          }
          .width('100%')
          .height(20)
          .margin({ bottom: 6 })

          Row() {
            Text($r('app.string.label_top'))
              .fontSize(9)
              .fontColor($r('app.color.margin_color'))
              .width(35)
            Slider({ value: this.layoutState.marginTop, min: 0, max: 40, step: 2 })
              .onChange((value: number) => { this.layoutState.marginTop = value; })
              .layoutWeight(1)
              .trackThickness(2)
              .blockSize({ width: 12, height: 12 })
            Text(`${this.layoutState.marginTop}`)
              .fontSize(9)
              .fontColor($r('app.color.text_hint'))
              .width(25)
          }
          .width('100%')
          .height(20)
          .margin({ bottom: 6 })

          Row() {
            Text($r('app.string.label_right'))
              .fontSize(9)
              .fontColor($r('app.color.margin_color'))
              .width(35)
            Slider({ value: this.layoutState.marginRight, min: 0, max: 40, step: 2 })
              .onChange((value: number) => { this.layoutState.marginRight = value; })
              .layoutWeight(1)
              .trackThickness(2)
              .blockSize({ width: 12, height: 12 })
            Text(`${this.layoutState.marginRight}`)
              .fontSize(9)
              .fontColor($r('app.color.text_hint'))
              .width(25)
          }
          .width('100%')
          .height(20)
          .margin({ bottom: 6 })

          Row() {
            Text($r('app.string.label_bottom'))
              .fontSize(9)
              .fontColor($r('app.color.margin_color'))
              .width(35)
            Slider({ value: this.layoutState.marginBottom, min: 0, max: 40, step: 2 })
              .onChange((value: number) => { this.layoutState.marginBottom = value; })
              .layoutWeight(1)
              .trackThickness(2)
              .blockSize({ width: 12, height: 12 })
            Text(`${this.layoutState.marginBottom}`)
              .fontSize(9)
              .fontColor($r('app.color.text_hint'))
              .width(25)
          }
          .width('100%')
          .height(20)
        }
      }
    }
  }

  @Builder
  MarginTypeButton(shortName: string, fullName: string) {
    Button(shortName)
      .fontSize(11)  // DOĞRUDAN SAYI - resource değil!
      .fontWeight(FontWeight.Normal)
      .height(32)    // DOĞRUDAN SAYI - resource değil!
      .width(50)
      .backgroundColor(this.layoutState.marginType === fullName ? $r('app.color.button_active') : $r('app.color.button_inactive'))
      .onClick(() => {
        this.layoutState.marginType = fullName;
        if (fullName === 'UNIFORM') {
          this.layoutState.marginLeft = 20;
          this.layoutState.marginTop = 20;
          this.layoutState.marginRight = 20;
          this.layoutState.marginBottom = 20;
        } else if (fullName === 'HORIZONTAL') {
          this.layoutState.marginLeft = 30;
          this.layoutState.marginTop = 5;
          this.layoutState.marginRight = 30;
          this.layoutState.marginBottom = 5;
        } else if (fullName === 'VERTICAL') {
          this.layoutState.marginLeft = 5;
          this.layoutState.marginTop = 30;
          this.layoutState.marginRight = 5;
          this.layoutState.marginBottom = 30;
        }
      })
  }

  @Builder
  BottomOffsetControls() {
      Row() {
        Text($r('app.string.label_offset'))
          .fontSize(10)
          .fontColor($r('app.color.bottom_offset_color'))
          .width(35)
        Slider({ value: this.layoutState.bottomOffset, min: 0, max: 50, step: 5 })
          .onChange((value: number) => { this.layoutState.bottomOffset = value; })
          .layoutWeight(1)
          .trackThickness(2)
          .blockSize({ width: 12, height: 12 })
        Text(`${this.layoutState.bottomOffset}px`)
          .fontSize(9)
          .fontColor($r('app.color.text_hint'))
          .width(30)
      }
      .width('100%')
      .height(20)
  }

  @Builder
  PositionControls() {
    Column() {
      Row() {
        Text($r('app.string.label_position_x'))
          .fontSize(10)
          .fontColor($r('app.color.position_color'))
          .width(20)
        Slider({ value: this.layoutState.positionX, min: 0, max: 230, step: 5 })
          .onChange((value: number) => { this.layoutState.positionX = value; })
          .layoutWeight(1)
          .trackThickness(2)
          .blockSize({ width: 12, height: 12 })
        Text(`${Math.round(this.layoutState.positionX)}`)
          .fontSize(9)
          .fontColor($r('app.color.text_hint'))
          .width(25)
      }
      .width('100%')
      .height(20)

      Row() {
        Text($r('app.string.label_position_y'))
          .fontSize(10)
          .fontColor($r('app.color.position_color'))
          .width(20)
        Slider({ value: this.layoutState.positionY, min: 0, max: 230, step: 5 })
          .onChange((value: number) => { this.layoutState.positionY = value; })
          .layoutWeight(1)
          .trackThickness(2)
          .blockSize({ width: 12, height: 12 })
        Text(`${Math.round(this.layoutState.positionY)}`)
          .fontSize(9)
          .fontColor($r('app.color.text_hint'))
          .width(25)
      }
      .width('100%')
      .height(20)
      .margin({ top: 4 })
    }
  }

  @Builder
  OffsetControls() {
    Column() {
      Row() {
        Text($r('app.string.label_offset_x'))
          .fontSize(10)
          .fontColor($r('app.color.offset_color'))
          .width(25)
        Slider({ value: this.layoutState.offsetX, min: -40, max: 40, step: 5 })
          .onChange((value: number) => { this.layoutState.offsetX = value; })
          .layoutWeight(1)
          .trackThickness(2)
          .blockSize({ width: 12, height: 12 })
        Text(`${this.layoutState.offsetX}`)
          .fontSize(9)
          .fontColor($r('app.color.text_hint'))
          .width(25)
      }
      .width('100%')
      .height(20)

      Row() {
        Text($r('app.string.label_offset_y'))
          .fontSize(10)
          .fontColor($r('app.color.offset_color'))
          .width(25)
        Slider({ value: this.layoutState.offsetY, min: -40, max: 40, step: 5 })
          .onChange((value: number) => { this.layoutState.offsetY = value; })
          .layoutWeight(1)
          .trackThickness(2)
          .blockSize({ width: 12, height: 12 })
        Text(`${this.layoutState.offsetY}`)
          .fontSize(9)
          .fontColor($r('app.color.text_hint'))
          .width(25)
      }
      .width('100%')
      .height(20)
      .margin({ top: 4 })

      Text($r('app.string.hint_offset_realtime'))
        .fontSize(8)
        .fontColor($r('app.color.offset_color'))
        .margin({ top: 6 })
        .textAlign(TextAlign.Center)
        .width('100%')
    }
  }

  @Builder
  LocationControls() {
    Row() {
      Text(`${$r('app.string.symbol_location')} ${Math.round(this.layoutState.componentX)},${Math.round(this.layoutState.componentY)}`)
        .fontSize(9)
        .fontColor($r('app.color.location_color'))
      Blank()
      Text(`${$r('app.string.symbol_dimension')} ${Math.round(this.layoutState.componentWidth)}x${Math.round(this.layoutState.componentHeight)}`)
        .fontSize(9)
        .fontColor($r('app.color.location_color'))
    }
    .width('100%')
    .height(20)
  }

  @Builder
  SafeAreaControls() {
    Row() {
      Text($r('app.string.label_safe'))
        .fontSize(10)
        .fontColor($r('app.color.text_primary'))

      Toggle({ type: ToggleType.Switch, isOn: this.layoutState.safeAreaEnabled })
        .onChange((isOn: boolean) => { this.layoutState.safeAreaEnabled = isOn; })
        .width(30)
        .height(16)

      Blank()

      if (this.layoutState.safeAreaEnabled) {
        Text($r('app.string.symbol_check'))
          .fontSize(12)
          .fontColor($r('app.color.status_safe'))
      } else {
        Text($r('app.string.symbol_warning'))
          .fontSize(12)
          .fontColor($r('app.color.status_critical'))
      }
    }
    .width('100%')
    .height(24)
  }
}