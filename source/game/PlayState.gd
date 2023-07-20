extends Node2D

@onready var boyfriend = $Boyfriend

var anims = ["singLEFT", "singDOWN", "singUP", "singRIGHT"];
var animtypes = ["left", "down", "up", "right"];

func _ready():
	pass
	
func _process(_delta):
	for i in anims.size():
		if Input.is_action_just_pressed(animtypes[i]):
			boyfriend.playAnim(anims[i], true, 'SING');
			boyfriend.timer = 0;

func beatHit(_curBeat):
	boyfriend.dance()

func stepHit(curStep):
	boyfriend.timer += 1;
