using { /UnrealEngine.com/Temporary/Diagnostics }
 
log_class := class(log_channel){}
 
DebugUtil<public> := class<unique><concrete>():
 
    Logger : log = log{Channel := log_class}
 
    # Prints in your log ingame and has a "Debug:" before it
    Debug(String:string):void=
        Logger.Print("{String}", ?Level := log_level.Debug)
 
    # Prints both ingame and output log and acts like your normal Print() function
    Log(String:string):void=
        Logger.Print("{String}", ?Level := log_level.Normal)
 
    # Prints both ingame and output log, is yellow and has a "Warning:" before it
    Warning(String:string):void=
        Logger.Print("{String}", ?Level := log_level.Warning)
 
    # Prints both ingame and output log, is red and has a "Error:" before it
    Error(String:string):void=
        Logger.Print("{String}", ?Level := log_level.Error)