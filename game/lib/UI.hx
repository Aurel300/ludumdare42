package lib;

import sk.thenet.anim.*;
import sk.thenet.app.Keyboard.Key;
import sk.thenet.bmp.*;
import sk.thenet.bmp.manip.*;
import sk.thenet.geom.*;
import sk.thenet.plat.Platform;

import lib.Interactive.IaFragment;

using sk.thenet.FM;

class UI {
  public static inline var DIALOGUE_HIGHLIGHT = 250 + 41;
  
  static var boxBG:Bitmap;
  static var boxCut:Box;
  
  static var intBG:Array<Bitmap>;
  
  static var scrollBG:Array<Bitmap>;
  
  static var dialogueBGShort:Bitmap;
  static var memoryBGShort:Bitmap;
  static var dialogueBG:Bitmap;
  static var memoryBG:Bitmap;
  
  static var help:Bitmap;
  
  static var icons:Array<Bitmap>;
  
  public static var slotBG:Array<Bitmap>;
  
  static var cursors:Map<Cursor, Bitmap>;
  public static var mapIcons:Map<MapIcon, Bitmap>;
  
  static var scrollCache:Array<Array<Bitmap>> = [[], []];
  
  public static function makeScroll(h:Int, down:Bool):Bitmap {
    var idx = down ? 1 : 0;
    for (s in scrollCache[idx]) if (s.height == h) return s;
    scrollCache[idx].shift();
    var ret = scrollBG[idx].fluent >> new Box(new Point2DI(3, 3), new Point2DI(4, 4), 7, h);
    scrollCache[idx].push(ret);
    return ret;
  }
  
  static var hoverCache:Array<{type:Int, w:Int, h:Int, b:Bitmap}> = [];
  
  public static function makeHover(type:Int, w:Int, h:Int):Bitmap {
    for (c in hoverCache) if (c.type == type && c.w == w && c.h == h) return c.b;
    var ret = slotBG[type].fluent >> new Box(new Point2DI(16, 16), new Point2DI(24, 20), w, h);
    hoverCache.push({
         type: type
        ,w: w
        ,h: h
        ,b: ret
      });
    return ret;
  }
  
  static function box(w:Int, h:Int):Bitmap {
    boxCut.width = w;
    boxCut.height = h;
    return boxBG.fluent >> boxCut;
  }
  
  public static function init(amB:String->Bitmap):Void {
    var b = amB("gui").fluent;
    
    boxBG = b >> new Cut(0, 0, 56, 40);
    boxCut = new Box(new Point2DI(41, 29), new Point2DI(42, 30), 1, 1);
    
    intBG = [
       b >> new Cut(96, 0, 16, 16)
      ,b >> new Cut(96 + 16, 0, 16, 16)
      ,b >> new Cut(96 + 16, 16, 16, 18)
      ,b >> new Cut(96 + 32, 16, 16, 18)
      ,b >> new Cut(96 + 32, 0, 16, 16)
      ,b >> new Cut(96 + 48, 0, 16, 16)
    ];
    
    scrollBG = [
       b >> new Cut(96, 16, 7, 7)
      ,b >> new Cut(104, 16, 7, 7)
    ];
    
    dialogueBGShort = box(189, 132);
    memoryBGShort = box(215, 148);
    dialogueBG = box(189, 300);
    memoryBG = box(215, 300);
    slotBG = [
       b >> new Cut(56, 0, 40, 32)
      ,b >> new Cut(56, 32, 40, 32)
      ,b >> new Cut(56, 64, 40, 32)
      ,b >> new Cut(56, 96, 40, 32)
      ,b >> new Cut(56, 128, 40, 32)
      ,b >> new Cut(96, 128, 40, 8)
      ,b >> new Cut(128, 139, 8, 10)
      ,b >> new Cut(96, 152, 40, 8)
      ,b >> new Cut(96, 139, 8, 10)
      ,b >> new Cut(40 + 96, 128, 40, 8)
      ,b >> new Cut(40 + 128, 139, 8, 10)
      ,b >> new Cut(40 + 96, 152, 40, 8)
      ,b >> new Cut(40 + 96, 139, 8, 10)
    ];
    
    cursors = [
         Normal => b >> new Cut(0, 40, 16, 16)
        ,Action => b >> new Cut(16, 40, 16, 16)
        ,Close => b >> new Cut(32, 40, 16, 16)
      ];
    
    mapIcons = [
         Player => b >> new Cut(0, 56, 8, 16)
        ,Take => b >> new Cut(8, 56, 8, 16)
        ,Give => b >> new Cut(16, 56, 8, 16)
        ,Operation => b >> new Cut(24, 56, 8, 16)
      ];
    
    icons = [
         b >> new Cut(0, 72, 16, 16)
        ,b >> new Cut(16, 72, 16, 16)
        ,b >> new Cut(32, 72, 16, 16)
      ];
    
    var intCut = new Box(new Point2DI(12, 12), new Point2DI(13, 13), 156 + 4, 100 + 6);
    help = intBG[1].fluent >> intCut;
    lib.Text.render(help, 10, 2, "$CRunnink out of Space\nby Aurel Bily and wan for LD42");
    help.blitAlpha(lib.Text.justify("The grid to the right is your memory, which also serves as your map and inventory. Learn new words by answering riddles or transforming them, but be careful not to forget where you are!", 140, Small, 10), 10, 24);
    help.blitAlpha(lib.Text.justify("Double click to move faster!", 140, Small, 10), 10, 89);
  }
  
