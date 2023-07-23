class_name Note
extends AnimatedSprite2D

var strumLine:Strumline;
var noteData:int = 0;
var time:float = 0;
var canBeHit:bool = false
var tooLate:bool = false
var wasGoodHit:bool = false

static var dirs = ["left", "down", "up", "right"]
	
func _ready():
	self.play(["purple", "blue", "green", "red"][noteData] + " instance 1")

func _process(_delta):
	var strum = self.strumLine.get_node(dirs[self.noteData])
	self.z_index = strum.z_index + 1
	self.position.x = strum.position.x + strumLine.position.x
	self.position.y = strum.position.y + strumLine.position.y + (self.time - Conductor.songPosition)
	# note.y = note.strum.y + ((note.time - Conductor.songPosition) * Chart.scrollSpeed * (Options.downscroll ? -1 : 1))
	self.strumLine.updateNote(self)
