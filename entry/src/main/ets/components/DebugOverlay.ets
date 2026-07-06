import { LayoutState } from '../model/LayoutState';

@Component
export struct DebugOverlay {
  @Consume layoutState: LayoutState;
  @Prop screenSize: number = 320;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private intervalId: number = -1;

  aboutToAppear() {
    this.startDrawing();
  }

  aboutToDisappear() {
    if (this.intervalId !== -1) {
      clearInterval(this.intervalId);
    }
  }

  private startDrawing(): void {
    this.intervalId = setInterval(() => {
      this.draw();
    }, 50);
  }

  private draw(): void {
    if (!this.canvasContext) { return };

    const center: number = this.screenSize / 2;
    const radius: number = center;

    this.canvasContext.clearRect(0, 0, this.screenSize, this.screenSize);

    this.canvasContext.beginPath();
    this.canvasContext.arc(center, center, radius, 0, 2 * Math.PI);
    this.canvasContext.strokeStyle = '#2A2A2A';
    this.canvasContext.lineWidth = 1.5;
    this.canvasContext.stroke();

    this.canvasContext.setLineDash([4, 6]);
    this.canvasContext.lineWidth = 0.8;
    this.canvasContext.strokeStyle = '#444444';

    this.canvasContext.beginPath();
    this.canvasContext.moveTo(15, center);
    this.canvasContext.lineTo(this.screenSize - 15, center);
    this.canvasContext.stroke();

    this.canvasContext.beginPath();
    this.canvasContext.moveTo(center, 15);
    this.canvasContext.lineTo(center, this.screenSize - 15);
    this.canvasContext.stroke();

    this.canvasContext.setLineDash([]);
    this.canvasContext.fillStyle = '#666666';
    this.canvasContext.beginPath();
    this.canvasContext.arc(center, center, 2, 0, 2 * Math.PI);
    this.canvasContext.fill();

    const x: number = this.layoutState.componentX;
    const y: number = this.layoutState.componentY;
    const w: number = this.layoutState.componentWidth;
    const h: number = this.layoutState.componentHeight;

    if (w > 0 && h > 0) {
      let boxColor: string = '#00FF00';
      if (this.layoutState.clipStatus === 'Warning') {
        boxColor = '#FFA500';
      } else if (this.layoutState.clipStatus === 'Critical') {
        boxColor = '#FF0000';
      }

      this.canvasContext.strokeStyle = boxColor;
      this.canvasContext.lineWidth = 1.5;
      this.canvasContext.setLineDash([4, 4]);
      this.canvasContext.strokeRect(x, y, w, h);

      this.canvasContext.setLineDash([]);
      this.canvasContext.fillStyle = boxColor;
      const markerSize: number = 3;
      this.canvasContext.fillRect(x - markerSize, y - markerSize, markerSize, markerSize);
      this.canvasContext.fillRect(x + w, y - markerSize, markerSize, markerSize);
      this.canvasContext.fillRect(x - markerSize, y + h, markerSize, markerSize);
      this.canvasContext.fillRect(x + w, y + h, markerSize, markerSize);

      if (this.layoutState.clipDepth > 3) {
        this.canvasContext.font = '7px Arial';
        this.canvasContext.fillStyle = '#FF0000';
        this.canvasContext.fillText(`!${this.layoutState.clipDepth}px`, x, y - 3);
      }
    }

    if (this.layoutState.currentModule === 8) {
      const safeRadius: number = radius - 20;

      this.canvasContext.beginPath();
      this.canvasContext.arc(center, center, safeRadius, 0, 2 * Math.PI);

      if (this.layoutState.safeAreaEnabled) {
        this.canvasContext.fillStyle = 'rgba(0, 255, 0, 0.05)';
        this.canvasContext.fill();
        this.canvasContext.strokeStyle = '#00FF00';
      } else {
        this.canvasContext.fillStyle = 'rgba(255, 0, 0, 0.05)';
        this.canvasContext.fill();
        this.canvasContext.strokeStyle = '#FF0000';
      }

      this.canvasContext.setLineDash([3, 4]);
      this.canvasContext.lineWidth = 1;
      this.canvasContext.stroke();
    }
  }

  build() {
    Canvas(this.canvasContext)
      .width(this.screenSize)
      .height(this.screenSize)
      .position({ x: 0, y: 0 })
      .hitTestBehavior(HitTestMode.None)
  }
}