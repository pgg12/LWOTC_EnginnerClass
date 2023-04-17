class X2Effect_LWOTC_EngineerClass_SpawnTurret extends X2Effect_SpawnUnit;

// We use one type of effect to spawn all the different types of turrets we need
/*
var private name TurretToSpawn;

function SpawnCV()
{
	TurretToSpawn = 'XComTurretM1';
}

function SpawnMG()
{
	TurretToSpawn = 'XComTurretM1';
}

function SpawnBM()
{
	TurretToSpawn = 'XComTurretM1';
}

*/
function name GetUnitToSpawnName(const out EffectAppliedData ApplyEffectParameters)
{
	local XComGameState_Item SourceItem;
	local XComGameStateHistory History;

	// This should be fine for getting the source Item, sadly this unit does not get passed the game state that is being prepared, which might be better suited
	History = `XCOMHISTORY;
	SourceItem = XComGameState_Item(History.GetGameStateForObjectID(ApplyEffectParameters.ItemStateObjectRef.ObjectID));
	If(SourceItem == None)
	{
		`LOG("LWOTC_EngineerClass: Source Item not found spawning default for turret");
		return 'XComTurretM1';
	}

	// for the moment I'm using a switch statement over wepon tech to decide which turret to spawn, 
	// I may wind up doing this via config file in the future
	// This assumes that the source item is always a weapon -> not great for foolprofing
	switch(X2WeaponTemplate(SourceItem.GetMyTemplate()).WeaponTech)
	{
		case 'conventional':
			return 'XcomTurretM2';
			break;
		case 'magnetic':
			return 'XComTurretM2';
			break;
		case 'beam':
			return 'XComTurretM2';
			break;
		default:
			`LOG("LWOTC_EngineerClass: weapon tech category not found");
			return 'XComTurretM1';
			break;
	}
}


function vector GetSpawnLocation(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState)
{
	if(ApplyEffectParameters.AbilityInputContext.TargetLocations.Length == 0)
	{
		`Redscreen("Attempting to create X2Effect_SpawnMimicBeacon without a target location! @dslonneger");
		return vect(0,0,0);
	}

	return ApplyEffectParameters.AbilityInputContext.TargetLocations[0];
}

function ETeam GetTeam(const out EffectAppliedData ApplyEffectParameters)
{
	return GetSourceUnitsTeam(ApplyEffectParameters);
}

function OnSpawnComplete(const out EffectAppliedData ApplyEffectParameters, StateObjectReference NewUnitRef, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit TurretState, SourceUnitGameState;
	//local array<XComGameState_Item> SourceInventory;
	//local XComGameState_Item InventoryItem, CopiedInventoryItem;
	//local X2ItemTemplate ItemTemplate;

	TurretState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(NewUnitRef.ObjectID));
	`assert(TurretState != none);

	SourceUnitGameState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	if( SourceUnitGameState == none)
	{
		SourceUnitGameState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID, eReturnType_Reference));
	}
	`assert(SourceUnitGameState != none);

	// don't want the turret to have any items, for now
	// maybe do a perk that allows ammo to apply to the turret ?
	/*
	SourceInventory = SourceUnitGameState.GetAllInventoryItems(, true);
	foreach SourceInventory(InventoryItem)
	{
		if (InventoryItem.bMergedOut)
		{
			continue;
		}
		
		ItemTemplate = InventoryItem.GetMyTemplate();
		CopiedInventoryItem = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		MimicBeaconGameState.AddItemToInventory(CopiedInventoryItem, InventoryItem.InventorySlot, NewGameState);
	}
	*/


	// Make sure the turret spawns with action points this turn
	// props add config for this
	TurretState.ActionPoints.Length = 2;
	TurretState.SetUnitFloatValue('NewSpawnedUnit', 1, eCleanup_BeginTactical);

	// UI update happens in quite a strange order when squad concealment is broken.
	// The unit which threw the mimic beacon will be revealed, which should reveal the rest of the squad.
	// The mimic beacon won't be revealed properly unless it's considered to be concealed in the first place.
	// TODO fiddle with this could be nice for givinbg an "ambusher" tree
	if (SourceUnitGameState.IsSquadConcealed())
		TurretState.SetIndividualConcealment(true, NewGameState); //Don't allow the mimic beacon to be non-concealed in a concealed squad.
}

defaultproperties
{
	UnitToSpawnName="XComTurretM1"
	bCopyTargetAppearance=false
	bKnockbackAffectsSpawnLocation=false
	EffectName="SpawnTurret"
}

