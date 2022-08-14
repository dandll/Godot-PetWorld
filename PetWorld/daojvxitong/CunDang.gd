extends Node2D


func _ready():
	pass # Replace with function body.


#保存进度
func _on_Button_pressed():
	baocunshujv()
	pass # Replace with function body.

#读取进度
func _on_Button2_pressed():
	duqvshujv()
	pass # Replace with function body.

#返回
func _on_Button3_pressed():
	get_tree().change_scene("res://daojvxitong/jiaohu.tscn")
	pass # Replace with function body.

#离开游戏
func _on_Button4_pressed():
	get_tree().quit()
	pass # Replace with function body.

#保存路径
var save1 = "res://Config//save1.json" 
#读取数据
func duqvshujv():
	var shujvb = []
	var file =File.new()
	file.open(save1,File.READ) 
	var json_str = file.get_as_text() 
	Daojvlan.daojvlan = parse_json(json_str) 
	file.close() 
	for b in Daojvlan.wupinku.size():
		shujvb.append(Daojvlan.wupinku[b][1]["daojvname"])
	
	for a in Daojvlan.daojvlan.size():
		if Daojvlan.daojvlan[a] != null:
			if shujvb.has(Daojvlan.daojvlan[a][1]["daojvname"]):
				var w = shujvb.find(Daojvlan.daojvlan[a][1]["daojvname"])
				Daojvlan.daojvlan[a][1]["daojvtubiao"] = Daojvlan.wupinku[w][1]["daojvtubiao"]
				
	pass 

#保存数据
func baocunshujv():
	var file = File.new() 
	file.open(save1, File.WRITE) 
	file.store_line(to_json(Daojvlan.daojvlan)) 
	file.close() 
	
