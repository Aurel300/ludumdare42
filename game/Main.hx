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
         Framerate(60)
        ,Optional(Window("", 800, 600))
        ,Surface(400, 300, 1)
        ,Assets([
             Embed.getBitmap("pal", "png/pal.png")
            ,Embed.getBitmap("floor0", "png/floor0.png")
            ,Embed.getBitmap("floor1", "png/floor1.png")
            ,Embed.getBitmap("floor2", "png/floor2.png")
            ,Embed.getBitmap("floor3", "png/floor3.png")
            ,Embed.getBitmap("floor4", "png/floor4.png")
            ,Embed.getBitmap("floor5", "png/floor5.png")
            ,Embed.getBitmap("floor6", "png/floor6.png")
            ,Embed.getBitmap("gui", "png/gui.png")
            ,Embed.getBitmap("ragdolls", "png/ragdolls.png")
            ,Embed.getBitmap(font.FontBasic3x9.ASSET_ID, "png/basic3x9.png")
            ,Embed.getBitmap(font.FontFancy8x13.ASSET_ID, "png/fancy8x13.png")
            ,Embed.getBitmap(font.FontNS.ASSET_ID, "png/ns8x16.png")
            ,Embed.getSound("loop-mecha", "wav/loop-mecha.mp3")
            ,Embed.getSound("loop-wind", "wav/loop-wind.mp3")
            ,Embed.getSound("sfx-chat-close", "wav/sfx-chat-close.wav")
            ,Embed.getSound("sfx-chat-letter", "wav/sfx-chat-letter.wav")
            ,Embed.getSound("sfx-chat-open", "wav/sfx-chat-open.wav")
            ,Embed.getSound("sfx-chat-talk", "wav/sfx-chat-talk.wav")
            ,Embed.getSound("sfx-click-invalid", "wav/sfx-click-invalid.wav")
            ,Embed.getSound("sfx-click-valid-1", "wav/sfx-click-valid-1.wav")
            ,Embed.getSound("sfx-click-valid-2", "wav/sfx-click-valid-2.wav")
            ,Embed.getSound("sfx-climb", "wav/sfx-climb.wav")
            ,Embed.getSound("sfx-door-close", "wav/sfx-door-close.wav")
            ,Embed.getSound("sfx-door-open", "wav/sfx-door-open.wav")
            ,Embed.getSound("sfx-nicejob", "wav/sfx-nicejob.wav")
            ,Embed.getSound("sfx-transition", "wav/sfx-transition.wav")
            ,Embed.getSound("sfx-trigger", "wav/sfx-trigger.wav")
            ,Embed.getSound("sfx-walk", "wav/sfx-walk.wav")
            ,Embed.getSound("sfx-word-drop-alt", "wav/sfx-word-drop-alt.wav")
            ,Embed.getSound("sfx-word-drop", "wav/sfx-word-drop.wav")
            ,Embed.getSound("sfx-word-grab-alt", "wav/sfx-word-grab-alt.wav")
            ,Embed.getSound("sfx-word-grab", "wav/sfx-word-grab.wav")
            ,Embed.getSound("test-1", "wav/test-1.mp3")
            ,Embed.getSound("test-2", "wav/test-2.mp3")
            ,Embed.getSound("theme-1", "wav/theme-1.mp3")
            ,Embed.getSound("theme-cuttlefish", "wav/theme-cuttlefish.mp3")
            ,Embed.getSound("theme-deepspace", "wav/theme-deepspace.mp3")
            ,Embed.getSound("theme-main", "wav/theme-main.mp3")
            ,Embed.getSound("theme-noise", "wav/theme-noise.mp3")
            ,new AssetTrigger("pal-parse", ["pal"], (am, _) -> {
                Pal.init(am.getBitmap);
                false;
              })
            ,new AssetBind([
                 "pal-parse", "gui", "ragdolls"
                ,"floor0", "floor1", "floor2", "floor3", "floor4", "floor5", "floor6"
                ,"loop-mecha"
                ,"loop-wind"
                ,"sfx-chat-close"
                ,"sfx-chat-letter"
                ,"sfx-chat-open"
                ,"sfx-chat-talk"
                ,"sfx-click-invalid"
                ,"sfx-click-valid-1"
                ,"sfx-click-valid-2"
                ,"sfx-climb"
                ,"sfx-door-close"
                ,"sfx-door-open"
                ,"sfx-nicejob"
                ,"sfx-transition"
                ,"sfx-trigger"
                ,"sfx-walk"
                ,"sfx-word-drop-alt"
                ,"sfx-word-drop"
                ,"sfx-word-grab-alt"
                ,"sfx-word-grab"
                ,"test-1"
                ,"test-2"
                ,"theme-1"
                ,"theme-cuttlefish"
                ,"theme-deepspace"
                ,"theme-main"
                ,"theme-noise"
                ,font.FontBasic3x9.ASSET_ID, font.FontFancy8x13.ASSET_ID, font.FontNS.ASSET_ID
              ], (am, _) -> {
                Text.init(am);
                UI.init(am.getBitmap);
                RoomVisual.init(am.getBitmap);
                RoomRenderer.init(am.getBitmap);
                Ragdoll.init(am.getBitmap);
                Sfx.init(am);
                false;
              })
          ])
        ,Keyboard
        ,Mouse
      ]);
    preloader = new TNPreloader(this, "title");
    addState(new SGame(this));
    addState(new STitle(this));
    mainLoop();
  }
}
