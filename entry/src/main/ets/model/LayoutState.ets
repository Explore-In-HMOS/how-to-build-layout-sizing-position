@Observed
export class LayoutState {
  // Modül yönetimi
  currentModule: number = 3;
  moduleNames: string[] = [
    $r('app.string.module_size').toString(),
    $r('app.string.module_sizing').toString(),
    $r('app.string.module_margin').toString(),
    $r('app.string.module_bottom_offset').toString(),
    $r('app.string.module_position').toString(),
    $r('app.string.module_offset').toString(),
    $r('app.string.module_location').toString(),
    $r('app.string.module_safe_area').toString()
  ];

  // Size module (1)
  explicitWidth: number = 90;
  explicitHeight: number = 90;

  // Sizing module (2)
  minWidth: number = 30;
  maxWidth: number = 120;
  layoutWeight: number = 1;

  // MarginType module (3)
  marginType: string = 'UNIFORM';
  marginLeft: number = 20;
  marginTop: number = 20;
  marginRight: number = 20;
  marginBottom: number = 20;

  // BottomOffset module (4)
  bottomOffset: number = 0;

  // Position module (5)
  positionX: number = 115;
  positionY: number = 115;

  // Offset module (6)
  offsetX: number = 0;
  offsetY: number = 0;
  isAnimating: boolean = false;

  // Location module (7)
  componentX: number = 0;
  componentY: number = 0;
  componentWidth: number = 0;
  componentHeight: number = 0;

  // Safe Area module (8)
  safeAreaEnabled: boolean = true;

  // UI durumu
  showCoordinates: boolean = true;
  clipStatus: string = 'Safe';
  clipDepth: number = 0;
}