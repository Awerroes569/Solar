import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application.Storage;
import Toybox.System;

module Delegates{


class DeadDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }
     
     function onSelect() {

     	Settings.insertHighscore(Settings.SCORE);
     	Settings.resetSettings();
     	Views.makeStart();
    }
    
    function onBack() as Boolean
    {
    	return true;
    }
    

}

class StartDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onBack() as Boolean
    {
    	return true;
    }
    
    function onSelect() as Boolean {
        
        if(Storage.getValue("NAME")==null)
        {
           Views.makePilot();
        }
        else
        {
        	Views.makeAction();        
        }
    }
    
    }
    
class PilotDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }
     
     function onSelect() {

     	Views.makePicker();
    }
    
    function onBack() as Boolean
    {
    	return true;
    }
    

}

class SummaryDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
         Menu2InputDelegate.initialize();
    }
     
     function onSelect(item) {

     	Views.makeAction();
    }
    
    function onBack() as Boolean
    {
    	return true;
    }
    

}

class ActionDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }
     
     function onSelect(item) {
     
     	var id=item.getId();
        System.println(id);
        if (id.equals("newgameId"))
        {
        	if (Storage.getValue("INPROGRESS"))
        	{
        		Views.makeConfirmation();
			}
			else
			{
				//TO CHANGE: NOW TO "ACTION MENU"
				Views.makeGame();
			}
			
			
        }
        
        if(id.equals("upgradesId"))
        {
        	System.println("confirm inside upgrades");
        	var menu= new WatchUi.Menu2({:title=>"UPGRADES"});
        	var items=Settings.generateUpgrades();
        	Settings.addUpgrades(menu,items);
        	var delegate=new UpgradesDelegate();
        	
        	WatchUi.switchToView(menu,delegate,WatchUi.SLIDE_IMMEDIATE);
        }
        
        if(id.equals("highscoresId"))
        {
        	Views.makeHighscores();
        }
        
         if(id.equals("continueId"))
        {
        	Views.makeGame();
        }
        
        if(id.equals("quitId"))
        {
        	Settings.saveSettings();
        	System.exit();
        }
        
        if(id.equals("settingsId"))
        {
        	Views.makeSettings();
        }
    }
    
    function onBack()
    {
    	System.println("onBack Menu2 pressed");
    	return true;
    }
    

}

class SettingsDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }
     
     function onSelect(item) {
     
     	var id=item.getId();
        System.println(id);
        if (id.equals("changenameId"))
        {
        	Views.makePilot();					
        }
        
        }
           
    function onBack()
    {
    	System.println("onBack Menu2 pressed");
    	Views.makeAction();
    	return true;
    }
    

}


class HighscoresDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }
     
     function onSelect(item) {
     
     	Views.makeAction();
			
        }
        
    function onBack()
    {
    	System.println("onBack Menu2 pressed");
    	return true;
    }
    

}

class NewGameConfirmationDelegate extends WatchUi.ConfirmationDelegate {
    function initialize() {
        ConfirmationDelegate.initialize();
    }

    function onResponse(response) {
        if (response == WatchUi.CONFIRM_NO) {
            System.println("Cancel");
            Views.makeAction();
        } else if (response == WatchUi.CONFIRM_YES){
            System.println("Confirm");
            Settings.STAGE=0;
            Views.makeGame();
        }
    }
    
    function onBack()
    {
    	return true;
    }
}

class MyTextPickerDelegate extends WatchUi.TextPickerDelegate {

    function initialize() {
        TextPickerDelegate.initialize();
    }

    function onTextEntered(text, changed) {
        Settings.NAME=text;
        Storage.setValue("NAME", text);
        System.println("NAME: "+Settings.NAME);
		Views.makeAction();
    }

    function onCancel() {
    }
}

class UpgradesDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }
     
     function onSelect(item) {
     
     	var id=item.getId();
     	
     	System.println("Main item: "+id[0]);
     	System.println("Second item: "+id[1]);
     	
     	Settings.applyUpgrade(id[0],id[1]);
     	
        	var items=Settings.generateUpgrades();
        	if(items.size()>0)
        	{
     			Views.makeUpgrades();
        	}
        	else
        	{
        		Views.makeAction();
        	}
    }
    
    function onBack()
    {
    	Views.makeAction();
    }
    

}

}