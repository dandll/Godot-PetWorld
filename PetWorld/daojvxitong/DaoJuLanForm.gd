extends Control

#道具栏
#res://daojvxitong/PanelContainer1.gd
#鼠标是停在哪里dj 道具栏 zb 装备栏
var mouseOnType="dj";#zb

#临时物品拷贝
var nowc = null
#临时物品拷贝是道具栏还是装备栏0道具栏 1装备栏
var lastSelType = 0;
#临时物品拷贝在道具栏的位置
var lastSelItemIndex = 0;
#存放临时图标
var linshishujv = null
#存放临时数组的数据
var xvhao
#右键时候获取的数组顺序
onready var tween = $Tween
#设置挂在的图片路径
onready var daojvkuang = $Panel/GridContainer
const yidong_miaoshu = preload("res://daojvxitong/yidong_miaoshu.tscn")
#装备-设置挂在的图片路径
onready var zhuangbeikuang = $Panel/PanelZhuangBei
#道具的目录节点
func _ready():
	_on_mouse_exited();
	#循环绑定道具栏物品的鼠标进入，鼠标离开，鼠标点击事件
	for item in $Panel/GridContainer.get_children():
		item.connect("gui_input",self,"_on_gui_input",[item])
		item.connect("mouse_entered",self,"_on_mouse_entered",[item])
		#mouseOnType="dj";
		item.connect("mouse_exited",self,"_on_mouse_exited")
	#加载保存的物品
	DaoJuLanShuaXin()
		
	#循环绑定道具栏物品的鼠标进入，鼠标离开，鼠标点击事件
	for item in $Panel/PanelZhuangBei.get_children():
		item.connect("gui_input",self,"_on_zbgui_input",[item])
		item.connect("mouse_entered",self,"_on_mouse_entered",[item])
		#mouseOnType="zb";
		item.connect("mouse_exited",self,"_on_mouse_exited")
	ZhuangBeiLanShuaXin()
	pass # Replace with function body.
	
#更新装备栏
func update_zb_panel(item_index):
	var slot = zhuangbeikuang.get_child(item_index)
	var item = Daojvlan.zhuangbeilan[item_index]
	if slot!=null:
		slot.update_item(item)

#刷新道具栏(根据数组，用于修改数组后)
func ZhuangBeiLanShuaXin():
	for item_index in Daojvlan.zhuangbeilan.size():
		update_zb_panel(item_index)
	pass

#更新道具栏
func update_panel(item_index):
	var slot = daojvkuang.get_child(item_index)
	var item = Daojvlan.daojvlan[item_index]
	if slot!=null:
		slot.update_item(item)

#刷新道具栏(根据数组，用于修改数组后)
func DaoJuLanShuaXin():
	for item_index in Daojvlan.daojvlan.size():
		update_panel(item_index)
	pass

#清空临时道具(用于修改数组后)
func TempDaoJuToNull():
	linshishujv = null
	if is_instance_valid(nowc):
		nowc.queue_free()
	nowc = null
	pass

#设置临时物品位置为鼠标位置
func _input(event):
	if nowc != null:
		nowc.position = get_local_mouse_position()
#		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT:
#			#鼠标右键使物品归位，GDS执行顺序，及鼠标事件触发问题，暂不解决
#			#把物品还到原来位置
#			Daojvlan.daojvlan[lastSelItemIndex] = linshishujv
#			var rValue= DaoJuLanShuaXin()
#			if rValue != 1:
#				TempDaoJuToNull()
#			pass
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
#		var mousePosition = get_local_mouse_position();
#		$Panel.rect_clip_content
		if nowc != null :
			var mPos = get_local_mouse_position();
			var pPos = $Panel.rect_global_position;
			var pRec=$Panel.rect_size;
