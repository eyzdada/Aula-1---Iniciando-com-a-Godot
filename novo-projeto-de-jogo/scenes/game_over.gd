extends Control

# função que altera a cena para a cena do jogo quando o botão é pressionado
func _on_tentar_novamente_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
