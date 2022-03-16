import Toybox.Graphics;
import Toybox.Math;

module Pointer{

function drawPointer(dc,gun,pointer)
    {
    	switch(gun)
    	{
    		case "riffle":
    			return drawPointerRiffle(dc,pointer);
    		case "laser":
    			return drawPointerLaser(dc,pointer);
    		case "hunter":
    			return drawPointerHunter(dc,pointer);
    		case "inferno":
    			return drawPointerInferno(dc,pointer);
    		default:
    			return;    			
    	}	
    }
    
    function drawPointerRiffle(dc as Dc,pointer) as Void{
    	
    	var pointX=pointer[0];
    	var pointY=pointer[1];
    	var centerX=dc.getWidth()/2; 
    	
    	//pointX=140;
    	//pointY=140;
    	
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        //circle
        dc.drawCircle(pointX, pointY, 0.2f*centerX);
        //top
		dc.drawLine(pointX, pointY+3,pointX, pointY+0.25f*centerX+3);
		//low
		dc.drawLine(pointX, pointY-3,pointX, pointY-0.25f*centerX-3);
		//left
		dc.drawLine(pointX-3, pointY,pointX-0.25f*centerX-3,pointY);
		//right
		dc.drawLine(pointX+3, pointY,pointX+0.25f*centerX+3,pointY);
		
		if(Settings.AUTOFIRECOUNTER>0)
		{
			dc.setPenWidth(4);
			dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
			dc.drawCircle(pointX, pointY, 0.2f*centerX);
			dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
			var end=(1.0f*(Settings.RELOAD-Settings.AUTOFIRECOUNTER)/Settings.RELOAD)*360;
			dc.drawArc(pointX, pointY, 0.2f*centerX,Graphics.ARC_COUNTER_CLOCKWISE, 0, end);
		}
		dc.setPenWidth(1);
		//return [pointX,pointY];
    }
    
    function drawPointerHunter(dc as Dc,pointer) as Void{
    	
    	var pointX=pointer[0];
    	var pointY=pointer[1];
    	var centerX=dc.getWidth()/2;
    	
    	var angle270=4.712389;
    	var angle30=0.523599;
    	var angle150=2.617994;
    	
    	var angle280=4.886922;
    	var angle20=0.349066;
    	var angle40=0.698132;
    	var angle140=2.443461;
    	var angle160=2.792527;
    	var angle260=4.537856;
    	
    	//pointX=140;
    	//pointY=140;
    	
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        //circle center
        dc.drawCircle(pointX, pointY, 0.1f*centerX);
        
        var shift=(1.0f*(Settings.RELOAD-Settings.AUTOFIRECOUNTER)/Settings.RELOAD)*120;
        
        var x1=pointX+0.13f*centerX*Math.cos(Math.toRadians(270+shift));
        var y1=pointY+0.13f*centerX*Math.sin(Math.toRadians(270+shift));
        
        var x2=pointX+0.13f*centerX*Math.cos(Math.toRadians(30+shift));
        var y2=pointY+0.13f*centerX*Math.sin(Math.toRadians(30+shift));
        
        var x3=pointX+0.13f*centerX*Math.cos(Math.toRadians(150+shift));
        var y3=pointY+0.13f*centerX*Math.sin(Math.toRadians(150+shift));
        
        var x11=pointX+0.27f*centerX*Math.cos(Math.toRadians(270+shift));
        var y11=pointY+0.27f*centerX*Math.sin(Math.toRadians(270+shift));
        
        var x22=pointX+0.27f*centerX*Math.cos(Math.toRadians(30+shift));
        var y22=pointY+0.27f*centerX*Math.sin(Math.toRadians(30+shift));
        
        var x33=pointX+0.27f*centerX*Math.cos(Math.toRadians(150+shift));
        var y33=pointY+0.27f*centerX*Math.sin(Math.toRadians(150+shift));
        
        var x1out=pointX+0.35f*centerX*Math.cos(Math.toRadians(270+shift));
        var y1out=pointY+0.35f*centerX*Math.sin(Math.toRadians(270+shift));
        
        var x2out=pointX+0.35f*centerX*Math.cos(Math.toRadians(30+shift));
        var y2out=pointY+0.35f*centerX*Math.sin(Math.toRadians(30+shift));
        
        var x3out=pointX+0.35f*centerX*Math.cos(Math.toRadians(150+shift));
        var y3out=pointY+0.35f*centerX*Math.sin(Math.toRadians(150+shift));
        
        dc.drawArc(pointX,pointY,0.22f*centerX,1,80,340);
        dc.drawArc(pointX,pointY,0.22f*centerX,1,320,220);
        dc.drawArc(pointX,pointY,0.22f*centerX,1,200,100);
        
        dc.drawLine(x1,y1,x11,y11);
        dc.drawLine(x2,y2,x22,y22);
        dc.drawLine(x3,y3,x33,y33);
        
        dc.drawCircle(x1out,y1out,9);
        dc.drawCircle(x2out,y2out,9);
        dc.drawCircle(x3out,y3out,9);
        
        if(Settings.AUTOFIRECOUNTER>0)
        {       	
        	dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        }
        else
        {
        	dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
        }
        
        dc.fillCircle(x1out,y1out,5);
        dc.fillCircle(x2out,y2out,5);
        dc.fillCircle(x3out,y3out,5);
       
		dc.setPenWidth(1);
		//return [pointX,pointY];
    }
    
