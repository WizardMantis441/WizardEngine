extends AnimatedSprite2D

var lastAnimContext:String = 'NONE'

func _ready():
	pass


func _process(delta):
	pass

func playAnim(name:String, force:bool = false, context:String = 'NONE'):
	lastAnimContext = context
	if force == false:
		self.play(name)
	else:
		self.frame = 0
		self.play(name)

func dance():
	if lastAnimContext != 'LOCK':
		self.playAnim("idle")
