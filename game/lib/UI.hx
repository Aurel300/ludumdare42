package lib;

import sk.thenet.bmp.*;
import sk.thenet.bmp.manip.*;
import sk.thenet.geom.*;

class UI {
  static var boxBG:Bitmap;
  static var boxCut:Box;
  
  static var dialogueBG:Bitmap;
  static var memoryBG:Bitmap;
  
  static function box(w:Int, h:Int):Bitmap {
    boxCut.width = w;
    boxCut.height = h;
    return boxBG.fluent >> boxCut;
  }
  
  public static function init(amB:String->Bitmap):Void {
    var b = amB("gui").fluent;
    boxBG = b >> new Cut(0, 0, 56, 40);
    
    boxCut = new Box(new Point2DI(41, 29), new Point2DI(46, 34), 1, 1);
    dialogueBG = box(189, 135);
    memoryBG = box(215, 151);
    var memorySlot = b >> new Cut(56, 0, 40, 32);
    for (y in 0...4) for (x in 0...5) {
      memoryBG.blitAlpha(memorySlot, 6 + x * 41, 14 + y * 33);
    }
  }
  
  public function new() {
    
  }
  
  public function prerender():Void {
    
  }
  
  public function render(ab:Bitmap):Void {
    ab.blitAlpha(dialogueBG, -2, 170);
    ab.blitAlpha(memoryBG, 187, 154);
  }
}
