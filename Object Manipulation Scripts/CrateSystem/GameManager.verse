using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

GameManager := class(creative_device):

    @editable _CrateController : []CrateController = array {}

    OnBegin<override>()<suspends>:void=
        Print("@GrinernCreates")

        for(crate : _CrateController):
            crate.Initialize()