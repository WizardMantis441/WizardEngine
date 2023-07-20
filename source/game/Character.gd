extends AnimatedSprite2D

var holdTime = 4;
var lastAnimContext:String = 'NONE'

var timer:int = 0;

func _ready():
	pass

func playAnim(name:String, force:bool = false, context:String = 'NONE'):
	lastAnimContext = context
	if force == false:
		self.play(name)
	else:
		self.frame = 0
		self.play(name)

func dance():
	if (lastAnimContext == 'SING' or lastAnimContext == 'NONE') and timer >= holdTime:
		self.playAnim("idle")
