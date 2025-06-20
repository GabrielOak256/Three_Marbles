extends Node

const lang_save_file : String = "user://lang.txt"
const label_save_file : String = "user://label.txt"
const custom_save_file : String = "user://custom.txt"
const high_scores_save_file : Array[String] = [
	"user://tutorial_high_scores.txt",
	"user://moon_high_scores.txt",
	"user://whirlpool_high_scores.txt",
	"user://yinyang_high_scores.txt",
	"user://redeye_high_scores.txt",
	"user://creatures_high_scores.txt",
	"user://shell_high_scores.txt",
	"user://galaxy_high_scores.txt",
	"user://platonic_high_scores.txt",
	"user://engine_high_scores.txt",
	"user://nebula_high_scores.txt",
	"user://pandemonium_high_scores.txt",
	"user://custom_high_scores.txt"
	]


func save_lang(lang : int) -> void:
	var file = FileAccess.open(lang_save_file, FileAccess.WRITE)
	file.store_var(lang)
	file.close()

func load_lang() -> int:
	var lang : int = 0
	if !FileAccess.file_exists(lang_save_file): save_lang(lang) 
	else:
		var file = FileAccess.open(lang_save_file, FileAccess.READ)
		lang = file.get_var()
		file.close()
	return lang


func save_label(r : int, g : int, b : int, label : String) -> void:
	var file = FileAccess.open(label_save_file, FileAccess.WRITE)
	file.store_var([r, g, b, label])
	file.close()

func load_label() -> Array:
	var label : Array = [0, 0, 0, "Custom\nLevel"]
	if !FileAccess.file_exists(label_save_file): save_label(label[0], label[1], label[2], label[3]) 
	else:
		var file = FileAccess.open(label_save_file, FileAccess.READ)
		label = file.get_var()
		file.close()
	return label


func save_custom(custom : String) -> void:
	var file = FileAccess.open(custom_save_file, FileAccess.WRITE)
	file.store_var(custom)
	file.close()

func load_custom() -> String:
	var custom : String = Board_Layouts.default_custom_board_layout
	if !FileAccess.file_exists(custom_save_file): save_custom(custom) 
	else:
		var file = FileAccess.open(custom_save_file, FileAccess.READ)
		custom = file.get_var()
		file.close()
	return custom


#class score:
#	var label : String = ""
#	var last_time : int = 0
#	var best_time : int = 0

func generate_default_high_scores() -> Array[Array]:
	var lang : int = load_lang()
	var result : Array[Array]
	result.append([("Play Time: " if (lang != 2) else "???"), 0, 0])
	result.append([("Life  Span: " if (lang != 2) else "???"), 0, 0])
	return result

func load_high_scores(i : int) -> Array[Array]:
	var high_scores : Array[Array] = generate_default_high_scores()
	if !FileAccess.file_exists(high_scores_save_file[i]): save_high_scores(i, high_scores) 
	else:
		var file = FileAccess.open(high_scores_save_file[i], FileAccess.READ)
		high_scores = file.get_var()
		file.close()
	return high_scores

func save_high_scores(i : int, high_scores : Array[Array]) -> void:
	var file = FileAccess.open(high_scores_save_file[i], FileAccess.WRITE)
	file.store_var(high_scores)
	file.close()


func reset() -> void:
	save_lang(0)
	save_label(0, 0, 0, "Custom\nLevel")
	save_custom(Board_Layouts.default_custom_board_layout)
	for i in high_scores_save_file.size(): save_high_scores(i, generate_default_high_scores()) 
