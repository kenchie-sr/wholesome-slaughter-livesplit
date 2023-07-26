// Wholesome Slaughter Autosplitter
// Created by KinzyKenzie
// With help from rythin_sr
// Powered by just-ero

state( "Wholesome Slaughter" ) {}

startup {
    Assembly.Load( File.ReadAllBytes("Components/asl-help" ) ).CreateInstance( "Unity" );
    vars.Helper.GameName = "Wholesome Slaughter";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();
    
    vars.SceneNames = new List<String> {
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
    return( current.activeScene == "loading screen" && old.activeScene == "main menu" );
}

reset {
    return( current.activeScene == "MainMenuLoadScreen" && old.activeScene != current.activeScene );
}

split {
    if( current.activeScene != old.activeScene &&
		current.activeScene.Contains( "LoadScreen" ) && vars.SceneNames.Contains( old.activeScene ) )
        return true;
	
    if( current.loadingScene == "credits" )
		return true;
	
	return false;
}

isLoading {
    return( current.activeScene.ToLower().Contains( "load" ) );
}