#			print("mPos:"+mPos.x as String+","+mPos.y as String)
#			print("pPos:"+pPos.x as String+","+pPos.y as String)
#			print("pRec:"+pRec.x as String+","+pRec.y as String)
#			print("1:"+(mPos.x >= pPos.x) as String)
#			print("2:"+(mPos.x<=pPos.x+pRec.x) as String)
#			print("3:"+(mPos.y>=pPos.y) as String)
#			print("4:"+(mPos.y<=pPos.y+pRec.y) as String)
			if !(mPos.x >= pPos.x&&mPos.x<=(pPos.x+pRec.x)&&mPos.y>=pPos.y&&mPos.y<=(pPos.y+pRec.y)):
				var nowitem = nowc.duplicate()
				#如果对应道具栏没有物品直接赋值
				if Daojvlan.daojvlan[lastSelItemIndex] == null:
					Daojvlan.daojvlan[lastSelItemIndex]=linshishujv;
				else:
					#对应位置有道具 则 找到未有道具背包栏
					for i in Daojvlan.daojvlan.size():
						if Daojvlan.daojvlan[i] == null:
							Daojvlan.daojvlan[i]=linshishujv;
							break;
					pass
				TempDaoJuToNull()
		pass
	pass


#鼠标点击事件（左键，右键）
func _on_gui_input(event,itembox):
	var nowSelType=0;#道具栏
	#鼠标左键
#	if event is InputEventScreenTouch and !event.is_pressed():
#		var item_index = itembox.get_index()
#		#获取节点在父节点的索引
#		var zidianshujv = Daojvlan.daojvlan[item_index]
#		if zidianshujv != null and nowc == null:
#			xvhao = item_index
##			$Panel/Node2D/Node2D/PopupMenu.rect_position = itembox.rect_position+Vector2(650,250)
#			$Panel/Node2D/Node2D/PopupMenu.rect_scale.x=self.rect_scale.x
#			$Panel/Node2D/Node2D/PopupMenu.rect_scale.y=self.rect_scale.y
#			$Panel/Node2D/Node2D/PopupMenu.rect_position = (itembox.rect_position+$Panel/GridContainer.rect_position+$Panel.rect_global_position)*self.rect_scale.x
#			#hide_on_item_selection
#			$Panel/Node2D/Node2D/PopupMenu.hide_on_item_selection=true
#			$Panel/Node2D/Node2D/PopupMenu.popup()
#		else:
#			if lastSelType == 1:
#				#Daojvlan.zhuangbeilan[lastSelItemIndex] = linshishujv
#				$Panel/Node2D/Node2D/PopupMenu.hide()
#				ZhuangBeiLanShuaXin()
#				TempDaoJuToNull()
#			else:
#				#把物品还到原来位置
#				#Daojvlan.daojvlan[lastSelItemIndex] = linshishujv
#				$Panel/Node2D/Node2D/PopupMenu.hide()
#				DaoJuLanShuaXin()
#				TempDaoJuToNull()
#			pass
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var child = itembox.get_children()
		var templastSelItemIndex=lastSelItemIndex
		var templastSelType = lastSelType
		#单个pane的子节点
		var item_index = itembox.get_index()
		lastSelItemIndex=item_index;
		lastSelType=nowSelType
		#获取节点在父节点的索引
		var zidianshujv = Daojvlan.daojvlan[item_index]
		#数组的数据
		if child.size() == 1:
			if nowc == null :
				#临时道具为空则把道具栏物品复制给临时物品
				nowc = child[0].duplicate()
				linshishujv = Daojvlan.daojvlan[item_index].duplicate()
				nowc.position = get_local_mouse_position()