  public var cursor:Cursor = Normal;
  public var game:SGame;
  public var held:UIHeld = None;
  
  public var btDialogue = new Bitween(30);
  public var btMemory = new Bitween(30);
  
  public var interactive:InteractiveState;
  
  var cache:Map<IaFragment, Bitmap> = new Map();
  var diaScroll:Scroller;
  var memScroll:Scroller;
  
  var cacheSlot:Map<Slot, Bitmap> = new Map();
  
  var diaX = -2;
  var diaY(get, never):Int;
  private inline function get_diaY():Int return (170 * (1 - Timing.quadInOut.getF(btDialogue.valueF))).floor();
  
  var memX = 187;
  var memY(get, never):Int;
  private inline function get_memY():Int return (154 * (1 - Timing.quadInOut.getF(btMemory.valueF))).floor();
  
  public var mapText:String = "";
  
  public function new(game:SGame) {
    this.game = game;
    diaScroll = new Scroller(165, 280, 4);
    memScroll = new Scroller(195, 128, 0);
    memScroll.isMap = true;
    updateInventory();
  }
  
  public function renderSlot(s:Slot):Bitmap {
    //if (cacheSlot.exists(s)) return cacheSlot[s];
    return (switch (s) {
      case Empty: slotBG[1];
      case Word(w):
      var ret = slotBG[1].fluent >> new Copy();
      lib.Text.render(ret, 2, 2, (cast w:String), FontType.Small);
      ret;
      case Map(f):
      var ret = slotBG[4].fluent >> new Copy();
      var r = Room.POS_INDEX[RPos.xy(f.x, f.y)];
      var rs = game.roomStates[r.name];
      if (r.exitMap.exists(Top)) ret.blitAlpha(slotBG[(rs.openExits.indexOf(Top) != -1 ? 0 : 4) + 5], 0, 0);
      if (r.exitMap.exists(Right)) ret.blitAlpha(slotBG[(rs.openExits.indexOf(Right) != -1 ? 0 : 4) + 6], 32, 11);
      if (r.exitMap.exists(Bottom)) ret.blitAlpha(slotBG[(rs.openExits.indexOf(Bottom) != -1 ? 0 : 4) + 7], 0, 24);
      if (r.exitMap.exists(Left)) ret.blitAlpha(slotBG[(rs.openExits.indexOf(Left) != -1 ? 0 : 4) + 8], 0, 11);
      if (rs.showTake) ret.blitAlpha(mapIcons[Take], 8, 4);
      if (rs.showGive) ret.blitAlpha(mapIcons[Give], 16, 4);
      if (rs.showOperation) ret.blitAlpha(mapIcons[Operation], 24, 4);
      ret;
      case _: null;
    });
  }
  
