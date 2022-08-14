extends Node2D

#属性连加，连减，间隔
var btnShuXingJianGe=0.1;

#剩余属性点
var tempSYSXD=0;
#等级
var dj=0;
#经验
var jy=0;
#体质
var tz=0;
#力量
var ll=0;
#耐力
var nl=0;
#初始生命值
var cssmz=0;
#初始伤害值
var csshz=0;
#初始防御值
var csfyz=0
#生命值
var smz=0;
#伤害值
var shz=0;
#防御值
var fyz=0

func _ready():
	tempSYSXD=GgInfo.playerData[0][1]["sysxd"];
	dj=GgInfo.playerData[0][1]["dj"];
	jy=GgInfo.playerData[0][1]["jy"];
	tz=GgInfo.playerData[0][1]["tz"];
	ll=GgInfo.playerData[0][1]["ll"];
	nl=GgInfo.playerData[0][1]["nl"];
	cssmz=GgInfo.playerData[0][1]["cssmz"];
	csshz=GgInfo.playerData[0][1]["csshz"];
	csfyz=GgInfo.playerData[0][1]["csfyz"];
	$Panel/lblZBShengMing.text="装备生命："+GgInfo.GetPlayerZBSMZ() as String;
	$Panel/lblZBShangHai.text="装备伤害："+GgInfo.GetPlayerZBSHZ() as String;
	$Panel/lblZBFangYu.text="装备防御："+GgInfo.GetPlayerZBFYZ() as String;
	ShuaXinJieMian()
	
	pass

func ShuaXinJieMian():
	$Panel/lblDengJiNum.text = dj as String;
	$Panel/lblTiZhiNum.text=tz as String;
	$Panel/lblLiLiangNum.text=ll as String;
	$Panel/lblNaiLiNum.text=nl as String;
	$Panel/lblShengMingNum.text=GgInfo.GetPlayerSMZ() as String;
	$Panel/lblShangHaiNum.text=GgInfo.GetPlayerSHZ() as String;
	$Panel/lblFangYuNum.text=GgInfo.GetPlayerFYZ() as String;
	
	GgInfo.playerTempTZ=tz;
	$Panel/lblShengMingNum.text=GgInfo.GetPlayerTempSMZ() as String;
	GgInfo.playerTempLL=ll;
	$Panel/lblShangHaiNum.text=GgInfo.GetPlayerTempSHZ() as String;
	GgInfo.playerTempNL=nl;
	$Panel/lblFangYuNum.text=GgInfo.GetPlayerTempFYZ() as String;
	
	$Panel/lblShuXingDianNum.text=tempSYSXD as String;
	
	$Panel/lblJingYanuNum.text = jy as String;
	$Panel/lblJingYanuNum2.text = Ggjy.playerJY["l"+dj as String] as String;
	pass

func _on_btnTiZhiJia_pressed():
	if tempSYSXD>0:
		tz+=1;
		tempSYSXD-=1;
	ShuaXinJieMian();
	pass


func _on_btnTiZhiJian_pressed():
	if tz>dj*1+10:
		tz-=1;
		tempSYSXD+=1;
	ShuaXinJieMian();
	pass


func _on_btnLiLiangJia_pressed():
	if tempSYSXD>0:
		ll+=1;
		tempSYSXD-=1;
	ShuaXinJieMian();
	pass


func _on_btnLiLiangJian_pressed():
	if ll>dj*1+10:
		ll-=1;
		tempSYSXD+=1;
	ShuaXinJieMian();
	pass


func _on_btnNaiLiJia_pressed():
	if tempSYSXD>0:
		nl+=1;
		tempSYSXD-=1;
	ShuaXinJieMian();
	pass


func _on_btnNaiLiJian_pressed():
	if nl>dj*1+10:
		nl-=1;
		tempSYSXD+=1;
	ShuaXinJieMian();
	pass


