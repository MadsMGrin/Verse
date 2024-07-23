
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

GameManager := class(creative_device):
    
    _PlayerRepository : PlayerRepository = PlayerRepository{}
    _DebugUtil : DebugUtil = DebugUtil{}

    # Editable properties for manipulating stats
    @editable IncrementStatButton : button_device = button_device{}
    @editable DecrementStatButton : button_device = button_device{}
    @editable SetStatButton : button_device = button_device{}
    @editable ShowStatsButton : button_device = button_device{}

    OnBegin<override>()<suspends>:void=
        _DebugUtil.Log("@GrinernCreates")
        AllPlayers:[]player = GetPlayspace().GetPlayers()
        for(Player:AllPlayers):
            _PlayerRepository.InitializePlayer(Player)
        IncrementStatButton.InteractedWithEvent.Subscribe(IncrementStat)
        DecrementStatButton.InteractedWithEvent.Subscribe(DecrementStat)
        SetStatButton.InteractedWithEvent.Subscribe(SetStat)
        ShowStatsButton.InteractedWithEvent.Subscribe(ShowStats)

    IncrementStat(Agent:agent):void=
        _PlayerRepository.SaveDataAsInt(Agent, stat.Example, manipulationType.Increment, 1)

    DecrementStat(Agent:agent):void=
        _PlayerRepository.SaveDataAsInt(Agent, stat.Example, manipulationType.Decrement, 1)

    SetStat(Agent:agent):void=
        _PlayerRepository.SaveDataAsInt(Agent, stat.Example, manipulationType.Set, 5891324983)

    ShowStats(Agent:agent):void=
        _DebugUtil.Debug("{_PlayerRepository.GetDataAsInt(Agent, stat.Example)}")