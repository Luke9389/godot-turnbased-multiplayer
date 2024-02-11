extends Control

@onready var error_label = $MarginContainer/VBoxContainer/ErrorLabel
@onready var label_1 = $MarginContainer/VBoxContainer/Label1
@onready var label_2 = $MarginContainer/VBoxContainer/Label2
@onready var label_3 = $MarginContainer/VBoxContainer/Label3
@onready var labels = [label_1, label_2, label_3]

func _ready():
	Lobby.player_connected.connect(_update_player_labels)
	_toggle_error(false)


func _on_create_game_pressed():
	if(_get_player_name().is_empty()):
		_toggle_error(true)
		return
	
	Lobby.create_game()

func _on_join_game_pressed():
	if(_get_player_name().is_empty()):
		_toggle_error(true)
		return
	
	Lobby.join_game()


func _on_player_name_text_changed(new_text):
	Lobby.player_info.name = new_text


func _get_player_name() -> String:
	return Lobby.player_info.name
	

func _toggle_error(on_off: bool):
	error_label.modulate = Color.WHITE if on_off else Color.TRANSPARENT


func _update_player_labels(_id, _info):
	var idx = 0
	for player_id in Lobby.players.keys():
		labels[idx].text = Lobby.players[player_id].name
		idx += 1
	
	if (Lobby.players.size() == 3 && multiplayer.is_server()):
		Lobby.load_game.rpc('res://scenes/game.tscn')
