import Toybox.Lang;
import Toybox.Time;

class Fire{

	public const fireSpeed=20;
	public var fires;
	//public var firesWaiting;
	public var firesWaiting2; //proba nowych fire opartych na dict
	
		
	function initialize() {
        fires=[];
        //firesWaiting=[];
        firesWaiting2=[];
    }
    
    public function generateFire(posX,posY){  //obecnie przeksztalcony
        	
    	if(Settings.AUTOFIRECOUNTER>0)
    	{
    		return;
    	}
    	
    	var currentGun=Settings.weapons.get(Settings.guns[0]);
    	
    	//
    	
    	for (var i=0;i<currentGun.get("multi");i++)
    	{  	
    		
    		var bullit={};
    		bullit.put("gun",Settings.guns[0]);
    		bullit.put("delay",i*5);
    		bullit.put("distance",100);
    		bullit.put("xLoc",posX);
    		bullit.put("yLoc",posY);
    		bullit.put("active",true);
    		firesWaiting2.add(bullit);    	
    	}
    	
    	//Attention.vibrate(Settings.FIRE_VIBE); 
    	Attention.playTone({:toneProfile=>Settings.FIRE_SOUND});
    	Settings.AUTOFIRECOUNTER=Settings.RELOAD;
    	
    }
    

    public function selectFire2(){
    	
    	var veryNow=[];
    	//var keys=fires.keys();
    	for(var i=0;i<fires.size();i++)
    	{
    		var currentFire=fires[i];
    		//var current=fires[i].get(keys[0]);
    		//System.println("fires item: "+i+"  "+keys[0]+"  "+current);
    		//if (currentFire!=null)
    		//{
    			
    			if(currentFire.get("gun").equals("inferno") and Settings.INFERNO_AIMED==false)
    			{
    				continue;
    			}
    			
    			if(currentFire.get("gun").equals("hunter") and currentFire.get("delay")==0)
    			{
    				if (Settings.TARGETS.size()>0)
    				{
    				var xTarget=Settings.TARGETS[0][0];
    				var yTarget=Settings.TARGETS[0][1];
    				var distanceTarget=Settings.TARGETS[0][2];
    				if(distanceTarget>currentFire.get("distance"))
    				{
    					currentFire.put("active",false);
    				}
    				var shift=Settings.weapons.get("hunter").get("shift");
    				var xHunter=currentFire.get("xLoc");
    				var yHunter=currentFire.get("yLoc");
    				
    				var xDiff=xTarget-xHunter;
    				var yDiff=yTarget-yHunter;
    				
    				//xxxxxxxxxxxxxxxxxxxxxx
    				if(xDiff>=shift)
    				{
    					xHunter+=shift;
    					currentFire.put("xLoc",xHunter);
    				}
    				else if(xDiff>0)
    				{
    					//xHunter+=xDiff;
    					currentFire.put("xLoc",xTarget);
    				}
    				else if(xDiff<=-shift)
    				{
    					xHunter-=shift;
    					currentFire.put("xLoc",xHunter);
    				}
    				else if(xDiff<0)
    				{
    					//xHunter-=xDiff;
    					currentFire.put("xLoc",xTarget);
    				}
    				
    				//yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
    				if(yDiff>=shift)
    				{
    					yHunter+=shift;
    					currentFire.put("yLoc",yHunter);
    				}
    				else if(yDiff>0)
    				{
    					//yHunter+=yDiff;
    					currentFire.put("yLoc",yTarget);
    				}
    				else if(yDiff<=-shift)
    				{
    					yHunter-=shift;
    					currentFire.put("yLoc",yHunter);
    				}
    				else if(yDiff<0)
    				{
    					//yHunter-=yDiff;
    					currentFire.put("yLoc",yTarget);
    				}
    				
    				//reloadTargets();
    				}
    			}
    			
    			if(currentFire.get("delay")>0)
    			{
    				var newDelay=currentFire.get("delay")-1;
    				currentFire.put("delay",newDelay);
    				veryNow.add(currentFire);
    			}
    			else if (currentFire.get("distance")>-500 and currentFire.get("active"))//fireSpeed+1)
    			{
    				var speed=Settings.weapons.get(currentFire.get("gun")).get("speed");
    				var newDistance=currentFire.get("distance")-speed;
    				currentFire.put("distance",newDistance);
    				veryNow.add(currentFire);
    			}   			
    		//}    		
    	}
    	fires=[];
    	fires.addAll(firesWaiting2);
    	//fires.addAll(firesWaiting);//.slice(0,-1);
    	firesWaiting2=[];
    	fires.addAll(veryNow);//.slice(0,-1));
    }
    
    function reloadTargets()
	{
		if (Settings.TARGETS.size()>1)
		{
			var first=Settings.TARGETS[0];
			Settings.TARGETS=Settings.TARGETS.slice(1,null);
			Settings.TARGETS.add(first);
		}
	}
}