#				nowc.position = Vector2(nowc.position)
#				print("self.rect_scale:"+self.rect_scale.x as String+","+self.rect_scale.y as String)
#				nowc.scale=Vector2(self.rect_scale.x,self.rect_scale.y)
#				nowc.scale=Vector2(0.3,0.3)
#				get_tree().get_root().add_child(nowc)
				$Panel.add_child(nowc)
				child[0].queue_free()
				Daojvlan.daojvlan[item_index] = null 
				
			else :
				#把临时道具复制至点击的位置
				#print(nowc)
				var nowitem = nowc.duplicate()
				#需交换的数据
				var jiaohuanshujvfuzhi = Daojvlan.daojvlan[item_index].duplicate()
				#Pane的数据给 jiaohuanshujvfuzhi
				nowitem.position =  Vector2(33,33)
				
				itembox.add_child(nowitem)
				
				nowc.queue_free()
				
				#if判断开启叠加物品，else为物品不同时交换物品
				if Daojvlan.daojvlan[item_index][1]["daojvname"]==linshishujv[1]["daojvname"]:
					Daojvlan.daojvlan[item_index][1]["daojvshuliang"] +=linshishujv[1]["daojvshuliang"]
					#print (Daojvlan.daojvlan[c[w]])
					DaoJuLanShuaXin()
					TempDaoJuToNull()
					return
					pass
				else:
					if 1==2:
						#有物品时，对应物品替换至手上
						Daojvlan.daojvlan[item_index] = linshishujv
						#lastSelItemIndex=item_index;
						#手上的数据给Pane
						
						linshishujv = jiaohuanshujvfuzhi
						#jiaohuanshujvfuzhi 数据返回到手上
						jiaohuanshujvfuzhi =null
						
						nowc = child[0].duplicate()
						nowc.position = get_local_mouse_position()
#						get_tree().get_root().add_child(nowc)
						$Panel.add_child(nowc)
						child[0].queue_free()
					else:
						if templastSelType != nowSelType:
							#对应位置有道具 则 找到未有道具背包栏
							for i in Daojvlan.daojvlan.size():
								if Daojvlan.daojvlan[i] == null:
									Daojvlan.daojvlan[i]=linshishujv;
									break;
							DaoJuLanShuaXin()
							ZhuangBeiLanShuaXin()
							TempDaoJuToNull()
						else:
							#有物品时进行交换位置模式
							Daojvlan.daojvlan[item_index] = linshishujv
							linshishujv = jiaohuanshujvfuzhi
							
							Daojvlan.daojvlan[templastSelItemIndex] = jiaohuanshujvfuzhi
	#						#对应位置有道具 则 找到未有道具背包栏
	#						for i in Daojvlan.daojvlan.size():
	#							if Daojvlan.daojvlan[i] == null:
	#								Daojvlan.daojvlan[i]=linshishujv;
	#								break;
							DaoJuLanShuaXin()
							child[0].queue_free()
							TempDaoJuToNull()
						pass
		else:
			if nowc == null:
				return
			var item = nowc.duplicate()
			Daojvlan.daojvlan[item_index] = linshishujv
			item.position = Vector2(33,33)
			itembox.add_child(item)
			TempDaoJuToNull()
			
	#鼠标右键
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT:
		var item_index = itembox.get_index()
		#获取节点在父节点的索引
		var zidianshujv = Daojvlan.daojvlan[item_index]
		if zidianshujv != null and nowc == null:
			xvhao = item_index
#			$Panel/Node2D/Node2D/PopupMenu.rect_position = itembox.rect_position+Vector2(650,250)
			$Panel/Node2D/Node2D/PopupMenu.rect_scale.x=self.rect_scale.x
			$Panel/Node2D/Node2D/PopupMenu.rect_scale.y=self.rect_scale.y
			$Panel/Node2D/Node2D/PopupMenu.rect_position = (itembox.rect_position+$Panel/GridContainer.rect_position+$Panel.rect_global_position)*self.rect_scale.x
			#hide_on_item_selection
			$Panel/Node2D/Node2D/PopupMenu.hide_on_item_selection=true
			$Panel/Node2D/Node2D/PopupMenu.popup()
		else:
			if lastSelType == 1:
				$Panel/Node2D/Node2D/PopupMenu.hide()
				#Daojvlan.zhuangbeilan[lastSelItemIndex] = linshishujv
				ZhuangBeiLanShuaXin()
				TempDaoJuToNull()
			else:
				#把物品还到原来位置
				$Panel/Node2D/Node2D/PopupMenu.hide()
				#Daojvlan.daojvlan[lastSelItemIndex] = linshishujv
				DaoJuLanShuaXin()
				TempDaoJuToNull()
			pass
	pass

