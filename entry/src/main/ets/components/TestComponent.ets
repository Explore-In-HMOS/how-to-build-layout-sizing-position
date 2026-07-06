import { LayoutState } from '../model/LayoutState';
import { GeometryUtils } from '../utils/GeometryUtils';

@Component
export struct TestComponent {
  @Consume layoutState: LayoutState;

  @State componentX: number = 0;
  @State componentY: number = 0;
  @State componentWidth: number = 0;
  @State componentHeight: number = 0;

  private geometryUtils: GeometryUtils = new GeometryUtils(320, 320);

  aboutToAppear() {
    this.componentX = 115;
    this.componentY = 115;
    this.componentWidth = 90;
    this.componentHeight = 90;
  }

  private updateClipStatus() {
    const result = this.geometryUtils.checkClipping(
      this.componentX, this.componentY,
      this.componentWidth, this.componentHeight
    );
    this.layoutState.clipStatus = result.status;
    this.layoutState.clipDepth = result.depth;
  }

  build() {
    this.CurrentView();
  }

  @Builder
  CurrentView() {
    if (this.layoutState.currentModule === 1) {
      this.SizeView();
    } else if (this.layoutState.currentModule === 2) {
      this.SizingView();
    } else if (this.layoutState.currentModule === 3) {
      this.MarginTypeView();
    } else if (this.layoutState.currentModule === 4) {
      this.BottomOffsetView();
    } else if (this.layoutState.currentModule === 5) {
      this.PositionView();
    } else if (this.layoutState.currentModule === 6) {
      this.OffsetView();
    } else if (this.layoutState.currentModule === 7) {
      this.LocationView();
    } else if (this.layoutState.currentModule === 8) {
      this.SafeAreaView();
    } else {
      this.SizeView();
    }
  }

