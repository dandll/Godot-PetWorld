extends CanvasLayer

onready var pause_menu = $PauseMenu

func _ready():
	pass

func _on_TextureButton_pressed():
	pause_menu.show_menu()
	pass
