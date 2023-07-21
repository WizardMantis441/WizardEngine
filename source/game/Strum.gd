class_name Strum
extends AnimatedSprite2D

@export var cpu:bool = false;
@export var noteData:int = 0;
var types = ["left", "down", "up", "right"];
var notes:Array[Note] = []
var canHitNote:bool = false

func _process(_delta):
	self.cpu = get_parent().cpu
	
#	if Input.is_action_just_pressed(types[noteData]) and not cpu and not canHitNote:
#		self.play(types[noteData] + " press instance 1")
#	if Input.is_action_just_released(types[noteData]) and not cpu and not canHitNote:
#		self.play("arrow static instance " + str(noteData))
	
	if self.animation.contains('confirm') and self.get_playing_speed() == 0 or not self.cpu and not Input.is_action_pressed(types[noteData]) and self.animation.contains('confirm') and self.get_playing_speed() == 0:
		self.play("arrow static instance " + str(noteData))

func updateNote(note):
	note.canBeHit = (note.time > Conductor.songPosition - (Conductor.hitWindow * Conductor.latePressWindow) and note.time < Conductor.songPosition + (Conductor.hitWindow * Conductor.earlyPressWindow))
	note.tooLate = (note.time < Conductor.songPosition - Conductor.hitWindow) and not note.wasGoodHit
	
	if Input.is_action_just_pressed(types[noteData]) and not cpu and note.canBeHit and notes.find(note) == 0 and not note.tooLate:
		get_tree().current_scene.goodNoteHit(note)
