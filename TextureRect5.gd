extends TextureRect
const check = preload("res://checkmark.png")
const eggs = preload("res://eggsmark.png")

#this is for checkmarks

func _ready():
	reseT()
func reseT():

	texture = null
func setC():
	texture = check
func setX():
	texture = eggs
