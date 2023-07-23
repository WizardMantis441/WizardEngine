class_name PlayState
extends Node2D

#var chart:Dictionary = JSON.parse_string(FileAccess.open("res://assets/songs/test/charts/normal.json", FileAccess.READ).get_as_text())

var curSong:String = 'test'
var chart:Dictionary = Chart.parse(curSong, 'normal');
var meta:Dictionary = JSON.parse_string(FileAccess.open("res://assets/songs/" + curSong + "/meta.json", FileAccess.READ).get_as_text())

@export var camZoomingStrength:int = 1
@export var camZoomingInterval:int = 4

@onready var camGame = $camGame
@onready var camHUD = $camHUD

@onready var camFollow = $camFollow

@onready var curStage = "stage"
@onready var stage = $Stage

@onready var dad = $Dad
@onready var gf = $ParallaxNode/GF
@onready var bf = $Boyfriend

@onready var cpuStrums = $"camHUD/Opponent Strums"
@onready var playerStrums = $"camHUD/Player Strums"
@onready var additionalStrums = $"camHUD/Additional Strums"
@onready var strumLines:Array[Strumline] = [cpuStrums, playerStrums, additionalStrums]

@onready var noteScene:PackedScene = load("res://source/game/Note.tscn")
@onready var notes = $camHUD/Notes

@onready var events:Array = []

@onready var inst = $Inst
@onready var voices = $Voices

func _ready():
	if ResourceLoader.exists("res://assets/data/stages/" + chart.stage + ".tscn"):
		curStage = chart.stage
	
	if ResourceLoader.exists("res://assets/songs/" + curSong + "/song/Inst.ogg"):
		inst.stream = load("res://assets/songs/" + curSong + "/song/Inst.ogg")
	
	if ResourceLoader.exists("res://assets/songs/" + curSong + "/song/Voices.ogg"):
		voices.stream = load("res://assets/songs/" + curSong + "/song/Voices.ogg")
	else:
		voices.volume_db = 0
	
	var newStage = load("res://assets/data/stages/" + curStage + ".tscn").instantiate()
	stage.add_child(newStage)
	
	for sL in chart.strumLines.size():
		for nJson in chart.strumLines[sL].notes:
			var n = JSON.parse_string(str(nJson))
			var note:Note = noteScene.instantiate()
			note.strumLine = strumLines[sL]
			note.noteData = n.id
			note.time = n.time
			notes.add_child(note)
			strumLines[sL].notes.push_back(note)
	
	events = chart.events
	
	Conductor.bpm = meta.bpm
	Conductor.pause()
	Conductor.reset()
	await get_tree().create_timer(1.0).timeout
	inst.play()
	voices.play()
	Conductor.play()

func executeEvent(event):
	match event.name:
		"Camera Movement":
			if event.params[0] == 0:
				camFollow.position = Vector2(495, 303)
			elif event.params[0] == 1:
				camFollow.position = Vector2(830, 590)
		"Change BPM":
			Conductor.bpm = event.params[0]
	pass

func _process(_delta):
	for event in events:
		if event.time - Conductor.songPosition <= 0:
			events.erase(event)
			executeEvent(event)
	
	camGame.zoom = lerp(camGame.zoom, Vector2(1,1), 0.06)
	camGame.position = lerp(camGame.position, camFollow.position, 0.06)
	
	camHUD.scale = lerp(camHUD.scale, Vector2(1,1), 0.06)
	camHUD.offset = lerp(camHUD.offset, Vector2(0,0), 0.06)

func goodNoteHit(note):
	note.queue_free()
	note.strumLine.notes.erase(note)
	if get_tree().current_scene.get_children().has(note):
		remove_child(note)
	note.wasGoodHit = true
	
	for character in note.strumLine.characters:
		character.playAnim('sing' + note.dirs[note.noteData].to_upper(), true, 'SING');
		character.timer = 0;

func stepHit(curStep):
	for sl in strumLines:
		for character in sl.characters:
			if character.has_method("stepHit"):
				character.call_deferred("stepHit", curStep)

func beatHit(curBeat):
	if curBeat % camZoomingInterval == 0:
		camGame.zoom = Vector2(1.00625*camZoomingStrength,1.0025*camZoomingStrength)
		camHUD.scale = Vector2(1.0125*camZoomingStrength,1.0125*camZoomingStrength)
		camHUD.offset = Vector2(-6.25*camZoomingStrength,-3.125*camZoomingStrength)
	
	for sl in strumLines:
		for character in sl.characters:
			character.dance()
			if character.has_method("beatHit"):
				character.call_deferred("beatHit", curBeat)

func measureHit(curMeasure):
	for sl in strumLines:
		for character in sl.characters:
			if character.has_method("measureHit"):
				character.call_deferred("measureHit", curMeasure)

func onBPMChange(newBPM):
	for sl in strumLines:
		for character in sl.characters:
			if character.has_method("onBPMChange"):
				character.call_deferred("onBPMChange", newBPM)
