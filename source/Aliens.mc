import Toybox.System;
import Toybox.Lang;
import Toybox.Time;

module Aliens{

class Enemy{

	public var type;
	public var size;
	public var speed;
	public var distance;
	public var endurance;
	public var quantity;
	public var bias;
	//private var biasY;
	//private var biasZ;
	public var rotation;
	public var position;

	function initialize(ty,si,sp,di,en,qu,bi,ro,po){
		type=ty;
		size=si;
		speed=sp;
		distance=di;
		endurance=en;
		quantity=qu;
		bias=bi;
		//biasY=bY;
		//biasZ=bZ;
		rotation=ro;
		position=po;
	}
}

class RealEnemy{

	public var probability;
	public var enemy;
	
	function initialize(pro,ene){
		probability=pro;
		enemy=ene;
	}

}

class Wave{   

	public var waveSpace=[];// as Lang.Array<Aliens.RealEnemy>;
	
	function initalize(){
		waveSpace=[];
	}
	
	function addEnemy(newEnemy as Aliens.RealEnemy){
		var lenght=me.waveSpace.size();
		if(lenght<1)
		{
			me.waveSpace.add(newEnemy);
		}
		else
		{
			var lastEne=waveSpace[lenght-1];
			System.println("new enemy prob: "+newEnemy.probability);
			var newProb=lastEne.probability+newEnemy.probability;
			var modEnemy=new RealEnemy(newProb,newEnemy.enemy);
			me.waveSpace.add(modEnemy);
		}
	}
	
	function produceEnemy(probability){
		var lenght=me.waveSpace.size();
		for(var i=0;i<lenght;i++)
		{
			if(me.waveSpace[i].probability>probability)
			{
				//return waveSpace[i].enemy;
				var current=waveSpace[i].enemy;
				var type=current.type;
				var size=current.size;
				var speed=current.speed;
				var distance=current.distance;
				var endurance=current.endurance;
				var quantity=current.quantity;
				var bias=current.bias;
				var rotation=current.rotation;
				var position=current.position;
				return new Enemy(type,size,speed,distance,endurance,quantity,bias,rotation,position);				
			}
		}
		return null;
	
	}
}

class Wave1{

	public var waveSpace=[];// as Lang.Array<Aliens.RealEnemy>;
	
	function initalize(space){
		waveSpace=space;
	}
	
	function addEnemy(newEnemy as Aliens.RealEnemy){
		var lenght=me.waveSpace.size();
		if(lenght<1)
		{
			me.waveSpace.add(newEnemy);
		}
		else
		{
			var lastEne=waveSpace[lenght-1];
			System.println("new enemy prob: "+newEnemy.probability);
			var newProb=lastEne.probability+newEnemy.probability;
			var modEnemy=new RealEnemy(newProb,newEnemy.enemy);
			me.waveSpace.add(modEnemy);
		}
	}
	
	function produceEnemy(probability){
		var lenght=me.waveSpace.size();
		for(var i=0;i<lenght;i++)
		{
			if(me.waveSpace[i].probability>probability)
			{
				//return waveSpace[i].enemy;
				var current=waveSpace[i].enemy;
				var type=current.type;
				var size=current.size;
				var speed=current.speed;
				var distance=current.distance;
				var endurance=current.endurance;
				var quantity=current.quantity;
				var bias=current.bias;
				var rotation=current.rotation;
				var position=current.position;
				return new Enemy(type,size,speed,distance,endurance,quantity,bias,rotation,position);
				
			}
		}
		return null;
	
	}
}
	
class RealWave{

	public var time;
	public var wave;
	public var text;
	
	function initialize(tim,wav,tex){
		time=tim;
		wave=wav;	
		text=tex;
	}
}

class Stage{
	private var text;
	public var stageSpace=[];
	
	function initialize(tex){
		text=tex;
		stageSpace=[];
	}
	
	
}

//[80,[[100,[0,120,5,-1000,1.0f,1,[1,0,0],0,[0,0]]]],"first encounter"]

function makeRealWave(data)
{
	var time=data[0];
	var preRealEnemy=data[1];
	var text=data[2];
	
	var wave= new Wave();
	
	for(var i=0;i<preRealEnemy.size();i++)
	{
		var probability=preRealEnemy[i][0];
		
		var type=preRealEnemy[i][1][0];
		var size=preRealEnemy[i][1][1];
		var speed=preRealEnemy[i][1][2];
		var distance=preRealEnemy[i][1][3];
		var endurance=preRealEnemy[i][1][4];
		var quantity=preRealEnemy[i][1][5];
		var bias=preRealEnemy[i][1][6];
		var rotation=preRealEnemy[i][1][7];
		var position=preRealEnemy[i][1][8];
		
		var enemy= new Enemy(type,size,speed,distance,endurance,quantity,bias,rotation,position);
		var realenemy= new RealEnemy(probability,enemy);
		
		wave.addEnemy(realenemy);
	}
	
	return new RealWave(time,wave,text);
}
}