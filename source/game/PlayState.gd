extends Node2D

@onready var boyfriend = $Boyfriend

func _ready():
	boyfriend.dance()

func beatHit(_curBeat):
	boyfriend.dance()
