// Wholesome Slaughter Autosplitter
// Created by KinzyKenzie
// With help from rythin_sr
// Powered by just-ero

state( "Wholesome Slaughter" ) {}

startup {
    Assembly.Load( File.ReadAllBytes( "Components/asl-help" ) ).CreateInstance( "Unity" );
    vars.Helper.GameName = "Wholesome Slaughter";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();
    
	settings.Add( "newgame",  true,  "Start on New Game"  );
	settings.Add( "loadgame", false, "Start on Any Level" );
	settings.Add( "credits",  true,  "End on Credits"     );
	settings.Add( "levels",   true,  "Level Splitting"    );
	
	settings.CurrentDefaultParent = "levels";
	settings.Add( "Tutorial Level", true, "Tutorial" );
	settings.Add( "LevelOne",       true, "Level 1"  );
	settings.Add( "LevelTwo",       true, "Level 2"  );
	settings.Add( "LevelThree",     true, "Level 3"  );
	settings.Add( "LevelFour",      true, "Level 4"  );
	
    vars.LoadScenes = new List<String> {
        "loading screen",
        "LevelOneLoadScreen",
        "LevelTwoLoadScreen",
        "LevelThreeLoadScreen",
        "LevelFourLoadScreen"
    };
	
    vars.GameScenes = new List<String> {
        "Tutorial Level",
        "LevelOne",
        "LevelTwo",
        "LevelThree",
        "LevelFour"
    };
    
    vars.FinishedInitialLoad = false;
}

update {
    if( vars.FinishedInitialLoad ) {
        current.activeScene =  vars.Helper.Scenes.Active.Name == null ?
                               current.activeScene :
                               vars.Helper.Scenes.Active.Name;
        current.loadingScene = vars.Helper.Scenes.Loaded[0].Name == null ?
                               current.loadingScene :
                               vars.Helper.Scenes.Loaded[0].Name;
    } else {
        if( vars.Helper.Scenes.Count > 0 )
            vars.FinishedInitialLoad = true;
        else
			current.activeScene = "program start";
		
        return false;
    }
}

start {
	if( current.activeScene == "loading screen" && old.activeScene == "main menu" )
		return settings["newgame"];
	
	if( vars.GameScenes.Contains( current.activeScene ) && vars.LoadScenes.Contains( old.activeScene ) )
		return settings["loadgame"];
}

reset {
    return( current.activeScene == "MainMenuLoadScreen" && old.activeScene != current.activeScene );
}

split {
    if( vars.LoadScenes.Contains( current.activeScene ) && vars.GameScenes.Contains( old.activeScene ) )
        return settings[ old.activeScene ];
	
    if( current.loadingScene == "credits" )
		return settings["credits"];
	
	return false;
}

isLoading {
    return( vars.LoadScenes.Contains( current.activeScene ) );
}
