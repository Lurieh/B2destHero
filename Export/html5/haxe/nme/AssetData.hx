package nme;


import openfl.Assets;


class AssetData {

	
	public static var className = new Map <String, Dynamic> ();
	public static var library = new Map <String, LibraryType> ();
	public static var path = new Map <String, String> ();
	public static var type = new Map <String, AssetType> ();
	
	private static var initialized:Bool = false;
	
	
	public static function initialize ():Void {
		
		if (!initialized) {
			
			className.set ("assets/ActionManBold.ttf", nme.NME_assets_actionmanbold_ttf);
			type.set ("assets/ActionManBold.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("assets/Arrow.fla", "assets/Arrow.fla");
			type.set ("assets/Arrow.fla", Reflect.field (AssetType, "binary".toUpperCase ()));
			path.set ("assets/Arrow.png", "assets/Arrow.png");
			type.set ("assets/Arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/Arrow.xml", "assets/Arrow.xml");
			type.set ("assets/Arrow.xml", Reflect.field (AssetType, "text".toUpperCase ()));
			className.set ("assets/ComicBook.ttf", nme.NME_assets_comicbook_ttf);
			type.set ("assets/ComicBook.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("assets/empty.json", "assets/empty.json");
			type.set ("assets/empty.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/example.json", "assets/example.json");
			type.set ("assets/example.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/FallingTower.rube", "assets/FallingTower.rube");
			type.set ("assets/FallingTower.rube", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/greensightRing.png", "assets/greensightRing.png");
			type.set ("assets/greensightRing.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/hero.svg", "assets/hero.svg");
			type.set ("assets/hero.svg", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/HeroAnim.fla", "assets/HeroAnim.fla");
			type.set ("assets/HeroAnim.fla", Reflect.field (AssetType, "binary".toUpperCase ()));
			path.set ("assets/HeroAnim.swf", "assets/HeroAnim.swf");
			type.set ("assets/HeroAnim.swf", Reflect.field (AssetType, "binary".toUpperCase ()));
			path.set ("assets/HeroAnim2.fla", "assets/HeroAnim2.fla");
			type.set ("assets/HeroAnim2.fla", Reflect.field (AssetType, "binary".toUpperCase ()));
			path.set ("assets/HeroFly.png", "assets/HeroFly.png");
			type.set ("assets/HeroFly.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/HeroStill.png", "assets/HeroStill.png");
			type.set ("assets/HeroStill.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/Level01.json", "assets/Level01.json");
			type.set ("assets/Level01.json", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/Level01.rube", "assets/Level01.rube");
			type.set ("assets/Level01.rube", Reflect.field (AssetType, "binary".toUpperCase ()));
			path.set ("assets/library.fla", "assets/library.fla");
			type.set ("assets/library.fla", Reflect.field (AssetType, "binary".toUpperCase ()));
			path.set ("assets/library.swf", "assets/library.swf");
			type.set ("assets/library.swf", Reflect.field (AssetType, "binary".toUpperCase ()));
			path.set ("assets/redSightRing.png", "assets/redSightRing.png");
			type.set ("assets/redSightRing.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/Sighteffect.fla", "assets/Sighteffect.fla");
			type.set ("assets/Sighteffect.fla", Reflect.field (AssetType, "binary".toUpperCase ()));
			path.set ("assets/sightRing.psd", "assets/sightRing.psd");
			type.set ("assets/sightRing.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
			path.set ("assets/TemplateLevel.rube", "assets/TemplateLevel.rube");
			type.set ("assets/TemplateLevel.rube", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/TestLevel.rube", "assets/TestLevel.rube");
			type.set ("assets/TestLevel.rube", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/TestLevelCollisionFilter.rube", "assets/TestLevelCollisionFilter.rube");
			type.set ("assets/TestLevelCollisionFilter.rube", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/victimNormal.png", "assets/victimNormal.png");
			type.set ("assets/victimNormal.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/VictimTemplate.rube", "assets/VictimTemplate.rube");
			type.set ("assets/VictimTemplate.rube", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/whiteSightRing.png", "assets/whiteSightRing.png");
			type.set ("assets/whiteSightRing.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/éclat.png", "assets/éclat.png");
			type.set ("assets/éclat.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("libraries/bin/1.png", "libraries/bin/1.png");
			type.set ("libraries/bin/1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("libraries/library.dat", "libraries/library.dat");
			type.set ("libraries/library.dat", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("libraries/bin/1.png", "libraries/bin/1.png");
			type.set ("libraries/bin/1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("libraries/HeroAnim.dat", "libraries/HeroAnim.dat");
			type.set ("libraries/HeroAnim.dat", Reflect.field (AssetType, "text".toUpperCase ()));
			
			library.set ("library", Reflect.field (LibraryType, "swf".toUpperCase ()));
			library.set ("HeroAnim", Reflect.field (LibraryType, "swf".toUpperCase ()));
			
			initialized = true;
			
		}
		
	}
	
	
}


class NME_assets_actionmanbold_ttf extends flash.text.Font { }



class NME_assets_comicbook_ttf extends flash.text.Font { }




























