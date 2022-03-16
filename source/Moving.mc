import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Sensor;
import Toybox.Attention;
import Toybox.Time;
import Toybox.Math;

module Moving{

	function producePosition(){
    	while(true)
    	{
    		var xProp=Math.rand()%1000;
    		var yProp=Math.rand()%1000;
    		
    		var xx=Settings.centerX-1f*xProp/1000*(Settings.centerX*2);
    		var yy=Settings.centerY-1f*yProp/1000*(Settings.centerY*2);
    		
    		var radius=Math.sqrt(1f*xx*xx+yy*yy);
    		if (radius<Settings.centerX-9)
    		{
    			return [Settings.centerX+xx,Settings.centerY+yy];   //moze wyrownac floor
    		}
    	}
    }
    
    function produceBias(xLoc,yLoc){
    	while(true)
    	{
    		var xProp=Math.rand()%1000;
    		var yProp=Math.rand()%1000;
    		
    		var xx=Settings.centerX-1f*xProp/1000*(Settings.centerX*2);
    		var yy=Settings.centerY-1f*yProp/1000*(Settings.centerY*2);
    		
    		//if(xx<xLoc
    		
    		var radius=Math.sqrt(1f*xx*xx+yy*yy);
    		if (radius<Settings.centerX-9)
    		{
    			return [Settings.centerX+xx,Settings.centerY+yy];   //moze wyrownac floor
    		}
    	}
    }
	
	function Circling(posX,posY,axisX,axisY,rotation)
	{
		var changeX=posX-axisX;
		var changeY=posY-axisY;
		var lenght=Math.sqrt(changeX*changeX+changeY*changeY);
		var currentAngle=getAngleDegrees(changeY,changeX);
		var newX=axisX+lenght*Math.cos(Math.toRadians(currentAngle+rotation));
        var newY=axisY+lenght*Math.sin(Math.toRadians(currentAngle+rotation));
        
        return [newY,newX];
	}
	
	function createPointFromAngle(axisX,axisY,lenght,rotation)
	{
		var newX=axisX+lenght*Math.cos(Math.toRadians(rotation));
        var newY=axisY+lenght*Math.sin(Math.toRadians(rotation));
        
        return [newY,newX];
	}
	
	function creatingPointsFromAngles(axisX,axisY,lenght,rotations)
	{
		var newPoints=[];
		var rotLenght=rotations.size();
		for(var i=0;i<rotLenght;i++)
		{
			var newPoint=createPointFromAngle(axisX,axisY,lenght,rotations[i]);
			newPoints.add(newPoint);
		}
		return newPoints;
	}
	
	function getAngleDegrees(deltaX,deltaY) 
	{
    	var radians = Math.atan2(deltaY, deltaX);
    	var degrees =((radians * 180) / Math.PI);
    	//console.log('angle to degree:',{deltaX,deltaY,radians,degrees})
    	return degrees;
  	}
  	
  	function Hunting(posX,posY,targetX,targetY,speed)
	{		
		var diffX=posX-targetX;
		var diffY=posY-targetY;
		
		if(diffX==0 and diffY==0)
		{
			return [posX,posY];
		}
		
		if(MathPlus.Absolute(diffX)<speed)
		{
			posX=targetX;
		}
		else if(diffX>0)
		{
			posX-=speed;
		}
		else
		{
			posX+=speed;
		}
		
		if(MathPlus.Absolute(diffY)<speed)
		{
			posY=targetY;
		}
		else if(diffY>0)
		{
			posY-=speed;
		}
		else
		{
			posY+=speed;
		}
        
        return [posX,posY];
	}
	
	function Lining(posX,posY,targetX,targetY,speed)
	{		
		var diffX=posX-targetX;
		var diffY=posY-targetY;
		
		var sum=MathPlus.Absolute(diffX)+MathPlus.Absolute(diffY);
		
		var deltaX=0;
		var deltaY=0;
		
		if(sum>2*speed)
		{		
			deltaX=-diffX/sum*speed;
			deltaY=-diffY/sum*speed;
		}
		
		return[posX+deltaX,posY+deltaY];
	}

}