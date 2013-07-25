package ;

/**
 * ...
 * @author Mathieu Foucat
*/

//class  GameStateElement
//{
	//public var id:Int;
	//public var levelAdress:String;
	//
	//public function new(pId:Int, ?pLevelAdress:String) 
	//{
		//id =  pId;
		//levelAdress = pLevelAdress;
	//}
//} 
//
//class GameStates
//{
	//public static var startMenu:GameStateElement = new GameStateElement(01)
	//public static var level01:GameStateElement = new GameStateElement(02, "assets/Level01.json")
	//
	//public function new() 
	//{
		//
	//}
//}

enum GameState {
	StartMenu;// (id:Int = 1)
	TutoScreen;
	Level01;// (id:Int = 2, level:String = "assets/Level01.json")
	Level02;
	Level03;
	Level04;
	Level05;
}