package lib;

import sk.thenet.anim.*;
import sk.thenet.app.*;

using sk.thenet.FM;

class SGame extends JamState {
  public static var G:SGame;
  
  public static var musicOn:Bool = true;
  public static var soundOn:Bool = true;
  
  public var roomStates:Map<String, RoomState>;
  public var room:RoomDisplay;
  public var ui:UI;
  public var renderer:RoomRenderer;
  public var cameraX:Float = 41;
  public var cameraTX:Float = 41;
  public var activeRoom:RoomState;
  
  public function new(app) {
    super("game", app);
    G = this;
    renderer = new RoomRenderer(this);
  }
  
  override public function to():Void {
    Story.initNew();
    Sfx.initMusic();
    roomStates = [ for (k in Room.INDEX.keys()) k => new RoomState(Room.INDEX[k]) ];
    ui = new UI(this);
    
    room = Single(roomStates["start"]);
    roomStates["start"].enter(Top);
  }
  
  override public function mouseDown(mx:Int, my:Int):Void {
    switch (room) {
      case Transitioning(_, _, _, _): return;
      case _:
    }
    ui.mouseDown(mx, my);
  }
  
  override public function mouseUp(mx:Int, my:Int):Void {
    switch (room) {
      case Transitioning(_, _, _, _): return;
      case _:
    }
       ui.mouseUp(mx, my)
    || renderer.mouseClick(mx - cameraX.floor(), my);
  }
  
  override public function keyUp(k):Void {
    ui.keyUp(k);
  }
  
  override public function text(t:String):Void {
    ui.text(t);
  }
  
  override public function tick():Void {
    Sfx.tick();
    
    activeRoom = (switch (room) {
        case Single(s): s;
        case _: activeRoom;
      });
    
    // logic
    ui.prerender();
    renderer.tick(app.mouse.x - cameraX.floor(), app.mouse.y);
    
    // render
    ab.fill(Pal.P[36]);
    renderer.renderRooms(ab, cameraX.floor());
    ui.render(ab, app.mouse.x, app.mouse.y);
    
    cameraX.targetMin(cameraTX, 8, 0.01);
  }
}
