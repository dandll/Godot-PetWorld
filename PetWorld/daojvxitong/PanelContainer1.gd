extends PanelContainer
const morenjiazai = preload("res://daojvxitong/DaoJuItem.tscn")
const morenshuliang =preload("res://daojvxitong/Label.tscn")

func _ready():
	pass

func update_item(item):
	if item != null:
		
		for shuliangjiancha in self.get_children():
			shuliangjiancha.queue_free()
		var item_node = morenjiazai.instance()
		
		item_node.texture = item[1]["daojvtubiao"]
		var shuliang = morenshuliang.instance()
		shuliang.text = item[1]["daojvshuliang"] as String
		#print(morenziyuansu)
		item_node.position = Vector2(33,33)
		add_child(item_node)
		item_node.add_child(shuliang)
		
		modulate = Color(1,1,1,1)
		
	else:
		for a in self.get_children():
			a.queue_free()

