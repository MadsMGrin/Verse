using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

PlayerRepository<public> := class<unique><concrete>():

    _PlayerService: PlayerService = PlayerService{}
    _DebugUtil : DebugUtil = DebugUtil{}

    InitializePlayer(Player:player):void=
        _PlayerService.InitializePlayer(Player)

    # Method to save data for a given agent
    SaveDataAsInt(Agent: agent, Stat: stat, Manipulation: manipulationType, Amount: int): void =
        StatActions := map{
            stat.Example => StatType.Example
            stat.Money => StatType.Money
        }
    
        ManipulationActions := map{
            manipulationType.Increment => _PlayerService.IncrementStat,
            manipulationType.Decrement => _PlayerService.DecrementStat,
            manipulationType.Set => _PlayerService.SetStat
        }
    
        # Perform the appropriate action based on the stat and manipulation type
        if (StatKey := StatActions[Stat], ManipulationAction := ManipulationActions[Manipulation]):
            ManipulationAction(Agent, StatKey, Amount)
            _DebugUtil.Log("{Amount} of {statTypeToString(Stat)} {manipulationTypeToString(Manipulation)}")
        else:
            _DebugUtil.Error("Manipulation Type not found: {manipulationTypeToString(Manipulation)}")

    # Method to get data for a given agent as an int
    GetDataAsInt(Agent: agent, Stat: stat)<transacts>: int =
        if (GetStats := _PlayerService.GetPlayerStats[Agent]):
            StatKey := statTypeToString(Stat)
            if (StatKey = "Example"):
                Amount := GetStats.Example
                return Amount
            else if (StatKey = "Money"):
                Amount := GetStats.Money
                return Amount
            else:
                return -1
        else:
            return -2