import sk.thenet.app.*;
import sk.thenet.app.TNPreloader;
import sk.thenet.app.asset.Bind as AssetBind;
import sk.thenet.app.asset.Bitmap as AssetBitmap;
import sk.thenet.app.asset.Sound as AssetSound;
import sk.thenet.app.asset.Trigger as AssetTrigger;
import sk.thenet.bmp.*;
import sk.thenet.plat.Platform;

import lib.*;

using sk.thenet.FM;
using sk.thenet.stream.Stream;

class Main extends Application {
  public function new() {
    super([
         Console
        ,ConsoleRemote("localhost", 8001)
        ,Framerate(60)
        ,Optional(Window("", 800, 600))
        ,Surface(400, 300, 1)
        ,Assets([
             Embed.getBitmap("pal", "png/pal.png")
            ,Embed.getBitmap("gui", "png/gui.png")
            ,Embed.getBitmap("rooms", "png/rooms.png")
            ,Embed.getBitmap("ragdolls", "png/ragdolls.png")
            ,new AssetTrigger("pal-parse", ["pal"], (am, _) -> {
                Pal.init(am.getBitmap);
                false;
              })
            ,new AssetBind(["pal-parse", "gui"], (am, _) -> {
                UI.init(am.getBitmap);
                false;
              })
            ,new AssetBind(["pal-parse", "rooms"], (am, _) -> {
                RoomRenderer.init(am.getBitmap);
                false;
              })
          ])
        ,Keyboard
        ,Mouse
      ]);
    preloader = new TNPreloader(this, "game", true);
    addState(new SGame(this));
    mainLoop();
  }
}
