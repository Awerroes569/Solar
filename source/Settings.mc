import Toybox.Lang;
import Toybox.Attention;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Application.Storage;
import Toybox.Graphics;

module Settings{

	var centerY;
    var centerX;
	
	var NAME="";
	
	var STAGE=0;
	
	var weapons=
    {	"riffle" => { "speed"=>10, "auto"=>true, "reload"=>20, "power" => 1.0f, "stable"=>1,"on"=>true,"multi"=>1,"sound"=>0,"vibe"=>0},//Sounds.soundRiffle,"vibe"=>Sounds.vibeRiffle},
		"hunter" => { "speed"=>30, "auto"=>true, "reload"=>25, "power" => 3.4f, "stable"=>1,"on"=>true,"multi"=>1,"shift"=>2,"sound"=>1,"vibe"=>1},//"sound"=>Sounds.soundHunter,"vibe"=>Sounds.vibeHunter},
		"laser" => { "speed"=>300, "auto"=>true, "reload"=>5, "power" => 0.8f, "stable"=>1,"on"=>true,"multi"=>1,"sound"=>2,"vibe"=>2},//"sound"=>Sounds.soundLaser,"vibe"=>Sounds.vibeLaser},
		"inferno" => { "speed"=>1, "auto"=>false, "reload"=>20, "power" => 0.5f, "increment"=>1.2f,"stable"=>1,"on"=>true,"multi"=>1,"sound"=>3,"vibe"=>3}//"sound"=>Sounds.soundInferno,"vibe"=>Sounds.vibeInferno}
	}; 
	
	var waves=
	{
		0=> [10,[[280,[0,120,5,-1000,1.0f,1,[1,0,0],0,[0,0]]]],"first encounter"],
		1=> [80,[[250,[0,120,5,-1000,1.0f,1,[1,0,0],0,[0,0]]]],"more bastards"],
		2=> [80,[[150,[0,120,7,-1000,1.0f,1,[1,0,0],0,[0,0]]]],"bastards are faster"],
		3=> [80,[[120,[0,120,10,-1000,1.0f,1,[1,0,0],0,[0,0]]]],"and faster"],
	};
	
	var scoresTRIAL=[
		["Spokens",			1500],
		["UBI",				1200],
		["Jabba",			1000],
		["Putti",			908],
		["ABC Man",			855],
		["Everest",			720],
		["Marina",			655],
		["Albobens",		329],
		["Pupex",			128],
		["Nieudanex",		20]	
	];
	
	var scores=[];
	
	var FIRE_START=100;
	var FIRE_SOUND=null;
	var FIRE_VIBE=null;	
	
	var AUTO_FIRE_STATUS=false;
	var RELOAD=7;
	var AUTOFIRECOUNTER=10;
	
	var INFERNO_AIMED=false;
	var INFERNO_HEAT=0.0f;
	
	var TARGETS=[];
	
	var INFO=[];
	var SCORE=0;
	var MONEY=0;
	var INFO_TIME=7;
	
	
	var MAX_HEALTH=8.0f;
	var MAX_SHIELD=5.0f;
	var HEALTH=8.0f;
	var SHIELD=5.0f;
	
	var SHIELD_REGENERATION_RATE=1f;
	
	
	
	var guns=["riffle","hunter","laser","inferno"];
    
    var vibeCollision=[    /////MOVE TO SOUNS
        new Attention.VibeProfile(100, 100),
        new Attention.VibeProfile(50, 30),
        new Attention.VibeProfile(100, 100),
    	];
    
     var upgrades=
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
     
     function generateUpgrades()
     {
     	var result=[];
        	var keys=Settings.upgrades.keys();
        	for(var i=0;i<keys.size();i++)
        	{
        		//System.println("key "+i+": "+keys[i]);
        		var sub=Settings.upgrades.get(keys[i]);
        		var subkeys=sub.keys();
        		for(var j=0;j<subkeys.size();j++)
        		{
        			//System.println("       subkey "+subkeys[j]);
        			var current=sub.get(subkeys[j]);
        			
        			if(current.size()<1 or (sub.get("on").size()>0 and !subkeys[j].equals("on")))
        			{
        				continue;
        			}
        			
        			if(Settings.MONEY>current[0].get("price"))
        			{
        				//result.add([keys[0],subkeys[j]]);
        				var mainItem=keys[i].toUpper();
        				var subkey=subkeys[j].toUpper();
        				var menuLabel=mainItem+" "+subkey;
        				
        				var menuSublabel=current[0].get("info");
        				
        				var menuIdentifier=[keys[i],subkeys[j]];
        				
        				result.add([menuLabel,menuSublabel,menuIdentifier]);     				
        				
        			}
        		}
        	}
        	
        	return result;
     }
     
     function addUpgrades(menu2,items)
     {
     	for(var i=0;i<items.size();i++)
     	{
     		menu2.addItem(
            new WatchUi.MenuItem(
                items[i][0],
                items[i][1],
                items[i][2],
                {}
            )
        );
     	}
     }
     
