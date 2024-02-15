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

object_follow_player := class(creative_device):

    # Change this to the object (Could legit be anything.)
    @editable
    ObjectToMove: button_device = button_device{}

    @editable
    smoothFactor: float = 0.20
 
    # Could change this to be another way of triggering.
    @editable
    SpecificPlayerSpawner: player_spawner_device = player_spawner_device{}
 
    var Agents : []agent = array{}
    OnBegin<override>()<suspends>:void=
        Print("@GrinernCreates Script Started")
        SpecificPlayerSpawner.SpawnedEvent.Subscribe(SpawnEvent)
 
    MoveObjectV2(Agent : agent)<suspends> : void =
        if (InitialCharacter : fort_character = Agent.GetFortCharacter[]):
            PlayerPosition := InitialCharacter.GetTransform().Translation
 
            loop:
                var targetX: float = PlayerPosition.X
                var targetY: float = PlayerPosition.Y
                var targetZ: float = PlayerPosition.Z
                var ObjectToMoveXform : float = ObjectToMove.GetTransform().Translation.X
                var ObjectToMoveYform : float = ObjectToMove.GetTransform().Translation.Y
                var ObjectToMoveZform : float = ObjectToMove.GetTransform().Translation.Z
 
                var newObjectToMoveZ: float = ObjectToMoveZform + (targetZ - ObjectToMoveZform) * smoothFactor
 
                Arrived := race:
                    block:
                        ObjectToMove.MoveTo(vector3{X:= targetX, Y:=targetY, Z:= newObjectToMoveZ}, MakeRotationFromYawPitchRollDegrees(0.00, 0.00, 0.00), 0.2)
                        true
                    block:
                        Sleep(0.25)
                        set ObjectToMoveXform = ObjectToMove.GetTransform().Translation.X
                        set ObjectToMoveYform = ObjectToMove.GetTransform().Translation.Y
                        set ObjectToMoveZform = ObjectToMove.GetTransform().Translation.Z
                        false
                if(not Arrived?, ObjectToMove.TeleportTo[vector3{X:= ObjectToMoveXform, Y:= ObjectToMoveYform, Z:= ObjectToMoveZform},MakeRotationFromYawPitchRollDegrees(0.00, 0.00, 0.00)]):
                    Sleep(0.0)
                    Sleep(0.0)
                else:
                    break
 
    FollowCharacter(Agent:agent)<suspends>:void = 
        loop:
            MoveObjectV2(Agent)
 
    SpawnEvent(Agent:agent):void =
        spawn:
            FollowCharacter(Agent)