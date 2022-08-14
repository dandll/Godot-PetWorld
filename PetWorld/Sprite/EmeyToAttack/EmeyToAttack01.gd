extends KinematicBody2D

#敌人序号，地图中的顺序，打败后删除该敌人
export var emeyXuHao:int=0

func ChangeScene():
	print("emeyXuHao:"+emeyXuHao as String)
	GameGlobal.yeWaiEmeyXuHao=emeyXuHao;
	print("yeWaiCameraStartV2:"+self.position.x as String+","+self.position.y as String)
	GameGlobal.yeWaiCameraStartV2=self.position;
	GameGlobal.AttakYeWaiGameScene();
	pass
