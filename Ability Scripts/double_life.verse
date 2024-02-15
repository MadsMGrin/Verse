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

double_life := class(creative_device):

    @editable
    DoubleLife: down_but_not_out_device = down_but_not_out_device{}

    amountOfLives: int = 1

    OnBegin<override>()<suspends >:void=
        Print("@GrinernCreates Script Started")
        DoubleLife.AgentDownedEvent.Subscribe(DoubleLifeEvent)

    DoubleLifeEvent(Agent:agent):void=
        spawn:
            CheckForDoubleLife(Agent)
    
    CheckForDoubleLife(Agent:agent)<suspends>:void=
        if(amountOfLives >= 1):
            Sleep(1.0)
            DoubleLife.Revive(Agent)
            Print("Revived")
            Sleep(0.1)
            if (Player : fort_character = Agent.GetFortCharacter[]):
                Player.SetHealth(100.0)
                Player.SetShield(100.0)
            Print("Given health")
            if(amountOfLives = 0):
                DoubleLife.Disable
            amountOfLives - 1