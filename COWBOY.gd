extends Node2D

var animationP #get node thing i just put in in ready

onready var thing = get_node("game/countdown") #this gets the control node with the Timer 
const NicoIsSOCOOLLOLOLOL = preload("res://NicoisSoCOOL!.tscn") #score screen

onready var T2 = get_node("game/countdown/T2") #this gets the second Timer
var sec = 5
var Hp = 5

var a # I used variable a and b for randomizing the explosion FX
var b

var rWins # this is for how many wins enemy has

var rng = RandomNumberGenerator.new()

var qWon =0
var rounds = 1
var q = 5 # this is for how many questions there are 
var answer

#this is for the checkmarks if you got the answer wrong or right
onready var squares =[$game/Control/TextureRect6,$game/Control/TextureRect5,$game/Control/TextureRect4,$game/Control/TextureRect3,$game/Control/TextureRect2,$game/Control/TextureRect]

# var for that boom effects
onready var bob = $game/boom
var floating_text = preload("res://floating.tscn")

func _ready():
	
	rng.randomize()
	a = rng.randi()%12+1 #this is for randomizing the questions
	b = rng.randi()%12+1
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)#this is for mouse hiding the normal one
	animationP = get_node("game/mouse/AnimationPlayer") 
	
	#making the animations active
	$game/KinematicBody2DB/AnimationTree.active = true
	$game/KinematicBody2DR/AnimationTree.active = true
	

#draw button to start the timers
func _on_Button_pressed():
	T2.start()
	$game/num3.visible = true # this is the 3 2 1 go part
	$game/KinematicBody2DB/Button.visible = false  # Hides the draw button



func _physics_process(delta):
	
	var minutes = thing.get("minutes")
	var seconds = thing.get("seconds")



	if sec == 0: # sec s utilized by the 3 second timer, after every timeout the sec goes down.
		$game/num3.bbcode_text = "[wave amp=50 freq=8]go"
		$game/countdown/Timer.start() #this part starts the main timer 
	
	
	if sec ==-1:
		get_node("game/Control").visible = true #this node shows the questions and contains the LineEdit node for answering
		$game/countdown.visible = true  # hides the 321 go timer
		$game/num3.visible = false
		
	
	
		#this is for mouse click animation it's like 3 images XD lol  lol Xd lol ol
	if  Input.is_action_just_pressed("left click"):
		animationP.play("click")


	# ----------------THE MAIN CODE--------------------
	if  $game/Control/LineEdit.text== str(answer) and Input.is_action_just_pressed("ui_accept") and $game/Control.visible == true and Hp>0 and $game/Control/LineEdit.text != "":
		#----------if ANSWER IS correct---------------
		squares[q].setC() #sets the current texturerect to checkmark
		q -= 1
		qWon += 1 # stands for questions won
		Global.qWon += 1 # this one is for scores it is seperated from normal qWon since if you lose to much qWon can go negative
		
		a = rng.randi()%12+1 # sets a random range from 1-12
		b = rng.randi()%12+1
		$game/Control/LineEdit.text = "" #so that the previous answer wont be there


	elif  Input.is_action_just_pressed("ui_accept") and $game/Control/LineEdit.text != str(answer) and $game/Control.visible == true and Hp>0 and $game/Control/LineEdit.text != "":
		#-------------if ANSWER IS wrong---------------
		squares[q].setX() #sets the current texturerect to Xmark
		q -= 1
		qWon -= 1 #the questions you win will be subtracted by how many you won
		Global.a = a
		Global.b = b
		Global.Wrong_answers()
		a = rng.randi()%12+1
		b = rng.randi()%12+1
		$game/Control/LineEdit.text = "" #so that the previous answer wont be there


	if minutes >=  0 and seconds > 0 and Hp > 0 and $game/countdown.visible == true and $game/hidden.visible == false: 
		# ----------------shows the questions--------------
		answer = a*b
		#print (answer) 
		# THE LINE ABOVE IS IF YOU ARE NOT FAST AT BASIC MATH JUST DELETE HASHTAG ON LINE 92 TO SEE ANSWER ON OUTPUT  

		$game/Control/RichTextLabel.bbcode_text = "[rainbow freq =2.0][center]" + str(a) + " X " + str(b) #this Line shows the problem



	elif minutes ==0 and seconds == 0 or Hp == 0: #This condition is when Time is Lost or player lose
			q = 5 #resets timer so It does not trigger another condition
			$game/Control.visible = true
			$game/countdown.visible = false 
			$game/countdown/Timer.start()
			


			if Hp == 0: #when you lose 5 hp
				$game/Control/LineEdit.text = "gameOVER, YOU LOST RIP"
				$game/Control/RichTextLabel.bbcode_text = "[rainbow freq =2.0][center][wave amp=50 freq=8]YOU LOST: GAMEOVER"
			else: #timer done
				$game/Control/LineEdit.text = "TIMER FINISHED"
				$game/Control/RichTextLabel.bbcode_text = "[rainbow freq =2.0][center][wave amp=50 freq=8]!!TIME FINISHED!!"

		


			if sec == 0:
				get_parent().add_child(NicoIsSOCOOLLOLOLOL.instance()) #goes to score scene
				queue_free() 

			if sec < 1: #because the T2 Timer goes to negative L oh L 
				sec = 6
	
			
	if q == -1: #when last question is fin it does the shooting function and shows the button to go next round
		$game/countdown/Timer.stop()
		$game/Control.visible = false
		rounds += 1
		$game/hidden.visible = true
		$game/hidden.text = "ROUND "+ str(rounds) 
	
		shooting_LOL()
		q = 5
	
