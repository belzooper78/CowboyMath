extends Node2D
var animationP
#rhis is the scene for score

func _ready():
	
	
	$ColorRect/Label2.set_text("score : " + str(Global.bruh))#shows score
	#loads highscore
	Global.load_highscore()
	if Global.bruh > Global.highscore:
		Global.highscore = Global.bruh
		Global.save_highscore()
		
	var wrongs = Global.Wrongs  
	var wrong = Array(wrongs.keys()) #turns the dictionary into an array with the dictionary's keys
	var joined_wrong = PoolStringArray(wrong).join(" ") #turns them into string 
	$ColorRect/lol/mistakes.set_text(joined_wrong) #displays it on a label
	
	$ColorRect/Best.set_text("HIGHSCORE : " + str(Global.highscore))
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	animationP = get_node("game/mouse/AnimationPlayer")

func _on_Button_pressed():
	Global.bruh = 0
	Global.Wrongs = {}
	get_tree().change_scene("res://main menu.tscn")
	queue_free()
