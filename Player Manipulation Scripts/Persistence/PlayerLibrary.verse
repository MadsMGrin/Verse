using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/UI }

# Define a weak map to store player stats, mapping a player to their stats table
var PlayerStatsMap:weak_map(player, player_stats_table) = map{}

# Define an enum for different stats
stat := enum:
    Example
    Money

# Define an enum for different manipulation types
manipulationType := enum:
    Increment
    Decrement
    Set

# Function to convert a stat enum to a string representation
statTypeToString(State: stat)<computes>:string=
    case(State):
        stat.Example => "Example"
        stat.Money => "Money"
        
# Function to convert a manipulation type enum to a string representation
manipulationTypeToString(State: manipulationType)<computes>:string=
    case(State):
        manipulationType.Increment => "Increment"
        manipulationType.Decrement => "Decrement"
        manipulationType.Set => "Set"