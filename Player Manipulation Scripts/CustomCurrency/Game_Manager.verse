
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }


Game_Manager := class (creative_device):


    #This one I will not explain. You can tweak it to your liking. This is a VERY bad tycoon script but you can expand upon it and use inspiration if you so require.


    #Custom Player Script *NECESSARY FOR CUSTOM CURRENCY*
    var PlayersMap:[player]Custom_Player = map{}

    #Display of item
    @editable
    VendingMachine1:vending_machine_device = vending_machine_device{}

    @editable
    VendingMachine2:vending_machine_device = vending_machine_device{}

    @editable
    VendingMachine3:vending_machine_device = vending_machine_device{}

    @editable
    VendingMachine4:vending_machine_device = vending_machine_device{}
    
    #On screen UI
    @editable
    MessageDevice:hud_message_device = hud_message_device{}

    #Trigger for earning
    @editable
    EarningsTrigger:trigger_device = trigger_device{}

    #Trigger for buying
    @editable
    HouseTrigger:trigger_device = trigger_device{}

    #Cinematic for buying
    @editable
    HouseCinematic:cinematic_sequence_device = cinematic_sequence_device{}

    #Item giver
    @editable
    ItemGranter1:item_granter_device = item_granter_device{}
    
    @editable
    ItemGranter2:item_granter_device = item_granter_device{}

    @editable
    ItemGranter3:item_granter_device = item_granter_device{}

    @editable
    ItemGranter4:item_granter_device = item_granter_device{}

    #Player spawner
    @editable
    P1Spawner:player_spawner_device = player_spawner_device{}

    #Variables
    EarningsValue: int = 1

    Weapon1Cost: int = 5

    Weapon2Cost: int = 15

    Weapon3Cost: int = 25

    Weapon4Cost: int = 50

    HouseCost: int = 25

    #Connecting devices to functions
    OnBegin<override>()<suspends >:void=
        P1Spawner.SpawnedEvent.Subscribe(OnPlayerAdded)

        VendingMachine1.ItemSpawnedEvent.Subscribe(WeaponGranted1)
        VendingMachine2.ItemSpawnedEvent.Subscribe(WeaponGranted2)
        VendingMachine3.ItemSpawnedEvent.Subscribe(WeaponGranted3)
        VendingMachine4.ItemSpawnedEvent.Subscribe(WeaponGranted4)

        EarningsTrigger.TriggeredEvent.Subscribe(EarningsReward)

        HouseTrigger.TriggeredEvent.Subscribe(BuyBuilding)


    #I set up the player and UI
    OnPlayerAdded(Agent:agent):void=
        if:
            PlayerObj := player [Agent]
        then:
            if (PlayerExists := PlayersMap [PlayerObj]):
                #do nothing, player already exists
            else:
                if:
                    FC := Agent.GetFortCharacter[]
                then:
                    CustomPlayer: Custom_Player = Custom_Player{Player := Agent}
                    option:
                        set PlayersMap [PlayerObj] = CustomPlayer
                    CustomPlayer.InitiateUI()

    #Here starts the weapon grant galore
    WeaponGranted1(Agent: agent):void=
        if(PlayerObj:=player [Agent]):
            if (CustomPlayer:Custom_Player = PlayersMap[PlayerObj]):
                DoWeHaveEnough: logic = CustomPlayer.CheckEarnings(Weapon1Cost)
                if(DoWeHaveEnough = true):
                    CustomPlayer.RemoveEarnings(Weapon1Cost)
                    ItemGranter1.GrantItem(Agent)
                else:
                    MessageDevice.Show(Agent)

    WeaponGranted2 (Agent: agent) : void=
        if(PlayerObj:=player [Agent]):
            if (CustomPlayer:Custom_Player = PlayersMap[PlayerObj]):
                DoWeHaveEnough: logic = CustomPlayer.CheckEarnings(Weapon2Cost)
                if(DoWeHaveEnough = true):
                    CustomPlayer.RemoveEarnings(Weapon2Cost)
                    ItemGranter2.GrantItem(Agent)
                else:
                    MessageDevice.Show(Agent)

    WeaponGranted3 (Agent: agent) : void=
        if(PlayerObj:=player [Agent]):
            if (CustomPlayer:Custom_Player = PlayersMap[PlayerObj]):
                DoWeHaveEnough: logic = CustomPlayer.CheckEarnings(Weapon3Cost)
                if(DoWeHaveEnough = true):
                    CustomPlayer.RemoveEarnings(Weapon3Cost)
                    ItemGranter3.GrantItem(Agent)
                else:
                    MessageDevice.Show(Agent)

    WeaponGranted4 (Agent: agent) : void=
        if(PlayerObj:=player [Agent]):
            if (CustomPlayer:Custom_Player = PlayersMap[PlayerObj]):
                DoWeHaveEnough: logic = CustomPlayer.CheckEarnings(Weapon4Cost)
                if(DoWeHaveEnough = true):
                    CustomPlayer.RemoveEarnings(Weapon4Cost)
                    ItemGranter4.GrantItem(Agent)
                else:
                    MessageDevice.Show(Agent)


    BuyBuilding(Agent: ?agent) : void=
        for(CustomPlayer : PlayersMap):
            DoWeHaveEnough: logic = CustomPlayer.CheckEarnings(HouseCost)
            if(DoWeHaveEnough = true):
                CustomPlayer.RemoveEarnings(HouseCost)
                HouseCinematic.Play()
            else:
                MessageDevice.Show()
    
    #Addition of currency
    EarningsReward(Agent: ?agent) : void=
        for(CustomPlayer : PlayersMap):
            CustomPlayer.AddEarnings(EarningsValue)

        block: