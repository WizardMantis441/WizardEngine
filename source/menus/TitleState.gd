extends Node2D

@onready var gf = $gf
@onready var logo = $"logo"
@onready var ng = $"ng"
@onready var enter = $"press enter"
@onready var flash = $FLASHHH
@onready var mainText = $Label
@onready var confirm = $confirm

var introText = FileAccess.get_file_as_string("res://assets/data/introText.txt").split("\n");
var curWacky = introText[randi_range(0, introText.size() - 2)].split("--");

var skippedIntro = false;
var pressedEnter = false;

func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK);
	ng.visible = false;
	
func _process(_elapsed:float) -> void:
	if Input.is_action_just_pressed("enter"):
		if skippedIntro:
			if not pressedEnter:
				pressedEnter = true;
				enter.play("ENTER PRESSED");
				var tween = get_tree().create_tween();
				tween.tween_property(flash, "modulate:a", 0, 1);
				confirm.play();
	#			FlxG.switchState(new MainMenuState());
		else:
			skipIntro();

func beatHit(curBeat):
	logo.frame = 0;
	logo.play("logo bumpin");
	
	gf.play("danceLeft" if curBeat % 2 == 0 else "danceRight");
	
	if skippedIntro == false:
		match curBeat:
			1: mainText.text = 'ninjamuffin99\nphantomArcade\nkawaisprite\nevilsk8er';
			3: mainText.text = 'ninjamuffin99\nphantomArcade\nkawaisprite\nevilsk8er\npresent';
			4: mainText.text = '';
			5: mainText.text = 'in association\nwith';
			7:
				mainText.text = 'in association\nwith\nnewgrounds';
				ng.visible = true;
			8:
				mainText.text = '';
				ng.visible = false;
			9: mainText.text = curWacky[0];
			11: mainText.text = curWacky[0] + '\n' + curWacky[1];
			12: mainText.text = '';
			13: mainText.text = 'friday';
			14: mainText.text = 'friday\nnight';
			15: mainText.text = 'friday\nnight\nfunkin';
			16: skipIntro();
		pass

func skipIntro():
	flash.color = Color.WHITE;
	var tween = get_tree().create_tween();
	tween.tween_property(flash, "modulate:a", 0, 4);
	mainText.visible = false;
	skippedIntro = true;
