package lib;

class Room {
  static var GEN_X:Int = 0;
  static var GEN_Y:Int = 0;
  public static inline var MAP_HEIGHT:Int = 7;
  public static inline var MAP_WIDTH:Int = 5;
  
  public static var INDEX:Map<String, Room> = {
      POS_INDEX = new Map();
      var EXL:RoomObject = Exit(0, -3, 2, 3, Left, false);
      var EXR:RoomObject = Exit(13, -3, 2, 3, Right, false);
      var rm = [ for (r in ([
              {
                 n: "start"
                ,o: [
                   Exit(7, -4, 2, 3, Top, true)
                  ,EXR
                ]
                ,l: [Colour(36), Stars, Ground(0), Ragdoll("player"), Ground(1)]
                ,i: []
                ,oe: [Right]
                ,d: "Starting room"
                ,m: "loop-wind"
              }, {
                 n: "bonsai"
                ,o: [
                   EXL
                  ,EXR
                  ,Exit(4, 0, 2, 3, Bottom, true)
                  ,Ragdoll("ss", ["idleHumanL", "idleHumanR"], 10, 0, "ss1")
                ]
                ,l: [Ground(0), Visual("bonsai-doors"), Ragdoll("ss"), Ragdoll("player"), Ground(1)]
                ,i: ["ss1"]
                ,oe: [Left, Bottom]
                ,ce: [Right]
                ,d: "Bonsai"
                ,m: "theme-main"
              }, {
                 n: "robogym"
                ,o: [
                   EXL
                  ,Ragdoll("climber", ["climbU"], 10, 0, "climber")
                ]
                ,l: [Ground(1), Visual("ladder"), Ragdoll("climber"), Ground(0), Ragdoll("player"), Ground(2)]
                ,i: ["climber"]
                ,oe: [Left]
                ,d: "Ascension"
                ,m: "loop-mecha"
              }, {
                 n: "king"
                ,o: [
                   EXR
                  ,Ragdoll("king", ["sitR", "sitR"], 2, -1, "king")
                ]
                ,l: [Ground(0), Ragdoll("king"), Ground(1), Ragdoll("player")]
                ,i: ["king"]
                ,oe: [Right]
                ,d: "King's Court"
                ,m: "theme-cuttlefish"
              }, {
                 n: "bridge"
                ,o: [
                   EXL
                  ,Exit(9, 0, 2, 3, Bottom, true)
                  ,Ragdoll("guard", ["idleHumanL", "idleHumanR"], 3, 0, "guard")
                ]
                ,l: [Ground(0), Ragdoll("guard"), Ragdoll("player"), Ground(1)]
                ,i: ["guard"]
                ,ce: [Left]
                ,oe: [Bottom]
                ,d: "Drawbridge"
                ,m: "theme-cuttlefish"
              }, {
                 n: "hey"
                ,o: [
                   EXR
                  ,Ragdoll("hey", ["idleHumanL", "idleHumanR"], 5, 0, "hey")
                ]
                ,l: [Ground(0), Ragdoll("hey"), Ragdoll("player"), Ground(1)]
                ,i: ["hey"]
                ,oe: [Right]
                ,d: "Social room"
                ,m: "theme-main"
              }, {
                 n: "bunker"
                ,o: [
                   EXL
                  ,EXR
                  ,Exit(4, -4, 2, 3, Top, true)
                  ,Exit(4, 0, 2, 3, Bottom, true)
                ]
                ,l: [Ground(0), Ragdoll("player"), Ground(1)]
                ,i: []
                ,oe: [Top, Right, Bottom, Left]
                ,d: "Bunker"
                ,m: "theme-main"
              }, {
                 n: "rev"
                ,o: [
                   EXL
                  ,Interaction("rev", 4, -4, 11, 4)
                ]
                ,l: [Ground(0), Ragdoll("player"), Ground(1)]
                ,i: ["rev"]
                ,oe: [Left]
                ,d: "Zorktown Turntable"
                ,m: "theme-main"
              }, {
                 n: "rap"
                ,o: [
                   EXR
                  ,Exit(4, 0, 2, 3, Bottom, true)
                  ,Ragdoll("rap", ["idleHumanL", "idleHumanR"], 4, -2, "rap")
                ]
                ,l: [Ground(0), Ragdoll("rap"), Ragdoll("player"), Ground(1)]
                ,i: ["rap"]
                ,oe: [Right, Bottom]
                ,d: "Freestyle"
                ,m: "theme-noise"
              }, {
                 n: "sensei"
                ,o: [
                   EXL
                  ,Exit(7, -4, 2, 3, Top, true)
                  ,Ragdoll("ss", ["idleHumanL", "idleHumanR"], 5, 0, "ss2")
                ]
                ,l: [Ground(0), Ragdoll("ss"), Ragdoll("player"), Ground(1)]
                ,i: ["ss2"]
                ,ce: [Top]
                ,oe: [Left]
                ,d: "Sensei"
                ,m: "theme-main"
              }, {
                 n: "seashore"
                ,o: [
                   EXR
                  ,Ragdoll("pirate", ["idleHumanL", "idleHumanL"], 7, 0, "c-")
                ]
                ,l: [Ground(0), Ragdoll("pirate"), Ragdoll("player"), Ground(1)]
                ,i: ["c-"]
                ,oe: [Right]
                ,d: "Seashore"
                ,m: "theme-noise"
              }, {
                 n: "comedy"
                ,o: [
                   Exit(4, -4, 2, 3, Top, true)
                  ,EXR
                  ,EXL
                  ,Ragdoll("general", ["idleHumanL", "idleHumanR"], 9, -2, "general")
                ]
                ,l: [Ground(0), Ragdoll("general"), Ragdoll("player"), Ground(1)]
                ,i: ["general"]
                ,oe: [Top, Right, Left]
                ,d: "The General"
                ,m: "theme-main"
              }, {
                 n: "shaft"
                ,o: [
                   EXR
                  ,Exit(4, 0, 2, 3, Bottom, true)
                  ,EXL
                  ,Interaction("lock", 5, -3, 3, 3)
                ]
                ,l: [Ground(0), Ragdoll("player"), Visual("shaft-trapdoor"), Ground(1)]
                ,i: ["lock"]
                ,ce: [Bottom]
                ,oe: [Left, Right]
                ,d: "Maintenance Shaft 17"
                ,m: "theme-main"
              }, {
                 n: "ad"
                ,o: [
                   Exit(4, -4, 2, 3, Top, true)
                  ,Exit(4, 0, 2, 3, Bottom, true)
                  ,EXL
                ]
                ,l: [Ground(0), Ragdoll("player"), Ground(1)]
                ,i: []
                ,oe: [Top, Bottom, Left]
                ,d: "Advertisement"
                ,m: "theme-noise"
              }, {
                 n: "kitchen"
                ,o: [
                   Exit(4, 0, 2, 3, Bottom, true)
                  ,Ragdoll("chef", ["idleHumanL", "idleHumanL"], 12, 1, "1cut")
                ]
                ,l: [Ground(2), Ragdoll("chef"), Ground(0), Ragdoll("player"), Ground(1)]
                ,i: ["1cut"]
                ,oe: [Bottom]
                ,d: "Kitchen"
                ,m: "theme-main"
              }, {
                 n: "funfair"
                ,o: [
                   Exit(4, 0, 2, 3, Bottom, true)
                  ,Ragdoll("juggler", ["idleHumanL", "idleHumanR"], 10, 1, "19rev")
                ]
                ,l: [Ground(0), Ragdoll("juggler"), Ragdoll("player"), Ground(1)]
                ,i: ["19rev"]
                ,oe: [Bottom]
                ,d: "Funfair"
                ,m: "theme-deepspace"
              }, {
                 n: "fairspot"
                ,o: [
                   EXR
                  ,Interaction("fairspot", 3, -2, 2, 2)
                ]
                ,l: [Ground(0), Ragdoll("player"), Ground(1)]
                ,i: ["fairspot"]
                ,oe: [Right]
                ,d: "Fair spot"
                ,m: "theme-deepspace"
              }, {
                 n: "slick"
                ,o: [
                   Exit(4, -4, 2, 3, Top, true)
                  ,EXR
                  ,EXL
                  ,Interaction("slick", 5, -2, 2, 2)
                ]
                ,l: [Ground(0), Ragdoll("player"), Ground(1)]
                ,i: ["slick"]
                ,ce: [Top]
                ,oe: [Right, Left]
                ,d: "Slippery"
                ,m: "loop-wind"
              }, {
                 n: "1inc"
                ,o: [
                   Exit(4, -4, 2, 3, Top, true)
                  ,EXR
                  ,Exit(4, 0, 2, 3, Bottom, true)
                  ,EXL
                  ,Ragdoll("1inc", ["idleHumanL", "idleHumanR"], 9, -1, "1inc")
                ]
                ,l: [Ground(2), Ragdoll("1inc"), Ground(0), Ragdoll("player"), Ground(1)]
                ,i: ["1inc"]
                ,oe: [Top, Right, Bottom, Left]
                ,d: "Booth"
                ,m: "theme-main"
              }, {
                 n: "golf"
                ,o: [
                   Exit(4, -4, 2, 3, Top, true)
                  ,EXL
                  ,Ragdoll("ss", ["idleHumanL", "idleHumanR"], 3, 0, "ss3")
                ]
                ,l: [Ground(0), Ragdoll("ss"), Ragdoll("player"), Ground(1)]
                ,i: ["ss3"]
                ,ce: [Top]
                ,oe: [Left]
                ,d: "Grassy knoll"
                ,m: "theme-noise"
              }, {
                 n: "check"
                ,o: [
                   Exit(4, -4, 2, 3, Top, true)
                  ,EXL
                  ,Exit(4, 0, 2, 3, Bottom, true)
                  ,Ragdoll("checker", ["idleHumanR", "idleHumanR"], 3, 0, "checker")
                ]
                ,l: [Ground(0), Ragdoll("checker"), Ragdoll("player"), Ground(1)]
                ,i: ["checker"]
                ,ce: [Top]
                ,oe: [Right, Bottom]
                ,d: "Fair entrance"
                ,m: "theme-deepspace"
              }, {
                 n: "clean"
                ,o: [
                   EXR
                  ,EXL
                  ,Ragdoll("ss", ["idleHumanR", "idleHumanR"], 5, 0, "ss4")
                ]
                ,l: [Ground(0), Visual("clean-doors"), Ragdoll("ss"), Ragdoll("player"), Ground(1)]
                ,i: ["ss4"]
                ,ce: [Left]
                ,oe: [Right]
                ,d: "Clean room"
                ,m: "theme-deepspace"
              }, {
                 n: "queen"
                ,o: [
                   EXR
                  ,EXL
                  ,Exit(9, 0, 2, 3, Bottom, true)
                  ,Ragdoll("queen", ["sitL", "sitL"], 7, -1, "queen")
                ]
                ,l: [Ground(0), Ragdoll("queen"), Ground(3), Ragdoll("player"), Visual("queen-trapdoor"), Ground(1)]
                ,i: ["queen"]
                ,ce: [Bottom]
                ,oe: [Right, Left]
                ,d: "Queen's Court"
                ,m: "theme-deepspace"
              }, {
                 n: "mishap"
                ,o: [
                   Exit(4, -4, 2, 3, Top, true)
                  ,EXR
                  ,EXL
                ]
                ,l: [Ground(0), Ragdoll("player"), Ground(1)]
                ,i: []
                ,oe: [Top, Right, Left]
                ,d: "Mishap"
                ,m: "theme-main"
              }, {
                 n: "theatre"
                ,o: [
                   EXL
                  ,Ragdoll("actor", ["idleHumanL", "idleHumanL"], 11, -2, "actor")
                ]
                ,l: [Ground(0), Ragdoll("actor"), Ragdoll("player"), Ground(1)]
                ,i: ["actor"]
                ,oe: [Left]
                ,d: "Theatre"
                ,m: "theme-main"
              }, {
                 n: "missing"
                ,o: [
                   Exit(4, -4, 2, 3, Top, true)
                  ,EXR
                  ,Interaction("leaf", 7, -3, 3, 3)
                ]
                ,l: [Ground(0), Visual("burnbox-doors-outside-l"), Ragdoll("player"), Ground(1)]
                ,i: ["leaf"]
                ,ce: [Right]
                ,oe: [Top]
                ,d: "Missing"
                ,m: "theme-deepspace"
              }, {
                 n: "burnbox"
                ,o: [
                   EXR
                  ,Exit(7, 0, 2, 3, Bottom, true)
                  ,EXL
                  ,Interaction("power", 9, -3, 3, 3)
                ]
                ,l: [Ground(0), Visual("burnbox-doors-inside-l"), Visual("burnbox-doors-inside-r"), Ragdoll("player"), Ground(1)]
                ,i: ["power"]
                ,oe: [Bottom]
                ,ce: [Right, Left]
                ,d: "Coal power"
                ,m: "theme-noise"
              }, {
                 n: "1dec*3"
                ,o: [
                   Exit(9, -4, 2, 3, Top, true)
                  ,EXR
                  ,EXL
                  ,Ragdoll("1dec*3", ["idleHumanL", "idleHumanR"], 9, -1, "1dec*3")
                ]
                ,l: [Ground(2), Ragdoll("1dec*3"), Ground(0), Visual("burnbox-doors-outside-r"), Ragdoll("player"), Ground(1)]
                ,i: ["1dec*3"]
                ,ce: [Top, Left]
                ,oe: [Right]
                ,d: "Booth continued"
                ,m: "theme-cuttlefish"
              }, {
                 n: "bounce"
                ,o: [
                   EXR
                  ,Exit(7, 0, 2, 3, Bottom, true)
                  ,EXL
                  ,Ragdoll("bouncer", ["idleHumanL", "idleHumanL"], 12, 0, "bouncer")
                ]
                ,l: [Ground(0), Visual("bounce-doors"), Ragdoll("bouncer"), Ragdoll("player"), Ground(1)]
                ,i: ["bouncer"]
                ,ce: [Right]
                ,oe: [Bottom, Left]
                ,d: "Bounce"
                ,m: "theme-cuttlefish"
              }, {
                 n: "bar"
                ,o: [
                   EXL
                  ,Interaction("bar", 3, -3, 3, 3)
                ]
                ,l: [Ground(0), Ragdoll("player"), Ground(1)]
                ,i: ["bar"]
                ,oe: [Left]
                ,d: "Minibar"
                ,m: "theme-cuttlefish"
              }, {
                 n: "fish"
                ,o: [
                   EXR
                  ,Interaction("o-u", 0, -4, 10, 5)
                ]
                ,l: [Colour(0), Ground(0), Ragdoll("player"), Visual("fish"), Ground(1)]
                ,i: ["o-u"]
                ,oe: [Right]
                ,d: "Fish"
                ,m: "theme-deepspace"
              }, {
                 n: "junction"
                ,o: [
                   Exit(7, -4, 2, 3, Top, true)
                  ,EXR
                  ,EXL
                ]
                ,l: [Ground(0), Ragdoll("player"), Ground(1)]
                ,i: []
                ,oe: [Top, Right, Left]
                ,d: "Junction"
                ,m: "theme-cuttlefish"
              }, {
                 n: "riddle"
                ,o: [
                   EXR
                  ,EXL
                  ,Interaction("horn", 6, -3, 3, 3)
                ]
                ,l: [Ground(0), Ragdoll("player"), Ground(1)]
                ,i: ["horn"]
                ,oe: [Right, Left]
                ,d: "Riddle"
                ,m: "theme-cuttlefish"
              }, {
                 n: "guardians"
                ,o: [
                   Exit(7, -4, 2, 3, Top, true)
                  ,EXR
                  ,EXL
                  ,Ragdoll("g1", ["idleHumanL", "idleHumanR"], 10, 0, "g1")
                  ,Ragdoll("g2", ["idleHumanL", "idleHumanR"], 11, 0, "g2")
                  ,Ragdoll("g3", ["idleHumanL", "idleHumanR"], 12, 0, "g3")
                ]
                ,l: [Ground(0), Visual("guardians-doors"), Ragdoll("g1"), Ragdoll("g2"), Ragdoll("g3"), Ragdoll("player"), Ground(1)]
                ,i: ["g1", "g2", "g3"]
                ,ce: [Right]
                ,oe: [Top, Left]
                ,d: "Guardians"
                ,m: "theme-cuttlefish"
              }, {
                 n: "cuttle"
                ,o: [
                   EXL
                  ,Interaction("cuttle", 6, -4, 8, 5)
                ]
                ,l: [Colour(0), Ground(0), Ragdoll("player"), Visual("cuttle"), Ground(1)]
                ,i: ["cuttle"]
                ,oe: [Left]
                ,d: "Final"
                ,m: "theme-cuttlefish"
              }
            ]:Array<{n:String, o:Array<RoomObject>, l:Array<RoomLayer>, i:Array<String>, ?oe:Array<Direction>, ?ce:Array<Direction>, d:String, m:String}>))
          r.n => new Room(
               r.n, r.o, r.l, r.i
              ,(r.oe == null ? [] : [ for (k in r.oe) new Exit("", k, true) ])
                .concat(r.ce == null ? [] : [ for (k in r.ce) new Exit("", k, false) ])
              ,r.d, r.m
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
        r.exitMap = [ for (e in r.exits) e.pos => e ];
      }
      rm;
    };
  public static var POS_INDEX:Map<RPos, Room>;
  
  public var x:Int;
  public var y:Int;
  public var name:String;
  public var objects:Array<RoomObject>;
  public var layers:Array<RoomLayer>;
  public var interactives:Array<String>;
  public var exits:Array<Exit>;
  public var exitMap:Map<Direction, Exit>;
  public var desc:String;
  public var music:String;
  
  public function new(n:String, o:Array<RoomObject>, l:Array<RoomLayer>, i:Array<String>, e:Array<Exit>, d:String, m:String) {
    x = GEN_X;
    y = GEN_Y;
    POS_INDEX[RPos.xy(x, y)] = this;
    GEN_X++;
    if (GEN_X >= MAP_WIDTH) {
      GEN_X = 0;
      GEN_Y++;
    }
    this.name = n;
    this.objects = o;
    this.layers = l;
    this.interactives = i;
    this.exits = e;
    this.desc = d;
    this.music = m;
  }
}

class Exit {
  public var to:String;
  public var pos:Direction;
  public var open:Bool;
  
  public function new(to:String, pos:Direction, ?open:Bool = true) {
    this.to = to;
    this.pos = pos;
    this.open = open;
  }
}
