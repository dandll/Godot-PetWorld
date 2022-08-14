extends Control

onready var transitions = $Transitions


func show_menu():
	show()
	transitions.play("show")


func hide_menu():
	#transitions.play_backwards("show",-0.1)
	#yield(transitions, "animation_finished")
	hide()


func _unhandled_input(event):
	if visible and event.is_action_pressed("ui_cancel"):
		hide_menu()
		get_tree().set_input_as_handled()

func _on_PauseMenu_visibility_changed():
	get_tree().paused = visible


func _on_btnResume_pressed():
	hide_menu()
	pass


func _on_btnQuit_pressed():
	hide_menu()
	GameGlobal.MainGameScene()
	pass


func _on_btnAbout_pressed():
	$PopupPanel.popup()
	pass # Replace with function body.
