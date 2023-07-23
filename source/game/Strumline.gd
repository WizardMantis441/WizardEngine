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

func updateNote(note):
	if note.strumLine.cpu:
		if note.time - Conductor.songPosition <= 0:
			get_tree().current_scene.goodNoteHit(note)
	else:
		self.strums[note.noteData].updateNote(note)