     function applyUpgrade(main,key)
     {
     	var subDictionary=Settings.upgrades.get(main);
     	var toPop=subDictionary.get(key);
     	var popped=toPop[0];
     	var price=popped.get("price");
     	var value=popped.get("value");
     	System.println("price: "+price+"  value: "+value);
     	
     	toPop.remove(popped);
     	var toChange=Settings.weapons.get(main);
     	toChange.put(key,value);
     	
     	System.println("check current value: "+Settings.weapons.get(main).get(key));
     	System.println("bank before: "+Settings.MONEY);
     	
     	Settings.MONEY-=price;
     	
     	System.println("bank after: "+Settings.MONEY);
     	
     	
     }
     
     function resetSettings()
     {
     	//var name=Storage.getValue("NAME");
     	Storage.deleteValue("INPROGRESS");
     	System.println("in progress deleted proof: "+Storage.getValue("INPROGRESS"));
     	//Storage.setValue("NAME",name);
     	
     	STAGE=Reset._STAGE;
		weapons=Reset._weapons;
		FIRE_START=Reset._FIRE_START;	
		SCORE=Reset._SCORE;
		MONEY=Reset._MONEY;
		MAX_HEALTH=Reset._MAX_HEALTH;
		MAX_SHIELD=Reset._MAX_SHIELD;
		HEALTH=Reset._HEALTH;
		SHIELD=Reset. _SHIELD;
		SHIELD_REGENERATION_RATE=Reset._SHIELD_REGENERATION_RATE;
		upgrades=Reset._upgrades;
		//scores=[];
     }
     
      function loadSettings()
     {
     	if (Storage.getValue("INPROGRESS")!=null)
     	{
     		STAGE=Storage.getValue("STAGE");
			weapons=Storage.getValue("weapons");
			FIRE_START=Storage.getValue("FIRE_START");
			SCORE=Storage.getValue("SCORE");
			MONEY=Storage.getValue("MONEY");
			MAX_HEALTH=Storage.getValue("MAX_HEALTH");
			MAX_SHIELD=Storage.getValue("MAX_SHIELD");
			HEALTH=Storage.getValue("HEALTH");
			SHIELD=Storage.getValue("SHIELD");
			SHIELD_REGENERATION_RATE=Storage.getValue("SHIELD_REGENERATION_RATE");
			upgrades=Storage.getValue("upgrades");
			scores=Storage.getValue("scores");
		}
     }
     
     function saveSettings()
     {
     	
     	Storage.setValue("upgrades",upgrades);
     	
     	Storage.setValue("STAGE",STAGE);
		Storage.setValue("weapons",weapons);
		Storage.setValue("FIRE_START",FIRE_START);
		Storage.setValue("SCORE",SCORE);
		Storage.setValue("MONEY",MONEY);
		Storage.setValue("MAX_HEALTH",MAX_HEALTH);
		Storage.setValue("MAX_SHIELD",MAX_SHIELD);
		Storage.setValue("HEALTH",HEALTH);
		Storage.setValue("SHIELD",SHIELD);
		Storage.setValue("SHIELD_REGENERATION_RATE",SHIELD_REGENERATION_RATE);
		Storage.setValue("scores",scores);
		
		Storage.setValue("INPROGRESS",true);
     }
     
     function insertHighscore(score)
     {
     	if(Settings.scores==null or Settings.scores.size()==0)
     	{
     		Settings.scores=[[Storage.getValue("NAME"),score]];
     		Storage.setValue("scores",Settings.scores);
     		return;
     	}
     	
     	System.println("Scores size is: "+Settings.scores.size());
     	
     	var end=Settings.scores.size()-1;
     	
     	System.println("Inside is: "+Settings.scores[end][1]);
     	System.println("and score is :"+score);
     	
     	if(score<=Settings.scores[end][1] and scores.size()>9)
     	{
     		return null;
     	}
     	else
     	{
     		var index=detectIndexHighscore(score);
     		updateHighscore(index);    		
     	}
     	
     }
     
     function detectIndexHighscore(score)
     {
     	for(var i=Settings.scores.size()-1;i>-1;i--)
     	{
     		if(Settings.scores[i][1]>score)
     		{
     			return i+1;
     		}
     	}
     	
     	return 0;      	
     }
     
     function updateHighscore(index)
     {
     	var toInsert=[Storage.getValue("NAME"),Settings.SCORE];
     	var result=[];
     	
     	if(Settings.scores.size()==1)
     	{
     		if(index==0)
     		{
     			result.add(toInsert);
     			result.addAll(Settings.scores);
     		}
     		else
     		{
     			result.addAll(Settings.scores);
     			result.add(toInsert);
     		}
     	}
     	else
     	{
     		var first=Settings.scores.slice(0,index);
     		var last=Settings.scores.slice(index,null);
     	
     		result.addAll(first);
     		result.add(toInsert);
     		result.addAll(last);
     		result=result.slice(0,10);
     	}
     	
     	Settings.scores=result;
     	Storage.setValue("scores",result);
     }

}