extends AnimatedSprite2D

@export var cpu:bool = false;
@export var strumID:int = 0;
var types = ["left", "down", "up", "right"];

func _process(_delta):
	if Input.is_action_just_pressed(types[strumID]) and not cpu:
		self.play(types[strumID] + " press instance 1");
	if Input.is_action_just_released(types[strumID]) and not cpu:
		self.play("arrow static instance " + str(strumID));