func shooting_LOL(): #for animations

	bob.visible = true #the xplosions


	$game/KinematicBody2DB/AnimationPlayer.stop()#animation stuff L oh L
	$game/KinematicBody2DR/AnimationPlayer.stop()
	$game/KinematicBody2DB/AnimationTree.set("parameters/general/current",1)
	$game/KinematicBody2DR/AnimationTree.set("parameters/general/current",1) #tried to use animation tree LohL


	var this = 6#total amount of rounds
	var wins 
	if qWon >= 0: #this condition is to play the red shooting animation 
		wins = (qWon+ this)/2  #this is to get how many wins player got without the subtraction everytime player is wrong
		rWins =  this - wins #this will tell how many times red will shoot
		
	else:
		rWins = abs(qWon) #this is for when player gets more than 3 wrong 

	
	for n in qWon: # to shoot animation muluiple times
		get_node("game/KinematicBody2DB/AnimationPlayer").queue("blue shooting")
	for x in rWins:
		get_node("game/KinematicBody2DR/AnimationPlayer").queue("blue shooting")


	if qWon >= 0: #if questions won is half or more
	
		Global.roundsW +=1 #for score later
		bob.visible = true#turns the explosions visible
		
		for n in qWon:
			
			bob.global_position = Vector2(296, 152)
			get_node("game/boom/Sprite/AnimationPlayer").queue("boom")#plays the explosion animation
			score()
			
		get_node("game/KinematicBody2DB/AnimationPlayer").queue("holster") 
		get_node("game/KinematicBody2DR/AnimationPlayer").queue("holster") #other animations
		get_node("game/KinematicBody2DB/AnimationPlayer").queue("blue_idle")
		get_node("game/KinematicBody2DR/AnimationPlayer").queue("blue_idle") 
		
		
	
	
	else:  #this means you lose the round
		Hp -= 1
		
		$game/health.frame += 1 
		bob.visible = true
		for n in rWins:
	
		
			bob.global_position = Vector2(24, 152) #explosions play on players side
			get_node("game/boom/Sprite/AnimationPlayer").queue("boom")
			
		get_node("game/KinematicBody2DB/AnimationPlayer").queue("holster")
		get_node("game/KinematicBody2DR/AnimationPlayer").queue("holster") 
		get_node("game/KinematicBody2DB/AnimationPlayer").queue("blue_idle")
		get_node("game/KinematicBody2DR/AnimationPlayer").queue("blue_idle") 
		
		
		
		
func score():
	#this function shows the score if player wins the round
	var text = floating_text.instance()
	text.global_position = Vector2(296, 120)
	text.amount = (Global.qWon*100)
	get_node("game/KinematicBody2DB").add_child(text)


	
#timer functions
func _on_T2_timeout(): #this timer is the 3 second countdown
	sec -=1
	$game/num3.bbcode_text = "[wave amp=60 freq=5] " + str(sec)

func _on_hidden_pressed():#basically the reset for each round
	squares[0].reseT()
	squares[1].reseT()
	squares[2].reseT()
	squares[3].reseT()
	squares[4].reseT()
	squares[5].reseT()
	sec = 3
	qWon = 0
	rWins = 0
	$game/num3.bbcode_text = "[wave amp=60 freq=5] " + str(sec)
	$game/num3.visible = true
	bob.visible = false
	$game/hidden.visible = false

