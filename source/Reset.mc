import Toybox.Lang;
import Toybox.Attention;
import Toybox.WatchUi;
import Toybox.System;

module Reset{
	
	var _STAGE=0;
	
	var _weapons=
    {	"riffle" => { "speed"=>10, "auto"=>true, "reload"=>20, "power" => 1.0f, "stable"=>1,"on"=>true,"multi"=>1,"sound"=>0,"vibe"=>0},//Sounds.soundRiffle,"vibe"=>Sounds.vibeRiffle},
		"hunter" => { "speed"=>30, "auto"=>true, "reload"=>25, "power" => 3.4f, "stable"=>1,"on"=>true,"multi"=>1,"shift"=>2,"sound"=>1,"vibe"=>1},//"sound"=>Sounds.soundHunter,"vibe"=>Sounds.vibeHunter},
		"laser" => { "speed"=>300, "auto"=>true, "reload"=>5, "power" => 0.8f, "stable"=>1,"on"=>true,"multi"=>1,"sound"=>2,"vibe"=>2},//"sound"=>Sounds.soundLaser,"vibe"=>Sounds.vibeLaser},
		"inferno" => { "speed"=>1, "auto"=>false, "reload"=>20, "power" => 0.5f, "increment"=>1.2f,"stable"=>1,"on"=>true,"multi"=>1,"sound"=>3,"vibe"=>3}//"sound"=>Sounds.soundInferno,"vibe"=>Sounds.vibeInferno}
	};
	
	var _FIRE_START=100;	

	var _SCORE=0;
	var _MONEY=0;
	
	
	var _MAX_HEALTH=8.0f;
	var _MAX_SHIELD=5.0f;
	var _HEALTH=8.0f;
	var _SHIELD=5.0f;
	
	var _SHIELD_REGENERATION_RATE=1f;
    
     var _upgrades=
     {
     	"riffle"=>
     		{
     			"on"=>
     			[
     				{"info"=>"buy item for 100", "price"=>100, "value"=>true} //1
     			],
     			"speed"=>
     			[
     				{"info"=>"up to 20 for 100", "price"=>100, "value"=>20}, //1
     				{"info"=>"up to 25", "price"=>150, "value"=>25}, //2
     				{"info"=>"up to 30", "price"=>225, "value"=>30}, //3
     				{"info"=>"up to 35", "price"=>337, "value"=>35}, //4
     				{"info"=>"up to 40", "price"=>506, "value"=>40} //5
     			],
     			"auto"=>
     			[
     				{"info"=>"enable auto-fire", "price"=>100, "value"=>true} //1
     			],
     			"reload"=>
     			[
     				{"info"=>"down to 30", "price"=>100, "value"=>30}, //1
     				{"info"=>"down to 27", "price"=>150, "value"=>27}, //2
     				{"info"=>"down to 24", "price"=>225, "value"=>24}, //3
     				{"info"=>"down to 21", "price"=>337, "value"=>21}, //4
     				{"info"=>"down to 18", "price"=>506, "value"=>18} //5
     			],
     			"power"=>
     			[
     				{"info"=>"up to 2.0", "price"=>100, "value"=>2.0}, //1
     				{"info"=>"up to 2.4", "price"=>150, "value"=>2.4}, //2
     				{"info"=>"up to 2.88", "price"=>225, "value"=>2.88}, //3
     				{"info"=>"up to 3.46", "price"=>337, "value"=>3.46}, //4
     				{"info"=>"up to 4.15", "price"=>506, "value"=>4.15} //5
     			]
     		}
     			
     };


}