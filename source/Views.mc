import Toybox.WatchUi;
import Toybox.System;
import Toybox.Application.Storage;

module Views{

	///VIEWS
	
	class StartView extends WatchUi.View {

    	function initialize() 
    	{
        	View.initialize();
    	}

    	// Load your resources here
    	function onLayout(dc as Dc) as Void 
    	{    
        	setLayout(Rez.Layouts.MainLayout(dc));       	
        }

    	// Called when this View is brought to the foreground. Restore
    	// the state of this View and prepare it to be shown. This includes
    	// loading resources into memory.
    	function onShow() as Void 
    	{
    	
    	}

    	// Update the view
    	function onUpdate(dc as Dc) as Void 
    	{
        	// Call the parent onUpdate function to redraw the layout
        	View.onUpdate(dc);
 		}

    	// Called when this View is removed from the screen. Save the
    	// state of this View here. This includes freeing resources from
    	// memory.
    	function onHide() as Void 
    	{
    
    	}

	}
	
	class DeadView extends WatchUi.View {

    	function initialize() 
    	{
        	View.initialize();
    	}

    	// Load your resources here
    	function onLayout(dc as Dc) as Void 
    	{    
        	setLayout(Rez.Layouts.DeadLayout(dc));       	
        }

    	// Called when this View is brought to the foreground. Restore
    	// the state of this View and prepare it to be shown. This includes
    	// loading resources into memory.
    	function onShow() as Void 
    	{
    	
    	}

    	// Update the view
    	function onUpdate(dc as Dc) as Void 
    	{
        	// Call the parent onUpdate function to redraw the layout
        	View.onUpdate(dc);
 		}

    	// Called when this View is removed from the screen. Save the
    	// state of this View here. This includes freeing resources from
    	// memory.
    	function onHide() as Void 
    	{
    
    	}

	}
	
	class PilotView extends WatchUi.View {

    	function initialize() {
        	View.initialize();
    	}

    	function onLayout(dc as Dc) as Void {
    
        	setLayout(Rez.Layouts.PilotLayout(dc));
        
    	}

    	function onShow() as Void {
    	}

    	function onUpdate(dc as Dc) as Void {
    
        	View.onUpdate(dc);
    	}

    	function onHide() as Void {
    	}
	}
	
	//FUNCTIONS
	
	function makeStart()
	{
		var view= new StartView();
		var delegate = new Delegates.StartDelegate();
		WatchUi.switchToView(view,delegate,WatchUi.SLIDE_IMMEDIATE);
	}
	
	function makeDead()
	{
		var view= new DeadView();
		var delegate = new Delegates.DeadDelegate();
		WatchUi.switchToView(view,delegate,WatchUi.SLIDE_IMMEDIATE);
		
	}
	
	function makeUpgrades()
	{
		var items=Settings.generateUpgrades();
		var menu= new WatchUi.Menu2({:title=>"UPGRADES"});
        Settings.addUpgrades(menu,items);
        var delegate=new Delegates.UpgradesDelegate();       	
        WatchUi.switchToView(menu,delegate,WatchUi.SLIDE_IMMEDIATE);
	}
	
	function makeGame()
	{
		var fire=new Fire();
    	var view=new SpaceshipView(fire);
    	var delegate=new SpaceshipDelegate(fire,view);
    	WatchUi.switchToView(view,delegate,WatchUi.SLIDE_IMMEDIATE);
	}
	
	function makeConfirmation()
	{
		var message = "Erase current game?";
		var dialog = new WatchUi.Confirmation(message);
		WatchUi.switchToView(dialog,new Delegates.NewGameConfirmationDelegate(),WatchUi.SLIDE_IMMEDIATE);
	}
	
	function makeAction()
	{
		var menu = new WatchUi.Menu2({:title=>"ACTION"});
        var delegate = new Delegates.ActionDelegate(); 
        generateMenus(menu);
        WatchUi.switchToView(menu,delegate,  WatchUi.SLIDE_DOWN);
	}
	
	function makeSettings()
	{
		var menu = new WatchUi.Menu2({:title=>"SETTINGS"});
        var delegate = new Delegates.SettingsDelegate(); 
        menu.addItem(
            new WatchUi.MenuItem(
                "CHANGE NAME",
                "new pilot name",
                "changenameId",
                {}
            )
            );
        WatchUi.switchToView(menu,delegate,  WatchUi.SLIDE_DOWN);
	}
	
