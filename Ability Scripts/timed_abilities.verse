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

timed_abilities := class(creative_device):

    @editable
    DefaultClass: class_and_team_selector_device = class_and_team_selector_device{}
    
    # I'm going to use an example in this script. However in you could implement this into mostly anything.
    # In this example we will use a "double damage" ability.

    # How this works is based on classes. So whenever a button event happens it subscribes to the ability then a timer also starts. 
    # When that timer is then done it will go back to the default class.


    OnBegin<override>()<suspends>:void=
        # Subscribe all DamageButtons to DamageActivated
        for (Button : DamageButtons):
            Button.ActivatedEvent.Subscribe(DamageActivated)

        DamageTimer.SuccessEvent.Subscribe(Default)

    Default(Agent:?agent):void=
        if (ActualAgent := Agent?):
            DefaultClass.ChangeClass(ActualAgent)

    
    # :------------ THIS IS THE PART YOU CAN "CHANGE" TO YOUR LIKEING ------------:
            
    @editable
    DamageButtons: []conditional_button_device = array{conditional_button_device{} , conditional_button_device{} ,conditional_button_device{} ,conditional_button_device{}}

    @editable
    DamageTimer: timer_device = timer_device{}

    @editable
    DamageHud: hud_message_device = hud_message_device{}

    @editable
    Damage: damage_amplifier_powerup_device = damage_amplifier_powerup_device {}

    DamageActivated(Agent:agent):void=
        Damage.Pickup(Agent)
        DamageHud.Show(Agent)
        DamageTimer.Start(Agent)