  public function prerender():Void {
    cursor = Normal;
    mapText = "";
    held = (switch (held) {
      case DropSlot(s, _): Slot(s);
      case _: held;
    });
  }
  
  public function mouse(mx:Int, my:Int):UIHeld {
    if (mx.withinI(400 - 18, 400) && my.withinI(0, 18)) return MuteSound;
    if (mx.withinI(400 - 18, 400) && my.withinI(0, 36)) return MuteMusic;
    if (mx.withinI(diaX, diaX + dialogueBG.width - 1) && my.withinI(diaY, diaY + dialogueBG.height - 1)) {
      if (btDialogue.isOn) {
        return diaScroll.mouse(diaX + 9, diaY + 13, mx, my);
      }
      return None;
    }
    if (mx.withinI(memX, memX + memoryBG.width - 1) && my.withinI(memY, memY + memoryBG.height - 1)) {
      var ret = memScroll.mouse(memX + 5, memY + 13, mx, my);
      switch (ret) {
        case Action(mo, _, _, _): if (mo != null) mo();
        case _:
      }
      return ret;
    }
    if (btMemory.isOn || btDialogue.isOn) {
      return Close;
    }
    return Game;
  }
  
  public function mouseDown(mx:Int, my:Int):Bool {
    var a = mouse(mx, my);
    held = None;
    switch (a) {
      case Scroll(_, _, _):
      held = a;
      return true;
      case Action(_, _, null, _) | Action(_, _, Empty, _) | Action(_, _, Map(_), _):
      case Action(_, _, slot, _):
      Sfx.play("word-grab-alt");
      held = Slot(slot);
      return true;
      case _:
    }
    return false;
  }
  
  public function mouseUp(mx:Int, my:Int):Bool {
    var a = mouse(mx, my);
    if (held != None) {
      Sfx.play("word-drop-alt");
    }
    switch [a, held] {
      case [MuteSound, None]: SGame.soundOn = !SGame.soundOn;
      case [MuteMusic, None]: SGame.musicOn = !SGame.musicOn;
      case [Close, None]: deactivate();
      case [_, DropSlot(_, f)]:
      f();
      held = None;
      case [Action(mo, mc, _, _), None]:
      if (mc != null) mc();
      case _ if (held != None): held = None;
      case [DefaultAction(scr), _]:
      if (scr == diaScroll) nextInteractive();
      case [Game, _]: return false;
      case _:
    }
    return true;
  }
  
  function renderIaFragment(i:IaFragment, ia:InteractiveState):Bitmap {
    if (i == null) return null;
    switch (i) {
      case Text(_): if (cache.exists(i)) return cache[i];
      case _:
    }
    var bgPos = 0;
    var marginW = 4;
    var marginH = 6;
    var content = (switch (i) {
      case Text(msg): lib.Text.justify(msg, 156);
      case Operation(op):
      bgPos = 5;
      marginH = 26;
      lib.Text.left(" Drag and drop a word here to\n transform it.", 156, Small);
      case Give(ans):
      bgPos = 4;
      if (ia.solved[i]) {
        lib.Text.left(' "${ans[0]}" was correct!', 156, Small);
      } else {
        marginH = 26;
        lib.Text.left(" Drag and drop your answer here.\n (Or come back later if you don't have\n it yet!)", 156, Small);
      }
      case Take(ans):
      bgPos = 1;
      marginH = 26;
      if (ia.solved[i]) {
        lib.Text.left(" Correct! You can drag and drop the\n word into your memory now.", 156, Small);
      } else {
        lib.Text.left(" Type your answer:", 156, Small);
      }
      case Continue(done): lib.Text.justify(done ? "Click here to close dialogue." : "Click to continue...", 156, Small);
      case _: return null;
    });
    var intCut = new Box(new Point2DI(12, 12), new Point2DI(13, 13), content.width + marginW, content.height + marginH);
    var ret = intBG[bgPos].fluent >> intCut;
    switch (i) {
      case Operation(op): ret.blitAlpha(renderSlot(ia.lastOp[op]), 118, 22);
      case Take(ans):
      if (ia.solved[i]) {
        ret.blitAlpha(renderSlot(Word(ia.answer)), 118, 22);
      } else {
        for (x in 0...ans[0].length) {
          ret.blitAlpha(intBG[x == ia.cursorPos ? 3 : 2], 16 + x * 14, 18);
          if (x < ia.input.length && ia.input[x] != null) {
            lib.Text.render(ret, 19 + x * 14, 22, ia.input[x].toUpperCase());
          }
        }
      }
      case _:
    }
    ret.blitAlpha(content, 2, 4);
    cache[i] = ret;
    return ret;
  }
  
