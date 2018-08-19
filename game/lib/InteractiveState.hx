package lib;

import lib.Interactive.IaFragment;

class InteractiveState {
  public var interactive:Interactive;
  public var room:RoomState;
  public var pos = 0;
  public var input:Array<String> = [];
  public var cursorPos = 0;
  public var solved:Map<IaFragment, Bool> = new Map();
  public var lastOp:Map<String, Slot> = new Map();
  
  public var current(get, never):IaFragment;
  private inline function get_current():IaFragment return pos < interactive.fragments.length ? interactive.fragments[pos] : null;
  
  public var answer(get, never):Word;
  private inline function get_answer():Word return input.join("");
  
  public function new(i:Interactive, r:RoomState) {
    interactive = i;
    room = r;
    if (i == null) return;
    for (i in interactive.fragments) switch (i) {
      case Take(_): solved[i] = false;
      case Give(_): solved[i] = false;
      case Operation(op): lastOp[op] = Slot.Empty;
      case _:
    }
  }
  
  public function hasNext():Bool {
    while (true) switch (current) {
      case Open(dir): if (room.openExits.indexOf(dir) == -1) room.openExits.push(dir); pos++;
      case OpenOther(name, dir): if (SGame.G.roomStates[name].openExits.indexOf(dir) == -1) SGame.G.roomStates[name].openExits.push(dir); pos++;
      case SetFlag(f, val): Story.flags[f] = val; pos++;
      case _: break;
    }
    return (switch (current) {
      case Text(_) | Open(_) | OpenOther(_, _): true;
      case _: false;
    });
  }
  
  public function next():Void {
    while (true) switch (current) {
      case Text(_): pos++; break;
      case Open(dir): if (room.openExits.indexOf(dir) == -1) room.openExits.push(dir); pos++;
      case OpenOther(name, dir): if (SGame.G.roomStates[name].openExits.indexOf(dir) == -1) SGame.G.roomStates[name].openExits.push(dir); pos++;
      case SetFlag(f, val): Story.flags[f] = val; pos++;
      case Take(ans): input = [ for (a in 0...ans[0].length) "" ]; cursorPos = 0; break;
      case _: break;
    }
  }
  
  public function check():Void {
    switch (current) {
      case Take(ans):
      for (a in ans) {
        if (a == answer) {
          solved[current] = true;
          pos++;
        }
      }
      case _:
    }
    room.recalculate();
  }
}
