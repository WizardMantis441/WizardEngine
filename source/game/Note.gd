class_name Note
extends AnimatedSprite2D

var strumLine;
var noteData:int = 0;
var time:float = 0;
var cpu:bool = true;

static var dirs = ["left", "down", "up", "right"]
	
func _ready():
	self.play(["purple", "blue", "green", "red"][noteData] + " instance 1")

func _process(delta):
	var strum = self.strumLine.get_node(dirs[self.noteData])
	self.z_index = strum.z_index + 1
	self.position.x = strum.position.x + 175
	self.position.y = strum.position.y + 125 + (self.time - Conductor.songPosition)
	# note.y = note.strum.y + ((note.time - Conductor.songPosition) * Chart.scrollSpeed * (Options.downscroll ? -1 : 1))
	
	if cpu:
		if self.time - Conductor.songPosition <= 0:
			removeNote()

func removeNote():
	var strum = self.strumLine.get_node(dirs[self.noteData])
	strum.play(dirs[noteData] + " confirm instance 1")
	queue_free()
	strum.animation_finished = finishStrumAnim() # what

func finishStrumAnim():
	var strum = self.strumLine.get_node(dirs[self.noteData])
	strum.play("arrow static instance " + str(noteData))
