class X2Character_LWOTC_EngineerClass_Turrets extends X2Character;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.additem(CreateTurret_CV());
	Templates.additem(CreateTurret_MG());
	Templates.additem(CreateTurret_BM());

	return Templates;
}

// Basis for all the turrets, taken from the games default turret setup
// For the moment all of these properties should be shared by all the turrets
static function CreateDefaultTurretTemplate(out X2CharacterTemplate CharTemplate, Name TemplateName, bool bShort=false)
{
	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, TemplateName);
	CharTemplate.BehaviorClass = class'XGAIBehavior';
	CharTemplate.strMatineePackages.AddItem("CIN_Turret");
	CharTemplate.strTargetingMatineePrefix = "CIN_Turret_FF_StartPos";

	// for the moment we are using default turret appearance
	if( bShort )
	{
		CharTemplate.RevealMatineePrefix = "CIN_Turret_Short";
		CharTemplate.strPawnArchetypes.AddItem("GameUnit_AdvTurret.ARC_GameUnit_AdvTurretVan");
	}
	else
	{
		CharTemplate.RevealMatineePrefix = "CIN_Turret_Tall";
		CharTemplate.strPawnArchetypes.AddItem("GameUnit_AdvTurret.ARC_GameUnit_AdvTurretM1");
	}

	// Traversal Rules
	// The commented out version is the default however we do not want them to be able to move at all, so setting everything to false should be alright and neater
	// Backup in case there isa reason they are not all set to false afterall
	/*
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = false;
	*/
	// Turrets should not move
	CharTemplate.bCanUse_eTraversal_Normal = false;
	CharTemplate.bCanUse_eTraversal_ClimbOver = false;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = false;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = false;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = false;
	CharTemplate.bCanUse_eTraversal_BreakWindow = false;
	CharTemplate.bCanUse_eTraversal_KickDoor = false;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bCanTakeCover = false;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = false;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = true;
	CharTemplate.bIsSoldier = false;
	CharTemplate.bIsTurret = true;

	CharTemplate.UnitSize = 1;
	CharTemplate.VisionArcDegrees = 360;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = false;

	CharTemplate.bAllowSpawnFromATT = false;
	CharTemplate.bSkipDefaultAbilities = true;

	CharTemplate.bBlocksPathingWhenDead = true;

	CharTemplate.ImmuneTypes.AddItem('Fire');
	CharTemplate.ImmuneTypes.AddItem('Poison');
	CharTemplate.ImmuneTypes.AddItem(class'X2Item_DefaultDamageTypes'.default.ParthenogenicPoisonType);
	CharTemplate.ImmuneTypes.AddItem('Panic');

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_turret_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Turret;

	CharTemplate.bDisablePodRevealMovementChecks = true;
}

static function X2CharacterTemplate CreateTurret_CV()
{
	local X2CharacterTemplate Template;

	CreateDefaultTurretTemplate(Template, 'LWOTC_EngineerClass_DeployableTurret_CV');
	Template.DefaultLoadout = 'LWOTC_EngineerClass_DeployableTurret_Default_Loadout_CV';

	return Template;
}

static function X2CharacterTemplate CreateTurret_MG()
{
	local X2CharacterTemplate Template;

	CreateDefaultTurretTemplate(Template, 'LWOTC_EngineerClass_DeployableTurret_MG');
	Template.DefaultLoadout = 'LWOTC_EngineerClass_DeployableTurret_Default_Loadout_MG';

	return Template;
}

static function X2CharacterTemplate CreateTurret_BM()
{
	local X2CharacterTemplate Template;

	CreateDefaultTurretTemplate(Template, 'LWOTC_EngineerClass_DeployableTurret_BM');
	Template.DefaultLoadout = 'LWOTC_EngineerClass_DeployableTurret_Default_Loadout_BM';

	return Template;
}