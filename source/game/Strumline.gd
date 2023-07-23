class_name Strumline
extends Node2D

@export var cpu:bool = false
@export var characters:Array[Character] = []

@onready var left = $left
@onready var down = $down
@onready var up = $up
@onready var right = $right

@onready var strums = [left, down, up, right];
var animtypes = ["left", "down", "up", "right"];

var notes:Array[Note] = []

#func _process(_delta):
#	for i in animtypes.size():
#		if Input.is_action_just_pressed(animtypes[i]) and not cpu:
#			for character in characters:
#				character.playAnim('sing' + animtypes[i].to_upper(), true, 'SING');
#				character.timer = 0;

func updateNote(note):
	if note.strumLine.cpu:
		if note.time - Conductor.songPosition <= 0:
			get_tree().current_scene.goodNoteHit(note)
	else:
		strums[note.noteData].updateNote(note)
