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

move_explosive_to_player := class(creative_device):

    @editable
    BombSignalRemoteManager: signal_remote_manager_device = signal_remote_manager_device{}

    @editable
    ExplosiveDevice: explosive_device = explosive_device{}

    OnBegin<override>()<suspends >:void=
        Print("@GrinernCreates Script Started")
        BombSignalRemoteManager.PrimarySignalEvent.Subscribe(BombEvent)
        BombSignalRemoteManager.SecondarySignalEvent.Subscribe(BombEvent)

    BombEvent(Agent:agent):void=
        spawn:
            BombActivated(Agent)

    MoveExplosive(Agent:agent)<suspends>:void=
        if (Player : fort_character = Agent.GetFortCharacter[]):
            ViewpointLoc := Player.GetViewLocation()
            ViewpointRot := Player.GetViewRotation()

            ExplosiveDevice.MoveTo(vector3(ViewpointLoc), rotation(ViewpointRot), 0.2)

    BombActivated(Agent:agent)<suspends>:void=
        MoveExplosive(Agent)
        ExplosiveDevice.Explode(Agent)
        Sleep(1.0)
        ExplosiveDevice.Reset()