package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var portraitFace = 1;
	var portraitCharacter:String = '';

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;
	var skipText:FlxText;

	public var finishThing:Void->Void;
	// pixel stuff
	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	// yoshi's faces
	var portraitLeft_Yoshi1:FlxSprite;
	var portraitLeft_Yoshi2:FlxSprite;
	var portraitLeft_Yoshi3:FlxSprite;

	// bf's faces
	var portraitRight_BF1:FlxSprite;
	var portraitRight_BF2:FlxSprite;
	var portraitRight_BF3:FlxSprite;
	var portraitRight_BF4:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;


	var canAdvance = false;


	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		new FlxTimer().start(0.5, function(tmr:FlxTimer)
		{
				canAdvance = true;
		});
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'flower-garden' | "underground" | "spikey-stroll":
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('dia/Dialogue_Box', 'yoshi');
				box.animation.addByPrefix('normalOpen', 'Dialogue Box open', 24, false);
				box.animation.addByIndices('normal', 'Dialogue Box', [26], "",24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return; 

			// THIS TOOK WAY LONGER THEN EXPECTED PLEASE KILL ME AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
	//Pixel Portrait
			portraitLeft = new FlxSprite(-20, 40);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
			portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;

			portraitRight = new FlxSprite(0, 40);
			portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
			portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;	
// YOSHI PORTS
			portraitLeft_Yoshi1 = new FlxSprite(120, -140);
			portraitLeft_Yoshi1.frames = Paths.getSparrowAtlas('dia/Yoshi_Portraits', "yoshi");
			portraitLeft_Yoshi1.animation.addByPrefix("fade", "Portrait 1 fade", 24, false);
			portraitLeft_Yoshi1.animation.addByIndices("enter", "Portrait", [1], "", 24, false);
			portraitLeft_Yoshi1.animation.addByIndices("fadeIN", "Portrait ` fade", [7, 6, 5, 4, 3, 2, 1], "", 24, false);
			portraitLeft_Yoshi1.setGraphicSize(Std.int(portraitLeft_Yoshi1.width * PlayState.daPixelZoom * 0.09));
			portraitLeft_Yoshi1.scrollFactor.set();
			add(portraitLeft_Yoshi1);
			portraitLeft_Yoshi1.visible = false;
			
			portraitLeft_Yoshi2 = new FlxSprite(120, -140);
			portraitLeft_Yoshi2.frames = Paths.getSparrowAtlas('dia/Yoshi_Portraits', "yoshi");
			portraitLeft_Yoshi2.animation.addByPrefix("fade", "Portrait 2 fade", 24, false);
			portraitLeft_Yoshi2.animation.addByIndices("enter", "Portrait", [2], "", 24, false);
			portraitLeft_Yoshi2.animation.addByIndices("fadeIN", "Portrait 2 fade", [7, 6, 5, 4, 3, 2, 1], "", 24, false);
			portraitLeft_Yoshi2.setGraphicSize(Std.int(portraitLeft_Yoshi2.width * PlayState.daPixelZoom * 0.09));
			portraitLeft_Yoshi2.scrollFactor.set();
			add(portraitLeft_Yoshi2);
			portraitLeft_Yoshi2.visible = false;	

			portraitLeft_Yoshi3 = new FlxSprite(120, -145);
			portraitLeft_Yoshi3.frames = Paths.getSparrowAtlas('dia/Yoshi_Portraits', "yoshi");
			portraitLeft_Yoshi3.animation.addByPrefix("fade", "Portrait 3 fade", 24, false);
			portraitLeft_Yoshi3.animation.addByIndices("enter", "Portrait", [3], "", 24, false);
			portraitLeft_Yoshi3.animation.addByIndices("fadeIN", "Portrait 3 fade", [7, 6, 5, 4, 3, 2, 1], "", 24, false);
			portraitLeft_Yoshi3.setGraphicSize(Std.int(portraitLeft_Yoshi3.width * PlayState.daPixelZoom * 0.09));
			portraitLeft_Yoshi3.scrollFactor.set();
			add(portraitLeft_Yoshi3);
			portraitLeft_Yoshi3.visible = false;		
		// BF
			portraitRight_BF1 = new FlxSprite(750, 90);
			portraitRight_BF1.frames = Paths.getSparrowAtlas('dia/bfPort', "yoshi");
			portraitRight_BF1.animation.addByPrefix('fade', 'bf port 1 fade', 24, false);
			portraitRight_BF1.animation.addByIndices("enter", "bf port", [1], "", 24, false);
			portraitRight_BF1.animation.addByIndices("fadeIN", "bf port 1 fade", [7, 6, 5, 4, 3, 2, 1], "", 24, false);
			portraitRight_BF1.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.25));
			portraitRight_BF1.scrollFactor.set();
			add(portraitRight_BF1);
			portraitRight_BF1.visible = false;	

			portraitRight_BF2 = new FlxSprite(750, 90);
			portraitRight_BF2.frames = Paths.getSparrowAtlas('dia/bfPort', "yoshi");
			portraitRight_BF2.animation.addByPrefix('fade', 'bf port 2 fade', 24, false);
			portraitRight_BF2.animation.addByIndices("enter", "bf port",[2],'',24, false);
			portraitRight_BF2.animation.addByIndices("fadeIN", "bf port 2 fade", [7, 6, 5, 4, 3, 2, 1], "", 24, false);
			portraitRight_BF2.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.25));
			portraitRight_BF2.scrollFactor.set();
			add(portraitRight_BF2);
			portraitRight_BF2.visible = false;	

			portraitRight_BF3 = new FlxSprite(750, 90);
			portraitRight_BF3.frames = Paths.getSparrowAtlas('dia/bfPort', "yoshi");
			portraitRight_BF3.animation.addByPrefix('fade', 'bf port 3 fade', 24, false);
			portraitRight_BF3.animation.addByIndices("enter", "bf port",[3],'',24, false);
			portraitRight_BF3.animation.addByIndices("fadeIN", "bf port 3 fade", [7, 6, 5, 4, 3, 2, 1], "", 24, false);
			portraitRight_BF3.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.25));
			portraitRight_BF3.scrollFactor.set();
			add(portraitRight_BF3);
			portraitRight_BF3.visible = false;	
			
			portraitRight_BF4 = new FlxSprite(750, 90);
			portraitRight_BF4.frames = Paths.getSparrowAtlas('dia/bfPort', "yoshi");
			portraitRight_BF4.animation.addByPrefix('fade', 'bf port 4 fade', 24, false);
			portraitRight_BF4.animation.addByIndices("enter", "bf port",[4],'',24, false);
			portraitRight_BF4.animation.addByIndices("fadeIN", "bf port 4 fade", [7, 6, 5, 4, 3, 2, 1], "", 24, false);
			portraitRight_BF4.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.25));
			portraitRight_BF4.scrollFactor.set();
			add(portraitRight_BF4);
			portraitRight_BF4.visible = false;	
			

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);
		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
			{
		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);	
			}



		if (!talkingRight)
		{
			// box.flipX = true;
		}
		if (PlayState.SONG.song.toLowerCase() == 'flower-garden' || PlayState.SONG.song.toLowerCase() == 'underground' || PlayState.SONG.song.toLowerCase() == 'spikey-stroll')
			{
				dropText = new FlxText(262, 422, Std.int(FlxG.width * 0.6), "", 28);
			}
			else
			{
				dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			}
		//dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);
		if (PlayState.SONG.song.toLowerCase() == 'flower-garden' || PlayState.SONG.song.toLowerCase() == 'underground' || PlayState.SONG.song.toLowerCase() == 'spikey-stroll')
			{
				swagDialogue = new FlxTypeText(260, 420, Std.int(FlxG.width * 0.6), "", 28);
			}
			else
				{
					swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
				}
		
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		skipText = new FlxText(5, 695, 640, "Press SPACE to skip the dialogue.\n", 40);
		skipText.scrollFactor.set(0, 0);
		skipText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		skipText.borderSize = 2;
		skipText.borderQuality = 1;
		add(skipText);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if(FlxG.keys.justPressed.SPACE && !isEnding){

			isEnding = true;
			endDialogue();

		}

		if (FlxG.keys.justPressed.ANY && dialogueStarted == true && canAdvance && !isEnding)
			{
				remove(dialogue);
				canAdvance = false;
	
				new FlxTimer().start(0.15, function(tmr:FlxTimer)
				{
					canAdvance = true;
				});
	
				FlxG.sound.play(Paths.sound('clickText'), 0.8);
	
				if (dialogueList[1] == null && dialogueList[0] != null)
				{
					if (!isEnding)
					{
						isEnding = true;
						endDialogue();
					}
				}
				else
				{
					dialogueList.remove(dialogueList[0]);
					startDialogue();
				}
			}

		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function endDialogue(){

		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
			FlxG.sound.music.fadeOut(2.2, 0);

		new FlxTimer().start(0.2, function(tmr:FlxTimer)
		{
			box.alpha -= 1 / 5;
			bgFade.alpha -= 1 / 5 * 0.7;
			portraitLeft.visible = false;
			portraitRight.visible = false;
			//portraitLeft_Yoshi1.visible = false;
			//portraitLeft_Yoshi2.visible = false;
			//portraitLeft_Yoshi3.visible = false;
			//portraitRight_BF1.visible = false;
			//portraitRight_BF2.visible = false;
			//portraitRight_BF3.visible = false;
			//portraitRight_BF4.visible = false;
			faceFadingAll(true, true, true, true, true, true, true);
			swagDialogue.alpha -= 1 / 5;
			dropText.alpha = swagDialogue.alpha;
		}, 5);


		new FlxTimer().start(1.2, function(tmr:FlxTimer)
		{
			finishThing();
			kill();
			FlxG.sound.music.stop();
		});

	}
	function faceFadingAll(Yoshi1:Bool, Yoshi2:Bool, Yoshi3:Bool, BF1:Bool, BF2:Bool, BF3:Bool, BF4:Bool)
		{
			if (Yoshi1 == true)
			{
				portraitLeft_Yoshi1.animation.play('fade', false);
			}
			if (Yoshi2 == true)
			{
				portraitLeft_Yoshi2.animation.play('fade', false);
			}	
			if (Yoshi3 == true)
			{
				portraitLeft_Yoshi3.animation.play('fade', false);
			}	
			if (BF1 == true)
			{
				portraitRight_BF1.animation.play('fade', false);
			}	
			if (BF2 == true)
			{
				portraitRight_BF2.animation.play('fade', false);
			}	
			if (BF3 == true)
			{
				portraitRight_BF3.animation.play('fade', false);
			}	
			if (BF4 == true)
			{
				portraitRight_BF4.animation.play('fade', false);
			}	
	
		new FlxTimer().start(0.4, function(tmr:FlxTimer)
			{
				portraitLeft.visible = false;
				portraitRight.visible = false;
				if (Yoshi1 == true)
					{
						portraitLeft_Yoshi1.visible = false;
					}
					if (Yoshi2 == true)
					{
						portraitLeft_Yoshi2.visible = false;
					}	
					if (Yoshi3 == true)
					{
						portraitLeft_Yoshi3.visible = false;
					}	
					if (BF1 == true)
					{
						portraitRight_BF1.visible = false;
					}	
					if (BF2 == true)
					{
						portraitRight_BF2.visible = false;
					}	
					if (BF3 == true)
					{
						portraitRight_BF3.visible = false;
					}	
					if (BF4 == true)
					{
						portraitRight_BF4.visible = false;
					}	
			});
		}

