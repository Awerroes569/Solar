import Toybox.Application.Storage;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Application;

class SolarApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }
    

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    	
    	//Storage.deleteValue("NAME");
    	//Settings.resetSettings();
    	//Storage.setValue("NAME","Pupens"); //TO POLISH
    	//Settings.saveSettings();
    	//if true current game in progress   if false only new game to choos
    	Settings.scores=Storage.getValue("scores");
    	System.println("scoresy: "+Settings.scores);//+"  size: "+Settings.scores.size());
    	
    	if (Storage.getValue("INPROGRESS")==true)
    	{
    		System.println("in progress value: "+Storage.getValue("INPROGRESS")+Storage.getValue("NAME"));
    		Settings.loadSettings();
    		System.println("game in progress loaded");
    	}
    	else
    	{
    		Settings.resetSettings();
    		System.println("no game in progress");
    	}

    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }


    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new Views.StartView(), new Delegates.StartDelegate() ] as Array<Views or InputDelegates>;
    }

}

function getApp() as SolarApp {
    return Application.getApp() as SolarApp;
}