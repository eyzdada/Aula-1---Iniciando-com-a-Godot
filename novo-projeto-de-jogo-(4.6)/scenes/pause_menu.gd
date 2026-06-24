extends CanvasLayer

# ao ser criado na tela, o menu é escondido
func _ready() -> void:
	hide()
	
# função para abrir o menu ou fechar o menu quando pressionar
# a tecla cadastrada como pause
func _input(event) -> void:
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			hide()
			get_tree().paused = false
		else:
			show()
			get_tree().paused = true
	
# função que executa quando o botão Continuar é clicado, removendo
# o estado de pause da cena para voltar o jogo e escondendo o menu
func _on_continuar_button_pressed() -> void:
	hide()
	get_tree().paused = false

# função que executa quando o botão Menu Inicial é clicado,
# removendo o pause do jogo e mudando para a tela do menu inicial
func _on_menu_principal_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu_inicial.tscn")
