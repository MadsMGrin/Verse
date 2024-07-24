# Define an abstract class for stat types
stat_type := class<computes><unique><abstract>:
    DebugString():string

# Define a module to hold the specific stat types
StatType := module:

    example_stat<public> := class<computes><unique>(stat_type):
        DebugString<override>():string= "Example"
    money_stat<public> := class<computes><unique>(stat_type):
        DebugString<override>():string= "Money"

    Example<public>:example_stat = example_stat{}
    Money<public>:money_stat = money_stat{}