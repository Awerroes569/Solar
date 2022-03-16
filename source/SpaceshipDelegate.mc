import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Attention;
import Settings;

class SpaceshipDelegate extends WatchUi.BehaviorDelegate {

    var fire;
    var view;
    var vibeFire;

    
    function initialize(fired,viewed) {
        BehaviorDelegate.initialize();
        fire=fired;
        view=viewed;
    	vibeFire=[
        new Attention.VibeProfile(30, 20),
        new Attention.VibeProfile(20, 15),
        new Attention.VibeProfile(10, 10)
    	];

    }

    function onMenu() as Boolean {
    }
    
    public function onSelect() as Boolean {

        var currentGun=Settings.guns[0];
        var fireAllowed=Settings.weapons.get(currentGun).get("auto");
        if(Settings.AUTO_FIRE_STATUS and fireAllowed)
        {
        	return false;
        }
        
        if(Settings.guns[0].equals("inferno"))
    	{
    		if(Settings.INFERNO_AIMED)
    		{
    			return;
    		}
    		else
    		{
    			Settings.INFERNO_AIMED=true;
    			Settings.INFERNO_HEAT=Settings.weapons.get("inferno").get("power"); 
    		}   		
    	}
    	
        fire.generateFire(view.pointX,view.pointY);
        return false;
    }
    
	public function onNextPage() as Boolean {
        if(Settings.AUTO_FIRE_STATUS)
        {
        	Settings.AUTO_FIRE_STATUS=false;
        	return false;
        }
        var currentGun=Settings.guns[0];
        var fireAllowed=Settings.weapons.get(currentGun).get("auto");
        if(fireAllowed)
        {
        	Settings.AUTO_FIRE_STATUS=true;
        }
        return false;
    }
    
    public function onPreviousPage() as Boolean {
        Settings.AUTO_FIRE_STATUS=false;     
        while(true)
        {
        	var previousGun=Settings.guns[0];
        	Settings.guns.remove(previousGun);
        	Settings.guns.add(previousGun);
        	var currentGun=Settings.guns[0];
        	var currentWeapon=Settings.weapons.get(currentGun);
        	if(currentWeapon.get("on"))
        	{
        		var reload=currentWeapon.get("reload");
        		Settings.RELOAD=reload;
        		Settings.AUTOFIRECOUNTER=reload;
        		var sound=currentWeapon.get("sound");
        		Settings.FIRE_SOUND=Sounds.SOUNDS.get(sound);
        		var vibe=currentWeapon.get("vibe");
        		Settings.FIRE_VIBE=Sounds.VIBES.get(vibe);	
        		break;
        	}
        	else
        	{
        		System.println("you didnt buy this weapon: "+currentGun);
        	}
        }     
        return false;
    }
    


}