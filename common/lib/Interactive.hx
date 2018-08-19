package lib;

class Interactive {
  public static var INDEX:Map<String, Interactive> = [
    "ss1" => new Interactive([
         Text('In your path stands a man, looking at a nearby tree very thoughtfully.')
        ,Text('"I seek synonyms," the man exclaims, when he notices you.')
        ,Text('"So many words, numerous, countless, infinite!"')
        ,Text('"You, robot, android, my machine friend, can you help me?"')
        ,Text('He pauses and seems a little bit embarassed.')
        ,Text('"I don\'t even know a single term for the fluid of a tree," he admits, "let alone any synonyms!"')
        ,Text('"Can you help me?"')
        ,Text('You suggest to the synonym seeker ...')
        ,Give(["sap"])
        ,Text('"Sap! What a sap I have been ... Thank you!"')
        ,Open(Right)
      ])
    ,"climber" => new Interactive([
         Text('You take in a strange scene: a robot, going up a ladder, but never getting anywhere. The ladder descends just as fast as the robot can ascend. Does it need to exercise to keep fit?')
        ,Text('With machine-like precision, the robot puts its arms on each step of the ladder, one at a time.')
        ,Text('You can only feel wonder at the robot and its infinite ...')
        ,Take(["climb"])
        ,Text('"Robogym," says the sign.')
      ])
    ,"king" => new Interactive([
         Text('You enter the royal court of King Kinplot.')
        ,Text('"Welcome, friendly mechanoid," says the King.')
        ,Text('"I heard thou has gifted fine silk garments to my Queen. Thou art a friend of the Kingdom indeed! Kneel before the King!"')
        ,Text('"For thy services, I dub thee Sir PLYR. Rise now, my ..."')
        ,Take(["knight"])
        ,Text('You feel blue blood surging through your metal body as you leave.')
      ])
    ,"guard" => new Interactive([
         Text('"Halt!"')
        ,Text('A royal guard in plate armour stops you from entering the castle.')
        ,Text('"This is Castle Kinplot. Only the worthy may enter."')
        ,Text('"To prove your virtue, first you must answer the customary riddle."')
        ,Text('"My first starts the second day."')
        ,Text('"My second starts the fourth moon."')
        ,Text('"My third starts the last day."')
        ,Text('"My last starts the royal family."')
        ,Text('"What am I?"')
        ,Give(["task"])
        ,SetFlag("king-guard", true)
        ,Text('"Well done," says the guard.')
        ,Text('"But of course," he continues, "that is not all there is to proving your worthiness! The King is wary of strangers. Perhaps you should gain favour of the Queen first."')
      ])
    ,"hey" => new Interactive([
         Text('You see a friendly guy looking at you.')
        ,Text('"Hi," says he.')
        ,Text('Is he a friend? You can\'t quite remember. You reply ...')
        ,Take(["hey"])
        ,Text('An awkard stretch of silence seems to fill the room now.')
      ])
    ,"ill" => new Interactive([
         Text('You see a rather ill-looking guy.')
        ,Text('"Ow, my head," he complains.')
        ,Text('"Would you happen to have some medicine?"')
        ,Text('You give him a ...')
        ,Give(["pill"])
        ,Text('"Thank you!"')
        ,Text('"My name is Michael. Or was it Nichael?"')
        ,Text('He notices you are a robot and adds, "are you here on a mission? Or is it a nission...?"')
        ,Operation("mini")
      ])
    ,"rev" => new Interactive([
         Text('You see a large railway turntable in the middle of a train depot. A sign says quietly, "Zorktown depot."')
        ,Text('A train from Annaburg to Zorktown slowly moves onto the turntable, signals to the operator, and the train is rotated - slowly.')
        ,Text('"All aboard," you hear on the PA, "for the express to Annaburg!"')
        ,Text('The turntable is now empty.')
        ,Operation("rev")
      ])
    ,"rap" => new Interactive([
         Text('A man stands on the stage, performing to no audience. He does not seem to mind.')
        ,Text('He speaks words with vigour, each verse flowing freely and yet akin the ones before.')
        ,Text('The words go by too fast to remember, but it is clearly a very impressive ...')
        ,Take(["rap"])
      ])
    ,"ss2" => new Interactive([
         Text('In your path stands a man, looking at the ladder thoughtfully.')
        ,Text('"I seek synonyms," the man exclaims, when he notices you.')
        ,Text('"So many meanings, intertwined, connected, braided!"')
        ,Text('"You, robot, android, my machine friend, can you help me?"')
        ,Text('"I need a favour from the king upstairs, but he is unhappy if his subjects \'demand\' things from him."')
        ,Text('"What should I do?"')
        ,Text('You suggest to the synonym seeker ...')
        ,Give(["ask"])
        ,Text('"Ask! How could I have looked askance at such a simple word ... Thank you!"')
        ,Open(Top)
      ])
    ,"c-" => new Interactive([
         Text('A pirate stands by his lonesome on the seashore. He is holding up a telescope to his left eye. You cannot tell why, for both of his eyes are covered with eyepatches.')
        ,Text('"I see no seas at the seashore," he mutters to himself.')
        ,Text('"Yet the sound of seas is all I hear!"')
        ,Text('He seems to dislike the sound of the seas.')
        ,Operation("c-")
      ])
    ,"general" => new Interactive([
         Text('A man in a uniform stands by three stars on the wall.')
        ,Text('"Attention, soldieeeeee-rs!"')
        ,Text('He seems to be ordering you to pay attention to him.')
        ,Text('"Thank you. The president recently came up to me," he continues, in a much more friendly tone. "And asked, \'well, General Thompson, how would you like the sound of ... -Lieutenant- General Thompson!\'"')
        ,Text('Is it a stand-up comedy act?')
        ,Text('"\'No thank you, Mr President,\' I replied! \'I would rather not be ...\'"')
        ,Take(["demoted"])
        ,Text('You realise that was the punchline and laugh out of politeness.')
      ])
    ,"lock" => new Interactive([
         Text('"Maintenance Shaft 17," says the text on the wall.')
        ,Text('You notice the floor has a trapdoor-shaped opening, but it is sealed shut.')
        ,Text('A futuristic-looking device (even to a robot with a mind of its own) stands ominously by the trapdoor. It seems to be a control panel of some sort, but you see no contact pads, universal control ports, nor touchscreens. The only apparent feature of the device is a recess in the panel, a small opening in the otherwise impenetrable metal. Upon closer inspection, you see that inside the opening, there are many little springs arranged in rows.')
        ,Text('You activate the futuristic-looking device with a ...')
        ,Give(["key"])
        ,Open(Bottom)
      ])
    ,"1cut" => new Interactive([
         Text('*swish* *thud*')
        ,Text('A chef cuts the head of a fish clean off just as you enter the kitchen.')
        ,Text('"Many a trout dares to enter my kitchen," he grins, "yet with a swish and a thud they are put to rout."')
        ,Operation("1cut")
      ])
    ,"19rev" => new Interactive([
         Text('A funfair stretches before you. Stalls of wild colours, games, rides, and a certain smell that can only be described as typical.')
        ,Text('After some meandering, you join a small gathering of people, watching a jester juggling colourful balls. Red goes up, then blue, green, and finally yellow. Their height seem random and yet the jester is in full control. Yellow is back in his hand, then the blue, green, and finally red. The crowd applauds - clearly the trick was very impressive.')
        ,Text('You, however, are not impressed, and the lack of any emotional circuitry in your braincase is not the reason.')
        ,Text('Juggling balls is easy - how about juggling ...')
        ,Operation("19rev")
      ])
    ,"fairspot" => new Interactive([
         Text('A lone telescope stands in the middle of the platform, trained at a floating island in the distance.')
        ,Text('You approach the telescope and take a peek.')
        ,Text('You see a small fun fair, with a juggler juggling some balls.')
      ])
    ,"slick" => new Interactive([
         Text('A faucet is open slightly in the middle of the room, dripping slowly a very viscous, extremely slippery pink liquid. It must have been open for a very long time, since the platform is now completely covered in the oil.')
        ,Text('In fact, without using the maintenance shaft, this faucet is now completely unreachable from either end of the room, all because of the oil --i-k.')
        ,Take(["slick"])
      ])
    ,"1inc" => new Interactive([
         Text('"Rocks for your rolls? Socks for cold feet? Tocks for the clock," the woman asks you.')
        ,Text('Noticing your confusion, the woman continues, as if to explain, "bog shoes! Cog wheels! Dog treats!"')
        ,Operation("1inc")
      ])
    ,"ss3" => new Interactive([
         Text('In your path stands a man, looking at the grassy knoll thoughtfully.')
        ,Text('"I seek synonyms," the man exclaims, when he notices you.')
        ,Text('"So many connotations, similar, alike, akin!"')
        ,Text('"You, robot, android, my machine friend, can you help me?"')
        ,Text('"This grassy knoll here, I think it is a target practice. You propel projectiles with a metallic tool and try to sink them in that little hole by the flag."')
        ,Text('"If I were up to scratch, they would call my score ... What! I can\'t think of the proper word for the life of me."')
        ,Text('You suggest to the synonym seeker ...')
        ,Give(["par"])
        ,Text('"Par! Should have been ap-par-ent to me ... Thank you!"')
        ,Open(Top)
      ])
    ,"checker" => new Interactive([
         Text('A man dressed in a old-time uniform welcomes you.')
        ,Text('"Welcome, friend," he says.')
        ,Text('"I see you want to enter the amazing Faerie World." The capital letters were very clearly pronounced.')
        ,Text('"Worry not, you can, but there is just one thing ..."')
        ,Text('"How to put this gently," he hesitates. "Well, I think your face is a bit too modern for our fantasy world."')
        ,Text('"Can you try to look a bit less mechanical?"')
        ,Give(["mask"])
        ,Text('"Ah, that\'s much better - our patrons will not run away screaming at the sight of you. Please, enter and enjoy!"')
        ,Open(Top)
      ])
    ,"ss4" => new Interactive([
         Text('In your path stands a man, looking at the room behind the glass thoughtfully.')
        ,Text('"I seek synonyms," the man exclaims, when he notices you.')
        ,Text('"So many ways to phrase a sentence, subtly different, nearly identical, virtually indistinguishable!"')
        ,Text('"You, robot, android, my machine friend, can you help me?"')
        ,Text('"I was admiring the room behind this window. It is completely spotless, clean, pure. Of course, it has no doors and this window is sealed. But there is not even a speck of dust!"')
        ,Text('He stops his monologue suddenly and seems to start looking for a word.')
        ,Text('"\'Speck\' of dust, \'speck\', hmm," he keeps muttering to himself.')
        ,Text('You suggest to the synonym seeker ...')
        ,Give(["mote"])
        ,Text('"Mote! What a remote word ... Thank you!"')
        ,Open(Left)
      ])
    ,"queen" => new Interactive([
         Text('"Welcome, my subject," says the Queen.')
        ,Text('"I presume thou art yet another stranger seeking passage to the inner Cuttlecombs."')
        ,Text('"We guard the royal Cuttle very carefully! Dost thou think any vagabond of steel can simply march into our Kingdom and see the Cuttle? That would be a disaster. Thou must prove thyself first!"')
        ,Text('"I will let thee enter if thou canst bring me the finest of cloth!"')
        ,Give(["silk"])
        ,Text('"Very well, I accept your gift, for this is fine silk indeed. Enter the inner Cuttlecombs, but beware! They are greener indeed."')
        ,Text('"Also, I believe the King will be happy to receive thee now."')
        ,SetFlag("king-queen", true)
        ,Open(Bottom)
      ])
    ,"actor" => new Interactive([
         Text('"To be or not to be that is the question whether \'tis nobler in the mind to suffer the slings and arrows of outrageous fortune or to take arms against a sea of troubles and by opposing end them to die to sleep no more and by a sleep to say we end ..."')
        ,Text('An actor seems to be reciting a play. After a minute of listening to the mindless droning, you realise it is not a rehearsal.')
        ,Text('After what seems like a lifetime, the play finally ends and the actor looks at you expectantly. To clap or not to clap?')
        ,Text('Your hesitation reaches a critical point and the actor asks, "oh okay, I get it, it was bad - but why?"')
        ,Text('"I said all the text perfectly, word for word, I am sure of this! What else do I need to do?"')
        ,Give(["emote"])
        ,Text('The actor seems dumbstruck. "Emote? But there is no indication of emotions in the script! How am I to know?"')
        ,Text('While he is considering this novel technique in theatre acting, you notice a face just as emotionless as the actor\'s.')
        ,Text('You pick up the ...')
        ,Take(["mask"])
      ])
    ,"leaf" => new Interactive([
         Text('The window opens up into a sad-looking display. Only a husk now remains of something once so majestic. The sight seems familiar somehow.')
        ,Text('A piece of paper is attached to the window. It says: "Step on me while I live, and I shall make no sound. Step on me when dead, I\'ll crack and groan. What am I?"')
        ,Take(["leaf"])
        ,Text('You leave the tree stump be.')
      ])
    ,"power" => new Interactive([
         Text('You see a small chamber in the wall. Upon closer examination, you see the top wall of the chamber is missing, and continues up a long chute, too narrow and dark to see. At the bed of the chamber there is a small quantity of some black, brittle lumps.')
        ,Text('The signs around the chamber suggest this is some sort of a futuristic power generator. The black lumps need to undergo an exothermic chemical reaction.')
        ,Text('You decide to ---- the black lumps.')
        ,Give(["burn"])
        ,OpenOther("missing", Right)
        ,OpenOther("1dec*3", Left)
        ,Open(Left)
        ,Open(Right)
      ])
    ,"1dec*3" => new Interactive([
         Text('"Fallen down, \'ave you," the man in the booth asks.')
        ,Text('"We all do sometimes, pal. Tell you what, gimme some change and I\'ll shave it down a step or three."')
        ,Operation("1dec*3")
      ])
    ,"bouncer" => new Interactive([
         Text('"Back off, buddy," a bouncer stops you.')
        ,Text('"This is only the finest bar this side of the galaxy. You cannot simply enter."')
        ,Text('He looks left and right to see if anybody is listening.')
        ,Text('"Weeeell, that is not true. You can actually enter, but it will cost you dear!"')
        ,Text('"That\'s right, friend ... it will cost you the answer to a riddle!"')
        ,Text('"A black dog sleeps in the middle of a road in a town painted black. None of the street lights work due to a power failure caused by the storm. A car with broken headlights drives towards the dog but turns in time to avoid it. How could the driver have seen the dog?"')
        ,Text('You ponder. Ah, of course - because it was not during the ...')
        ,Give(["night"])
        ,Text('"Well done, you may enter the finest minibar this side of the room," laughs the bouncer.')
        ,Open(Right)
      ])
    ,"bar" => new Interactive([
         Text('This bar really is mini.')
        ,Text('Below, you can see the royal Cuttle, but landing on top of it would probably be a bad idea.')
        ,Text('The automatic machine seems to have the standard menu of alcoholic beverages, but perhaps the usual clientele is a bit rougher around here than you would imagine. After all, the smallest portion you can buy is a ...')
        ,Take(["bucket"])
      ])
    ,"o-u" => new Interactive([
         Text('You see a gigantic fish in the room.')
        ,Text('"Oh, you," it says.')
        ,Text('It doesn\'t seem particularly bothered about the world around it, not even the fact that it is a fish out of water. It probably has yet to notice.')
        ,Text('"Oh, you," it repeats, vacantly.')
        ,Operation("o-u")
      ])
    ,"horn" => new Interactive([
         Text('You notice a strange object on the pedestal.')
        ,Text('A plaque nearby reads, "I play jazz, yet my brethren grow on giraffes."')
        ,Text('You decide to pick up the ...')
        ,Take(["horn"])
      ])
    ,"g1" => new Interactive([
         Text('Three men stand guard at the entrance to the royal Cuttle.')
        ,Text('The left man says to you, "I detest Evil! I cannot see it with peace in my soul."')
        ,Text('"But, as you see, my soul is very much at peace! It is simple - I am ..."')
        ,Give(["blind"])
        ,SetFlag("g1-done", true)
      ])
    ,"g2" => new Interactive([
         Text('Three men stand guard at the entrance to the royal Cuttle.')
        ,Text('The middle man says to you, "I detest Evil! I cannot hear it with peace in my soul."')
        ,Text('"But, as you see, my soul is very much at peace! It is simple - I am ..."')
        ,Give(["deaf"])
        ,SetFlag("g2-done", true)
      ])
    ,"g3" => new Interactive([
         Text('Three men stand guard at the entrance to the royal Cuttle.')
        ,Text('The right man looks at you, but speaks not. He seems at peace.')
        ,Text('You ponder and realise. It is simple, the man is ...')
        ,Give(["mute"])
        ,SetFlag("g3-done", true)
      ])
    ,"cuttle" => new Interactive([
         Text('This is it, the royal Cuttle!')
        ,Text('What a majestic creature.')
        ,Text('It observes you calmly as you come closer. It seems happy enough to give up ink, but how to do it? And where to store it? Really, these mission critical details should have been thought of in advance.')
        ,Text('You pull up a stool and improvise. You locate what seems to be the ink sac and place a ------ below it.')
        ,Give(["bucket"])
        ,Text('With the bucket in place, you can finally start to ---- the royal Cuttle!')
        ,Give(["milk"])
        ,Text('As the last drops of the Space Ink drop into the bucket, you feel a sense of accomplishment. Not much longer now and you will be able to forget this whole place.')
        ,Text('(YOU WIN!)')
      ])
  ];
  
  public var fragments:Array<IaFragment>;
  
  public function new(f:Array<IaFragment>) {
    this.fragments = f;
  }
}

enum IaFragment {
  Text(msg:String);
  Image(name:String);
  RoomImage(name:String);
  Operation(name:String);
  Give(words:Array<Word>);
  Take(words:Array<Word>);
  SetFlag(flag:String, value:Bool);
  Open(exit:Direction);
  OpenOther(room:String, exit:Direction);
  Continue(done:Bool);
}

typedef IaBranch = {
     conditions:Map<String, Bool>
    ,fragments:Array<IaFragment>
  };
