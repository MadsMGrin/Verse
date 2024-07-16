using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

CrateService<public> := class<unique><concrete>():

    HandleEvent(Agent: agent, Reward: item_granter_device): void =
        Reward.GrantItem(Agent)