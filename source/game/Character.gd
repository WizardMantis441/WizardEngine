class_name Character
extends AnimatedSprite2D

@export var curCharacter:String = 'bf'
var json:Dictionary = {}

var holdTime:int = 4;
var idles:Array = [];

var lastAnimContext:String = 'NONE'

var timer:int = 0;

var globalOffset:Vector2 = Vector2(0,0)

var animData:Dictionary = {}

func _ready():
	json = JSON.parse_string(FileAccess.open("res://assets/data/characters/" + curCharacter + ".json", FileAccess.READ).get_as_text())
	holdTime = json.info.holdTime;
	globalOffset = Vector2(json.info.x, json.info.y)
	idles = json.info.idles
	
	if self.json.info.flipX:
		self.flip_h = not self.flip_h
	
	for anim in self.json.anims:
		animData[anim.name] = anim

func playAnim(animname:String, force:bool = false, context:String = 'NONE'):
	self.lastAnimContext = context
	self.offset.x = globalOffset.x + animData[animname].x
	self.offset.y = globalOffset.y + animData[animname].y
	
	if force == false:
		self.play(animname)
	else:
		self.frame = 0
		self.play(animname)

func dance(curBeat):
	if (self.lastAnimContext == 'SING' or self.lastAnimContext == 'NONE' or self.lastAnimContext == 'DANCE') and self.timer >= self.holdTime:
		self.playAnim(idles[curBeat % idles.size()])

func stepHit(_curStep):
	self.timer += 1;

func beatHit(curBeat):
	self.dance(curBeat)
