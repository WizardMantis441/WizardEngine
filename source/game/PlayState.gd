extends Node2D

@export var strumLines:Array[Strumline] = []

@export var camZoomingStrength = 1
@export var camZoomingInterval = 4

@onready var camGame = $camGame
@onready var camHUD = $camHUD

func _ready():
	Conductor.bpm = 150.0

func _process(_delta):
	camGame.scale = lerp(camGame.scale, Vector2(1,1), 0.06)
	camGame.position = lerp(camGame.position, Vector2(0,0), 0.06)
	
	camHUD.scale = lerp(camHUD.scale, Vector2(1,1), 0.06)
	camHUD.position = lerp(camHUD.position, Vector2(0,0), 0.06)

func stepHit(curStep):
	for sl in strumLines:
		for character in sl.characters:
			if character.has_method("stepHit"):
				character.call_deferred("stepHit", curStep)

func beatHit(curBeat):
	if curBeat % camZoomingInterval == 0:
		camGame.scale = Vector2(1.00625*camZoomingStrength,1.0025*camZoomingStrength)
		camGame.position = Vector2(-3.25*camZoomingStrength,-1.5625*camZoomingStrength)
		
		camHUD.scale = Vector2(1.0125*camZoomingStrength,1.0125*camZoomingStrength)
		camHUD.position = Vector2(-6.25*camZoomingStrength,-3.125*camZoomingStrength)
	
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
