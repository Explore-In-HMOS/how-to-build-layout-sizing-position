export interface ClipResult {
  status: string;
  depth: number;
}

export interface SafeAreaPadding {
  top: number;
  bottom: number;
  left: number;
  right: number;
}

export interface ClampedPosition {
  x: number;
  y: number;
}

export class GeometryUtils {
  private screenWidth: number = 320;
  private screenHeight: number = 320;
  private centerX: number = 160;
  private centerY: number = 160;
  private radius: number = 160;

  constructor(width: number, height: number) {
    this.screenWidth = width;
    this.screenHeight = height;
    this.centerX = width / 2;
    this.centerY = height / 2;
    this.radius = Math.min(width, height) / 2;
  }

  checkClipping(x: number, y: number, w: number, h: number): ClipResult {
    const cornersX: Float64Array = new Float64Array([x, x + w, x, x + w]);
    const cornersY: Float64Array = new Float64Array([y, y, y + h, y + h]);

    let maxDistance: number = 0;
    let clippedCount: number = 0;

    for (let i = 0; i < cornersX.length; i++) {
      const dx: number = cornersX[i] - this.centerX;
      const dy: number = cornersY[i] - this.centerY;
      const distance: number = Math.sqrt(dx * dx + dy * dy);

      if (distance > this.radius) {
        clippedCount++;
        const depth: number = distance - this.radius;
        if (depth > maxDistance) { maxDistance = depth };
      }
    }

    let status: string = 'Safe';
    if (clippedCount === 0) {
      status = 'Safe';
    } else if (clippedCount <= 2) {
      status = 'Warning';
    } else {
      status = 'Critical';
    }

    const result: ClipResult = {
      status: status,
      depth: Math.ceil(maxDistance)
    };
    return result;
  }

  getSafeAreaPadding(): SafeAreaPadding {
    const safeMargin: number = 20;
    const padding: SafeAreaPadding = {
      top: safeMargin,
      bottom: safeMargin,
      left: safeMargin,
      right: safeMargin
    };
    return padding;
  }

  clampToScreen(x: number, y: number, w: number, h: number): ClampedPosition {
    let newX: number = x;
    let newY: number = y;

    if (x < 0) { newX = 0 };
    if (x > this.screenWidth - w) { newX = this.screenWidth - w };
    if (y < 0) { newY = 0 };
    if (y > this.screenHeight - h) { newY = this.screenHeight - h };

    const result: ClampedPosition = { x: newX, y: newY };
    return result;
  }
}