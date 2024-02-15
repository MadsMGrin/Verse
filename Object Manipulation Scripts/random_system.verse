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

random_event := class(creative_device):
 
    @editable
    ConditionalButton: conditional_button_device = conditional_button_device{}
 
    @editable
    Event1: cinematic_sequence_device = cinematic_sequence_device{}
 
    @editable
    Event2: cinematic_sequence_device = cinematic_sequence_device{}
 
    @editable
    Event3: cinematic_sequence_device = cinematic_sequence_device{}
 
    @editable
    Event4: cinematic_sequence_device = cinematic_sequence_device{}
 
    @editable
    Event5: cinematic_sequence_device = cinematic_sequence_device{}
 
    @editable
    Timer1: timer_device = timer_device{}
 
    @editable
    Timer2: timer_device = timer_device{}
 
    @editable
    Timer3: timer_device = timer_device{}
 
    @editable
    Timer4: timer_device = timer_device{}
 
    @editable
    Timer5: timer_device = timer_device{}

    OnBegin<override>()<suspends >:void=
        Print("@GrinernCreates Script Started")
        ConditionalButton.ActivatedEvent.Subscribe(OnButtonClick)
 
    OnButtonClick(Agent:agent):void=
        spawn:
            ConditionalButtonActivated(Agent)
 
    ConditionalButtonActivated(Agent:agent)<suspends>:void=
        var RandomEvent:int = GetRandomInt(1, 5)

        #Could use cases instead (This is one of the oldest scripts I made)
        if (RandomEvent = 1):
            Event1.Play()
            ConditionalButton.Disable()
            Print("Event 1 playing")
            Timer1.Start()
            Sleep(120.0)
            Event1.GoToEndAndStop()
            ConditionalButton.Enable()
 
        else if (RandomEvent = 2):
            Event2.Play()
            ConditionalButton.Disable()
            Print("Event 2 playing")
            Timer2.Start()
            Sleep(120.0)
            Event2.GoToEndAndStop()
            ConditionalButton.Enable()
 
        else if (RandomEvent = 3):
            Event3.Play()
            ConditionalButton.Disable()
            Print("Event 3 playing")
            Timer3.Start()
            Sleep(120.0)
            Event3.GoToEndAndStop()
            ConditionalButton.Enable()
 
        else if (RandomEvent = 4):
            Event4.Play()
            ConditionalButton.Disable()
            Print("Event 4 playing")
            Timer4.Start()
            Sleep(120.0)
            Event4.GoToEndAndStop()
            ConditionalButton.Enable()
 
        else if (RandomEvent = 5):
            Event5.Play()
            ConditionalButton.Disable()
            Print("Event 5 playing")
            Timer5.Start()
            Sleep(120.0)
            Event5.GoToEndAndStop()
            ConditionalButton.Enable()