  public function nextInteractive():Void {
    if (interactive != null && interactive.hasNext()) {
      Sfx.play("chat-talk", .4);
      interactive.next();
      diaScroll.scroll = 1;
      updateInteractive();
    }
  }
  
  public function updateInteractive():Void {
    if (interactive == null) return;
    var curY = 4;
    diaScroll.items = [ for (ip in 0...interactive.pos + 1) {
        var i = interactive.interactive.fragments[ip];
        var ir = renderIaFragment(i, interactive);
        if (ir == null) continue;
        var itY = curY;
        curY += ir.height + 4;
        {
           x: 0
          ,y: itY
          ,w: ir.width
          ,h: ir.height
          ,b: ir
          ,mouseOver: null
          ,mouseClick: () -> switch (i) {
            case Text(_): nextInteractive();
            case _:
          }
          ,mouseDown: switch (i) {
            case Operation(op): interactive.lastOp[op];
            case Take(ans) if (interactive.solved[i]): Word(interactive.answer);
            case _: null;
          }
          ,swap: switch (i) {
            case Operation(op):
            (with) -> {
              diaScroll.hoverX = -1;
              diaScroll.hoverY = itY;
              diaScroll.hoverW = ir.width + 3;
              diaScroll.hoverH = ir.height;
              diaScroll.hoverType = 3;
              held = DropSlot(with, () -> {
                switch (with) {
                  case Word(w):
                  var res = Operations.INDEX[op].f([w]);
                  interactive.lastOp[op] = res == null ? lib.Slot.Empty : lib.Slot.Word(res[0]);
                  if (res != null) Sfx.play("click-valid-1");
                  else Sfx.play("click-invalid");
                  case _:
                }
                updateInteractive();
              });
            }
            case Give(ans) if (!interactive.solved[i]):
            (with) -> {
              diaScroll.hoverX = -1;
              diaScroll.hoverY = itY;
              diaScroll.hoverW = ir.width + 3;
              diaScroll.hoverH = ir.height;
              diaScroll.hoverType = 3;
              held = DropSlot(with, () -> {
                switch (with) {
                  case Word(w):
                  if (w == ans[0]) {
                    interactive.solved[i] = true;
                    interactive.check();
                    interactive.pos++;
                    Sfx.play("click-valid-2");
                  } else {
                    interactive.solved[i] = false;
                    Sfx.play("click-invalid");
                  }
                  case _:
                }
                updateInteractive();
              });
            }
            case _: null;
          }
        };
      } ];
    var ir = renderIaFragment(Continue(!interactive.hasNext()), interactive);
    diaScroll.items.push({
       x: 0
      ,y: curY
      ,w: ir.width
      ,h: ir.height
      ,b: ir
      ,mouseOver: null
      ,mouseClick: () -> {
        if (interactive.hasNext()) {
          nextInteractive();
        } else {
          deactivate();
        }
      }
      ,mouseDown: null
      ,swap: null
    });
  }
  
