class_name Strum
extends AnimatedSprite2D

@export var cpu:bool = false;
@export var noteData:int = 0;
var types = ["left", "down", "up", "right"];

func _process(_delta):
	self.cpu = get_parent().cpu
	
	if Input.is_action_just_pressed(types[noteData]) and not cpu:
		self.play(types[noteData] + " press instance 1");
	if Input.is_action_just_released(types[noteData]) and not cpu:
		self.play("arrow static instance " + str(noteData));
