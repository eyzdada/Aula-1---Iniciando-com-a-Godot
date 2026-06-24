extends Control

func _on_jogar_button_pressed() -> void:
	GameManager.resetar_jogo()

	print("O botão foi clicado com sucesso!")
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