  public function updateInventory():Void {
    var i = 0;
    memScroll.items = [ for (y in 0...Room.MAP_HEIGHT) for (x in 0...Room.MAP_WIDTH) {
        var slot = Story.inv.slots[i++];
        {
           x: x * 39
          ,y: y * 33 + 1
          ,w: 40
          ,h: 32
          ,b: renderSlot(slot)
          ,mouseOver: function ():Void {
            switch (slot) {
              case Map(_): mapText = Room.POS_INDEX[RPos.xy(x, y)].desc;
              case _:
            }
          }
          ,mouseClick: () -> {}
          ,mouseDown: slot
          ,swap: (with) -> {
              memScroll.hoverX = x * 39;
              memScroll.hoverY = y * 33 + 1;
              memScroll.hoverW = 40;
              memScroll.hoverH = 32;
              memScroll.hoverType = slot == Empty ? 3 : 2;
              held = DropSlot(with, () -> {
                  Story.inv.slots[x + y * Room.MAP_WIDTH] = with;
                  updateInventory();
                });
            }
        };
      } ];
  }
  
  public function deactivate():Void {
    Sfx.play("chat-close");
    updateInventory();
    game.cameraTX = 41;
    btDialogue.setTo(false);
    btMemory.setTo(false);
  }
  
  public function activateInteractive(name:String):Void {
    Sfx.play("chat-open");
    btDialogue.setTo(true);
    interactive = (switch (game.room) {
        case Single(s): s.interactive[name];
        case _: null;
      });
    updateInteractive();
  }
  
  public function keyUp(k:Key):Void {
    if (interactive != null && interactive.current != null) {
      switch (interactive.current) {
        case Take(ans):
        switch (k) {
          case ArrowLeft: interactive.cursorPos = (interactive.cursorPos - 1).maxI(0);
          case ArrowRight: interactive.cursorPos = (interactive.cursorPos + 1).minI(ans[0].length - 1);
          case Backspace: interactive.input[interactive.cursorPos] = ""; interactive.cursorPos = (interactive.cursorPos - 1).maxI(0);
          case _: return;
        }
        Sfx.play("chat-letter");
        updateInteractive();
        case _:
      }
    }
  }
  
  public function text(t:String):Void {
    if (t.length != 1) return;
    if (interactive != null) {
      switch (interactive.current) {
        case Take(ans):
        var let = t.toLowerCase();
        if (Operations.ALPHA.indexOf(let) == -1) return;
        Sfx.play("chat-letter");
        interactive.input[interactive.cursorPos++] = let;
        interactive.cursorPos = interactive.cursorPos.minI(ans[0].length - 1);
        interactive.check();
        updateInteractive();
        case _:
      }
    }
  }
  
  public function render(ab:Bitmap, mx:Int, my:Int):Void {
    var a = mouse(mx, my);
    cursor = (switch [a, held] {
      case [_, Scroll(scr, os, omy)]:
      scr.mouseMove(os, omy, my);
      Normal;
      case [Action(_, _, _, swap), Slot(s)] | [Action(_, _, _, swap), DropSlot(s, _)]:
      if (swap != null) swap(s);
      Normal;
      case [Close, _]: Close;
      case [Game, _]: cursor;
      case _: Normal;
    });
    
    ab.blitAlpha(btDialogue.value != 0 ? dialogueBG : dialogueBGShort, diaX, diaY);
    ab.blitAlpha(btMemory.value != 0 ? memoryBG : memoryBGShort, memX, memY);
    
    ab.blitAlpha(help, diaX + 9, 170 + 17 + 170 - diaY);
    if (!btDialogue.isOff) {
      diaScroll.render(ab, diaX + 9, diaY * 2 + 13);
    }
    memScroll.render(ab, memX + 5, memY + 13);
    lib.Text.render(ab, memX + 2, memY + 2, mapText);
    
    ab.blitAlpha(icons[1], 400 - 18, 2);
    if (!SGame.soundOn) ab.blitAlpha(icons[0], 400 - 18, 2);
    ab.blitAlpha(icons[2], 400 - 18, 2 + 18);
    if (!SGame.musicOn) ab.blitAlpha(icons[0], 400 - 18, 2 + 18);
    
    switch (held) {
      case Slot(s) | DropSlot(s, _):
      ab.blitAlpha(renderSlot(s), mx + 7, my + 7);
      case _:
    }
    ab.blitAlpha(cursors[cursor], mx, my);
    btDialogue.tick();
    btMemory.tick();
  }
}