#鼠标点击事件（左键，右键）
func _on_zbgui_input(event,itembox):
	#鼠标左键
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var nowSelType=1;#装备栏类别
		var child = itembox.get_children()
		var templastSelItemIndex=lastSelItemIndex
		var templastSelType = lastSelType
		#单个pane的子节点
		var item_index = itembox.get_index()
		lastSelType=nowSelType
		lastSelItemIndex=item_index;
		#获取节点在父节点的索引
		var zidianshujv = Daojvlan.daojvlan[item_index]
		#数组的数据
		if child.size() == 1:
			if nowc == null :
				#临时道具为空则把道具栏物品复制给临时物品
				nowc = child[0].duplicate()
				linshishujv = Daojvlan.zhuangbeilan[item_index].duplicate()
				nowc.position = get_local_mouse_position()
#				nowc.position = Vector2(nowc.position)
#				print("self.rect_scale:"+self.rect_scale.x as String+","+self.rect_scale.y as String)
#				nowc.scale=Vector2(self.rect_scale.x,self.rect_scale.y)
#				nowc.scale=Vector2(0.3,0.3)
#				get_tree().get_root().add_child(nowc)
				$Panel.add_child(nowc)
				child[0].queue_free()
				Daojvlan.zhuangbeilan[item_index] = null 
				
			else :
				#把临时道具复制至点击的位置
				#print(nowc)
				var nowitem = nowc.duplicate()
				#需交换的数据
				var jiaohuanshujvfuzhi = Daojvlan.zhuangbeilan[item_index].duplicate()
				#Pane的数据给 jiaohuanshujvfuzhi
				nowitem.position =  Vector2(33,33)
				
				itembox.add_child(nowitem)
				
				nowc.queue_free()
				
				#if判断开启叠加物品，else为物品不同时交换物品
				if Daojvlan.zhuangbeilan[item_index][1]["daojvname"]==linshishujv[1]["daojvname"]:
					Daojvlan.zhuangbeilan[item_index][1]["daojvshuliang"] +=linshishujv[1]["daojvshuliang"]
					#print (Daojvlan.daojvlan[c[w]])
					ZhuangBeiLanShuaXin()
					TempDaoJuToNull()
					return
					pass
				else:
					if 1==2:
						#有物品时，对应物品替换至手上
						Daojvlan.zhuangbeilan[item_index] = linshishujv
						#lastSelItemIndex=item_index;
						#手上的数据给Pane
						
						linshishujv = jiaohuanshujvfuzhi
						#jiaohuanshujvfuzhi 数据返回到手上
						jiaohuanshujvfuzhi =null
						
						nowc = child[0].duplicate()
						nowc.position = get_local_mouse_position()
#						get_tree().get_root().add_child(nowc)
						$Panel.add_child(nowc)
						child[0].queue_free()
					else:
						if templastSelType != nowSelType:
							#有物品时进行交换位置模式
							Daojvlan.zhuangbeilan[item_index] = linshishujv
							linshishujv = jiaohuanshujvfuzhi
							#对应位置有道具 则 找到未有道具背包栏
							for i in Daojvlan.daojvlan.size():
								if Daojvlan.daojvlan[i] == null:
									Daojvlan.daojvlan[i]=linshishujv;
									break;
							ZhuangBeiLanShuaXin()
							DaoJuLanShuaXin()
							TempDaoJuToNull()
						else:
							#有物品时进行交换位置模式
							Daojvlan.zhuangbeilan[item_index] = linshishujv
							linshishujv = jiaohuanshujvfuzhi
							
							Daojvlan.zhuangbeilan[templastSelItemIndex] = jiaohuanshujvfuzhi
	#						#对应位置有道具 则 找到未有道具背包栏
	#						for i in Daojvlan.daojvlan.size():
	#							if Daojvlan.daojvlan[i] == null:
	#								Daojvlan.daojvlan[i]=linshishujv;
	#								break;
							ZhuangBeiLanShuaXin()
							child[0].queue_free()
							TempDaoJuToNull()
						pass
				
		else:
			if nowc == null:
				return
			var item = nowc.duplicate()
			Daojvlan.zhuangbeilan[item_index] = linshishujv
			item.position = Vector2(33,33)
			itembox.add_child(item)
			TempDaoJuToNull()
			
	#鼠标右键
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT:
		var item_index = itembox.get_index()
		#获取节点在父节点的索引
		var zidianshujv = Daojvlan.zhuangbeilan[item_index]
		if zidianshujv != null and nowc == null:
			xvhao = item_index
			$Panel/Node2D/Node2D/PopupMenu.rect_scale.x=self.rect_scale.x
			$Panel/Node2D/Node2D/PopupMenu.rect_scale.y=self.rect_scale.y
			$Panel/Node2D/Node2D/PopupMenu.rect_position = (itembox.rect_position+$Panel/GridContainer.rect_global_position)*self.rect_scale.x
			$Panel/Node2D/Node2D/PopupMenu.popup()
		else:
			#把物品还到原来位置
			if lastSelType == 1:
				Daojvlan.zhuangbeilan[lastSelItemIndex] = linshishujv
				ZhuangBeiLanShuaXin()
				TempDaoJuToNull()
			else:
			#把物品还到原来位置
				Daojvlan.daojvlan[lastSelItemIndex] = linshishujv
				DaoJuLanShuaXin()
				TempDaoJuToNull()
			pass
	pass

