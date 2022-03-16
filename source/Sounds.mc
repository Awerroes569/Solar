import Toybox.Lang;
import Toybox.Time;
import Toybox.Attention;

module Sounds{
    	
    	var soundRiffle=[
        new Attention.ToneProfile( 1100, 15),
        new Attention.ToneProfile( 900, 25),
        new Attention.ToneProfile(700, 35),
        new Attention.ToneProfile( 500, 45),
        new Attention.ToneProfile( 300, 55),
    	];
    	var vibeRiffle=[
        new Attention.VibeProfile(30, 20),
        new Attention.VibeProfile(20, 15),
        new Attention.VibeProfile(10, 10)
    	];
    
    	var soundHunter=[
        new Attention.ToneProfile( 300, 55),
        new Attention.ToneProfile( 500, 45),
        new Attention.ToneProfile(700, 35),
        new Attention.ToneProfile( 900, 25),
        new Attention.ToneProfile( 1100, 15),
    	];
    	var vibeHunter=[
        new Attention.VibeProfile(50, 30),
        new Attention.VibeProfile(10, 20),
        new Attention.VibeProfile(50, 30)
    	];
    	
    	var soundLaser=[
        new Attention.ToneProfile( 1000, 75),
        new Attention.ToneProfile( 700, 40),
    	];
    	var vibeLaser=[
        new Attention.VibeProfile(20, 20),
    	];
    	
    	var soundInferno=[
        new Attention.ToneProfile( 500, 35),
        new Attention.ToneProfile( 400, 75),
        new Attention.ToneProfile(300, 115),

    	];
    	var vibeInferno=[
        new Attention.VibeProfile(10, 100),
    	];
    	
    	var SOUNDS=
    		{
    			0=>soundRiffle,
    			1=>soundHunter,
    			2=>soundLaser,
    			3=>soundInferno
    		};
    		
    	var VIBES=
    		{
    			0=>vibeRiffle,
    			1=>vibeHunter,
    			2=>vibeLaser,
    			3=>vibeInferno
    		};
}


