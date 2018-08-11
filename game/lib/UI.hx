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
    boxBG = amB("gui").fluent >> new Cut(400, 0, 56, 40);
    
    boxCut = new Box(new Point2DI(41, 29), new Point2DI(46, 34), 1, 1);
    dialogueBG = box(189, 133);
    memoryBG = box(215, 149);
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
