class X2Item_LWOTC_EngineerClass_Turrets extends X2Item config(GameData_WeaponData);

// Turret item setup

var config int ConventionalTurretThrowCharges;
var config int MagneticTurretThrowCharges;
var config int BeamTurretThrowCharges;

// Turret weapons setup

var config array<int> ConventionalTurretRange;
var config array<int> MagneticTurretRange;
var config array<int> BeamTurretRange;

var config WeaponDamageValue ConventionalTurretDamage;
var config WeaponDamageValue MagneticTurretDamage;
var config WeaponDamageValue BeamTurretDamage;

var config int ConventionalTurretEnvironmentalDamage;
var config int MagneticTurretEnvironmentalDamage;
var config int BeamTurretEnvironmentalDamage;

var config int ConventionalTurretSoundRange;
var config int MagneticTurretSoundRange;
var config int BeamTurretSoundRange;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	// Items in the inventory of our soldiers
	Items.additem(CreateTurret_CV());
	Items.additem(CreateTurret_MG());
	Items.additem(CreateTurret_BM());

	// Weapons used by the various turrets
	Items.additem(CreateTurretWeapon_CV());
	items.additem(CreateTurretWeapon_MG());
	items.additem(CreateTurretWeapon_BM());

	return Items;
}

// Turret Items

static function X2WeaponTemplate CreateTurret_CV()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'LWOTC_EngineerClass_Turret_CV');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Mimic_Beacon";
	Template.EquipSound = "StrategyUI_Grenade_Equip";

	Template.GameArchetype = "WP_Grenade_MimicBeacon.WP_Grenade_MimicBeacon";
	Template.Abilities.AddItem('TurretThrow');
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'LWOTC_EngineerClass_turret';
	Template.WeaponTech = 'conventional';
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_BeltHolster;
	Template.bMergeAmmo = true;
	Template.iClipSize = default.ConventionalTurretThrowCharges;
	Template.Tier = 0;

	Template.iRadius = 1;
	Template.iRange = 12; // todo config for this

	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.bShouldCreateDifficultyVariants = true;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , 12); // same config as above

	return Template;
}

static function X2WeaponTemplate CreateTurret_MG()
{
	local X2WeaponTemplate Template;
	// TODO: add cost for building

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'LWOTC_EngineerClass_Turret_MG');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Mimic_Beacon";
	Template.EquipSound = "StrategyUI_Grenade_Equip";

	Template.GameArchetype = "WP_Grenade_MimicBeacon.WP_Grenade_MimicBeacon";
	Template.Abilities.AddItem('TurretThrow');
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'LWOTC_EngineerClass_turret';
	Template.WeaponTech = 'magnetic';
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_BeltHolster;
	Template.bMergeAmmo = true;
	Template.iClipSize = default.MagneticTurretThrowCharges;
	Template.Tier = 2;

	Template.iRadius = 1;
	Template.iRange = 12; // todo config for this

	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.bShouldCreateDifficultyVariants = true;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , 12); // same config as above

	return Template;
}

static function X2WeaponTemplate CreateTurret_BM()
{
	local X2WeaponTemplate Template;
	// TODO: add cost for building

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'LWOTC_EngineerClass_Turret_BM');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Mimic_Beacon";
	Template.EquipSound = "StrategyUI_Grenade_Equip";

	Template.GameArchetype = "WP_Grenade_MimicBeacon.WP_Grenade_MimicBeacon";
	Template.Abilities.AddItem('TurretThrow');
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'LWOTC_EngineerClass_turret';
	Template.WeaponTech = 'beam';
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_BeltHolster;
	Template.bMergeAmmo = true;
	Template.iClipSize = default.BeamTurretThrowCharges;
	Template.Tier = 4;

	Template.iRadius = 1;
	Template.iRange = 12; // todo config for this

	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.bShouldCreateDifficultyVariants = true;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , 12); // same config as above

	return Template;
}

// Turret Weapons

static function X2WeaponTemplate CreateTurretWeapon_CV()
{
	local X2WeaponTemplate Template;

	// TODO: adjust this for my needs
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'LWOTC_EngineerClass_DeployableTurret_Weapon_CV');

	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.AdventTurret";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = default.ConventionalTurretRange;
	Template.BaseDamage = default.ConventionalTurretDamage;
	Template.iClipSize = 1;
	Template.InfiniteAmmo = true;
	Template.iSoundRange = default.ConventionalTurretSoundRange;
	Template.iEnvironmentDamage = default.ConventionalTurretEnvironmentalDamage;

	// TODO: Overhaul theabilities granted by the weapon, most likely remove most of these
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot_NoEnd');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Turret_MG.WP_Turret_MG";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	Template.DamageTypeTemplateName = 'Projectile_MagAdvent';

	return Template;
}

static function X2WeaponTemplate CreateTurretWeapon_MG()
{
	local X2WeaponTemplate Template;

	// TODO: adjust this for my needs
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'LWOTC_EngineerClass_DeployableTurret_Weapon_MG');

	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.AdventTurret";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = default.MagneticTurretRange;
	Template.BaseDamage = default.MagneticTurretDamage;
	Template.iClipSize = 1;
	Template.InfiniteAmmo = true;
	Template.iSoundRange = default.MagneticTurretSoundRange;
	Template.iEnvironmentDamage = default.MagneticTurretEnvironmentalDamage;

	// TODO: Overhaul theabilities granted by the weapon, most likely remove most of these
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot_NoEnd');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Turret_MG.WP_Turret_MG";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	Template.DamageTypeTemplateName = 'Projectile_MagAdvent';

	return Template;
}

static function X2WeaponTemplate CreateTurretWeapon_BM()
{
	local X2WeaponTemplate Template;

	// TODO: adjust this for my needs
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'LWOTC_EngineerClass_DeployableTurret_Weapon_BM');

	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.AdventTurret";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = default.BeamTurretRange;
	Template.BaseDamage = default.BeamTurretDamage;
	Template.iClipSize = 1;
	Template.InfiniteAmmo = true;
	Template.iSoundRange = default.BeamTurretSoundRange;
	Template.iEnvironmentDamage = default.BeamTurretEnvironmentalDamage;

	// TODO: Overhaul theabilities granted by the weapon, most likely remove most of these
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot_NoEnd');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Turret_MG.WP_Turret_MG";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	Template.DamageTypeTemplateName = 'Projectile_MagAdvent';

	return Template;
}
