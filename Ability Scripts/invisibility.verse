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

invisibility := class(creative_device):

    @editable
    CardDetector: conditional_button_device = conditional_button_device{}

    OnBegin<override>()<suspends>:void=
        Print("@GrinernCreates Script Started")
        spawn:
            CheckForKeycard()

    CheckForKeycard()<suspends>:void=
        loop:
           Sleep(0.5)
           AllPlayers:=GetPlayspace().GetPlayers()
           for(Player:AllPlayers):
               if(Agent:agent = agent[Player]):
                   if(CardDetector.IsHoldingItem[Agent]):
                       Print("Hiding player")
                       HidePlayer(Agent)
                   else:
                       Print("Player is shown")
                       ShowPlayer(Agent)
    
    ShowPlayer(Agent:agent):void=
       if(FortCharacter:=Agent.GetFortCharacter[]):
        FortCharacter.Show()
    
    HidePlayer(Agent:agent):void=
       if(FortCharacter:=Agent.GetFortCharacter[]):
        FortCharacter.Hide()