enum UIHeld {
  Game;
  None;
  Close;
  Scroll(scroller:Scroller, os:Float, omy:Int);
  DefaultAction(scroller:Scroller);
  Action(over:Void->Void, click:Void->Void, down:Null<Slot>, swap:Slot->Void);
  Slot(slot:Slot);
  DropSlot(slot:Slot, f:Void->Void);
  MuteSound;
  MuteMusic;
}

class Scroller {
  public var w:Int;
  public var h:Int;
  public var buf:Bitmap;
  public var items:Array<ScrollItem> = [];
  public var scroll:Float = 0;
  public var scrollH:Int = 1;
  public var down:Bool = false;
  public var margin:Int;
  public var isMap:Bool;
  
  public var hoverX:Int = -1;
  public var hoverY:Int = -1;
  public var hoverW:Int = -1;
  public var hoverH:Int = -1;
  public var hoverType:Int = -1;
  
  public var coffY:Float = 0;
  
  public var offY(get, never):Int;
  private inline function get_offY():Int {
    coffY.targetMin(-((scrollH - h) * scroll), 21, 0.01);
    return scrollH > h ? coffY.floor() : 0;
  }
  
  public function new(w:Int, h:Int, margin:Int) {
    this.w = w;
    this.h = h;
    this.margin = margin;
    buf = Platform.createBitmap(w, h, 0);
  }
  
  public function mouse(x:Int, y:Int, mx:Int, my:Int):UIHeld {
    var sx = x + w + 2;
    var sy = y + 1 + (((h - 2) >> 1) * scroll).floor();
    if (mx.withinI(sx, sx + 6) && my.withinI(sy, sy + (h >> 1) - 1)) {
      return Scroll(this, scroll, my);
    }
    for (i in items) {
      if (mx.withinI(x + i.x, x + i.x + i.w - 1) && (my - offY).withinI(y + i.y, y + i.y + i.h - 1)) {
        return Action(i.mouseOver, i.mouseClick, i.mouseDown, i.swap);
      }
    }
    return DefaultAction(this);
  }
  
  public function mouseMove(os:Float, omy:Int, my:Int):Void {
    var dmy = (my - omy) / (h / 2);
    scroll = (os + dmy).clampF(0, 1);
    down = true;
  }
  
  public function render(to:Bitmap, x:Int, y:Int):Void {
    scrollH = 0;
    for (i in items) {
      scrollH = scrollH.maxI(margin + i.y + i.h);
    }
    if (scrollH > h) {
      to.blitAlpha(UI.makeScroll(h >> 1, down), x + w + 2, y + 1 + (((h - 2) >> 1) * scroll).floor());
    }
    down = false;
    buf.fill(0);
    for (i in items) if (i.b != null) {
      buf.blitAlpha(i.b, i.x, i.y + offY);
    }
    if (hoverType != -1) {
      buf.blitAlpha(UI.makeHover(hoverType, hoverW, hoverH), hoverX, hoverY + offY);
    }
    if (isMap) {
      buf.blitAlpha(UI.mapIcons[Player], SGame.G.activeRoom.room.x * 39, SGame.G.activeRoom.room.y * 33 + 16 + 1 + offY);
    }
    to.blitAlpha(buf, x, y);
    hoverX = -1;
    hoverY = -1;
    hoverW = -1;
    hoverH = -1;
    hoverType = -1;
  }
}

typedef ScrollItem = {
     x:Int
    ,y:Int
    ,w:Int
    ,h:Int
    ,b:Bitmap
    ,mouseOver:Void->Void
    ,mouseClick:Void->Void
    ,mouseDown:Null<Slot>
    ,swap:Slot->Void
  };

@:enum
abstract Cursor(Int) from Int to Int {
  var Normal = 0;
  var Action = 1;
  var Close = 2;
}

@:enum
abstract MapIcon(Int) from Int to Int {
  var Player = 0;
  var Take = 1;
  var Give = 2;
  var Operation = 3;
}
