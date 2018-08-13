package lib;

import sk.thenet.anim.*;
import sk.thenet.bmp.*;
import sk.thenet.bmp.manip.*;

using sk.thenet.FM;

class RoomVisual {
  public static var INDEX:Map<String, RoomState->Bitmap->Void>;
  
  public static function init(amB:String->Bitmap):Void {
    var doors = [
       amB("floor0").fluent >> new Cut(5, 412, 43, 60)
      ,amB("floor0").fluent >> new Cut(271, 412, 43, 60)
      ,amB("floor6").fluent >> new Cut(5, 412, 43, 60)
      ,amB("floor6").fluent >> new Cut(271, 412, 43, 60)
      ,amB("floor0").fluent >> new Cut(1302, 387, 38, 83)
    ];
    var trapdoors = [
        amB("floor4").fluent >> new Cut(825, 475, 40, 50)
       ,amB("floor2").fluent >> new Cut(725, 475, 40, 50)
    ];
    function doorExit(right:Bool, ?green:Bool = false):RoomState->Bitmap->Void {
      var bt = new Bitween(45);
      return (s, to) -> {
        if (s.openExits.indexOf(right ? Right : Left) != -1 && bt.isOff) {
          bt.setTo(true);
          Sfx.play("door-open");
        }
        var ph = (Timing.quadInOut.getF(bt.valueF) * 45).round();
        if (right) {
          to.blitAlpha(doors[green ? 3 : 1], 271 + ph, 62);
        } else {
          to.blitAlpha(doors[green ? 2 : 0], 5 - ph, 62);
        }
        bt.tick();
      }
    }
    function trapdoor(i:Int, x:Int):RoomState->Bitmap->Void {
      var bt = new Bitween(45);
      return (s, to) -> {
        if (s.openExits.indexOf(Bottom) != -1 && bt.isOff) {
          bt.setTo(true);
          Sfx.play("door-open");
        }
        var ph = (Timing.quadInOut.getF(bt.valueF) * 45).round();
        to.blitAlpha(trapdoors[i], x - (ph >> 8), 125 + ph);
        bt.tick();
      }
    }
    INDEX = [
      "ladder" => {
        var ladder = amB("floor0").fluent >> new Cut(636, 525, 40, 72);
        (s, to) -> {
          var ladderY = -s.ragdolls["climber"].root.yOffset.floor();
          for (y in 0...3) {
            to.blitAlpha(ladder, RoomRenderer.TILE_OX + 9 * RoomRenderer.TILE_W, -32 + y * 72 + ladderY);
          }
        };
      }
      ,"cuttle" => {
        var cuttle = amB("floor6").fluent >> new Cut(1272, 350, 230, 140);
        var phase = 0;
        (s, to) -> {
          to.blitAlpha(cuttle, 80, 20 + (Math.sin((phase++ / 230) * Math.PI * 2) * 10).round());
          phase %= 230;
        };
      }
      ,"fish" => {
        var cuttle = amB("floor6").fluent >> new Cut(1095, 350, 177, 179);
        var phase = 0;
        (s, to) -> {
          to.blitAlpha(cuttle, 20, 20 + (Math.sin((phase++ / 280) * Math.PI * 2) * 10).round());
          phase %= 280;
        };
      }
      ,"bonsai-doors" => doorExit(true)
      ,"bounce-doors" => doorExit(true)
      ,"clean-doors" => doorExit(false)
      ,"burnbox-doors-outside-l" => doorExit(true)
      ,"burnbox-doors-inside-l" => doorExit(false)
      ,"burnbox-doors-inside-r" => doorExit(true, true)
      ,"burnbox-doors-outside-r" => doorExit(false, true)
      ,"guardians-doors" => {
        var bt = new Bitween(120);
        (s, to) -> {
          var done = Story.flags.exists("g1-done") && Story.flags.exists("g2-done") && Story.flags.exists("g3-done");
          if (done && bt.isOff) {
            bt.setTo(true);
            Sfx.play("door-open");
          }
          if (bt.isOn) {
            if (SGame.G.roomStates["guardians"].openExits.indexOf(Right) == -1) SGame.G.roomStates["guardians"].openExits.push(Right);
          }
          var ph = (Timing.quadInOut.getF(bt.valueF) * 45).round();
          to.blitAlpha(doors[3], 271 + ph, 62);
          bt.tick();
        };
      }
      ,"queen-trapdoor" => trapdoor(0, 189)
      ,"shaft-trapdoor" => trapdoor(1, 89)
      ,"bridge-doors" => {
        var bt = new Bitween(45);
        (s, to) -> {
          if (s.openExits.indexOf(Left) != -1) bt.setTo(true);
          var ph = (Timing.quadInOut.getF(bt.valueF) * 45).round();
          to.blitAlpha(doors[4], 30 - ph, 37);
          bt.tick();
        };
      }
    ];
  }
}