	function makeSummary()
	{
		var menu = new WatchUi.Menu2({:title=>"YOU SURVIVED!"});
        var delegate = new Delegates.SummaryDelegate(); 
        
        var scoresInfo=Settings.SCORE.toString();
        var moneyInfo=Settings.MONEY.toString();
        var healthInfo=Settings.HEALTH.format("%.2f").toString();
        var shieldInfo=Settings.SHIELD.format("%.2f").toString();
        
        menu.addItem(
            new WatchUi.MenuItem(
                "SCORES",
                scoresInfo,
                "scoresId",
                {}
            )
            );
        menu.addItem(
            new WatchUi.MenuItem(
                "MONEY",
                moneyInfo,
                "moneyId",
                {}
            )
            );
        menu.addItem(
            new WatchUi.MenuItem(
                "HEALTH",
                healthInfo,
                "healthId",
                {}
            )
            );
        menu.addItem(
            new WatchUi.MenuItem(
                "SHIELD",
                shieldInfo,
                "shieldId",
                {}
            )
            );
        WatchUi.switchToView(menu,delegate,  WatchUi.SLIDE_DOWN);
	}
	
	function makeHighscores()
	{
		var menu = new WatchUi.Menu2({:title=>"HIGHSCORES"});
        var delegate = new Delegates.HighscoresDelegate(); 
        generateHighscores(menu);
        WatchUi.switchToView(menu,delegate,  WatchUi.SLIDE_DOWN);
	}
	
	function makePilot()
	{
		WatchUi.switchToView(
                    new Views.PilotView(),
                    new Delegates.PilotDelegate(),
                    WatchUi.SLIDE_DOWN
                );
	}
	
	function makePicker()
	{
		var name=Storage.getValue("NAME");
		if(name==null)
		{
			name="";
		}
		WatchUi.switchToView(
                    new WatchUi.TextPicker(name),
                    new Delegates.MyTextPickerDelegate(),
                    WatchUi.SLIDE_DOWN);
	}
	
	function generateMenus(menu)
    {
    	
    	if(Storage.getValue("INPROGRESS"))
    	{
    		menu.addItem(
            	new WatchUi.MenuItem(
                	"CONTINUE",
                	"continue current game",
                	"continueId",
                	{}
            	)
        	);
        }
        
        var upgrades=Settings.generateUpgrades();
        System.println("money: "+Settings.MONEY);
        System.println("nr of upgrades:"+upgrades.size());
        
        if(upgrades.size()>0)
        {
        	menu.addItem(
            new WatchUi.MenuItem(
                "UPGRADES",
                "new upgrades available",
                "upgradesId",
                {}
            )
            );
        }
        
        menu.addItem(
            new WatchUi.MenuItem(
                "NEW GAME",
                "start new game",
                "newgameId",
                {}
            )
        );

        if(Settings.scores!=null and Settings.scores.size()>0)
            {
        		menu.addItem(           
            			new WatchUi.MenuItem(
                	"HIGHSCORES",
                	"your best games",
                	"highscoresId",
                	{}
            		)          
        			);
        	}
        	
        menu.addItem(
            new WatchUi.MenuItem(
                "HALL OF FAME",
                "best players",
                "halloffameId",
                {}
            )
        );
        menu.addItem(
            new WatchUi.MenuItem(
                "SETTINGS",
                "change settings",
                "settingsId",
                {}
            )
        );
        menu.addItem(
            new WatchUi.MenuItem(
                "QUIT",
                "quit this war",
                "quitId",
                {}
            )
        );
    }
    
    function generateHighscores(menu)
    {
    	
    	for(var i=0;i<Settings.scores.size();i++)
    	{
    		var scores=Settings.scores;//Storage.getValue("scores");

    		var player=scores[i][0];
    		var score=scores[i][1].toString();
    		var mainText=(i+1)+". "+player;
    		
    		menu.addItem(
            	new WatchUi.MenuItem(
                	mainText,
                	score,
                	mainText,
                	{}
            	)
        	);
    	}
    }

}