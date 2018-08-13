package lib;

import sk.thenet.anim.*;
import sk.thenet.app.*;
import sk.thenet.app.Keyboard.Key;
import sk.thenet.bmp.*;
import sk.thenet.plat.Platform;

using sk.thenet.FM;

class STitle extends JamState {
  var textB:Bitmap;
  var textY:Float = 400;
  
  public function new(app) {
    super("title", app);
  }
  
  override public function to():Void {
    textB = Platform.createBitmap(300, 400, 0);
    var curY = 0;
    for (l in [
       "Runnink out of Space"
      ,"by Aurel B%l& and wan for LD42"
      ,"It is the year 20XX."
      ,"Space (the black stuff in the sky) is limited! We need to get more ink to make more Space. Unfortunately, the only way to gather enough ink is to milk a Giant Deep-Space Cuttlefiship."
      ,"GDSC's envelop themselves in a protective puzzling labyrinth - a human would go mad in such a labyrinth. Instead, we are sending you, a PLYR robot with a unique ability – to forget very easily. Your memory is very limited. Not because we built you cheaply or anything."
      ,"Controls: mouse to interact and move, keyboard to type when needed."
      ,"Press Q to start!"
      ]) {
      var a = Text.justify(l, 300);
      textB.blitAlpha(a, 0, curY);
      curY += a.height + 8;
    }
  }
  
  override public function keyUp(k:Key):Void {
    switch (k) {
      case KeyQ: st("game");
      case _:
    }
  }
  
  override public function tick():Void {
    ab.fill(Pal.P[36]);
    ab.blitAlpha(textB, 50, textY.floor());
    textY.target(10, 31);
  }
}