#随机生成道具
func _on_Button_pressed():
	#未有道具的背包栏
	var nullItemArr = []
	#随机道具
	var randItem = round(rand_range(0,5))
	#有道具的背包栏
	var haveItemArr = []
	#有道具的道具名称
	var haveItemNameArr = []
	
	#分类未有道具背包栏 和 有道具背包栏
	for i in Daojvlan.daojvlan.size():
		if Daojvlan.daojvlan[i] == null:
			nullItemArr.append(i)
		else :
			haveItemArr.append(i)
			haveItemNameArr.append(Daojvlan.daojvlan[i][1]["daojvname"])
	#如果有名称相同的道具，对应物品栏数量+1，并返回
	if haveItemNameArr.has(Daojvlan.wupinku[randItem][1]["daojvname"]):
		var w = haveItemNameArr.find(Daojvlan.wupinku[randItem][1]["daojvname"])
		#print (Daojvlan.wupinku[b][1]["daojvname"])
		#print (Daojvlan.daojvlan[c[w]])
		Daojvlan.daojvlan[haveItemArr[w]][1]["daojvshuliang"] +=1
		#print (Daojvlan.daojvlan[c[w]])
		DaoJuLanShuaXin()
		return
	#如果未有道具物品栏>0，则新增物品
	if nullItemArr.size() > 0:
		#a.shuffle()
		randomize()
		Daojvlan.daojvlan[nullItemArr[0]] = Daojvlan.wupinku[randItem]
		DaoJuLanShuaXin()
	else :
		$Panel/Node2D/PopupDialog.popup()
		return
	
	pass # Replace with function body.

#整理背包
func _on_Button2_pressed():
	var tempObj = Daojvlan.daojvlan.duplicate();
	for i in tempObj.size():
		tempObj[i]=null
	for i in Daojvlan.daojvlan.size():
#		if Daojvlan.daojvlan[i] == null:
#			Daojvlan.daojvlan.append(Daojvlan.daojvlan[i])
#			Daojvlan.daojvlan.remove(i)
		if Daojvlan.daojvlan[i] != null:
			for j in tempObj.size():
				if tempObj[j]==null:
					tempObj[j]=Daojvlan.daojvlan[i];
					break;
#	Daojvlan.daojvlan.sort()
#	Daojvlan.daojvlan.invert()
	tempObj.sort()
	tempObj.invert()
	Daojvlan.daojvlan = tempObj.duplicate();
	tempObj=null
	DaoJuLanShuaXin()
	pass # Replace with function body.

