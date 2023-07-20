extends AnimatedSprite2D

var holdTime = 4;
var lastAnimContext:String = 'NONE'

var anims = ["singLEFT", "singDOWN", "singUP", "singRIGHT"];
var types = ["left", "down", "up", "right"];

var timer:int = 0;

func _ready():
	pass

func _process(_delta):
	for i in anims.size():
		if Input.is_action_just_pressed(types[i]):
			self.playAnim(anims[i], true, 'SING');
			timer = 0;

func playAnim(name:String, force:bool = false, context:String = 'NONE'):
	lastAnimContext = context
	if force == false:
		self.play(name)
	else:
		self.frame = 0
		self.play(name)

func dance():
	if lastAnimContext == 'SING' and timer >= holdTime:
		self.playAnim("idle")