function portraitFadeIn(portraitName:String) {
	if (portraitName == "Yoshi1")
		{
			portraitLeft_Yoshi1.visible = true;
			//portraitLeft_Yoshi1.animation.play('fadeIN', false);
			portraitLeft_Yoshi1.alpha = 0.3;
		}
		if (portraitName == "Yoshi2")
		{
			portraitLeft_Yoshi2.visible = true;
			//portraitLeft_Yoshi2.animation.play('fadeIN', false);
			portraitLeft_Yoshi2.alpha = 0.3;
		}	
		if (portraitName == "Yoshi3")
		{
			portraitLeft_Yoshi3.visible = true;
			//portraitLeft_Yoshi3.animation.play('fadeIN');
			portraitLeft_Yoshi3.alpha = 0.3;
		}	
		if (portraitName == "BF1")
		{
			portraitRight_BF1.visible = true;
			//portraitRight_BF1.animation.play('fadeIN');
			portraitRight_BF1.alpha = 0.3;
		}	
		if (portraitName == "BF2")
		{
			portraitRight_BF2.visible = true;
			//portraitRight_BF2.animation.play('fadeIN');
			portraitRight_BF2.alpha = 0.3;
		}	
		if (portraitName == "BF3")
		{
			portraitRight_BF3.visible = true;
			//portraitRight_BF3.animation.play('fadeIN');
			portraitRight_BF3.alpha = 0.3;
		}	
		if (portraitName == "BF4")
		{
			portraitRight_BF4.visible = true;
			//portraitRight_BF4.animation.play('fadeIN');
			portraitRight_BF4.alpha = 0.3;
		}	
		new FlxTimer().start(0.6, function(tmr:FlxTimer)
			{
				if (portraitName == "Yoshi1")
					{
						portraitLeft_Yoshi1.alpha = 1;
						//portraitLeft_Yoshi1.visible = true;
						portraitLeft_Yoshi1.animation.play('enter', true);
					}
					if (portraitName == "Yoshi2")
					{
						portraitLeft_Yoshi2.alpha = 1;
						//portraitLeft_Yoshi2.visible = true;
						portraitLeft_Yoshi2.animation.play('enter', true);
					}	
					if (portraitName == "Yoshi3")
					{
						portraitRight_BF1.alpha = 1;
						//portraitRight_BF1.visible = true;
						portraitRight_BF1.animation.play('enter', true);
					}	
					if (portraitName == "BF2")
					{
						portraitRight_BF2.alpha = 1;
						//portraitRight_BF2.visible = true;
						portraitRight_BF2.animation.play('enter', true);
					}	
					if (portraitName == "BF3")
					{
						portraitRight_BF3.alpha = 1;
						//portraitRight_BF3.visible = true;
						portraitRight_BF3.animation.play('enter', true);
					}	
					if (portraitName == "BF4")
					{
						portraitRight_BF4.alpha = 1;
						//portraitRight_BF4.visible = true;
						portraitRight_BF4.animation.play('enter', true);
					}
			});

}


	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{

			case 'dad1':
			//	portraitRight.visible = false;
			//	portraitLeft.visible = false;
			//	portraitLeft_Yoshi2.visible = false;
			//	portraitLeft_Yoshi3.visible = false;
			//	portraitRight_BF1.visible = false;
			//	portraitRight_BF2.visible = false;
			//	portraitRight_BF3.visible = false;
			//	portraitRight_BF4.visible = false;
				if (!portraitLeft_Yoshi1.visible)
				{
					faceFadingAll(false, true, true, true, true, true, true);
					portraitLeft_Yoshi1.visible = true;
					//portraitFadeIn("Yoshi1");
					portraitLeft_Yoshi1.animation.play('enter', true);
	
				}
			case 'dad2':
			//	portraitRight.visible = false;
			//	portraitLeft.visible = false;
			//	portraitLeft_Yoshi1.visible = false;
			//	portraitLeft_Yoshi3.visible = false;
			//	portraitRight_BF1.visible = false;
			//	portraitRight_BF2.visible = false;
			//	portraitRight_BF3.visible = false;
			//	portraitRight_BF4.visible = false;
				if (!portraitLeft_Yoshi2.visible)
				{
					faceFadingAll(true, false, true, true, true, true, true);
					portraitLeft_Yoshi2.visible = true;
					//portraitFadeIn("Yoshi2");
					portraitLeft_Yoshi2.animation.play('enter', true);
				}
			case 'dad3':
				//portraitRight.visible = false;
				//portraitLeft.visible = false;
				//portraitLeft_Yoshi1.visible = false;
				//portraitLeft_Yoshi2.visible = false;
				//portraitRight_BF1.visible = false;
				//portraitRight_BF2.visible = false;
				//portraitRight_BF3.visible = false;
				//portraitRight_BF4.visible = false;
				if (!portraitLeft_Yoshi3.visible)
				{
					faceFadingAll(true, true, false, true, true, true, true);
					portraitLeft_Yoshi3.visible = true;
					//portraitFadeIn("Yoshi3");
					portraitLeft_Yoshi3.animation.play('enter', true);
				}
			case 'bf1':
			//	portraitRight.visible = false;
			//	portraitLeft.visible = false;
			//	portraitLeft_Yoshi1.visible = false;
			//	portraitLeft_Yoshi3.visible = false;
			//	portraitLeft_Yoshi2.visible = false;
			//	portraitRight_BF2.visible = false;
			//	portraitRight_BF3.visible = false;
			//	portraitRight_BF4.visible = false;
			
				if (!portraitRight_BF1.visible)
				{
					faceFadingAll(true, true, true, false, true, true, true);
					portraitRight_BF1.visible = true;
					//portraitFadeIn("BF1");
					portraitRight_BF1.animation.play('enter', true);
				}
			case 'bf2':
			//	portraitRight.visible = false;
			//	portraitLeft.visible = false;
			//	portraitLeft_Yoshi1.visible = false;
			//	portraitLeft_Yoshi3.visible = false;
			//	portraitLeft_Yoshi2.visible = false;
			//	portraitRight_BF1.visible = false;
			//	portraitRight_BF3.visible = false;
			//	portraitRight_BF4.visible = false;
			
				if (!portraitRight_BF2.visible)
				{
					faceFadingAll(true, true, true, true, false, true, true);
					portraitRight_BF2.visible = true;
					//portraitFadeIn("BF2");
					portraitRight_BF2.animation.play('enter', true);
				}
			case 'bf3':
			//	portraitRight.visible = false;
				//portraitLeft.visible = false;
				//portraitLeft_Yoshi1.visible = false;
			//	portraitLeft_Yoshi3.visible = false;
				//portraitLeft_Yoshi2.visible = false;
			//	portraitRight_BF1.visible = false;
				//portraitRight_BF2.visible = false;
				//portraitRight_BF4.visible = false;
				
				if (!portraitRight_BF3.visible)
				{
					faceFadingAll(true, true, true, true, true, false, true);
					portraitRight_BF3.visible = true;
					//portraitFadeIn("BF3");
					portraitRight_BF3.animation.play('enter', true);
				}
			case 'bf4':
			//	portraitRight.visible = false;
			//	portraitLeft.visible = false;
			//	portraitLeft_Yoshi1.visible = false;
			//	portraitLeft_Yoshi3.visible = false;
			//	portraitLeft_Yoshi2.visible = false;
			//	portraitRight_BF1.visible = false;
			//	portraitRight_BF3.visible = false;
			//	portraitRight_BF2.visible = false;
				if (!portraitRight_BF4.visible)
				{
					faceFadingAll(true, true, true, true, true, true, false);
					portraitRight_BF4.visible = true;
					//portraitFadeIn("BF4");
					portraitRight_BF4.animation.play('enter', true);
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
