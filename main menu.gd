extends MarginContainer
#https://youtu.be/Jjv2MWbQVhs ref. Jon topielski for title screen
const Cowboy = preload("res://COWBOY.tscn") #This main scene
const cumtrolls = preload("res://controlls.tscn") #This is for the options scene
onready var selectorOne = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/SELECTOR
onready var selectorTwo = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/SELECTOR
onready var selectorThree = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/SELECTOR

var currentSelection = 0
func _ready():
	setCurrentSelection(0)
	
	# this is for the arrow selecting the labels
	# it shows what the user is selecting using arrow keys
func _process(delta):
	if Input.is_action_just_pressed("ui_up"): 
		currentSelection -= 1
		setCurrentSelection(currentSelection)
	
	elif Input.is_action_just_pressed("ui_down"):
		currentSelection += 1
		setCurrentSelection(currentSelection)
	
	elif currentSelection <0:
		currentSelection = 2
		setCurrentSelection(currentSelection)
	
	elif currentSelection >2:
		currentSelection = 0
		setCurrentSelection(currentSelection)
	
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(currentSelection)


func handle_selection(current_selection):
	if current_selection == 0:
		
		get_parent().add_child(Cowboy.instance())
		queue_free()
	elif current_selection == 1:
		get_parent().add_child(cumtrolls.instance())
		queue_free()
	elif current_selection == 2:
		get_tree().quit()
		
func setCurrentSelection(current_selection):
	selectorOne.text = ""
	selectorTwo.text = ""
	selectorThree.text = ""
	
	if current_selection == 0:
		selectorOne.text = ">"
		
	elif current_selection == 1:
		selectorTwo.text = ">"
	
	elif current_selection == 2:
		selectorThree.text = ">"
	