    function drawPointerInferno(dc as Dc,pointer) as Void{
    	
    	var pointX=pointer[0];
    	var pointY=pointer[1];
    	var centerX=dc.getWidth()/2;

    	
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    	dc.setPenWidth(2);
        //line vertical
        dc.drawLine(pointX, pointY+0.3*centerX,pointX, pointY-0.3*centerX);
        //line horizontal
        dc.drawLine(pointX+0.3*centerX,pointY,pointX-0.3*centerX,pointY);
        
        var shift=(1.0f*(Settings.RELOAD-Settings.AUTOFIRECOUNTER)/Settings.RELOAD)*100;
        
        if(shift<33)
        {
        	dc.setPenWidth(4);
        	dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        }
               
        dc.drawArc(pointX,pointY,0.08f*centerX,1,75,15);
        dc.drawArc(pointX,pointY,0.08f*centerX,1,345,285);
        dc.drawArc(pointX,pointY,0.08f*centerX,1,255,195);
        dc.drawArc(pointX,pointY,0.08f*centerX,1,165,105);
        
        if(32<shift and shift<66)
        {
        	dc.setPenWidth(4);
        	dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_BLACK);
        }
        
        dc.drawArc(pointX,pointY,0.16f*centerX,1,75,15);
        dc.drawArc(pointX,pointY,0.16f*centerX,1,345,285);
        dc.drawArc(pointX,pointY,0.16f*centerX,1,255,195);
        dc.drawArc(pointX,pointY,0.16f*centerX,1,165,105);
        
        if(65<shift and shift<99)
        {
        	dc.setPenWidth(4);
        	dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
        }
        
        dc.drawArc(pointX,pointY,0.24f*centerX,1,75,15);
        dc.drawArc(pointX,pointY,0.24f*centerX,1,345,285);
        dc.drawArc(pointX,pointY,0.24f*centerX,1,255,195);
        dc.drawArc(pointX,pointY,0.24f*centerX,1,165,105);
 		
 		//System.println("shift: "+shift);
 		
 		dc.setPenWidth(1);
    }
    
    //////
    function drawPointerLaser(dc as Dc,pointer) as Void{
    	
    	var pointX=pointer[0];
    	var pointY=pointer[1];
    	var centerX=dc.getWidth()/2;
    	
    	//pointX=140;
    	//pointY=140;
    	
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        //View.onUpdate(dc);
        //System.println("actualX "+actualX+"     actualY "+actualY);
        //dc.fillCircle(actualX,actualY,5);
        //dc.drawCircle(pointX, pointY, 0.2f*centerX);
        //topleft
		dc.drawLine(pointX, pointY+3,pointX-0.15f*centerX, pointY+3+0.15f*centerX);
		//topright
		dc.drawLine(pointX, pointY+3,pointX+0.15f*centerX, pointY+3+0.15f*centerX);
		
		//leftup
		dc.drawLine(pointX-3, pointY,pointX-3-0.15f*centerX, pointY+0.15f*centerX);
		//leftdown
		dc.drawLine(pointX-3, pointY,pointX-3-0.15f*centerX, pointY-0.15f*centerX);
		
		//downleft
		dc.drawLine(pointX, pointY-3,pointX-0.15f*centerX, pointY-3-0.15f*centerX);
		//downright
		dc.drawLine(pointX, pointY-3,pointX+0.15f*centerX, pointY-3-0.15f*centerX);
		
		//rightup
		dc.drawLine(pointX+3, pointY,pointX+3+0.15f*centerX, pointY+0.15f*centerX);
		//rightdown
		dc.drawLine(pointX+3, pointY,pointX+3+0.15f*centerX, pointY-0.15f*centerX);
		
		//circle
        dc.drawCircle(pointX, pointY, 0.25f*centerX);
        
        if(Settings.AUTOFIRECOUNTER>0)
		{
			dc.setPenWidth(4);
			dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
			dc.drawCircle(pointX, pointY, 0.2f*centerX);
			dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
			var end=(1.0f*(Settings.RELOAD-Settings.AUTOFIRECOUNTER)/Settings.RELOAD)*360;
			dc.drawArc(pointX, pointY, 0.2f*centerX,Graphics.ARC_COUNTER_CLOCKWISE, 0, end);
		}
		dc.setPenWidth(1);
		

    }

}