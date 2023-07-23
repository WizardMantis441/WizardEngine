class_name Strum
extends AnimatedSprite2D

@export var cpu:bool = false;
@export var noteData:int = 0;
var types = ["left", "down", "up", "right"];
var notes:Array[Note] = []
var canHitNote:bool = false
var closestNote:Note = null

func _ready():
	notes = get_parent().notes
	for note in notes:
		if note.noteData != self.noteData:
			notes.erase(note)

func _process(_delta):
	self.cpu = get_parent().cpu
	
	if self.animation.contains('confirm') and self.get_playing_speed() == 0 or not self.cpu and not Input.is_action_pressed(types[noteData]) and self.animation.contains('confirm') and self.get_playing_speed() == 0:
		self.play("arrow static instance " + str(noteData))

func updateNote(note):
	note.tooLate = (note.time < Conductor.songPosition - Conductor.hitWindow) and not note.wasGoodHit

	if abs(Conductor.songPosition - note.time) < Conductor.hitWindow * 0.35 and self.notes.find(note) == 0:
		note.canBeHit = true
		self.closestNote = note
	
	if note.tooLate:
		self.closestNote = null
		note.canBeHit = false
		note.queue_free()
		note.strumLine.notes.erase(note)
		if get_tree().current_scene.get_children().has(note):
			get_tree().current_scene.remove_child(note)
	
#	if self.closestNote != null and Input.is_action_just_pressed(self.closestNote.dirs[self.closestNote.noteData]) and not self.closestNote.wasGoodHit:
#		get_tree().current_scene.goodNoteHit(self.closestNote)
#		self.closestNote = null
#		self.play(types[self.noteData] + " confirm instance 1")
#	elif Input.is_action_just_pressed(types[self.noteData]):
#		self.play(types[self.noteData] + " press instance 1")
#	elif Input.is_action_just_released(types[self.noteData]):
#		self.play("arrow static instance " + str(self.noteData))
#
#	if self.animation.contains('confirm') and not Input.is_action_pressed(types[self.noteData]):
#		self.play("arrow static instance " + str(self.noteData))

func _input(event):
	if cpu or not event.is_action(types[self.noteData]):
		return

	if self.closestNote != null and Input.is_action_just_pressed(self.closestNote.dirs[self.closestNote.noteData]) and not self.closestNote.wasGoodHit:
		get_tree().current_scene.goodNoteHit(self.closestNote)
		self.closestNote = null
		self.play(types[self.noteData] + " confirm instance 1")
	elif Input.is_action_just_pressed(types[self.noteData]):
		self.play(types[self.noteData] + " press instance 1")
	elif Input.is_action_just_released(types[self.noteData]):
		self.play("arrow static instance " + str(self.noteData))

	if self.animation.contains('confirm') and not Input.is_action_pressed(types[self.noteData]):
		self.play("arrow static instance " + str(self.noteData))
