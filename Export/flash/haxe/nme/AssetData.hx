package nme;


import openfl.Assets;


class AssetData {

	
	public static var className = new #if haxe3 Map <String, #else Hash <#end Dynamic> ();
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();
	
	private static var initialized:Bool = false;
	
	
	public static function initialize ():Void {
		
		if (!initialized) {
			
			className.set ("assets/ActionManBold.ttf", nme.NME_assets_actionmanbold_ttf);
			type.set ("assets/ActionManBold.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			className.set ("assets/Arrow.fla", nme.NME_assets_arrow_fla);
			type.set ("assets/Arrow.fla", Reflect.field (AssetType, "binary".toUpperCase ()));
			className.set ("assets/Arrow.png", nme.NME_assets_arrow_png);
			type.set ("assets/Arrow.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/Background.png", nme.NME_assets_background_png);
			type.set ("assets/Background.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/Block.png", nme.NME_assets_block_png);
			type.set ("assets/Block.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/boulder.png", nme.NME_assets_boulder_png);
			type.set ("assets/boulder.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/ComicBook.ttf", nme.NME_assets_comicbook_ttf);
			type.set ("assets/ComicBook.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			className.set ("assets/greensightRing.png", nme.NME_assets_greensightring_png);
			type.set ("assets/greensightRing.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/HeroFly.png", nme.NME_assets_herofly_png);
			type.set ("assets/HeroFly.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/HeroStill.png", nme.NME_assets_herostill_png);
			type.set ("assets/HeroStill.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/Level01.json", nme.NME_assets_level01_json);
			type.set ("assets/Level01.json", Reflect.field (AssetType, "text".toUpperCase ()));
			className.set ("assets/Level01.rube", nme.NME_assets_level01_rube);
			type.set ("assets/Level01.rube", Reflect.field (AssetType, "binary".toUpperCase ()));
			className.set ("assets/Level02.json", nme.NME_assets_level02_json);
			type.set ("assets/Level02.json", Reflect.field (AssetType, "text".toUpperCase ()));
			className.set ("assets/Level02.rube", nme.NME_assets_level02_rube);
			type.set ("assets/Level02.rube", Reflect.field (AssetType, "binary".toUpperCase ()));
			className.set ("assets/Level03.json", nme.NME_assets_level03_json);
			type.set ("assets/Level03.json", Reflect.field (AssetType, "text".toUpperCase ()));
			className.set ("assets/Level03.rube", nme.NME_assets_level03_rube);
			type.set ("assets/Level03.rube", Reflect.field (AssetType, "binary".toUpperCase ()));
			className.set ("assets/MetalBare.jpg", nme.NME_assets_metalbare_jpg);
			type.set ("assets/MetalBare.jpg", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/plank02.png", nme.NME_assets_plank02_png);
			type.set ("assets/plank02.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/plank03.png", nme.NME_assets_plank03_png);
			type.set ("assets/plank03.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/redSightRing.png", nme.NME_assets_redsightring_png);
			type.set ("assets/redSightRing.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/Sighteffect.fla", nme.NME_assets_sighteffect_fla);
			type.set ("assets/Sighteffect.fla", Reflect.field (AssetType, "binary".toUpperCase ()));
			className.set ("assets/sightRing.psd", nme.NME_assets_sightring_psd);
			type.set ("assets/sightRing.psd", Reflect.field (AssetType, "binary".toUpperCase ()));
			className.set ("assets/terrain.png", nme.NME_assets_terrain_png);
			type.set ("assets/terrain.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/Tuto.png", nme.NME_assets_tuto_png);
			type.set ("assets/Tuto.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/victimNormal.png", nme.NME_assets_victimnormal_png);
			type.set ("assets/victimNormal.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/whiteSightRing.png", nme.NME_assets_whitesightring_png);
			type.set ("assets/whiteSightRing.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/éclat.png", nme.NME_assets__clat_png);
			type.set ("assets/éclat.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}


class NME_assets_actionmanbold_ttf extends flash.text.Font { }
class NME_assets_arrow_fla extends flash.utils.ByteArray { }
class NME_assets_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_background_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_block_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_boulder_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_comicbook_ttf extends flash.text.Font { }
class NME_assets_greensightring_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_herofly_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_herostill_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_level01_json extends flash.utils.ByteArray { }
class NME_assets_level01_rube extends flash.utils.ByteArray { }
class NME_assets_level02_json extends flash.utils.ByteArray { }
class NME_assets_level02_rube extends flash.utils.ByteArray { }
class NME_assets_level03_json extends flash.utils.ByteArray { }
class NME_assets_level03_rube extends flash.utils.ByteArray { }
class NME_assets_metalbare_jpg extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_plank02_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_plank03_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_redsightring_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_sighteffect_fla extends flash.utils.ByteArray { }
class NME_assets_sightring_psd extends flash.utils.ByteArray { }
class NME_assets_terrain_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_tuto_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_victimnormal_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_whitesightring_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets__clat_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
