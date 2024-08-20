# Define an abstract class for stat types
stat_type := class<computes><abstract>:
    Id() <transacts>:int

# Define a module to hold the specific stat types
StatType := module:

    example_stat<public> := class<computes>(stat_type):
        Id<override>()<transacts>:int = 1
    money_stat<public> := class<computes>(stat_type):
        Id<override>()<transacts>:int = 2

    Example<public>:example_stat = example_stat{}
    Money<public>:money_stat = money_stat{}