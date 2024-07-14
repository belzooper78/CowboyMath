extends Node #this global scropt is in charge og the scores and remembering the wrong answers
#global variables 
var qWon =0 
var roundsW =0
var bruh
var highscore =0
var Wrongs = {} #Dictionary was used so that there wouldnt be any duplicates 
var a
var b 
var Sq #specific question
var Sq2
#highscore reference https://youtu.be/Lf3b7U6H2Mw Kaan Alpar (October 15 ,2020)
const SAVE_FILE_PATH = "user://savescore.save"


func _process(_delta): #calculates for the score
	bruh = (qWon * 100) + (roundsW*202)
	#qWon is questions won *100 + rounds won*202
	
func save_highscore():
	
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH, File.WRITE) #writes the  new save
	save_data.store_var(highscore)
	save_data.close()
	
func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH): #checks if file exists
		save_data.open(SAVE_FILE_PATH, File.READ)
		highscore = save_data.get_var() 
		save_data.close()
		
		
func Wrong_answers(): #this function puts the question into the dictionary 

	Sq = str(a) +"X"  +str(b)
	Sq2 = str(b) +"X"  +str(a) 
	Wrongs[Sq] = Sq2
	print(Wrongs) # for debugin
	if Wrongs.has(Sq2) == true and Sq != Sq2: #this condition removes one of the questions if the added questions has a value simillar to another key
		Wrongs.erase(Sq)
	print(Wrongs) # if this line is shorter than last line in debug output, then it works

