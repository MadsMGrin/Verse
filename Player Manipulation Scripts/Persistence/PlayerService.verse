using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

PlayerService := class<concrete>():
    
    _DebugUtil : DebugUtil = DebugUtil{}
    
    # Method to initialize a single player
    InitializePlayer(Player:player):void=
        if:
            not PlayerStatsMap[Player]
            set PlayerStatsMap[Player] = player_stats_table{}
        
    # Method to reset a player's progress
    ResetPlayerProgress(Player:player):void=
        if:
            PlayerStatsMap[Player]
            set PlayerStatsMap[Player] = player_stats_table{}
        then:
            InitializePlayer(Player)
        
    # Method to get a player's stats
    GetPlayerStats(Agent:agent)<decides><transacts>:player_stats_table=
        var PlayerStats:player_stats_table = player_stats_table{}
        if:
            Player := player[Agent]
            PlayerStatsTable := PlayerStatsMap[Player]
            set PlayerStats = MakePlayerStatsTable(PlayerStatsTable)
        PlayerStats
        
    # Method to increment a player's stat
    IncrementStat(Agent:agent, Stat:stat_type, Score:int):void=
        if:
            Player := player[Agent]
            PlayerStatsTable := PlayerStatsMap[Player]
            if(Stat = StatType.Example):
                ExampleStat := PlayerStatsTable.Example
                set PlayerStatsMap[Player] = player_stats_table:
                    MakePlayerStatsTable<constructor>(PlayerStatsTable)
                    Example := PlayerStatsTable.Example + Score
        then:
            if(Stat = StatType.Example):
                _DebugUtil.Log("Example incremented by {Score}")
            else:
                _DebugUtil.Error("Invalid Stat Type")
        else:
            _DebugUtil.Error("Player Stats Table not found")
        
    # Method to decrement a player's stat
    DecrementStat(Agent:agent, Stat:stat_type, Score:int):void=
        if:
            Player := player[Agent]
            PlayerStatsTable := PlayerStatsMap[Player]
            if(Stat = StatType.Example):
                ExampleStat := PlayerStatsTable.Example
                set PlayerStatsMap[Player] = player_stats_table:
                    MakePlayerStatsTable<constructor>(PlayerStatsTable)
                    Example := PlayerStatsTable.Example - Score
        then:
            if(Stat = StatType.Example):
                _DebugUtil.Log("Example decremented by {Score}")
            else:
                _DebugUtil.Error("Invalid Stat Type")
        else:
            _DebugUtil.Error("Player Stats Table not found")
        
    # Method to set a player's stat
    SetStat(Agent:agent, Stat:stat_type, Score:int):void=
        if:
            Player := player[Agent]
            PlayerStatsTable := PlayerStatsMap[Player]
            if(Stat = StatType.Example):
                ExampleStat := PlayerStatsTable.Example
                set PlayerStatsMap[Player] = player_stats_table:
                    MakePlayerStatsTable<constructor>(PlayerStatsTable)
                    Example := Score
        then:
            if(Stat = StatType.Example):
                _DebugUtil.Log("Example set to {Score}")
            else:
                _DebugUtil.Error("Invalid Stat Type")
        else:
            _DebugUtil.Error("Player Stats Table not found")