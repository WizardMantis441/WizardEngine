class_name Note
extends AnimatedSprite2D

var strumLine;
var noteData:int = 0;
var time:float = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	self.play(["purple", "blue", "green", "red"][noteData] + " instance 1")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var strum = self.strumLine.get_node(["left", "down", "up", "right"][self.noteData])
#	self.position.x = strum.position.x
#	self.position.y = strum.position.y + 50 # note.y = note.strum.y + ((note.time - Conductor.songPosition) * Chart.scrollSpeed * (Options.downscroll ? -1 : 1))
	self.z_index = strum.z_index + 1
	self.position.x = strum.position.x + 175
	self.position.y = strum.position.y + 125 + (self.time - Conductor.songPosition)
#	self.position.y = strum.position.y + 125
