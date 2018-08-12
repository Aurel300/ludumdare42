package lib;

import sk.thenet.app.*;

class SGame extends JamState {
  public static var G:SGame;
  
  public var room:RoomDisplay;
  public var ui:UI;
  
  static var walkspeed = 20;
  
  public function new(app) {
    super("game", app);
    G = this;
  }
  
  override public function to():Void {
    Story.initNew();
    room = Single("start"); // TODO: base on Story state
    ui = new UI();
    
    rd = Ragdoll.makeHumanoid(amB("ragdolls"), 0, 0);
    rda = RagdollAnimation.INDEX["walkR"];
    rdam = rda.animate([0, 1, 2, 3, 4, 5], [20, 15, 20, 20, 15, 20], rd).makeScaled(.5);
  }
  
  var rd:Ragdoll;
  var rda:RagdollAnimation;
  var rdam:lib.RagdollAnimation.RdAnimator;
  var rdX = 0;
  
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
    
    // ragdoll
    rd.render(ab, rdX + 30, 120, 0);
    rdam.tick((frozen) -> {
        for (part in frozen) if (part.id == "root") {
          if (part.xOffset >= walkspeed) {
            part.xOffset -= walkspeed;
            rdX += walkspeed;
            rdX %= 200;
            rd.root.xOffset -= walkspeed;
            break;
          }
        }
      });
  }
}
