package lib;

@:enum
abstract Direction(Int) from Int to Int {
  public static var OPPOSITE:Map<Direction, Direction> = [
       Top => Bottom
      ,Right => Left
      ,Bottom => Top
      ,Left => Right
    ];
  
  var Top = 0;
  var Right = 1;
  var Bottom = 2;
  var Left = 3;
}
