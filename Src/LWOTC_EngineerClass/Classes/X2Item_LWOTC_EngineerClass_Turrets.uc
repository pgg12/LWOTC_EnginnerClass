class X2Item_LWOTC_EngineerClass_Turrets extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	// Items in the inventory of our soldiers
	Items.additem(CreateTurret_CV());
	Items.additem(CreateTurret_MG());
	Items.additem(CreateTurret_BM());

	// Weapons used by the various turrets

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
	Template.iClipSize = 1;
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

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'LWOTC_EngineerClass_Turret_CV');

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
	Template.iClipSize = 1;
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

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'LWOTC_EngineerClass_Turret_CV');

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
	Template.iClipSize = 1;
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

