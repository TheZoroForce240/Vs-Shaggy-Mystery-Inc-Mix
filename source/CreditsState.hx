package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = 1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];

	private static var creditsStuff:Array<Dynamic> = [ //Name - Icon name - Description - Link - BG Color
		['Mystery Inc Mix'],
		['Rareblin', 'mim/rareblin', 'Mod Idea, Music (God Eater, Final Destination, Talladega, Pre-Talladega Dialogue music)', '', 0xFFFF9E00],
		['TheOnlyVolume', '', 'Music (Main Menu, Zeph Theme, Kaio Ken, Blast, Revenge, Astral Calamity, Talladega)', '', 0xFFFF9E00],
		['TheZoroForce240', 'mim/zoro', 'Coding and Charting', '', 0xFFFF9E00],
		['RhysRJJ', 'mim/rhys', 'Charting, Animated Shaggy Sprites (Green, Red, Zeph)', '', 0xFFFF9E00],
		['ShagLSSJ', 'mim/shag', 'Shaggy Sprites (Green, Red, Zeph), Icons', '', 0xFFFF9E00],
		['KaosKurve', 'mim/kaos', 'Green Shaggy BG, Red Shaggy BG, Dialogue Portraits', '', 0xFFFF9E00],
		['b0nette', 'mim/bon', 'WB Shaggy BG, Boxing BG, Spanish Translations for Shaggy X Matt Dialogue', '', 0xFFFF9E00],
		['Boboa', 'mim/boboa', 'Menu BG, Brazilian-Portuguese Translations for Shaggy X Matt Dialogue', '', 0xFFFF9E00],
		['Kivro', '', 'Blue Matt Sprites', '', 0xFFFF9E00],
		['SamTheSly', 'mim/samthesly', 'Music (Where Are You)', '', 0xFFFF9E00],
		['SicOn', 'mim/sicon', 'Music (Eruption, Super Saiyan)', '', 0xFFFF9E00],
		['ThatOneGuy', '', 'Music (Power Link)', '', 0xFFFF9E00],
		['krayzoneX', '', 'Music (Power Link)', '', 0xFFFF9E00],
		['Ahloof', 'mim/ahloof', 'Music (Soothing Power)', '', 0xFFFF9E00],
		['Atomified Productions', '', 'Music (Thunderstorm)', '', 0xFFFF9E00],
		['Somf', '', 'Music (Dissasembler, Kaio Ken)', '', 0xFFFF9E00],
		['Leebert', '', 'Music (Astral Calamity)', '', 0xFFFF9E00],
		['The Shaggy mod'],
		['srPerez', 'perez', 'Coder, Main artist & animator, Main composer, Co-charter', 'https://twitter.com/NewSrPerez', 0xFFFF9E00],
		['MORO', 'moro', 'Artist & animator of WB Shaggy sprites\n& Chapter 5 cutscene', 'https://twitter.com/Moro0986', 0xFF7027AD],
		['Pointy', 'pointy', 'Co-Charter, Betatester', 'https://twitter.com/PointyyESM', 0xFF28389D],
		['Saruky', 'saruky', 'Composer of "Thunderstorm"', 'https://twitter.com/Saruky__', 0xFFDA0837],
		['Joan Atlas', 'tono', 'Composer of "Dissasembler"', 'https://twitter.com/joan_atlas', 0xFF543BC9],
		[''],
		['Translators'],
		['Soulegal', 'soulegal', 'Brazilian-Portuguese Co-Translator', 'https://twitter.com/nickstwt', 0xFFBF2322],
		['Aizakku', 'aizakku', 'Brazilian-Portuguese Co-Translator', 'https://twitter.com/ItsAizakku', 0xFFC7CDD6],
		[''],
		['Special thanks'],
		['Cony', 'cony', 'Artist of the epic Shaggy close-up', 'https://www.instagram.com/con0mmm/', 0xFFEAE4B0],
		['Kade Dev', 'kade', 'Updated input system', 'https://twitter.com/KadeDeveloper', 0xFF4A6747],
		['Sulayre', 'sulayre', 'Matt sprites (used in story menu)', 'https://twitter.com/Sulayre', 0xFF9F60CA],
		['McChomk', 'mcchomk', 'Transcribed the OG dialogue into\nthe new dialogue file system', 'https://mcchomk.itch.io', 0xFFBE672D],
		['Github Credits', 'ghub', 'Check out Github contributors', 'https://github.com/GithubSPerez/the-shaggy-mod/graphs/contributors', 0xFF28389D],
		[''],
		['Psych Engine Team'],
		['Shadow Mario',		'shadowmario',		'Main Programmer of Psych Engine',					'https://twitter.com/Shadow_Mario_',	0xFFFFDD33],
		['RiverOaken',			'riveroaken',		'Main Artist/Animator of Psych Engine',				'https://twitter.com/river_oaken',		0xFFC30085],
		['Keoiki',				'keoiki',			'Note Splash Animations',							'https://twitter.com/Keoiki_',			0xFFFFFFFF],
		['PolybiusProxy',		'polybiusproxy',	'.MP4 Video Loader Extension',						'https://twitter.com/polybiusproxy',	0xFFE01F32],
		[''],
		["Funkin' Crew"],
		['ninjamuffin99',		'ninjamuffin99',	"Programmer of Friday Night Funkin'",				'https://twitter.com/ninja_muffin99',	0xFFF73838],
		['PhantomArcade',		'phantomarcade',	"Animator of Friday Night Funkin'",					'https://twitter.com/PhantomArcade3K',	0xFFFFBB1B],
		['evilsk8r',			'evilsk8r',			"Artist of Friday Night Funkin'",					'https://twitter.com/evilsk8r',			0xFF53E52C],
		['kawaisprite',			'kawaisprite',		"Composer of Friday Night Funkin'",					'https://twitter.com/kawaisprite',		0xFF6475F3]
	];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;

				if (creditsStuff[i][1] == '') icon.visible = false;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
			}
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		bg.color = creditsStuff[curSelected][4];
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		if(controls.ACCEPT) {
			CoolUtil.browserLoad(creditsStuff[curSelected][3]);
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int = creditsStuff[curSelected][4];
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}
		descText.text = creditsStuff[curSelected][2];
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
