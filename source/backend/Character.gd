extends AnimatedSprite2D

var holdTime = 4;
var lastAnimContext:String = 'NONE'

var anims = ["singLEFT", "singDOWN", "singUP", "singRIGHT"];
var types = ["left", "down", "up", "right"];

func _ready():
	pass

var timer:int = 0;
func _process(_delta):
	for i in anims.size():
		if Input.is_action_just_pressed(types[i]):
			self.playAnim(anims[i]);
			timer = 0;

func playAnim(name:String, force:bool = false, context:String = 'NONE'):
	lastAnimContext = context
	if force == false:
		self.play(name)
	else:
		self.frame = 0
		self.play(name)

func dance():
	if lastAnimContext != 'LOCK' and timer >= holdTime:
		self.playAnim("idle")

func stepHit(curStep):
	print(timer)
	timer += 1;
