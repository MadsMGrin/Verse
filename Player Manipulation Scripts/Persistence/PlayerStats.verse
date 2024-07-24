# Define a class for storing player stats
player_stats_table := class<final><persistable>:
    Example: int = 0
    Money: int = 0

# Define a constructor function to create a new player_stats_table from an existing one
MakePlayerStatsTable<constructor>(OldTable:player_stats_table)<transacts> := player_stats_table:
    Example := OldTable.Example
    Money := OldTable.Money