  @Builder
  SizeView() {
    Column() {
      Text($r('app.string.text_size'))
        .fontSize($r('app.float.font_xlarge'))
        .fontColor($r('app.color.text_primary'))
      Text(`${this.layoutState.explicitWidth}x${this.layoutState.explicitHeight}`)
        .fontSize($r('app.float.font_medium'))
        .fontColor($r('app.color.text_secondary'))
    }
    .width(this.layoutState.explicitWidth)
    .height(this.layoutState.explicitHeight)
    .backgroundColor($r('app.color.size_color'))
    .borderRadius($r('app.float.radius_button'))
    .justifyContent(FlexAlign.Center)
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.componentX = newValue.globalPosition.x as number;
      this.componentY = newValue.globalPosition.y as number;
      this.componentWidth = newValue.width as number;
      this.componentHeight = newValue.height as number;
      this.updateClipStatus();
    })
  }

  @Builder
  SizingView() {
    Column() {
      Text($r('app.string.text_sizing'))
        .fontSize($r('app.float.font_xlarge'))
        .fontColor($r('app.color.text_primary'))
      Text(`Wgt:${this.layoutState.layoutWeight}`)
        .fontSize($r('app.float.font_medium'))
        .fontColor($r('app.color.text_secondary'))
    }
    .constraintSize({
      minWidth: this.layoutState.minWidth,
      maxWidth: this.layoutState.maxWidth,
      minHeight: 40,
      maxHeight: 80
    })
    .layoutWeight(this.layoutState.layoutWeight)
    .backgroundColor($r('app.color.sizing_color'))
    .borderRadius($r('app.float.radius_button'))
    .justifyContent(FlexAlign.Center)
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.componentX = newValue.globalPosition.x as number;
      this.componentY = newValue.globalPosition.y as number;
      this.componentWidth = newValue.width as number;
      this.componentHeight = newValue.height as number;
      this.updateClipStatus();
    })
  }

  @Builder
  MarginTypeView() {
    Column() {
      Text($r('app.string.text_margin'))
        .fontSize($r('app.float.font_xlarge'))
        .fontColor($r('app.color.text_primary'))
      Text(`L:${this.layoutState.marginLeft} T:${this.layoutState.marginTop} R:${this.layoutState.marginRight} B:${this.layoutState.marginBottom}`)
        .fontSize($r('app.float.font_small'))
        .fontColor($r('app.color.text_secondary'))
        .margin({ top: 4 })
    }
    .width(100)
    .height(70)
    .backgroundColor($r('app.color.margin_color'))
    .borderRadius($r('app.float.radius_button'))
    .justifyContent(FlexAlign.Center)
    .margin({
      left: this.layoutState.marginLeft,
      top: this.layoutState.marginTop,
      right: this.layoutState.marginRight,
      bottom: this.layoutState.marginBottom
    })
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.componentX = newValue.globalPosition.x as number;
      this.componentY = newValue.globalPosition.y as number;
      this.componentWidth = newValue.width as number;
      this.componentHeight = newValue.height as number;
      this.updateClipStatus();
    })
  }

  @Builder
  BottomOffsetView() {
    Column() {
      Text($r('app.string.text_bottom'))
        .fontSize($r('app.float.font_xlarge'))
        .fontColor($r('app.color.text_primary'))
      Text(`Offset:${this.layoutState.bottomOffset}`)
        .fontSize($r('app.float.font_medium'))
        .fontColor($r('app.color.text_secondary'))
    }
    .width(120)
    .height(40)
    .backgroundColor($r('app.color.bottom_offset_color'))
    .borderRadius($r('app.float.radius_pill'))
    .justifyContent(FlexAlign.Center)
    .margin({ bottom: this.layoutState.bottomOffset })
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.componentX = newValue.globalPosition.x as number;
      this.componentY = newValue.globalPosition.y as number;
      this.componentWidth = newValue.width as number;
      this.componentHeight = newValue.height as number;
      this.updateClipStatus();
    })
  }

  @Builder
  PositionView() {
    Column() {
      Text($r('app.string.text_position'))
        .fontSize($r('app.float.font_xlarge'))
        .fontColor($r('app.color.text_primary'))
      Text(`${Math.round(this.layoutState.positionX)},${Math.round(this.layoutState.positionY)}`)
        .fontSize($r('app.float.font_small'))
        .fontColor($r('app.color.text_secondary'))
    }
    .width(80)
    .height(50)
    .backgroundColor($r('app.color.position_color'))
    .borderRadius($r('app.float.radius_button'))
    .justifyContent(FlexAlign.Center)
    .position({ x: this.layoutState.positionX, y: this.layoutState.positionY })
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.componentX = newValue.globalPosition.x as number;
      this.componentY = newValue.globalPosition.y as number;
      this.componentWidth = newValue.width as number;
      this.componentHeight = newValue.height as number;
      this.updateClipStatus();
    })
  }

  @Builder
  OffsetView() {
    Column() {
      Text($r('app.string.text_offset_demo'))
        .fontSize($r('app.float.font_xlarge'))
        .fontColor($r('app.color.text_primary'))
      Text(`ΔX: ${this.layoutState.offsetX}  ΔY: ${this.layoutState.offsetY}`)
        .fontSize($r('app.float.font_medium'))
        .fontColor($r('app.color.text_secondary'))
    }
    .width(90)
    .height(65)
    .backgroundColor($r('app.color.offset_color'))
    .borderRadius($r('app.float.radius_round_button'))
    .justifyContent(FlexAlign.Center)
    .offset({ x: this.layoutState.offsetX, y: this.layoutState.offsetY })
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.componentX = newValue.globalPosition.x as number;
      this.componentY = newValue.globalPosition.y as number;
      this.componentWidth = newValue.width as number;
      this.componentHeight = newValue.height as number;
      this.updateClipStatus();
    })
  }

  @Builder
  LocationView() {
    Column() {
      Text($r('app.string.text_location'))
        .fontSize($r('app.float.font_xlarge'))
        .fontColor($r('app.color.text_primary'))
      Text(`X:${Math.round(this.componentX)} Y:${Math.round(this.componentY)}`)
        .fontSize($r('app.float.font_small'))
        .fontColor($r('app.color.text_secondary'))
    }
    .width(110)
    .height(60)
    .backgroundColor($r('app.color.location_color'))
    .borderRadius($r('app.float.radius_button'))
    .justifyContent(FlexAlign.Center)
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.componentX = newValue.globalPosition.x as number;
      this.componentY = newValue.globalPosition.y as number;
      this.componentWidth = newValue.width as number;
      this.componentHeight = newValue.height as number;
      this.updateClipStatus();

      this.layoutState.componentX = this.componentX;
      this.layoutState.componentY = this.componentY;
      this.layoutState.componentWidth = this.componentWidth;
      this.layoutState.componentHeight = this.componentHeight;
    })
  }

  @Builder
  SafeAreaView() {
    Column() {
      Text($r('app.string.text_safe_area'))
        .fontSize($r('app.float.font_xlarge'))
        .fontColor($r('app.color.text_primary'))
      Text($r('app.string.text_round_display'))
        .fontSize($r('app.float.font_small'))
        .fontColor($r('app.color.text_secondary'))
    }
    .width('80%')
    .height(70)
    .backgroundColor($r('app.color.safe_area_color'))
    .borderRadius($r('app.float.radius_button'))
    .justifyContent(FlexAlign.Center)
    .safeAreaPadding(
      this.layoutState.safeAreaEnabled ?
        { top: 15, bottom: 20, left: 12, right: 12 } :
        { top: 0, bottom: 0, left: 0, right: 0 }
    )
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.componentX = newValue.globalPosition.x as number;
      this.componentY = newValue.globalPosition.y as number;
      this.componentWidth = newValue.width as number;
      this.componentHeight = newValue.height as number;
      this.updateClipStatus();
    })
  }
}