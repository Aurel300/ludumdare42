package lib;

import sk.thenet.app.*;
import sk.thenet.bmp.*;
import sk.thenet.plat.Platform;

using StringTools;
using sk.thenet.FM;

class Text {
  public static var fonts:Array<Font>;
  public static inline var REG = FontType.Regular; //Mono4;
  public static inline var tr = t(REG);
  static var tmp:Bitmap = Platform.createBitmap(200, 1, 0);
  
  public static function init(am:AssetManager):Void {
    fonts = [
         font.FontFancy8x13.initAuto(am, Pal.P[36], Pal.P[19], Pal.P[20])
        ,font.FontNS.initAuto(am, Pal.P[36], Pal.P[19], Pal.P[20])
        ,font.FontBasic3x9.init(am, Pal.P[36], Pal.P[19], Pal.P[20])
      ];
  }
  /*
  public static inline function tp(pov:Int):String {
    return t(FontType.Mono5 - ((pov / 20).floor().clampI(0, 4)));
  }
  */
  public static inline function t(ft:FontType):String {
    return "$" + String.fromCharCode("A".code + ft);
  }
  /*
  public static inline function c(l:Int):String {
    return t(Symbol) + "G" + "".lpad("H", l) + "I";
  }
  */
  public static function render(
    ab:Bitmap, tx:Int, ty:Int, text:String, ?initial:FontType = Regular
  ):Void {
    fonts[initial].render(ab, tx, ty, text, fonts);
  }
  /*
  public static function centred(txt:String, x:Int, y:Int, ?ft:FontType = Regular):RoomVisual {
    var tw = fonts[ft].render(tmp, 0, 0, txt, fonts).x;
    return Text(txt, x - (tw >> 1), y);
  }
  */
  
  public static function left(txt:String, width:Int, ?ft:FontType = Regular):Bitmap {
    var lines = txt.split("\n");
    var res = Platform.createBitmap(width, lines.length * 16, 0);
    fonts[ft].render(res, 0, 0, txt, fonts);
    return res;
  }
  
  public static function justify(txt:String, width:Int, ?ft:FontType = Regular, ?lh:Int = 16):Bitmap {
    var words = txt.split(" ").map(w -> {
         txt: w
        ,width: fonts[ft].render(tmp, 0, 0, w, fonts).x + (w.startsWith("$B") ? 8 : 0)
        ,mono: w.startsWith("$B")
      });
    var lines = [];
    var lineWidths = [];
    var lineWords = [];
    var lineWidth = 0;
    var minSpace = width * 0.01;
    var maxSpacing = 100.0;
    while (words.length > 0) {
      var curWord = words.shift();
      if (width - (curWord.width + lineWidth) >= minSpace) {
        lineWords.push(curWord);
        lineWidth += curWord.width;
      } else {
        lines.push(lineWords);
        lineWidths.push(lineWidth);
        lineWords = [curWord];
        lineWidth = curWord.width;
      }
    }
    if (lineWords.length > 0) {
      lines.push(lineWords);
      lineWidths.push(lineWidth);
    }
    var res = Platform.createBitmap(width, lines.length.maxI(1) * 16, 0);
    var cy = 0;
    for (l in lines) {
      var spacing = l == lines[lines.length - 1] ? minSpace : ((width - lineWidths.shift()) / (l.length - 1)).minF(maxSpacing);
      var cx = 0.0;
      for (w in l) {
        fonts[ft].render(res, cx.floor() + 1, cy, t(ft) + w.txt, fonts);
        cx += w.width + spacing;
      }
      cy += lh;
    }
    return res;
  }
}
