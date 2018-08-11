package lib;

class Room {
  static var GEN_X:Int = 0;
  static var GEN_Y:Int = 0;
  public static inline var MAP_HEIGHT:Int = 7;
  public static inline var MAP_WIDTH:Int = 5;
  
  public static var INDEX:Map<String, Room> = {
      POS_INDEX = new Map();
      var rm = [ for (r in ([
               {n: "start", i: [], oe: [Right], d: "Starting room"}
              ,{n: "1-0", i: [], oe: [Left], ce: [Right], d: ""}
              ,{n: "robogym", i: [], oe: [Left], d: "Robogym"}
              ,{n: "king", i: [], oe: [Right], d: "King's Court"}
              ,{n: "bridge", i: [], oe: [], d: "Drawbridge"}
            ]:Array<{n:String, i:Array<String>, ?oe:Array<ExitPosition>, ?ce:Array<ExitPosition>, d:String}>))
          r.n => new Room(
               r.n, r.i
              ,(r.oe == null ? [] : [ for (k in r.oe) new Exit("", k, true) ])
                .concat(r.ce == null ? [] : [ for (k in r.ce) new Exit("", k, false) ])
              ,r.d
            )
        ];
      for (y in 0...MAP_HEIGHT) for (x in 0...MAP_WIDTH) {
        var r = POS_INDEX[RPos.xy(x, y)];
        if (r == null) continue;
        for (e in r.exits) {
          e.to = POS_INDEX[switch (e.pos) {
              case Top: RPos.xy(x, y - 1);
              case Right: RPos.xy(x + 1, y);
              case Bottom: RPos.xy(x, y + 1);
              case Left: RPos.xy(x - 1, y);
            }].name;
        }
      }
      rm;
    };
  public static var POS_INDEX:Map<RPos, Room>;
  
  public var x:Int;
  public var y:Int;
  public var name:String;
  public var interactives:Array<String>;
  public var exits:Array<Exit>;
  public var desc:String;
  
  public function new(n:String, i:Array<String>, e:Array<Exit>, d:String) {
    x = GEN_X;
    y = GEN_Y;
    POS_INDEX[RPos.xy(x, y)] = this;
    if (GEN_X++ >= 5) {
      GEN_X = 0;
      GEN_Y++;
    }
    this.name = n;
    this.interactives = i;
    this.exits = e;
    this.desc = d;
  }
}

class Exit {
  public var to:String;
  public var pos:ExitPosition;
  public var open:Bool;
  
  public function new(to:String, pos:ExitPosition, ?open:Bool = true) {
    this.to = to;
    this.pos = pos;
    this.open = open;
  }
}

enum ExitPosition {
  Top;
  Right;
  Bottom;
  Left;
}
