
extends TextureFrame

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process(true)
	
func _process(delta):
	pass




func _on_Button_pressed():
	get_tree().change_scene("res://Pong.scn")
