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

Template := class(creative_device):

    @editable
    FreezeButtons: []conditional_button_device = array{conditional_button_device{} , conditional_button_device{} ,conditional_button_device{} ,conditional_button_device{}}

    @editable
    FreezeClass: class_and_team_selector_device = class_and_team_selector_device{}

    @editable
    FreezeTimer: timer_device = timer_device{}

    @editable
    FreezeHud: hud_message_device = hud_message_device{}

    @editable
    FreezeDetector: conditional_button_device = conditional_button_device{}

    @editable 
    FreezeTime : float = 3.0

    @editable
    DefaultClass: class_and_team_selector_device = class_and_team_selector_device{}

    OnBegin<override>()<suspends>:void=
        Print("@GrinernCreates Script Started")
        GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerAdded)
        for (Player : GetPlayspace().GetPlayers(), FortCharacter := Player.GetFortCharacter[]):
            FortCharacter.DamagedEvent().Subscribe(OnPlayerDamaged)
            FortCharacter.DamagedShieldEvent().Subscribe(OnPlayerDamaged)

        FreezeTimer.SuccessEvent.Subscribe(Default)

        # Subscribe FreezeButtons to FreezeActivated
        for (Button : FreezeButtons):
            Button.ActivatedEvent.Subscribe(FreezeActivated)

    Default(Agent:?agent):void=
        if (ActualAgent := Agent?):
            DefaultClass.ChangeClass(ActualAgent)

    FreezeActivated(Agent:agent):void=
        FreezeClass.ChangeClass(Agent)
        FreezeHud.Show(Agent)
        FreezeTimer.Start(Agent)

    OnPlayerDamaged(DamageResult : damage_result): void =
        if:
            Instigator := DamageResult.Instigator?
            Agent := Instigator.GetInstigatorAgent[]
            FreezeDetector.IsHoldingItem[Agent]
            Target := fort_character[DamageResult.Target]

        then:
            spawn:
                FreezePlayer(Target)

    FreezePlayer(Target : fort_character)<suspends> : void =
        Target.PutInStasis(stasis_args{})
        Sleep(FreezeTime)
        Target.ReleaseFromStasis()

    OnPlayerAdded(Player : player) : void =
        if (FortCharacter := Player.GetFortCharacter[]):
            FortCharacter.DamagedEvent().Subscribe(OnPlayerDamaged)
            FortCharacter.DamagedShieldEvent().Subscribe(OnPlayerDamaged)