func _on_btnSava_pressed():
	
	GgInfo.playerData[0][1]["dj"]=dj;
	GgInfo.playerData[0][1]["sysxd"]=tempSYSXD;
	GgInfo.playerData[0][1]["jy"]=jy;
	GgInfo.playerData[0][1]["tz"]=tz;
	GgInfo.playerData[0][1]["ll"]=ll;
	GgInfo.playerData[0][1]["nl"]=nl;
	
	GameGlobal.baocunshujv_info();
	pass


func _on_btnShengJi_pressed():
	if jy>Ggjy.playerJY["l"+dj as String]:
		jy-=Ggjy.playerJY["l"+dj as String];
		dj+=1;
		GgInfo.playerData[0][1]["dj"]+=1;
		GgInfo.playerData[0][1]["sysxd"]+=5;
		GgInfo.playerData[0][1]["jy"]=jy;
		GgInfo.playerData[0][1]["tz"]+=1;
		GgInfo.playerData[0][1]["ll"]+=1;
		GgInfo.playerData[0][1]["nl"]+=1;
		GameGlobal.baocunshujv_info();
		_ready();
	pass


func _on_btnCannel_pressed():
	GameGlobal.MainGameScene();
	pass


func _on_btnTiZhiJia_button_down():
	$TimerTZ.start(0.5)
	pass


func _on_btnTiZhiJia_button_up():
	$TimerTZ.stop()
	pass


func _on_TimerTZ_timeout():
	_on_btnTiZhiJia_pressed();
	$TimerTZ.start(btnShuXingJianGe)
	pass


func _on_TimerLL_timeout():
	_on_btnLiLiangJia_pressed();
	$TimerLL.start(btnShuXingJianGe)
	pass


func _on_TimerNL_timeout():
	_on_btnNaiLiJia_pressed();
	$TimerNL.start(btnShuXingJianGe)
	pass


func _on_btnTiZhiJian_button_down():
	_on_btnTiZhiJian_pressed();
	$TimerTZJian.start(btnShuXingJianGe)
	pass # Replace with function body.


func _on_btnTiZhiJian_button_up():
	$TimerTZJian.stop()
	pass # Replace with function body.


func _on_btnLiLiangJia_button_down():
	_on_btnLiLiangJia_pressed();
	$TimerLL.start(btnShuXingJianGe)
	pass # Replace with function body.


func _on_btnLiLiangJia_button_up():
	$TimerLL.stop()
	pass # Replace with function body.


func _on_btnLiLiangJian_button_down():
	_on_btnLiLiangJian_pressed();
	$TimerLLJian.start(btnShuXingJianGe)
	pass # Replace with function body.


func _on_btnLiLiangJian_button_up():
	$TimerLLJian.stop()
	pass # Replace with function body.


func _on_btnNaiLiJia_button_down():
	_on_btnNaiLiJia_pressed();
	$TimerNL.start(btnShuXingJianGe);
	pass # Replace with function body.


func _on_btnNaiLiJia_button_up():
	$TimerNL.stop()
	pass # Replace with function body.


func _on_btnNaiLiJian_button_down():
	_on_btnNaiLiJian_pressed();
	$TimerNLJian.start(btnShuXingJianGe);
	pass # Replace with function body.


func _on_btnNaiLiJian_button_up():
	$TimerNLJian.stop()
	pass # Replace with function body.


func _on_TimerTZJian_timeout():
	_on_btnTiZhiJian_pressed();
	$TimerTZJian.start(btnShuXingJianGe)
	pass # Replace with function body.


func _on_TimerLLJian_timeout():
	_on_btnLiLiangJian_pressed();
	$TimerLLJian.start(btnShuXingJianGe)
	pass # Replace with function body.


func _on_TimerNLJian_timeout():
	_on_btnNaiLiJian_pressed();
	$TimerNLJian.start(btnShuXingJianGe)
	pass # Replace with function body.
