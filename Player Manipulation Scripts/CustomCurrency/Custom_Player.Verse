
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
using { /Fortnite.com/UI }
using { /Verse.org/Simulation }
using { /Verse.org/Colors }
using { /Verse.org/Random }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }


Custom_Player := class<unique>():
    StringToMessage<localizes> (value:string) <computes> : message = "{value}"
    
    Player: agent

    var EarningsScoreText :text_block = text_block{}
    var Earnings: int = 0

    #UI Initiation
    InitiateUI():void=
        set EarningsScoreText = text_block{DefaultText := StringToMessage("Earnings: {Earnings}"), DefaultTextColor:= NamedColors.White, DefaultShadowColor:=NamedColors.Black}
        PlayerScoreWidget: canvas = CreateUserUI(EarningsScoreText)

        if(PlayerObj:=player[Player], PlayerUI := GetPlayerUI[PlayerObj]):
            PlayerUI.AddWidget(PlayerScoreWidget)


    #UI creation
    CreateUserUI(ScoreTextBlock:text_block):canvas=
        UICanvas: canvas = canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors {Minimum := vector2{X := 0.5, Y := 0.2}, Maximum := vector2{X := 0.5, Y := 0.2} }
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.0}
                    SizeToContent := true
                    Widget := overlay:
                        Slots := array:
                            overlay_slot:
                                Widget := color_block:
                                    DefaultColor := NamedColors.Black
                                    DefaultOpacity := 0.1
                                    DefaultDesiredSize := vector2{X := 300.0, Y := 40.0}
                            overlay_slot:
                                Widget := ScoreTextBlock
        return UICanvas

    #Add currency
    AddEarnings (Amount:int) : void=
        set Earnings += Amount
        UpdateUI ()

    #Remove currency
    RemoveEarnings (Amount:int) : void=
        set Earnings -= Amount
        UpdateUI ()

    #Logic for checking currency
    CheckEarnings (Amount: int): logic=
        if(Earnings < Amount):
            return false
        else:
            return true
        
    #UI Updating
    UpdateUI():void=
        EarningsScoreText.SetText(StringToMessage("Earnings: {Earnings}"))