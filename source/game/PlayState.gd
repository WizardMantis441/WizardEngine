extends Node2D

#var chart:Dictionary = JSON.parse_string(FileAccess.open("res://assets/songs/test/charts/normal.json", FileAccess.READ).get_as_text())

var chart:Dictionary = Chart.parse('test', 'normal');

@onready var noteScene:PackedScene = load("res://source/game/Note.tscn")
@onready var notes = $camHUD/Notes

@export var camZoomingStrength = 1
@export var camZoomingInterval = 4

@onready var camGame = $camGame
@onready var camHUD = $camHUD

@onready var cpuStrums = $"camHUD/Opponent Strums"
@onready var playerStrums = $"camHUD/Player Strums"

@onready var strumLines:Array = [cpuStrums, playerStrums]

func _ready():
	for sL in chart.strumLines.size():
		for nJson in chart.strumLines[sL].notes:
			var n = JSON.parse_string(str(nJson))
#			var newNote = Note.new(strumLines[sL], note.id, note.time)
			var note:Note = noteScene.instantiate()
			note.strumLine = strumLines[sL]
			note.noteData = n.id
			note.time = n.time
			notes.add_child(note)
			print(note.strumLine)
			
			

	Conductor.bpm = 150.0

func _process(_delta):
	camGame.scale = lerp(camGame.scale, Vector2(1,1), 0.06)
	camGame.position = lerp(camGame.position, Vector2(0,0), 0.06)
	
	camHUD.scale = lerp(camHUD.scale, Vector2(1,1), 0.06)
	camHUD.position = lerp(camHUD.position, Vector2(0,0), 0.06)

#func stepHit(curStep):
#	for sl in strumLines:
#		for character in sl.characters:
#			if character.has_method("stepHit"):
#				character.call_deferred("stepHit", curStep)

func beatHit(curBeat):
	if curBeat % camZoomingInterval == 0:
		camGame.scale = Vector2(1.00625*camZoomingStrength,1.0025*camZoomingStrength)
		camGame.position = Vector2(-3.25*camZoomingStrength,-1.5625*camZoomingStrength)
		
		camHUD.scale = Vector2(1.0125*camZoomingStrength,1.0125*camZoomingStrength)
		camHUD.position = Vector2(-6.25*camZoomingStrength,-3.125*camZoomingStrength)
	
#	for sl in strumLines:
#		for character in sl.characters:
#			character.dance()
#			if character.has_method("beatHit"):
#				character.call_deferred("beatHit", curBeat)

#func measureHit(curMeasure):
#	for sl in strumLines:
#		for character in sl.characters:
#			if character.has_method("measureHit"):
#				character.call_deferred("measureHit", curMeasure)
#
#func onBPMChange(newBPM):
#	for sl in strumLines:
#		for character in sl.characters:
#			if character.has_method("onBPMChange"):
#				character.call_deferred("onBPMChange", newBPM)
