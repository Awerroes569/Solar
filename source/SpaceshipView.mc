import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Sensor;
import Toybox.Attention;
import Toybox.Time;
import Toybox.Math;

class SpaceshipView extends WatchUi.View {

	private var centerX;
    private var centerY;
    private var forceX;
    private var forceY;
    private var forceZ;
    public var actualX;
    public var actualY;
    private var dataTimer;
    private var minimum;
    private var gravity;
    private var neutralX;
    private var maxX;
    private var neutralY;
    private var maxY;
    private var fire;
    private var start; //test moment
    var minR;
    var maxR;
    var background;
    var pointX;
    var pointY;
    var wave;//  as prototype
    var enemies;
    var autofirecounter;
    var beginning;

    
    var infernoOnTarget;
    var infernoHeat;
    
    var realFala;
    var realFala1;
    var realFala2;
    var realFala3;
    
    var ROTATIONS;
    
    var currentWave;
    
    
    
    function initialize(fired) {
        View.initialize();
        centerX=0;
        centerY=0;
        forceX=0;
        forceY=0;
        forceZ=2;
        actualX=[140,140,140];//0;
        actualY=[140,140,140];//0;
        minimum=5;
        neutralX=0;
        maxX=400;
        neutralY=-500;
        maxY=400;
        start=new Time.Moment(Time.now().value());
        fire=fired;
        //fire.generateFire(140,140);
        //background = WatchUi.loadResource(Rez.Drawables.flag);
        
        Math.srand(1);
        
        minR=1000000000;
        maxR=0;
        pointX=140;
        pointY=140;
        
        enemies=[];
        
        autofirecounter=Settings.RELOAD;
        beginning=true;

        ROTATIONS=[12,112,244,312];
        //infernoOnTarget=false;
        //infernoHeat=0.0f;
        
        currentWave=Aliens.makeRealWave(Settings.waves[Settings.STAGE]);
        System.println(currentWave.text);
    }

	function calculatePointerPosition()
	{
		var currentX=neutralX+forceX;
    	if (currentX<neutralX-maxX)
    	{
    		currentX=neutralX-maxX;
    	}
    	else if (currentX>neutralX+maxX)
    	{
    		currentX=neutralX+maxX;
    	}
    	//actualX=centerX+1.0f*(currentX-neutralX)/maxX*centerX;
    	var toAddX=centerX+1.0f*(currentX-neutralX)/maxX*centerX;
    	
    	//calculating position on Y-axis
    	var currentY=neutralY+forceY;
    	if (currentY<-maxY)
    	{
    		currentY=-maxY;
    	}
    	else if (currentY>maxY)
    	{
    		currentY=maxY;
    	}
    	//actualY=centerY+1.0f*currentY/maxY*centerY;
    	var toAddY=centerY+1.0f*currentY/maxY*centerY;
    	
    	actualX.remove(actualX[0]);
    	actualY.remove(actualY[0]);
    	actualX.add(toAddX);
    	actualY.add(toAddY);
    	
    	//actualX=140;
    	//actualY=140;
    	
    	pointX=(actualX[0]+actualX[1]+actualX[2])/3;
    	pointY=(actualY[0]+actualY[1]+actualY[2])/3;
    	
    	return [pointX,pointY];
	}
    
  
    