#鼠标进入事件，显示物品介绍
func _on_mouse_entered(item):
	#print("_on_mouse_entered")
	var item_index = item.get_index()
	#print("size()"+item.get_parent().get_children().size() as String)
	if item.get_parent().get_children().size() > 4:
		mouseOnType="dj"
	else:
		mouseOnType="zb"
		pass
	#print(mouseOnType)
	if Daojvlan.daojvlan[item_index] != null && mouseOnType=="dj":
		#print("item.rect_position:"+item.rect_position.x as String+","+item.rect_position.y as String)
		#print("Node2D.position:"+$Panel/Node2D.position.x as String+","+$Panel/Node2D.position.y as String)
		#print("/Sprite.position:"+$Panel/Node2D/Sprite.position.x as String+","+$Panel/Node2D/Sprite.position.y as String)
		$Panel/Node2D/Sprite.position= item.rect_position
		$Panel/Node2D/Sprite.position.x+=$Panel/Node2D/Sprite/yidong_miaoshu.rect_size.x
		$Panel/Node2D/Sprite.position.x-=50
		$Panel/Node2D/Sprite.position.y+=30
		$Panel/Node2D/Sprite.visible = true
		$Panel/Node2D/Sprite/yidong_miaoshu/Label.text = Daojvlan.daojvlan[item_index][1]["daojvmiaoshu"] as String
		$Panel/Node2D/Sprite/yidong_miaoshu/Label.text += GetZbMiaoShu(Daojvlan.daojvlan[item_index][1])
	elif item_index<Daojvlan.zhuangbeilan.size() && Daojvlan.zhuangbeilan[item_index] != null && mouseOnType=="zb":
		#print("item.rect_position:"+item.rect_position.x as String+","+item.rect_position.y as String)
		#print("Node2D.position:"+$Panel/Node2D.position.x as String+","+$Panel/Node2D.position.y as String)
		#print("/Sprite.position:"+$Panel/Node2D/Sprite.position.x as String+","+$Panel/Node2D/Sprite.position.y as String)
		$Panel/Node2D/Sprite.position= item.rect_position
		$Panel/Node2D/Sprite.position.x+=$Panel/Node2D/Sprite/yidong_miaoshu.rect_size.x
		$Panel/Node2D/Sprite.position.x-=80
		$Panel/Node2D/Sprite.position.y+=30+$Panel/Node2D/Sprite/yidong_miaoshu.rect_size.y
		$Panel/Node2D/Sprite.visible = true
		$Panel/Node2D/Sprite/yidong_miaoshu/Label.text = Daojvlan.zhuangbeilan[item_index][1]["daojvmiaoshu"] as String
		$Panel/Node2D/Sprite/yidong_miaoshu/Label.text += GetZbMiaoShu(Daojvlan.zhuangbeilan[item_index][1])
	else :
		_on_mouse_exited();
		return
	pass

#获取装备的数值部分描述
func GetZbMiaoShu(inObj)->String:
	var rValue="";
	if inObj.has("sm"):
		var zbValue = inObj["sm"] as int;
		if zbValue!=0:
			rValue+="\r\n生命值+"+zbValue as String;
	if inObj.has("gj"):
		var zbValue = inObj["gj"] as int;
		if zbValue!=0:
			rValue+="\r\n攻击值+"+zbValue as String;
	if inObj.has("fy"):
		var zbValue = inObj["fy"] as int;
		if zbValue!=0:
			rValue+="\r\n防御值+"+zbValue as String;
	return rValue;
	pass

#鼠标离开事件，隐藏物品介绍
func _on_mouse_exited():
	$Panel/Node2D/Sprite.visible = false
	pass

#丢弃物品
func _on_diu_pressed():
	
	Daojvlan.daojvlan[xvhao] = null
	
	DaoJuLanShuaXin()
	
	$Panel/Node2D/Node2D/PopupMenu.hide()
	pass # Replace with function body.

#存档界面
func _on_Button3_pressed():
	get_tree().change_scene("res://daojvxitong/CunDang.tscn")
	
	pass 

func _on_Panel_mouse_exited():

	pass # Replace with function body.


func _on_ButtonCanel_pressed():
	GameGlobal.baocunshujv_daojulan()
	GameGlobal.baocunshujv_zhuangbeilan();
	GameGlobal.MainGameScene()
	pass # Replace with function body.


func _on_ButtonSava_pressed():
	GameGlobal.baocunshujv_daojulan()
	GameGlobal.baocunshujv_zhuangbeilan();
	pass # Replace with function body.
