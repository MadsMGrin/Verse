using { /Fortnite.com/Characters }
using { /Fortnite.com/UI }
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Colors }
using { /Verse.org/Random }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI }
using { /Fortnite.com/Game }

#    _______ .______    __  .__   __.  _______ .______   .__   __.     ______ .______    _______     ___   .___________. _______     _____.
#   /  _____||   _  \  |  | |  \ |  | |   ____||   _  \  |  \ |  |    /      ||   _  \  |   ____|   /   \  |           ||   ____|   /     |
#  |  |  __  |  |_)  | |  | |   \|  | |  |__   |  |_)  | |   \|  |   |  ,----'|  |_)  | |  |__     /  ^  \ `---|  |----`|  |__     |   (--`
#  |  | |_ | |      /  |  | |  . `  | |   __|  |      /  |  . `  |   |  |     |      /  |   __|   /  /_\  \    |  |     |   __|     \   \  
#  |  |__| | |  |\  \-.|  | |  |\   | |  |____ |  |\  \-.|  |\   |   |  `----.|  |\  \-.|  |____ /  _____  \   |  |     |  |____  .--)   | 
#   \______| | _| `.__||__| |__| \__| |_______|| _| `.__||__| \__|    \______|| _| `.__||_______/__/     \__\  |__|     |_______| |_____/  
                                                                                                                                         
#Discord: @Grinern
#Twitter: @GrinernCreates
#Youtube: @GrinernCreates

underground_teleport := class(creative_device):

    #THIS SCRIPT REQUIRES ATLEAST SOME KNOWLEDGE OF VERSE (I WILL NOT ANSWER ANY QUESTIONS REGARDING THIS ONE OTHER THAN THE COMMENTS IN HERE.)

    @editable
    TeleportClass: class_and_team_selector_device = class_and_team_selector_device{}

    @editable
    TeleportSignalRemoteManager: signal_remote_manager_device = signal_remote_manager_device{}

    @editable
    DownTeleporter: teleporter_device = teleporter_device{}

    @editable
    UpTeleporter: teleporter_device = teleporter_device{}

    @editable
    DownTrigger: trigger_device = trigger_device{}

    @editable
    UpTrigger: trigger_device = trigger_device{}

    OnBegin<override>()<suspends>:void=
        Print("@GrinernCreates Script Started")
        #This part you could in theory make it so primary teleports down and secondary teleports up but you need to tweak the script a bit for that.
        TeleportSignalRemoteManager.PrimarySignalEvent.Subscribe(TeleportDownEvent)
        TeleportSignalRemoteManager.SecondarySignalEvent.Subscribe(TeleportDownEvent)
        #This part can be changed and tweaked (You need some sort of trigger to make the teleport follow the player).
        TeleportClass.ClassSwitchedEvent.Subscribe(TeleportFollowEvent)

    TeleportDownEvent(Agent:agent):void=
        spawn:
            TeleportDownActivated(Agent)

    TeleportFollowEvent(Agent:agent):void=
        spawn:
            TeleportFollow(Agent)

    MoveTeleport(Agent:agent)<suspends>:void=
        if (Player : fort_character = Agent.GetFortCharacter[]):
            ViewpointLocX := Player.GetViewLocation().X
            ViewpointLocY := Player.GetViewLocation().Y
            ViewpointLocZ := Player.GetViewLocation().Z
            ViewpointRot := Player.GetViewRotation()

            #This basically ensure that the teleporters are at the required location. (If you want to tweak specifically what height then change the Z for both of them).
            UpTeleporter.MoveTo(vector3{X:= ViewpointLocX, Y:= ViewpointLocY, Z:= 500.00}, rotation(ViewpointRot), 0.2)
            DownTeleporter.MoveTo(vector3{X:= ViewpointLocX, Y:= ViewpointLocY, Z:= 150.00}, rotation(ViewpointRot), 0.2)

    TeleportDownActivated(Agent:agent)<suspends>:void=
        #This is the part you in theory could change to make it that you have to press each trigger once to come up and down.

        #Currently it just teleports you back up from going underground after 10 seconds.
        DownTrigger.Trigger(Agent)
        Sleep(10.0)
        UpTrigger.Trigger(Agent)
    
    TeleportFollow(Agent: agent)<suspends>:void =
        #Ensures that the teleporters always follows the player.
        loop:
            MoveTeleport(Agent)