	function drawFires(dc as Dc,fire) as Void{
		if(fire.fires.size()>0)
		{
			dc.setPenWidth(5);
			dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_WHITE);
			
			for(var i=0;i<fire.fires.size();i++)
			{
				var key=fire.fires[i].keys();
				var xPos=key[0][1];
				var yPos=key[0][2];
				var distance=fire.fires[i].get(key[0])[0];
				var radius=0;
				if (distance>5)
				{
					radius=distance/2;
				}
				else if(distance>-50)
				{
					radius=5;
				}
				else if(distance>-100)
				{
					radius=4;
				}
				else if(distance>-150)
				{
					radius=3;
				}
				else if(distance>-200)
				{
					radius=2;
				}
				else
				{
					radius=1;
				}
				dc.fillCircle(xPos,yPos,radius);
			}
			
			dc.setPenWidth(1);
		}
    }
    
    function drawFires2(dc as Dc,fire) as Void{
		if(fire.fires.size()>0)
		{
			dc.setPenWidth(3);
			//dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_WHITE);
			
			for(var i=0;i<fire.fires.size();i++)
			{
				
				dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_WHITE);
				
				var currentFire=fire.fires[i]; //var key=fire.fires[i].keys();
				var gun=currentFire.get("gun");
				var delay=currentFire.get("delay");
				if (delay>0)
				{
					continue;
				}
				var xPos=currentFire.get("xLoc");  //key[0][1];
				var yPos=currentFire.get("yLoc");  //key[0][2];
				var distance=currentFire.get("distance");  //fire.fires[i].get(key[0])[0];
				var radius=0;
				
				if(gun.equals("laser"))
				{
					dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_WHITE);
					//dc.drawLine(xPos,0,xPos,280);
					//dc.drawLine(0,yPos,280,yPos);
					
					var x1=xPos+2.0f*centerX*Math.cos(Math.toRadians(225));
        			var y1=yPos+2.0f*centerX*Math.sin(Math.toRadians(225));
        
        			var x2=xPos+2.0f*centerX*Math.cos(Math.toRadians(45));
        			var y2=yPos+2.0f*centerX*Math.sin(Math.toRadians(45));
        
        			var x3=xPos+2.0f*centerX*Math.cos(Math.toRadians(135));
        			var y3=yPos+2.0f*centerX*Math.sin(Math.toRadians(135));
        
        			var x11=xPos+2.0f*centerX*Math.cos(Math.toRadians(315));
        			var y11=yPos+2.0f*centerX*Math.sin(Math.toRadians(315));
        			
        			dc.drawLine(x1,y1,x2,y2);
					dc.drawLine(x3,y3,x11,y11);
					dc.drawCircle(xPos,yPos,5);				
					continue;				
				}
				
				if(gun.equals("inferno"))
				{
					var rad=5.0f;
					if(Settings.INFERNO_HEAT>rad)
					{
						rad=Settings.INFERNO_HEAT;
					}
					if(Settings.INFERNO_HEAT>40)
					{
						rad=40;
					}
					
					var xAb1=Math.rand()%rad.toLong()-rad/2;
					var yAb1=Math.rand()%rad.toLong()-rad/2;
					var xAb2=Math.rand()%rad.toLong()-rad/2;
					var yAb2=Math.rand()%rad.toLong()-rad/2;
					var xAb3=Math.rand()%rad.toLong()-rad/2;
					var yAb3=Math.rand()%rad.toLong()-rad/2;
					
					
					dc.fillCircle(pointX+xAb1, pointY+yAb1, rad);
					dc.fillCircle(pointX+xAb2, pointY+yAb2, rad);
					dc.fillCircle(pointX+xAb3, pointY+yAb3, rad);
					continue;
				}
				
				if(gun.equals("hunter"))
				{
					dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);				
				}
				
				
				if (distance>5)
				{
					radius=distance/2;
				}
				else if(distance>-50)
				{
					radius=5;
				}
				else if(distance>-100)
				{
					radius=4;
				}
				else if(distance>-150)
				{
					radius=3;
				}
				else if(distance>-200)
				{
					radius=2;
				}
				else
				{
					radius=1;
				}
				dc.fillCircle(xPos,yPos,radius);
			}
			
			dc.setPenWidth(1);
		}
    }
    
    function drawEnemies(dc as Dc) as Void{
		if(enemies.size()>0)
		{
			dc.setPenWidth(5);
			dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_WHITE);
			
			for(var i=enemies.size()-1;i>-1;i--)
			{
				
				var enemy=enemies[i];
				
				var type=enemy.type;
				var xPos=enemy.position[0];
				var yPos=enemy.position[1];
				var distance=enemy.distance;
				var size=enemy.size;
				
				
				if(type==0)
				{
					var realSize=0.5f*size*(100/(1.0f*100+(100-distance)));
					//System.println("size= "+size+" real size= "+realSize+" distance= "+distance);
					dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_WHITE);
					if(enemy.endurance==1)
					{
						dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_WHITE);
					}
					dc.fillCircle(xPos,yPos,realSize);
					dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
					dc.setPenWidth(1);
					dc.drawCircle(xPos,yPos,realSize);
					dc.drawCircle(xPos,yPos,realSize/2);
					dc.drawCircle(xPos,yPos,realSize/4);
					continue;
				}
				
				if(type==3)
				{
					var realSize=0.5f*size*(100/(1.0f*100+(100-distance)));
					
					dc.setPenWidth(1);
					dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.COLOR_WHITE);
					
					//dc.fillEllipse(xPos,yPos,realSize,realSize);
					dc.fillEllipse(xPos,yPos,3*realSize,0.3*realSize);					
					dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
					dc.drawEllipse(xPos,yPos,3*realSize,0.3*realSize);
					
					
					dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.COLOR_WHITE);
					dc.fillEllipse(xPos,yPos,realSize,realSize);
					dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
					dc.drawEllipse(xPos,yPos,realSize,realSize);
				}
				
				if(type==2)
				{
					var realSize=0.5f*size*(100/(1.0f*100+(100-distance)));
					
					//dc.setPenWidth(1);
					dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_WHITE);
					
					//dc.fillEllipse(xPos,yPos,realSize,realSize);
					dc.fillEllipse(xPos,yPos,5*realSize,0.3*realSize);					
					dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
					dc.drawEllipse(xPos,yPos,5*realSize,0.3*realSize);
					dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_WHITE);
					dc.fillEllipse(xPos,yPos,0.3*realSize,5*realSize);					
					dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
					dc.drawEllipse(xPos,yPos,0.3*realSize,5*realSize);
					dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_WHITE);
					dc.fillCircle(xPos,yPos,realSize);
					dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
					dc.drawCircle(xPos,yPos,realSize);

				}
				//DESTROYED OBJECTS
				if(type==10)
				{
					var realSize=0.5f*size*(100/(1.0f*100+(100-distance)));
					//System.println("size= "+size+" real size= "+realSize+" distance= "+distance);
					dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_WHITE);
					dc.fillCircle(xPos,yPos,realSize);
					enemy.size=0.8f*enemy.size;
					//dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
					//dc.setPenWidth(1);
					//dc.drawCircle(xPos,yPos,realSize);
					//dc.drawCircle(xPos,yPos,realSize/2);
					//dc.drawCircle(xPos,yPos,realSize/4);
					enemy.endurance-=1;
				}
			}
			
			dc.setPenWidth(1);
		}
    }
    
    
    // Load your resources here
    function onLayout(dc as Dc) as Void {

        System.println("angle: "+Moving.getAngleDegrees(40,0));
        var newCoord=Moving.Circling(180,140,140,140,0);
        System.println("new coordinates: "+newCoord[0]+"   "+newCoord[1]);
        
        centerY=dc.getHeight()/2;// TO KILL IN FINAL STAGE
        centerX=dc.getWidth()/2; // TO KILL IN FINAL STAGE
        Settings.centerY=dc.getHeight()/2;
        Settings.centerX=dc.getWidth()/2;
        
        Settings.loadSettings();
        
        var currentWeapon=Settings.weapons.get(Settings.guns[0]);
        var sound=currentWeapon.get("sound");
        var vibe=currentWeapon.get("vibe");
        Settings.FIRE_SOUND=Sounds.SOUNDS.get(sound);  ////////////////////////
        Settings.FIRE_VIBE=Sounds.VIBES.get(vibe);
        
        dataTimer = new Timer.Timer();
        dataTimer.start(method(:gravityUpdate), 50, true);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    	
    }
    
        // Update the view
    function onUpdate(dc as Dc) as Void {       
        // Call the parent onUpdate function to redraw the layout
        //System.println("check aimed at update: "+Settings.INFERNO_AIMED);
        
        //CHECK IF STILL ALIVE
        if(Settings.HEALTH<2*Settings.SHIELD_REGENERATION_RATE)
        {
        	dataTimer.stop();
        	Views.makeDead();
        }
        
        
        //NO DARKNESS
        Attention.backlight(true);
        
        //SHIELD INCREASE ACCORDING TO REGENERATION RATE
        if(Settings.SHIELD<Settings.MAX_SHIELD)
        {
        	Settings.SHIELD+=Settings.SHIELD_REGENERATION_RATE;
        }
        
        //CLEARING SCREEN FROM PREVIOUS SCREEN
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLACK);
        dc.clear();
        
        //DETECT THE TIME FROM START
        var now=new Time.Moment(Time.now().value());
        var diff=now.subtract(start);
        
        //ONLY PROTOTYPE TO CORRECT
        if(diff.value()<3)
        {
        	drawWaveTitle(dc,centerX,centerY,currentWave.text);
        	if(beginning and diff.value()>0)
        	{
        		//Attention.playTone({:toneProfile=>Settings.musicMarch});
        		beginning=false;
        	}
        	return;
        }
        else if(diff.value()<currentWave.time)
        {
        	var probability=Math.rand()%10000;
        	var enemy=currentWave.wave.produceEnemy(probability); 
        	if(enemy!=null)
        	{
        		//System.println("success enemy generated"+enemy);
        		var position=Moving.producePosition();
        		var biasPosition=Moving.producePosition();
        		enemy.position=position; //buba
        		enemy.bias=biasPosition;
        		me.enemies.add(enemy);
        	}
        }
         else if(diff.value()>currentWave.time+3 and me.enemies.size()<1)
        {
        	//drawWaveTitle(dc,centerX,centerY,"you survived");
        	dataTimer.stop();
        	Settings.STAGE+=1;
        	Settings.saveSettings();
        	Views.makeSummary();
        	//Views.makeAction();

        }
         
        
	//END OF PROTOTYPE TO CORRECT
	
	//NO ENEMIES SO INFERNO IS COOLED
        
        if(enemies.size()==0)
        {
        	Settings.INFERNO_AIMED=false;
    		Settings.INFERNO_HEAT=0;
        }
        
        
        fire.selectFire2();
        
        me.selectEnemies2(fire);
        
        me.drawEnemies(dc);
        
        drawFires2(dc,fire);

        
        var gun=Settings.guns[0];
        var pointer=[140,140];//calculatePointerPosition();
        //drawPointerRiffle(dc);
        Pointer.drawPointer(dc,gun,pointer);
        //var pointer=drawAutoPointer(dc);
        if(Settings.AUTOFIRECOUNTER>0)
		{
			Settings.AUTOFIRECOUNTER-=1;
		}
        
		if(Settings.AUTO_FIRE_STATUS and Settings.AUTOFIRECOUNTER<1)
			{
				fire.generateFire(pointer[0], pointer[1]);
				Settings.AUTOFIRECOUNTER=Settings.RELOAD;
			}
			
		updateTargets();
		
		//INFO CANAL
		var text=prepareInfo();
		dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);		
		dc.drawText(centerX, 10, 0,text, 1);
		
		//PROXIMITY
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		dc.drawCircle(centerX,centerX*2-30,10);
		
		if(enemies.size()>0)
		{
			var color=chooseColor(enemies[0].distance);
			dc.setColor(color, Graphics.COLOR_TRANSPARENT);
			dc.fillCircle(centerX,centerX*2-30,9);		
		}
		
		dc.setPenWidth(4);
		
		var healthBar=Settings.HEALTH/Settings.MAX_HEALTH*90;
		if (healthBar>0)
		{
			dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
			dc.drawArc(centerX, centerY, centerX-5,Graphics.ARC_CLOCKWISE, 225,225-healthBar);
		}
		
		var shieldBar=Settings.SHIELD/Settings.MAX_SHIELD*90;		
		if (shieldBar>0)
		{
			dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
			dc.drawArc(centerX, centerY, centerX-5,Graphics.ARC_COUNTER_CLOCKWISE, 315, 315+1+shieldBar);//45-shieldBar);
		}		
		
		dc.setPenWidth(1);

    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
    
    function gravityUpdate(){
    	var info=Sensor.getInfo();
    	if (info has :accel && info.accel != null){
    	gravity=info.accel;
    	forceX=gravity[0];
    	forceY=-gravity[1];
    	forceZ=gravity[2];}
    	WatchUi.requestUpdate();
    }
    
    function minGravity(number){
    	if(number>minimum)
    	{return number;}
    	return minimum;
    }
    
    function producePosition(){
    	while(true)
    	{
    		var xProp=Math.rand()%1000;
    		var yProp=Math.rand()%1000;
    		
    		var xx=centerX-1f*xProp/1000*(centerX*2);
    		var yy=centerY-1f*yProp/1000*(centerY*2);
    		
    		var radius=Math.sqrt(1f*xx*xx+yy*yy);
    		if (radius<centerX-9)
    		{
    			return [centerX+xx,centerY+yy];   //moze wyrownac floor
    		}
    	}
    }
    
    function isGenerated(probabilityEdge){ //as x/10000
    	var probability=Math.rand()%10000;
    	if(probability<probabilityEdge)
    	{
    		System.println("generate true");
    		return true;
    	}
    	else
    	{
    		return false;
    	}
    }
    	
    	function drawBackground(dc){
        	// Draw the pri
        	dc.drawBitmap(0, 0, background);
        	//dcR.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        	//dcR.fillCircle(center[0], center[1], center[0]/1.2);
        }
        
        function drawWaveTitle(dc,X,Y,text){
        	var dcR=dc;
        	dcR.drawText(X, Y-10 , Graphics.FONT_MEDIUM, text,Graphics.TEXT_JUSTIFY_CENTER);
        }
        
        public function selectEnemies(fires){
    	
    	var veryNow=[];
    	//var keys=fires.keys();
    	for(var i=0;i<me.enemies.size();i++)
    	{
    		var enemy=me.enemies[i];
    		var speed=enemy.speed;
    		var distance=enemy.distance;
    		var endurance=enemy.endurance;
    		var size=enemy.size;
    		var eneX=enemy.position[0];
    		var eneY=enemy.position[1];
    		//System.println("fires item: "+i+"  "+keys[0]+"  "+current);
    		
    		if (enemy!=null)
    		{
    			
    			for(var j=0;j<fire.fires.size();j++)
    			{
    				var keys=fire.fires[j].keys();
    				var current=fire.fires[j].get(keys[0]);
    				var fireX=keys[0][1];
    				var fireY=keys[0][2];
    				var fireDistance=current[0];
    				
    				if(enemy.type!=10 and checkDistance(speed,distance,Fire.fireSpeed,fireDistance) and checkPosition(eneX,eneY,fireX,fireY,distance,size))
    				{
    					
    					System.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    					Attention.playTone(1);
    					fire.fires[j].put(keys[0],[-1000,false]);
    					enemy.endurance-=1;
    					if(enemy.endurance<1)
    					{
    						enemy.type=10;
    						enemy.speed=5;
    						enemy.size*=3;
    						enemy.endurance=5;
    					}
    				}
    				
    			}
    			
    			
    			if (enemy.distance<100 and enemy.endurance>0)//fireSpeed+1)
    			{
    				enemy.distance+=enemy.speed;
    				veryNow.add(enemy);
    			}
    			else if (enemy.endurance>0 and enemy.type!=10)
    			{
    				Attention.vibrate(Settings.vibeCollision);
    			}
    			
    		}    		
    	}
    	me.enemies=[];
    	me.enemies.addAll(veryNow);
    	//fires.addAll(firesWaiting);//.slice(0,-1);
    	//firesWaiting=[];
    	//fires.addAll(veryNow);//.slice(0,-1));
    }
    
    public function selectEnemies2(fires){
    	
    	var infernoCounter=0;
    	var veryNow=[];
    	//var keys=fires.keys();
    	for(var i=0;i<me.enemies.size();i++)
    	{
    		var enemy=me.enemies[i];
    		var speed=enemy.speed;
    		var distance=enemy.distance;
    		var endurance=enemy.endurance;
    		var size=enemy.size;
    		var eneX=enemy.position[0];
    		var eneY=enemy.position[1];
    		//System.println("fires item: "+i+"  "+keys[0]+"  "+current);
    		
    		if (enemy!=null)
    		{
    			
    			for(var j=0;j<fire.fires.size();j++)
    			{
    				var currentFire=fire.fires[j];//buba
    				//var keys=fire.fires[j].keys();
    				//var current=fire.fires[j].get(keys[0]);
    				//var fireX=keys[0][1]; //x
    				var fireX=currentFire.get("xLoc");
    				//var fireY=keys[0][2];  //y
    				var fireY=currentFire.get("yLoc");
    				//var fireDistance=current[0];//distance
    				var fireDistance=currentFire.get("distance");
    				var fireSpeed=Settings.weapons.get(currentFire.get("gun")).get("speed"); 
    				
    				if(enemy.type!=10)
    				{
    					 if(currentFire.get("gun").equals("inferno"))// and checkPosition(eneX,eneY,pointX,pointY,distance,size)) //and check distance
    					 {
    					 ///// inny damage  counter?????
    					 	System.println("really inferno");
    					 	//var point=calculatePointerPosition();
    					 	if(Settings.INFERNO_AIMED==false)
    					 	{
    					 		currentFire.put("active",false);
    					 		//System.println("inferno false");
    					 	}
    					 	else if(checkPosition(eneX,eneY,actualX[0],actualY[0],distance,size))
    					 	{
    					 		infernoCounter+=1;
    					 		enemy.endurance-=Settings.INFERNO_HEAT;
    					 		//Attention.playTone({:toneProfile=>Settings.soundRiffle}); /// CZASOWO ZEBY TESTOWAC WARUNEK
    					 		System.println("inferno heat: "+Settings.INFERNO_HEAT);
    					 	}
    					 	else
    					 	{
    					 		System.println("inferno true");
    					 	}
    					 	//VIBE,SOUND???
    					 }
    				
    					else if(checkDistance(speed,distance,fireSpeed,fireDistance) and checkPosition(eneX,eneY,fireX,fireY,distance,size))
    					{
    					
    						System.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    						Attention.playTone(1);
    						//fire.fires[j].put(keys[0],[-1000,false]);   //wystarczy w nowej wersji zmienic "active"
    						currentFire.put("active",false);
    						var damage=Settings.weapons.get(currentFire.get("gun")).get("power"); 
    						enemy.endurance-=damage;
    						if(enemy.endurance>0)
    						{
    							Settings.INFO.add(["hit " +damage.format("%+.2f"),Settings.INFO_TIME]);
    							Settings.INFO.add([enemy.endurance.format("%+.2f")+" left",Settings.INFO_TIME]);	 
    						}					
    					}
    				
    					if(enemy.endurance<=0)
    					{
    						enemy.type=10;
    						enemy.speed=5; 
    						enemy.size*=3;
    						enemy.endurance=5;
    						Settings.INFO.add(["+ 10 POINTS",Settings.INFO_TIME]);
    						Settings.SCORE+=10;
    						Settings.MONEY+=10;
    					} 				
    				}
    			}
    			
    			if (enemy.distance<100 and enemy.endurance>0)//fireSpeed+1)
    			{
    				enemy.distance+=enemy.speed;
    				//HERE MODIFY POSITION
    				
    				var newPosition=Moving.Lining(eneX, eneY, enemy.bias[0], enemy.bias[1], 0.5);//buba
    				enemy.position[0]=newPosition[0];
    				enemy.position[1]=newPosition[1];
    				
    				veryNow.add(enemy);
    			}
    			else if(enemy.endurance>0 and enemy.type!=10)
    			{
    				Attention.vibrate(Settings.vibeCollision);
    				Settings.INFO.add(["COLLISION",Settings.INFO_TIME]);
    				modifyHS(enemy.endurance);
    			}
    			
    		}    		
    	}
    	me.enemies=[];
    	me.enemies.addAll(veryNow);
    	
    	if(infernoCounter>0)
    	{
    		Settings.INFERNO_HEAT*=Settings.weapons.get("inferno").get("increment");
    	}
    	else
    	{
    		Settings.INFERNO_AIMED=false;
    		Settings.INFERNO_HEAT=0;
    	}
    	
    	//fires.addAll(firesWaiting);//.slice(0,-1);
    	//firesWaiting=[];
    	//fires.addAll(veryNow);//.slice(0,-1));
    }
    
    function checkDistance(speedEnemy,distanceEnemy,fireSpeed,distanceFire){
    	if(distanceEnemy>distanceFire and (distanceEnemy-distanceFire)<(fireSpeed+speedEnemy+10))
    	{
    		//System.println("SPEED TRUE!!!");
    		return true;
    	}
    	else
    	{
    		return false;
    	}
    }
    
    function checkPosition(enemyX,enemyY,fireX,fireY,distanceEnemy,sizeEnemy){
    	var realSize=0.5f*sizeEnemy*(100/(1.0f*100+(100-distanceEnemy)));
    	var radius=Math.sqrt(1.0f*(enemyX-fireX)*(enemyX-fireX)+(enemyY-fireY)*(enemyY-fireY));
    	//System.println("distance enemy:"+distanceEnemy+" real size: "+realSize+" radius: "+radius);
    	
    	if(realSize>radius)
    	{
    		//System.println("DISTANCE TRUE!!!");
    		return true;
    	}
    	else
    	{
    		return false;
    	}
    	}
    	
    function updateTargets()
    	{
    		Settings.TARGETS=[];
    		var counter=0;
    		for(var i=0;i<enemies.size();i++)
    		{
    			if(counter>1)
    			{
    				break;
    			}
    			else if (enemies[i].type<10)
    			{
    				var xLoc=enemies[i].position[0];
    				var yLoc=enemies[i].position[1];
    				var distance=enemies[i].distance;
    				Settings.TARGETS.add([xLoc,yLoc,distance]);
    				counter+=1;
    			}
    		}
    		
    	}
	function prepareInfo()
		{
			if (Settings.INFO.size()==0)
			{
				return Settings.SCORE;
			}
			
			var counter=Settings.INFO[0][1];
			var text=Settings.INFO[0][0];
			
			if (counter>0)
			{
				Settings.INFO[0][1]-=1;
			}
			else
			{
				Settings.INFO=Settings.INFO.slice(1,null);
			}
			
			return text;
		}
		
	function chooseColor(distance)
		{
			if(distance>-50)
			{
				return Graphics.COLOR_RED;
			}
			else if(distance>-200)
			{
				return Graphics.COLOR_PINK;
			}
			else if(distance>-350)
			{
				return Graphics.COLOR_YELLOW;
			}
			else
			{
				return Graphics.COLOR_WHITE;
			}
		}
		
	function modifyHS(endurance)
		{
			var damage=endurance;
			
			if (Settings.SHIELD>0)
			{
				if(Settings.SHIELD>damage)
				{
					Settings.SHIELD-=damage;
					Settings.INFO.add(["SHIELD LEFT "+Settings.SHIELD.format("%+.2f"),Settings.INFO_TIME]);
					return;
				}
				else
				{
					damage-=Settings.SHIELD;
					Settings.INFO.add(["SHIELD DESTROYED",Settings.INFO_TIME]);
					Settings.SHIELD=0;
				}
			}
			
			Settings.HEALTH-=damage;
			Settings.INFO.add(["HEALTH LEFT "+Settings.HEALTH.format("%+.2f"),Settings.INFO_TIME]);
			if(Settings.HEALTH<0)
			{
				Settings.HEALTH=0;
			}
		}
    	


}
