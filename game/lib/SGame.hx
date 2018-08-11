package lib;

import sk.thenet.app.*;

class SGame extends JamState {
  public static var G:SGame;
  
  public var room:RoomDisplay;
  public var ui:UI;
  
  public function new(app) {
    super("game", app);
    G = this;
  }
  
  override public function to():Void {
    Story.initNew();
    room = Single("start"); // TODO: base on Story state
    ui = new UI();
  }
  
  var rns = ["start", "1-0", "robogym", "king", "bridge", "start"];
  var rnum = 0;
  var dns:Array<lib.Room.ExitPosition> = [Right, Bottom, Left, Top, Bottom];
  var dnum = 0;
  
  override public function tick():Void {
    // logic
    room = (switch (room) {
        case Transitioning(from, dir, to, prog):
        var nprog = prog + 0.05;
        nprog >= 2 ? Single(to) : Transitioning(from, dir, to, nprog);
        case Single(_): rnum %= rns.length - 1; dnum %= dns.length; Transitioning(rns[rnum], dns[dnum++], rns[++rnum], 0);
        case _: room;
      });
    ui.prerender();
    
    // render
    ab.fill(Pal.P[36]);
    RoomRenderer.renderRooms(ab, room);
    ui.render(ab);
  }
}
