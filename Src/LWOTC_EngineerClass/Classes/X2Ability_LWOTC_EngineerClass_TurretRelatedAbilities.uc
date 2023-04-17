class X2Ability_LWOTC_EngineerClass_TurretRelatedAbilities extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(TurretThrow());

	return Templates;
}

// Turret throw abilities for all tiers
static function X2AbilityTemplate TurretThrow()
{	
	local X2AbilityTemplate								Template;
	local X2AbilityCost_ActionPoints					ActionPointCost;
	local X2AbilityCost_Ammo							AmmoCost;
	local X2AbilityTarget_Cursor						CursorTarget;
	local X2AbilityMultiTarget_Radius					RadiusMultiTarget;
	local X2Effect_LWOTC_EngineerClass_SpawnTurret     SpawnTurret;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'TurretThrow');

	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_item_mimicbeacon";
	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	Template.bHideWeaponDuringFire = true;

	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);

	Template.bUseAmmoAsChargesForHUD = true;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.STANDARD_GRENADE_PRIORITY;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	// look up what this does
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	CursorTarget = new class'X2AbilityTarget_Cursor';
	CursorTarget.bRestrictToWeaponRange = true;
	Template.AbilityTargetStyle = CursorTarget;

	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.bUseWeaponRadius = true;
	RadiusMultiTarget.bIgnoreBlockingCover = true; // we don't need this, the squad viewer will do the appropriate things once thrown
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	// This should be code we cann reuse, but maybe it would make sense to implememnt ourselves for combatibility reasons?
	Template.TargetingMethod = class'X2TargetingMethod_MimicBeacon';
	Template.SkipRenderOfTargetingTemplate = true;

	Template.bUseThrownGrenadeEffects = true;

	// here we need to deviate from the default mimic beacon code
	SpawnTurret = new class'X2Effect_LWOTC_EngineerClass_SpawnTurret';
	SpawnTurret.UnitToSpawnName = 'XComTurretM2';
	SpawnTurret.BuildPersistentEffect(0, true, true, false, eGameRule_PlayerTurnBegin);
	
	Template.AddShooterEffect(SpawnTurret);
	Template.AddShooterEffect(new class'X2Effect_BreakUnitConcealment');

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	// Maybe the below will have to be replaced by a custom function, see The corresponding thing in mimic beacon.
	Template.BuildVisualizationFn = ThrowTurret_BuildVisualization;

	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.NonAggressiveChosenActivationIncreasePerUse;

	return Template;
}

simulated function ThrowTurret_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameStateContext_Ability Context;
	local StateObjectReference InteractingUnitRef;
	local VisualizationActionMetadata EmptyTrack;
	local VisualizationActionMetadata SourceTrack, MimicBeaconTrack;
	local XComGameState_Unit MimicSourceUnit, SpawnedUnit;
	local UnitValue SpawnedUnitValue;
	local X2Effect_LWOTC_EngineerClass_SpawnTurret SpawnMimicBeaconEffect;
	local X2Action_MimicBeaconThrow FireAction;
	// no animation for the time being
	//local X2Action_PlayAnimation AnimationAction;

	History = `XCOMHISTORY;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	InteractingUnitRef = Context.InputContext.SourceObject;

	//Configure the visualization track for the shooter
	//****************************************************************************************
	SourceTrack = EmptyTrack;
	SourceTrack.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	SourceTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	SourceTrack.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

	class'X2Action_ExitCover'.static.AddToVisualizationTree(SourceTrack, Context);
	FireAction = X2Action_MimicBeaconThrow(class'X2Action_MimicBeaconThrow'.static.AddToVisualizationTree(SourceTrack, Context));
	class'X2Action_EnterCover'.static.AddToVisualizationTree(SourceTrack, Context);

	// Configure the visualization track for the mimic beacon
	//******************************************************************************************
	MimicSourceUnit = XComGameState_Unit(VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID));
	`assert(MimicSourceUnit != none);
	MimicSourceUnit.GetUnitValue(class'X2Effect_SpawnUnit'.default.SpawnedUnitValueName, SpawnedUnitValue);

	MimicBeaconTrack = EmptyTrack;
	MimicBeaconTrack.StateObject_OldState = History.GetGameStateForObjectID(SpawnedUnitValue.fValue, eReturnType_Reference, VisualizeGameState.HistoryIndex);
	MimicBeaconTrack.StateObject_NewState = MimicBeaconTrack.StateObject_OldState;
	SpawnedUnit = XComGameState_Unit(MimicBeaconTrack.StateObject_NewState);
	`assert(SpawnedUnit != none);
	MimicBeaconTrack.VisualizeActor = History.GetVisualizer(SpawnedUnit.ObjectID);

	// Set the Throwing Unit's FireAction to reference the spawned unit
	FireAction.MimicBeaconUnitReference = SpawnedUnit.GetReference();
	// Set the Throwing Unit's FireAction to reference the spawned unit
	class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(MimicBeaconTrack, Context);

	// Only one target effect and it is X2Effect_SpawnMimicBeacon
	SpawnMimicBeaconEffect = X2Effect_LWOTC_EngineerClass_SpawnTurret(Context.ResultContext.ShooterEffectResults.Effects[0]);
	
	if( SpawnMimicBeaconEffect == none )
	{
		`RedScreenOnce("MimicBeacon_BuildVisualization: Missing X2Effect_SpawnMimicBeacon -dslonneger @gameplay");
		return;
	}

	SpawnMimicBeaconEffect.AddSpawnVisualizationsToTracks(Context, SpawnedUnit, MimicBeaconTrack, MimicSourceUnit, SourceTrack);

	class'X2Action_SyncVisualizer'.static.AddToVisualizationTree(MimicBeaconTrack, Context);

	// for the moment no animation
	//AnimationAction = X2Action_PlayAnimation(class'X2Action_PlayAnimation'.static.AddToVisualizationTree(MimicBeaconTrack, Context));
	// currently no animation
	//AnimationAction.Params.AnimName = default.MIMIC_BEACON_START_ANIM;
	//AnimationAction.Params.BlendTime = 0.0f;
}
