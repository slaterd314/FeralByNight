--
-- Feral by Night
-- An addon by Nightcrowler of Runetotem, with credits Yukizawa (creator of the original version of the suggester frame -FaceMauler-) of Aggramar, Aytherine of Maelstrom

-- Our base array
FeralbyNight = {}
  

-- Feral by Night variables NOT SAVED

FeralbyNight.currentTarget = {}
FeralbyNight.currentSpell = ""
FeralbyNight.srTime = 0
FeralbyNight.tfTime = 0
FeralbyNight.berserkTime = 0
FeralbyNight.srDuration = 0
FeralbyNight.oocTime = 0
FeralbyNight.currentTarget.guid="A"
FeralbyNight.currentTarget.id=0000;
FeralbyNight.currentTarget.unitType=0000;
	FeralbyNight.currentTarget.bosshp={}
		FeralbyNight.currentTarget.bosshp_time={}
	FeralbyNight.damage=0;
	FeralbyNight.currentTarget.dps={}
		FeralbyNight.shreded_rip=0;
		FeralbyNight.old_rip=0;
				FeralbyNight.elder_rip=0;
				FeralbyNight.rip_damagextick_saved=0;
				FeralbyNight.notice_timer=-2;
				FeralbyNight.playertargetchanged=0;
				  FeralbyNight.castfinish=-30
  FeralbyNight.castdurat=-30
  FeralbyNight.castname="nil"
  FeralbyNight.trinket1="nil"
  FeralbyNight.trinket2="nil"
  FeralbyNight.trinket1special=0;
  FeralbyNight.trinket2special=0;
  FeralbyNight.trinket1cd=0
  FeralbyNight.trinket2cd=0
  	 FeralbyNight.berserkplyph = 0;
	 FeralbyNight.mangleglyph = 0;
	 FeralbyNight.shredglyph = 0;
	 FeralbyNight.ripglyph =0;
	 FeralbyNight.srglyph =0;
	 FeralbyNight.crit_meta =0;

-- Define list of terms that need translation.
function FbN_GetSpellNameById(spellId)
	if (spellId == nil) then
		return nil
	end
		local spellName, rank, _, _, _, _, _, _, _ = GetSpellInfo(spellId)
	if rank==nil then
	return spellName
	elseif string.len(rank)>1 then
		return spellName.."("..rank..")"
	end
	return spellName
end

local bearform, _, _, _, _, _, _, _, _ = GetSpellInfo(9634);
local catForm, _, _, _, _, _, _, _, _ = GetSpellInfo(768);

FeralbyNight.L = {
	["Rake"] = "Rake",
	["Rip"] = "Rip",
	["Mangle (Cat)"] = "Mangle (Cat)",
	["Mangle (Bear)"] = "Mangle (Bear)",
	["Trauma"] = "Trauma",
	["Faerie Fire"] = "Faerie Fire",
	["Clearcasting"] = "Clearcasting",
	["Savage Roar"] = "Savage Roar",
	["Tiger's Fury"] = "Tiger's Fury",
	["Berserk"] = "Berserk",
	["Shred"] = "Shred",
	["Ferocious Bite"] = "Ferocious Bite",
	["Faerie Fire (Feral)(Rank 6)"] = "Faerie Fire (Feral)()",
	["Faerie Fire (Feral)"] = "Faerie Fire (Feral)",
	["Cat Form"] = "Cat Form",
	["Sting"] = "Sting",
	["Acid Spit"] = "Acid Spit",
	["Expose Armor"] = "Expose Armor",
	["Sunder Armor"] = "Sunder Armor",
	["Heart of the Crusader"] = "Heart of the Crusader",
	["Master Poisoner"] = "Master Poisoner",
	["Totem of Wrath"] = "Totem of Wrath",
	["Lacerate"] = "Lacerate",
	["Maul"] = "Maul",
	["Demoralizing Roar"] = "Demoralizing Roar",
	["Demoralizing Shout"] = "Demoralizing Shout",
	["Curse of Weakness"] = "Curse of Weakness",
	["Vindication"] = "Vindication",
	["Barkskin"] = "Barkskin",
	["Survival Instincts"] = "Survival Instincts",
	["Swipe (Bear)"] = "Swipe (Bear)",
	["Growl"] = "Growl",
	["Dire Bear Form"] = "Dire Bear Form",
	["Enrage"] = "Enrage",
	["Heroic Presence (a)"] = "Heroic Presence (a)",
	["Heroic Presence (b)"] = "Heroic Presence (b)",
	["Maim"] = "Maim",
	["Bash"] = "Bash",
	}
	
local language = GetLocale();


	FeralbyNight.L["Rake"] = FbN_GetSpellNameById(48574)
	FeralbyNight.L["Rake Debuff"] = GetSpellInfo(1822)
	FeralbyNight.L["Rip"] = FbN_GetSpellNameById(49800)
	FeralbyNight.L["Rip Debuff"] = GetSpellInfo(1079)
	FeralbyNight.L["Mangle (Cat)"] = FbN_GetSpellNameById(48566)
	FeralbyNight.L["Mangle (Cat) Debuff"] = GetSpellInfo(33983)
	FeralbyNight.L["Mangle (Bear)"] = FbN_GetSpellNameById(48564)
	FeralbyNight.L["Mangle (Bear) Debuff"] = GetSpellInfo(33987)
	FeralbyNight.L["Trauma"] = GetSpellInfo(46857)
	FeralbyNight.L["Faerie Fire"] = FbN_GetSpellNameById(770)
	FeralbyNight.L["Clearcasting"] = FbN_GetSpellNameById(16870)
	FeralbyNight.L["Savage Roar"] = GetSpellInfo(52610)
	FeralbyNight.L["Tiger's Fury"] = FbN_GetSpellNameById(50213)
	FeralbyNight.L["Berserk"] = FbN_GetSpellNameById(50334)
	FeralbyNight.L["Shred"] = FbN_GetSpellNameById(48572)
	FeralbyNight.L["Ferocious Bite"] = FbN_GetSpellNameById(48577)
	FeralbyNight.L["Faerie Fire (Feral)"] = FbN_GetSpellNameById(16857)
	FeralbyNight.L["Cat Form"] = GetSpellInfo(768)
	FeralbyNight.L["Sting"] = GetSpellInfo(56631)
	FeralbyNight.L["Acid Spit"] = GetSpellInfo(55754)
	FeralbyNight.L["Expose Armor"] = GetSpellInfo(8647)
	FeralbyNight.L["Sunder Armor"] = GetSpellInfo(7386)
	FeralbyNight.L["Heart of the Crusader"] = GetSpellInfo(20337)
	FeralbyNight.L["Master Poisoner"] = GetSpellInfo(58410)
	FeralbyNight.L["Totem of Wrath"] = GetSpellInfo(30706)
	FeralbyNight.L["Lacerate"] = FbN_GetSpellNameById(48568)
	FeralbyNight.L["Lacerate Debuff"] = GetSpellInfo(33745)
	FeralbyNight.L["Maul"] = FbN_GetSpellNameById(48480)
	FeralbyNight.L["Demoralizing Roar"] = FbN_GetSpellNameById(48560)
	FeralbyNight.L["Demoralizing Roar Debuff"] = GetSpellInfo(99)
	FeralbyNight.L["Demoralizing Shout"] = GetSpellInfo(25203)
	FeralbyNight.L["Curse of Weakness"] = GetSpellInfo(50511)
	FeralbyNight.L["Vindication"] = GetSpellInfo(26017)
	FeralbyNight.L["Barkskin"] = FbN_GetSpellNameById(22812)
	FeralbyNight.L["Survival Instincts"] = FbN_GetSpellNameById(61336)
	FeralbyNight.L["Swipe (Bear)"] = FbN_GetSpellNameById(48562)
	FeralbyNight.L["Growl"] = FbN_GetSpellNameById(6795)
	FeralbyNight.L["Dire Bear Form"] = GetSpellInfo(9634)
	FeralbyNight.L["Enrage"] = FbN_GetSpellNameById(5229)
	FeralbyNight.L["Heroic Presence (a)"] = GetSpellInfo(28878)
	FeralbyNight.L["Heroic Presence (b)"] = GetSpellInfo(6562)
	FeralbyNight.L["Maim"] = FbN_GetSpellNameById(49802)
	FeralbyNight.L["Bash"] = FbN_GetSpellNameById(8983)
	FeralbyNight.L["Rend"] = GetSpellInfo(772)
	FeralbyNight.L["Garrote"] = GetSpellInfo(703)
	FeralbyNight.L["Rupture"] = GetSpellInfo(1943)
	FeralbyNight.L["Pounce Bleed"] = GetSpellInfo(9007)
	FeralbyNight.L["Savage Rend"] = GetSpellInfo(50498)
	FeralbyNight.L["Rake (Pet)"] = GetSpellInfo(59881)
	FeralbyNight.L["Deep Wounds"] = GetSpellInfo(12721)
	FeralbyNight.L["First Aid"] = GetSpellInfo(3274)


	
	
	FeralbyNight.bossid={
		["Expert's Training Dummy"] = 32666,
		["Master's Training Dummy"] = 32667,
		["Training Dummy"] = 30527,
		["Grandmaster's Training Dummy"] = 31144,
		["Heroic Training Dummy"] = 31146,
		["Flame Leviathan"] = 33113,
		["Flame Leviathan Turret"] = 33139,
		["Ignis"] = 33118,
		["Iron Construct"] = 33121,
		["Razorscale"] = 33186,
		["Dark Rune Watcher"] = 33453,
		["Dark Rune Sentinel"] = 33846,
		["Dark Rune Guardian"] = 33388,
		["XT-002"] = 33293,
		["Heart of the Deconstructor"] = 33329,
		["Stormcaller"] = 32857,
		["Steelbreaker"] = 32867,
		["Molgeim"] = 32927,
		["Kologarn body"] = 32930,
		["Kologarn left arm"]= 32933,
		["Kologarn right arm"]= 32934,
		["Auriaya"] = 33515,
		["Sanctum Sentry"] = 34014,
		["Feral Defender"] = 34035,
		["Mimiron"] = 33350,
		["Leviathan Mk II"] = 33432,
		["VX-001"] = 33651,
		["ACU"] = 33670,
		["Hodir"] = 32845,
		["Thorim"] = 32865,
		["Dark Rune Acolyte"] = 33110,
		["Dark Rune Evoker"] = 32878,
		["Dark Rune Champion"] = 32876,
		["Dark Rune Commoner"] = 32904,
		["Dark Rune Warbringer"] = 32877,
		["Iron Ring Guard"] = 32874,
		["Runic Colossus"] = 32872,
		["Iron Honor Guard"] = 33125,
		["Ancient Rune Giant"] = 32873,
		["Freya"] = 32906,
		["Elder Brightleaf"] = 32915,
		["Elder Ironbranch"] = 32913,
		["Elder Stonebark"] = 32914,
		["Detonating Lasher"] = 32918,
		["Ancient Water Spirit"] = 33202,
		["Storm Lasher"] = 32919,
		["Snaplasher"] = 32916,
		["Ancient Conservator"] = 33203,
		["Eonar's Gift"] = 33228,
		["General Vezax"] = 33271,
		["Yogg-Saron"] = 33288,
		["Guardians of Yogg-Saron"] = 33136,
		["Immortal Guardian"] = 33988,
		["Brain of Yogg-Saron"] = 33890,
		["Crusher Tentacle"] = 33966,
		["Constrictor Tentacle"] = 33983,
		["Corruptor Tentacle"] = 33985,
		["Algalon"] = 32871,
		["Collapsing Star"] = 32955,
		["Living Constellation"] = 33052,
		["Emalon"] = 33993,
		["Tempest Minion"] = 33998,
	}
	
	--1-4---5-7---8-39 --aggiungi staticità dei proc con reset quando oo-combat
	FeralbyNight.procaura={
	["Misdirection"]=GetSpellInfo(34477),
	["Hysteria"]=GetSpellInfo(49016),
	["Trick of the Trade"]=GetSpellInfo(57933),
	["Shattering Throw"]=GetSpellInfo(64382),
	["Primal Wrath"]=GetSpellInfo(64951),
	["Primal Instinct"]=GetSpellInfo(43738),
	["Agile"]=GetSpellInfo(67355),
	["Evasion"]=GetSpellInfo(67354),
	["Berserking"]=GetSpellInfo(59620),
	["Mongoose"]=GetSpellInfo(28093),
	["FrostforgedChampion"]=GetSpellInfo(72412),
	["FrostforgedDefender"]=GetSpellInfo(72414),
	["Executioner"]=GetSpellInfo(42976),
	["Blood of the Old God"]=GetSpellInfo(64790),
	["Dark Matter"]=GetSpellInfo(65025),
	["Heart of Iron"]=GetSpellInfo(64763),
	["Mark of Norganon"]=GetSpellInfo(60319),
	["Mjolnir Runestone"]=GetSpellInfo(65020),
	["The General's Heart"]=GetSpellInfo(64764),
	["Vaniquished Clutches of Yogg-Saron"]=GetSpellInfo(64981),
	["Wrathstone"]=GetSpellInfo(64800),
	["Alacrity of the elements"]=GetSpellInfo(65005),
	["Furnace Stone"]=GetSpellInfo(65011),
	["Pyrite Infusion"]=GetSpellInfo(65013),
	["Bandit's Insigna"]=GetSpellInfo(60442),
	["Defender's Code"]=GetSpellInfo(60286),
	["Fury of the Five Flights"]=GetSpellInfo(60313),
	["Grim Toll"]=GetSpellInfo(60436),
	["Platinum Disk of Battle"]=GetSpellInfo(64524),
	["Platinum Disk of Swiftness"]=GetSpellInfo(46088),
	["Anvil of Titans"]=GetSpellInfo(62115),
	["DC_Berserk"]=GetSpellInfo(60196),
	["Greatness"]=GetSpellInfo(60233),
	["FH Insigna of Fury"]=GetSpellInfo(59818),
	["Loatheb's Shadow"]=GetSpellInfo(60439),
	["Reflection of Torment"]=GetSpellInfo(60065),
	["Resolute"]=GetSpellInfo(60180),
	["Tears of Bitter Anguish"]=GetSpellInfo(58901),
	["Valor medal of the first war"]=GetSpellInfo(60054),
	["Essence of Gossamer"]=GetSpellInfo(60218),
	["Emerald Boar"]=GetSpellInfo(56188),
	["Monarch Crab"]=GetSpellInfo(59757),
	["Ruby Hare"]=GetSpellInfo(56121),
	["Incisor Fragment"]=GetSpellInfo(60299),
	["Meteoriute Whetstone"]=GetSpellInfo(60301),
	["Seal of Panthaleon"]=GetSpellInfo(60214),
	["Furya"]=GetSpellInfo(67671),
	["Fortitudea"]=GetSpellInfo(67753),
	["Tremendous Fortitude"]=GetSpellInfo(67596),
	["Hardening Armora"]=GetSpellInfo(67742),
	["Rage"]=GetSpellInfo(67695),
	["Celerity"]=GetSpellInfo(67683),
	["Risen Furya"]=GetSpellInfo(67746),
	["Comet's Trail"]=GetSpellInfo(64772),
	["Defensive Tactics"]=GetSpellInfo(67694),
	["Paragona"]=GetSpellInfo(67772),
	["IcyRagea"]=GetSpellInfo(71401), --45
	["Invigoratea"]=GetSpellInfo(71575),  --no cd stack
	["Angercapacitora"]=GetSpellInfo(71406), --no cd stack
	["AegisofDalanara"]=GetSpellInfo(71635), --1 min on use
	["Rageofthefallen"]=GetSpellInfo(71396), --no cd stack
	["agilityofthevyrkula"]=GetSpellInfo(71485), --30 sec time, 90 sec cd
	["StrengthoftheTaunkaa"]=GetSpellInfo(71561),--30 sec time, 90 sec cd
	["SpeedoftheVrykula"]=GetSpellInfo(71560),--30 sec time, 90 sec cd
	["HardenedSkin"]=GetSpellInfo(71586), -- 1 min cd on use
	["ThickSkina"]=GetSpellInfo(71633), -- 30 sec cd
	["PiercingTwilighta"]=GetSpellInfo(75458), -- 45 sec cd
	["ScalyNimblenessa"]=GetSpellInfo(75477),  -- 45 sec cd
	["FatalFlaws"]=GetSpellInfo(71403),  -- 50 sec cd
	["IncreasedFortitudo"]=GetSpellInfo(71569),  -- 180 sec cd on use

	}
	
		FeralbyNight.proccd={	
	["Misdirection"]=0,
	["Hysteria"]=0,
	["Trick of the Trade"]=0,
	["Shattering Throw"]=0,
	["Primal Wrath"]=0,
	["Primal Instinct"]=0,
	["Agile"]=0,
	["Evasion"]=0,
	["Berserking"]=0,
	["Mongoose"]=0,
	["FrostforgedChampion"]=60,
	["FrostforgedDefender"]=0,
	["Executioner"]=0,
	["Blood of the Old God"]=50,
	["Dark Matter"]=45,
	["Heart of Iron"]=120,
	["Mark of Norganon"]=120,
	["Mjolnir Runestone"]=45,
	["The General's Heart"]=0,
	["Vaniquished Clutches of Yogg-Saron"]=120,
	["Wrathstone"]=120,
	["Alacrity of the elements"]=45,
	["Furnace Stone"]=120,
	["Pyrite Infusion"]=50,
	["Bandit's Insigna"]=45,
	["Defender's Code"]=120,
	["Fury of the Five Flights"]=0,
	["Grim Toll"]=45,
	["Platinum Disk of Battle"]=120,
	["Platinum Disk of Swiftness"]=120,
	["Anvil of Titans"]=45,
	["DC_Berserk"]=0,
	["Greatness"]=45,
	["FH Insigna of Fury"]=0,
	["Loatheb's Shadow"]=120,
	["Reflection of Torment"]=50,
	["Resolute"]=180,
	["Tears of Bitter Anguish"]=50,
	["Valor medal of the first war"]=120,
	["Essence of Gossamer"]=0,
	["Emerald Boar"]=300,
	["Monarch Crab"]=60,
	["Ruby Hare"]=180,
	["Incisor Fragment"]=120,
	["Meteoriute Whetstone"]=45,
	["Seal of Panthaleon"]=120,
	["Furya"]=45,
	["Fortitudea"]=180,
	["Tremendous Fortitude"]=180,
	["Hardening Armora"]=120,
	["Rage"]=120,
	["Celerity"]=120,
	["Risen Furya"]=120,
	["Comet's Trail"]=45,
	["Defensive Tactics"]=120,
	["Paragona"]=45,
	["IcyRagea"]=45,
	["Invigoratea"]=0,
	["Angercapacitora"]=0,
	["AegisofDalanara"]=60,
	["Rageofthefallen"]=0,
	["agilityofthevyrkula"]=105,
	["StrengthoftheTaunkaa"]=105,
	["SpeedoftheVrykula"]=105,
	["HardenedSkin"]=60,
	["ThickSkina"]=30,
	["PiercingTwilighta"]=45,
	["ScalyNimblenessa"]=45,
	["FatalFlaws"]=50,
	["IncreasedFortitudo"]=180,
	}

	
	FeralbyNight.bossaura={
	["Tempest Minion - Overcharged"] = GetSpellInfo(64217),
	["XT - Exposed Heart"] = GetSpellInfo(63849),
	["XT - Tympanic Tantrum"] = GetSpellInfo(62776), 
	["XT - Searing Light"] = GetSpellInfo(63018), 
	["XT - Gravity Bomb"] = GetSpellInfo(63024), 
	["Razor - Devouring Flame"] = GetSpellInfo(64733),
	["Razor - Fuse Armor"] = GetSpellInfo(64771),
	["Ignis - Slag Pot"] = GetSpellInfo(62717),
	["Ignis - Strength of the Creator"] = GetSpellInfo(62717),
	["Ignis - Constructor - Molten"] = GetSpellInfo(62373),
	["Ignis - Scorch"] = GetSpellInfo(62549),
	["Ignis - Heat"] = GetSpellInfo(62343),
	["SteelBreaker - Council - Fusion Punch"] = GetSpellInfo(61903),
	["SteelBreaker - Council - Static Disruption"] = GetSpellInfo(61912),
	["SteelBreaker - Council - Overwhelming Power"] = GetSpellInfo(61888),
	["Runemaster - Council - Runic Barrier"] = GetSpellInfo(62338),
	["Runemaster - Council - Rune of Power"] = GetSpellInfo(64320),
	["Runemaster - Council - Rune of Death"] = GetSpellInfo(63490),
	["Stormcaller - Council - Lightning Whirl"] = GetSpellInfo(61915),
	["Stormcaller - Council - Lightning Tendrils"] = GetSpellInfo(61887),
	["Kologarn - Focused Eyebeam"] = GetSpellInfo(63976),
	["Kologarn - Crunch Armor"] = GetSpellInfo(64002),
	["Kologarn - Rumbler - Stone Nova"] = GetSpellInfo(63978),
	["Auriaya - Terrifying Screech"] = GetSpellInfo(64386),
	["Auriaya - Seeping Feral Essence"] = GetSpellInfo(64459),
	["Auriaya - Strength of the Pack"] = GetSpellInfo(64381),
	["Freya - Fungi"] = GetSpellInfo(62619),
	["Freya - Conservator's Grip"] = GetSpellInfo(62532),
	["Freya - Nature's Fury"] = GetSpellInfo(62589),
	["Brightleaf - Brightleaf Flux"] = GetSpellInfo(62262),
	["Ironbranch - Impale"] = GetSpellInfo(62310),
	["Stonebark - Fist of Stone"] = GetSpellInfo(62344),
	["Stonebark - Petrified Bark"] = GetSpellInfo(62337),
	["Stonebark - Broken Bones"] = GetSpellInfo(62354),
	["Snaplasher - Hardened Bark"] = GetSpellInfo(64191),
	["Hodir - Freeze"] = GetSpellInfo(62469),
	["Hodir - Biting Cold"] = GetSpellInfo(62039),
	["Hodir - Frozen Blow"] = GetSpellInfo(63512),
	["Hodir - Starlight"] = GetSpellInfo(62807),
	["Hodir - Stormpower"] = GetSpellInfo(65134),
	["Hodir - Toasty Fire"] = GetSpellInfo(62821),
	["Hodir - Singed"] = GetSpellInfo(65280),
	["Mimiron - Napalm Shell"] = GetSpellInfo(63666),
	["Mimiron - Plasma Blast"] = GetSpellInfo(62997),
	["Mimiron - Magnetic Field"] = GetSpellInfo(64668),
	["Thorim - Lightning Charge"] = GetSpellInfo(62279),
	["Thorim - Unbalancing Strike"] = GetSpellInfo(62130),
	["Thorim - Frostbolt Volley"] = GetSpellInfo(62580),
	["Thorim - Frostnova"] = GetSpellInfo(62597),
	["Thorim - Blizzard"] = GetSpellInfo(62576),
	["Thorim - Runic Colossus - Runic Barrier"] = GetSpellInfo(62338),	
	["Vezax - Surge of Darkness"] = GetSpellInfo(62662),
	["Yogg - Sara's Fervor"] = GetSpellInfo(63138),	
	["Yogg - Sara's Blessing"] = GetSpellInfo(63134),
	["Yogg - Sara's Anger"] = GetSpellInfo(63147),	
	["Yogg - Dark volley"] = GetSpellInfo(63038),	
	["Yogg - Sanity"] = GetSpellInfo(63050),	
	["Yogg - Brain Link"] = GetSpellInfo(63802),		
	}
	
	FeralbyNight.bosscast={
	["Emalon - Lightning Nova"] = FbN_GetSpellNameById(64216),
	["Razor-Watcher-Chain 1"] = FbN_GetSpellNameById(64758), --
	["Razor-Watcher-Chain 2"] = FbN_GetSpellNameById(64759), --
	["Steelbreaker - Council - Fusion Punch"] = FbN_GetSpellNameById(61903), --
	["Stormcaller - Council - Chain Lightning"] = FbN_GetSpellNameById(61879), --
	["Stormcaller - Council - Lightning Whirl"] = FbN_GetSpellNameById(61915), --
	["Stormcaller - Council - Overload"] = FbN_GetSpellNameById(61869),
	["Auriaya - Sonic Screech"] = FbN_GetSpellNameById(64422),
	["Auriaya - Sentinel Blast"] = FbN_GetSpellNameById(64389), --
	["Auriaya - Terrifying Screech"] = FbN_GetSpellNameById(64386),
	["Freya - Ground Tremor"] = FbN_GetSpellNameById(62437),
	["Stonebark - Fist of Stone"] = FbN_GetSpellNameById(62344),
	["Mimiron - Plasma Blast"] = FbN_GetSpellNameById(62997),
	["Mimiron - Shock Blast"] = FbN_GetSpellNameById(63631),
	["Mimiron - Laser Barrage"] = FbN_GetSpellNameById(63293),
	["Thorim - Acolyte - Greater Heal"] = FbN_GetSpellNameById(62334), --
	["Thorim - Evoker - Runic Mending"] = FbN_GetSpellNameById(62328), --
	["Vezax - Surge of Darkness"] = FbN_GetSpellNameById(62662),	
	["Vezax - Searing Flame"] = FbN_GetSpellNameById(62611), --
	["Yogg - Dark volley"] = FbN_GetSpellNameById(63038), --
	["Yogg - Drain Life"] = FbN_GetSpellNameById(64159), --
	["Yogg - Drain Life2"] = FbN_GetSpellNameById(64160), --
	}


--20
FeralbyNight.fontvector={
"ABF.ttf",
"Adventure.ttf",
"Avqest.ttf",
"base_font.ttf",
"Bazooka.ttf",
"BigNoodleTitling-Oblique.ttf",
"BigNoodleTitling.ttf",
"BlackChancery.ttf",
"croissant.ttf",
"Emblem.ttf",
"Enigma__2.ttf",
"Movie_Poster-Bold.ttf",
"Perpetua_Italic.ttf",
"Porky.ttf",
"rm_midse.ttf",
"Tangerin.ttf",
"Tw_Cen_MT_Bold.ttf",
"Ultima_Campagnoli.ttf",
"VeraSe.ttf",
"Yellowjacket.ttf",
}

--62
FeralbyNight.texturevector={
"Aluminium.tga",
"Armory.tga",
"BantoBar.tga",
"Bars.tga",
"Bumps.tga",
"Button.tga",
"Charcoal.tga",
"Cilo.tga",
"Cloud.tga",
"Comet.tga",
"Dabs.tga",
"DarkBottom.tga",
"Diagonal.tga",
"Empty.tga",
"Falumn.tga",
"Fifths.tga",
"Flat.tga",
"Fourths.tga",
"Frost.tga",
"Glamour.tga",
"Glamour2.tga",
"Glamour3.tga",
"Glamour4.tga",
"Glamour5.tga",
"Glamour6.tga",
"Glamour7.tga",
"Glass.tga",
"Glaze.tga",
"Glaze2.tga",
"Gloss.tga",
"Graphite.tga",
"Grid.tga",
"Hatched.tga",
"Healbot.tga",
"LiteStep.tga",
"LiteStepLite.tga",
"Lyfe.tga",
"Melli.tga",
"MelliDark.tga",
"MelliDarkRough.tga",
"Minimalist.tga",
"Otravi.tga",
"Outline.tga",
"Perl.tga",
"Perl2.tga",
"Pill.tga",
"Rain.tga",
"Rocks.tga",
"Round.tga",
"Ruben.tga",
"Runes.tga",
"Skewed.tga",
"Smooth.tga",
"Smoothv2.tga",
"Smudge.tga",
"Steel.tga",
"Striped.tga",
"Tube.tga",
"Water.tga",
"Wglass.tga",
"Wisps.tga",
"Xeon.tga",
}




--GUID Parser
function ParseGUID(guid)
if guid==nil then
FeralbyNight.currentTarget.id=0000;
--print("No target, ID #",FeralbyNight.currentTarget.id)
return
end

   local first3 = tonumber("0x"..strsub(guid, 3,5))
   local unitType = bit.band(first3,0x00f)
	FeralbyNight.currentTarget.unitType=unitType;
   if (unitType == 0x000) then
      --print("Player, ID #", strsub(guid,6))
   elseif (unitType == 0x003) then
      local creatureID = tonumber("0x"..strsub(guid,9,12))
      FeralbyNight.currentTarget.id=creatureID;
      local spawnCounter = tonumber("0x"..strsub(guid,13)) 
   elseif (unitType == 0x004) then
      local petID = tonumber("0x"..strsub(guid,6,12))
      local spawnCounter = tonumber("0x"..strsub(guid,13)) 
     -- print("Pet, ID #",petID,"spawn #",spawnCounter)
   elseif (unitType == 0x005) then
      local creatureID = tonumber("0x"..strsub(guid,9,12))
      local spawnCounter = tonumber("0x"..strsub(guid,13)) 
     -- print("Vehicle, ID #",creatureID,"spawn #",spawnCounter)
   end
end
--
	


-- Input Language translations
if language == "deDE" then
	FeralbyNight.L["Faerie Fire (Feral)(Rank 6)"] = "Feenfeuer (Tiergestalt)(Rang 6)"
elseif language == "zhTW" then 
	FeralbyNight.L["Faerie Fire (Feral)(Rank 6)"] = "\231\178\190\233\157\136\228\185\139\231\129\171 (\233\135\142\230\128\167)(\231\173\137\231\180\154\229\133\173)" 
elseif language == "ruRU" then 
	FeralbyNight.L["Faerie Fire (Feral)(Rank 6)"] = "\208\146\208\190\208\187\209\136\208\181\208\177\208\189\209\139\208\185 \208\190\208\179\208\190\208\189\209\140 (\208\183\208\178\208\181\209\128\209\140)(\208\163\209\128\208\190\208\178\208\181\208\189\209\140 6)" -- Needs review
	elseif language == "frFR" then 
	FeralbyNight.L["Faerie Fire (Feral)(Rank 6)"] = "Lucioles (farouche)(Rang 6)"
end

FeralbyNight.timeSinceLastUpdate = 0
FeralbyNight.timeSinceLastUpdate_dps = 0


FeralbyNight.playerName = UnitName("player")



FeralbyNight.textureList = {
  ["last"] = nil,
  ["current"] = nil,
  ["next"] = nil,
  ["misc"] = nil,
  ["int"] = nil,
  }

FeralbyNight.notice={
["kitte"]="Interface\\AddOns\\FeralbyNight\\arts\\notice\\kitte.tga",
["go away"]="Interface\\AddOns\\FeralbyNight\\arts\\notice\\go_away.tga",
["use surv cd"]="Interface\\AddOns\\FeralbyNight\\arts\\notice\\use_surv_cd.tga",
["out of range"]="Interface\\AddOns\\FeralbyNight\\arts\\notice\\out_of_range.tga",
["turn"]="Interface\\AddOns\\FeralbyNight\\arts\\notice\\turn.tga",
["aggro1"]="Interface\\AddOns\\FeralbyNight\\arts\\notice\\aggro1.tga",
["aggro2"]="Interface\\AddOns\\FeralbyNight\\arts\\notice\\aggro2.tga",
["go all out"]="Interface\\AddOns\\FeralbyNight\\arts\\notice\\go_all_out.tga",
["taunt"]="Interface\\AddOns\\FeralbyNight\\arts\\notice\\taunt.tga",
["wait"]="Interface\\AddOns\\FeralbyNight\\arts\\notice\\wait.tga",
["can't use"]="Interface\\AddOns\\FeralbyNight\\arts\\notice\\cant_use.tga",
["attention"]="Interface\\AddOns\\FeralbyNight\\arts\\notice\\attention.tga",
["ooc"]="Interface\\AddOns\\FeralbyNight\\arts\\ooc.tga",
["bleeds"]="Interface\\AddOns\\FeralbyNight\\arts\\bleeds.tga",
}

FeralbyNight.noticestatus=0;


FeralbyNight.getability = {
	[1]=FeralbyNight.L["Enrage"],
	[2]=FeralbyNight.L["Survival Instincts"],
	[3]=FeralbyNight.L["Barkskin"],
	[4]=FeralbyNight.L["Demoralizing Roar"],
	[5]=FeralbyNight.L["Lacerate"],
	[6]=FeralbyNight.L["Growl"],
	[7]=FeralbyNight.L["Maim"],
	[8]=FeralbyNight.L["Berserk"],
	[9]=FeralbyNight.L["Faerie Fire"],
	[10]=FeralbyNight.L["Mangle (Cat)"],
	[11]=FeralbyNight.L["Rake"],
	[12]=FeralbyNight.L["Rip"],
	[13]=FeralbyNight.L["Savage Roar"],
	[14]=FeralbyNight.L["Tiger's Fury"],
	}
	
	FeralbyNight.getbossaura={};
		FeralbyNight.getmyaura={};
		FeralbyNight.getproc={};
		
FeralbyNight.getbossaura.icon = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	}

FeralbyNight.getbossaura.stack = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	}

FeralbyNight.getbossaura.timer = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	}

FeralbyNight.getmyaura.icon = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	}

FeralbyNight.getmyaura.stack = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	}

FeralbyNight.getmyaura.timer = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	}
	
FeralbyNight.getproc.icon = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	}

FeralbyNight.getproc.stack = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	}

FeralbyNight.getproc.timer = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	}

FeralbyNight.getproc.cd = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	}
	
FeralbyNight.getproc.finish = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	}

FeralbyNight.currentTarget.bosshp = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	[6]=0,
	[7]=0,
	[8]=0,
	[9]=0,
	[10]=0,
	}
FeralbyNight.currentTarget.dps = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	[6]=0,
	[7]=0,
	[8]=0,
	[9]=0,
	[10]=0,
	}
FeralbyNight.currentTarget.bosshp_time = {
	[1]=1,
	[2]=2,
	[3]=3,
	[4]=4,
	[5]=5,
	[6]=6,
	[7]=7,
	[8]=8,
	[9]=9,
	[10]=10,
	}

FeralbyNight.abilitycdmon = {
	[1]=nil,
	[2]=nil,
	[3]=nil,
	[4]=nil,
	[5]=nil,
	[6]=nil,
	[7]=nil,
	[8]=nil,
	[9]=nil,
	[10]=nil,
	[11]=nil,
	[12]=nil,
	[13]=nil,
	[14]=nil,
	}
	
FeralbyNight.abilitycdmon1 = {
	[1]=nil,
	[2]=nil,
	[3]=nil,
	[4]=nil,
	[5]=nil,
	}

FeralbyNight.abilitycdmon2 = {
	[1]=nil,
	[2]=nil,
	[3]=nil,
	[4]=nil,
	[5]=nil,
	}

FeralbyNight.abilitycdmon3 = {
	[1]=nil,
	[2]=nil,
	[3]=nil,
	[4]=nil,
	[5]=nil,
	}
	
FeralbyNight.bossfight= {
	[1]=nil,
	[2]=nil,
	[3]=nil,
	[4]=nil,
	[5]=nil,
	}

FeralbyNight.myfight = {
	[1]=nil,
	[2]=nil,
	[3]=nil,
	[4]=nil,
	[5]=nil,
	}
	
FeralbyNight.proc = {
	[1]=nil,
	[2]=nil,
	[3]=nil,
	[4]=nil,
	[5]=nil,
	}
	

		FeralbyNight.bossaurabossindex={
	FeralbyNight.bossaura["Tempest Minion - Overcharged"],
	FeralbyNight.bossaura["XT - Exposed Heart"], 
	FeralbyNight.bossaura["XT - Tympanic Tantrum"], 
	FeralbyNight.bossaura["XT - Searing Light"], 
	FeralbyNight.bossaura["XT - Gravity Bomb"], 
	FeralbyNight.bossaura["Razor - Devouring Flame"], 
	FeralbyNight.bossaura["Razor - Fuse Armor"], 
	FeralbyNight.bossaura["Ignis - Slag Pot"],
	FeralbyNight.bossaura["Ignis - Strength of the Creator"],
	FeralbyNight.bossaura["Ignis - Constructor - Molten"],
	FeralbyNight.bossaura["Ignis - Scorch"],
	FeralbyNight.bossaura["Ignis - Heat"],
	FeralbyNight.bossaura["SteelBreaker - Council - Fusion Punch"],
	FeralbyNight.bossaura["SteelBreaker - Council - Static Disruption"],
	FeralbyNight.bossaura["SteelBreaker - Council - Overwhelming Power"],
	FeralbyNight.bossaura["Runemaster - Council - Runic Barrier"],
	FeralbyNight.bossaura["Runemaster - Council - Rune of Power"],
	FeralbyNight.bossaura["Runemaster - Council - Rune of Death"],
	FeralbyNight.bossaura["Stormcaller - Council - Lightning Whirl"],
	FeralbyNight.bossaura["Stormcaller - Council - Lightning Tendrils"],
	FeralbyNight.bossaura["Kologarn - Focused Eyebeam"],
	FeralbyNight.bossaura["Kologarn - Crunch Armor"],
	FeralbyNight.bossaura["Kologarn - Rumbler - Stone Nova"],
	FeralbyNight.bossaura["Auriaya - Terrifying Screech"],
	FeralbyNight.bossaura["Auriaya - Seeping Feral Essence"],
	FeralbyNight.bossaura["Auriaya - Strength of the Pack"],
	FeralbyNight.bossaura["Freya - Fungi"], 
	FeralbyNight.bossaura["Freya - Conservator's Grip"],
	FeralbyNight.bossaura["Freya - Nature's Fury"],
	FeralbyNight.bossaura["Brightleaf - Brightleaf Flux"],
	FeralbyNight.bossaura["Ironbranch - Impale"],
	FeralbyNight.bossaura["Stonebark - Fist of Stone"],
	FeralbyNight.bossaura["Stonebark - Petrified Bark"],
	FeralbyNight.bossaura["Stonebark - Broken Bones"],
	FeralbyNight.bossaura["Snaplasher - Hardened Bark"],
	FeralbyNight.bossaura["Hodir - Freeze"],
	FeralbyNight.bossaura["Hodir - Biting Cold"],
	FeralbyNight.bossaura["Hodir - Frozen Blow"],
	FeralbyNight.bossaura["Hodir - Starlight"], 
	FeralbyNight.bossaura["Hodir - Stormpower"],
	FeralbyNight.bossaura["Hodir - Toasty Fire"],
	FeralbyNight.bossaura["Hodir - Singed"], 
	FeralbyNight.bossaura["Mimiron - Napalm Shell"],
	FeralbyNight.bossaura["Mimiron - Plasma Blast"],
	FeralbyNight.bossaura["Mimiron - Magnetic Field"],
	FeralbyNight.bossaura["Thorim - Lightning Charge"],
	FeralbyNight.bossaura["Thorim - Unbalancing Strike"],
	FeralbyNight.bossaura["Thorim - Frostbolt Volley"], 
	FeralbyNight.bossaura["Thorim - Frostnova"],
	FeralbyNight.bossaura["Thorim - Blizzard"],
	FeralbyNight.bossaura["Thorim - Runic Colossus - Runic Barrier"],
	FeralbyNight.bossaura["Vezax - Surge of Darkness"],
	FeralbyNight.bossaura["Yogg - Sara's Fervor"],	
	FeralbyNight.bossaura["Yogg - Sara's Anger"], 	
	FeralbyNight.bossaura["Yogg - Sara's Blessing"], 
	FeralbyNight.bossaura["Yogg - Dark volley"],	
	FeralbyNight.bossaura["Yogg - Sanity"],	
	FeralbyNight.bossaura["Yogg - Brain Link"],		
	}

		FeralbyNight.bossauramyindex={
	FeralbyNight.bossaura["Tempest Minion - Overcharged"],
	FeralbyNight.bossaura["XT - Exposed Heart"], 
	FeralbyNight.bossaura["XT - Tympanic Tantrum"], 
	FeralbyNight.bossaura["XT - Searing Light"], 
	FeralbyNight.bossaura["XT - Gravity Bomb"], 
	FeralbyNight.bossaura["Razor - Devouring Flame"], 
	FeralbyNight.bossaura["Razor - Fuse Armor"], 
	FeralbyNight.bossaura["Ignis - Slag Pot"],
	FeralbyNight.bossaura["Ignis - Strength of the Creator"],
	FeralbyNight.bossaura["Ignis - Constructor - Molten"],
	FeralbyNight.bossaura["Ignis - Scorch"],
	FeralbyNight.bossaura["Ignis - Heat"],
	FeralbyNight.bossaura["SteelBreaker - Council - Fusion Punch"],
	FeralbyNight.bossaura["SteelBreaker - Council - Static Disruption"],
	FeralbyNight.bossaura["SteelBreaker - Council - Overwhelming Power"],
	FeralbyNight.bossaura["Runemaster - Council - Runic Barrier"],
	FeralbyNight.bossaura["Runemaster - Council - Rune of Power"],
	FeralbyNight.bossaura["Runemaster - Council - Rune of Death"],
	FeralbyNight.bossaura["Stormcaller - Council - Lightning Whirl"],
	FeralbyNight.bossaura["Stormcaller - Council - Lightning Tendrils"],
	FeralbyNight.bossaura["Kologarn - Focused Eyebeam"],
	FeralbyNight.bossaura["Kologarn - Crunch Armor"],
	FeralbyNight.bossaura["Kologarn - Rumbler - Stone Nova"],
	FeralbyNight.bossaura["Auriaya - Terrifying Screech"],
	FeralbyNight.bossaura["Auriaya - Seeping Feral Essence"],
	FeralbyNight.bossaura["Auriaya - Strength of the Pack"],
	FeralbyNight.bossaura["Freya - Fungi"], 
	FeralbyNight.bossaura["Freya - Conservator's Grip"],
	FeralbyNight.bossaura["Freya - Nature's Fury"],
	FeralbyNight.bossaura["Brightleaf - Brightleaf Flux"],
	FeralbyNight.bossaura["Ironbranch - Impale"],
	FeralbyNight.bossaura["Stonebark - Fist of Stone"],
	FeralbyNight.bossaura["Stonebark - Petrified Bark"],
	FeralbyNight.bossaura["Stonebark - Broken Bones"],
	FeralbyNight.bossaura["Snaplasher - Hardened Bark"],
	FeralbyNight.bossaura["Hodir - Freeze"],
	FeralbyNight.bossaura["Hodir - Biting Cold"],
	FeralbyNight.bossaura["Hodir - Frozen Blow"],
	FeralbyNight.bossaura["Hodir - Starlight"], 
	FeralbyNight.bossaura["Hodir - Stormpower"],
	FeralbyNight.bossaura["Hodir - Toasty Fire"],
	FeralbyNight.bossaura["Hodir - Singed"], 
	FeralbyNight.bossaura["Mimiron - Napalm Shell"],
	FeralbyNight.bossaura["Mimiron - Plasma Blast"],
	FeralbyNight.bossaura["Mimiron - Magnetic Field"],
	FeralbyNight.bossaura["Thorim - Lightning Charge"],
	FeralbyNight.bossaura["Thorim - Unbalancing Strike"],
	FeralbyNight.bossaura["Thorim - Frostbolt Volley"], 
	FeralbyNight.bossaura["Thorim - Frostnova"],
	FeralbyNight.bossaura["Thorim - Blizzard"],
	FeralbyNight.bossaura["Thorim - Runic Colossus - Runic Barrier"],
	FeralbyNight.bossaura["Vezax - Surge of Darkness"],
	FeralbyNight.bossaura["Yogg - Sara's Fervor"],	
	FeralbyNight.bossaura["Yogg - Sara's Anger"], 
	FeralbyNight.bossaura["Yogg - Sara's Blessing"], 	
	FeralbyNight.bossaura["Yogg - Dark volley"],	
	FeralbyNight.bossaura["Yogg - Sanity"],	
	FeralbyNight.bossaura["Yogg - Brain Link"],		
	}

			FeralbyNight.procindex={
	FeralbyNight.procaura["Misdirection"],
	FeralbyNight.procaura["Hysteria"],
	FeralbyNight.procaura["Trick of the Trade"],
	FeralbyNight.procaura["Shattering Throw"],
	FeralbyNight.procaura["Primal Wrath"],
	FeralbyNight.procaura["Primal Instinct"],
	FeralbyNight.procaura["Agile"],
	FeralbyNight.procaura["Evasion"],
	FeralbyNight.procaura["Berserking"],
	FeralbyNight.procaura["Mongoose"],
	FeralbyNight.procaura["FrostforgedChampion"],
	FeralbyNight.procaura["FrostforgedDefender"],
	FeralbyNight.procaura["Executioner"],
	FeralbyNight.procaura["Blood of the Old God"],
	FeralbyNight.procaura["Dark Matter"],
	FeralbyNight.procaura["Heart of Iron"],
	FeralbyNight.procaura["Mark of Norganon"],
	FeralbyNight.procaura["Mjolnir Runestone"],
	FeralbyNight.procaura["The General's Heart"],
	FeralbyNight.procaura["Vaniquished Clutches of Yogg-Saron"],
	FeralbyNight.procaura["Wrathstone"],
	FeralbyNight.procaura["Alacrity of the elements"],
	FeralbyNight.procaura["Furnace Stone"],
	FeralbyNight.procaura["Pyrite Infusion"],
	FeralbyNight.procaura["Bandit's Insigna"],
	FeralbyNight.procaura["Defender's Code"],
	FeralbyNight.procaura["Fury of the Five Flights"],
	FeralbyNight.procaura["Grim Toll"],
	FeralbyNight.procaura["Platinum Disk of Battle"],
	FeralbyNight.procaura["Platinum Disk of Swiftness"],
	FeralbyNight.procaura["Anvil of Titans"],
	FeralbyNight.procaura["DC_Berserk"],
	FeralbyNight.procaura["Greatness"],
	FeralbyNight.procaura["FH Insigna of Fury"],
	FeralbyNight.procaura["Loatheb's Shadow"],
	FeralbyNight.procaura["Reflection of Torment"],
	FeralbyNight.procaura["Resolute"],
	FeralbyNight.procaura["Tears of Bitter Anguish"],
	FeralbyNight.procaura["Valor medal of the first war"],
	FeralbyNight.procaura["Essence of Gossamer"],
	FeralbyNight.procaura["Emerald Boar"],
	FeralbyNight.procaura["Monarch Crab"],
	FeralbyNight.procaura["Ruby Hare"],
	FeralbyNight.procaura["Incisor Fragment"],
	FeralbyNight.procaura["Meteoriute Whetstone"],
	FeralbyNight.procaura["Seal of Panthaleon"],
	FeralbyNight.procaura["Furya"],
	FeralbyNight.procaura["Fortitudea"],
	FeralbyNight.procaura["Tremendous Fortitude"],
	FeralbyNight.procaura["Hardening Armora"],
	FeralbyNight.procaura["Rage"],
	FeralbyNight.procaura["Celerity"],
	FeralbyNight.procaura["Risen Furya"],
	FeralbyNight.procaura["Comet's Trail"],
	FeralbyNight.procaura["Defensive Tactics"],
	FeralbyNight.procaura["Paragona"],
	FeralbyNight.procaura["IcyRagea"],
	FeralbyNight.procaura["Invigoratea"],
	FeralbyNight.procaura["Angercapacitora"],
	FeralbyNight.procaura["AegisofDalanara"],
	FeralbyNight.procaura["Rageofthefallen"],
	FeralbyNight.procaura["agilityofthevyrkula"],
	FeralbyNight.procaura["StrengthoftheTaunkaa"],
	FeralbyNight.procaura["SpeedoftheVrykula"],
	FeralbyNight.procaura["HardenedSkin"],
	FeralbyNight.procaura["ThickSkina"],
	FeralbyNight.procaura["PiercingTwilighta"],
	FeralbyNight.procaura["ScalyNimblenessa"],
	FeralbyNight.procaura["FatalFlaws"],
	FeralbyNight.procaura["IncreasedFortitudo"],

	}
			

			FeralbyNight.proccdindex={
	FeralbyNight.proccd["Misdirection"],
	FeralbyNight.proccd["Hysteria"],
	FeralbyNight.proccd["Trick of the Trade"],
	FeralbyNight.proccd["Shattering Throw"],
	FeralbyNight.proccd["Primal Wrath"],
	FeralbyNight.proccd["Primal Instinct"],
	FeralbyNight.proccd["Agile"],
	FeralbyNight.proccd["Evasion"],
	FeralbyNight.proccd["Berserking"],
	FeralbyNight.proccd["Mongoose"],
	FeralbyNight.proccd["FrostforgedChampion"],
	FeralbyNight.proccd["FrostforgedDefender"],
	FeralbyNight.proccd["Executioner"],
	FeralbyNight.proccd["Blood of the Old God"],
	FeralbyNight.proccd["Dark Matter"],
	FeralbyNight.proccd["Heart of Iron"],
	FeralbyNight.proccd["Mark of Norganon"],
	FeralbyNight.proccd["Mjolnir Runestone"],
	FeralbyNight.proccd["The General's Heart"],
	FeralbyNight.proccd["Vaniquished Clutches of Yogg-Saron"],
	FeralbyNight.proccd["Wrathstone"],
	FeralbyNight.proccd["Alacrity of the elements"],
	FeralbyNight.proccd["Furnace Stone"],
	FeralbyNight.proccd["Pyrite Infusion"],
	FeralbyNight.proccd["Bandit's Insigna"],
	FeralbyNight.proccd["Defender's Code"],
	FeralbyNight.proccd["Fury of the Five Flights"],
	FeralbyNight.proccd["Grim Toll"],
	FeralbyNight.proccd["Platinum Disk of Battle"],
	FeralbyNight.proccd["Platinum Disk of Swiftness"],
	FeralbyNight.proccd["Anvil of Titans"],
	FeralbyNight.proccd["DC_Berserk"],
	FeralbyNight.proccd["Greatness"],
	FeralbyNight.proccd["FH Insigna of Fury"],
	FeralbyNight.proccd["Loatheb's Shadow"],
	FeralbyNight.proccd["Reflection of Torment"],
	FeralbyNight.proccd["Resolute"],
	FeralbyNight.proccd["Tears of Bitter Anguish"],
	FeralbyNight.proccd["Valor medal of the first war"],
	FeralbyNight.proccd["Essence of Gossamer"],
	FeralbyNight.proccd["Emerald Boar"],
	FeralbyNight.proccd["Monarch Crab"],
	FeralbyNight.proccd["Ruby Hare"],
	FeralbyNight.proccd["Incisor Fragment"],
	FeralbyNight.proccd["Meteoriute Whetstone"],
	FeralbyNight.proccd["Seal of Panthaleon"],
	FeralbyNight.proccd["Furya"],
	FeralbyNight.proccd["Fortitudea"],
	FeralbyNight.proccd["Tremendous Fortitude"],
	FeralbyNight.proccd["Hardening Armora"],
	FeralbyNight.proccd["Rage"],
	FeralbyNight.proccd["Celerity"],
	FeralbyNight.proccd["Risen Furya"],
	FeralbyNight.proccd["Comet's Trail"],
	FeralbyNight.proccd["Defensive Tactics"],
	FeralbyNight.proccd["Paragona"],
	FeralbyNight.proccd["IcyRagea"],
	FeralbyNight.proccd["Invigoratea"],
	FeralbyNight.proccd["Angercapacitora"],
	FeralbyNight.proccd["AegisofDalanara"],
	FeralbyNight.proccd["Rageofthefallen"],
	FeralbyNight.proccd["agilityofthevyrkula"],
	FeralbyNight.proccd["StrengthoftheTaunkaa"],
	FeralbyNight.proccd["SpeedoftheVrykula"],
	FeralbyNight.proccd["HardenedSkin"],
	FeralbyNight.proccd["ThickSkina"],
	FeralbyNight.proccd["PiercingTwilighta"],
	FeralbyNight.proccd["ScalyNimblenessa"],
	FeralbyNight.proccd["FatalFlaws"],
	FeralbyNight.proccd["IncreasedFortitudo"],
			}

	  	FeralbyNight.time_to_die=9999999;
	  	FeralbyNight.damage=nil;
	
FeralbyNight.ooctexture=nil;
FeralbyNight.noticetexture=nil;


-- Our sneaky frame to watch for events ... checks FeralbyNight.events[] for the function.  Passes all args.
FeralbyNight.eventFrame = CreateFrame("Frame")
FeralbyNight.eventFrame:SetScript("OnEvent", function(self, event, ...)
  FeralbyNight.events[event](...)
end)

FeralbyNight.eventFrame:RegisterEvent("ADDON_LOADED")
FeralbyNight.eventFrame:RegisterEvent("PLAYER_LOGIN")
FeralbyNight.eventFrame:RegisterEvent("PLAYER_ALIVE")
FeralbyNight.eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
  FeralbyNight.eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
  FeralbyNight.eventFrame:RegisterEvent("COMBAT_RATING_UPDATE") 
  FeralbyNight.eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
  FeralbyNight.eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")    FeralbyNight.eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
    FeralbyNight.eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")


-- Define our Event Handlers here
FeralbyNight.events = {}

function FeralbyNight.events.PLAYER_ALIVE()
	FeralbyNight.eventFrame:UnregisterEvent("PLAYER_ALIVE")
end

function FeralbyNight.events.PLAYER_LOGIN()
  FeralbyNight.playerName = UnitName("player");
 -- FeralbyNight.spellHaste = GetCombatRatingBonus(20)

end

function FeralbyNight.events.ADDON_LOADED(addon)
  if addon ~= "FeralbyNight" then return end

  local _,playerClass = UnitClass("player")
  local playerlevel = UnitLevel("player")
  
  if (playerClass ~= "DRUID" or playerlevel<80) then
	FeralbyNight.eventFrame:UnregisterEvent("PLAYER_ALIVE")
	FeralbyNight.eventFrame:UnregisterEvent("ADDON_LOADED")
	FeralbyNight.eventFrame:UnregisterEvent("PLAYER_LOGIN")
	FeralbyNight.eventFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
  FeralbyNight.eventFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
  FeralbyNight.eventFrame:UnregisterEvent("COMBAT_RATING_UPDATE") 
  FeralbyNight.eventFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
  FeralbyNight.eventFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")    FeralbyNight.eventFrame:UnregisterEvent("PLAYER_REGEN_DISABLED")
     FeralbyNight.eventFrame:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED")
	return 
  end

  -- Default saved variables
if not FeralbyNightdb then
	FeralbyNightdb = {} -- fresh start
	FeralbyNightdb.interrupt={}	
	FeralbyNightdb.versionNumber = 3.321
end
if not FeralbyNightdb.versionNumber then FeralbyNightdb.versionNumber=3.0 end
if FeralbyNightdb.versionNumber==nil then FeralbyNightdb.versionNumber=3.0 end
if FeralbyNightdb.versionNumber < 3.22 then
	FeralbyNightdb = {} -- fresh start
	FeralbyNightdb.interrupt={}	
	FeralbyNightdb.versionNumber = 3.321
end
if FeralbyNightdb.versionNumber < 3.3 then
	FeralbyNightdb.interrupt={}	
end
if FeralbyNightdb.versionNumber ~= 3.321 then
	FeralbyNightdb.versionNumber = 3.321
end
 
  if FeralbyNightdb.badspec == nil then FeralbyNightdb.spec1 = true end
  if FeralbyNightdb.spec1 == nil then FeralbyNightdb.spec1 = true end
    if FeralbyNightdb.spec2 == nil then FeralbyNightdb.spec2 = true end
   if not FeralbyNightdb.updateinterval then FeralbyNightdb.updateinterval = 0.1 end
   if not FeralbyNightdb.killmodeupdateinterval then FeralbyNightdb.killmodeupdateinterval = 1.0 end
  if not FeralbyNightdb.scale then FeralbyNightdb.scale = 0.70 end
     if not FeralbyNightdb.cdmonscale1 then FeralbyNightdb.cdmonscale1 = 1.15 end
     if not FeralbyNightdb.cdmonscale2 then FeralbyNightdb.cdmonscale2 = 1.15 end
     if not FeralbyNightdb.cdmonscale3 then FeralbyNightdb.cdmonscale3 = 1.15 end
     if FeralbyNightdb.lagcorrection== nil then FeralbyNightdb.lagcorrection = true end

      if not FeralbyNightdb.bossfightscale then FeralbyNightdb.bossfightscale = 1.15 end
     if not FeralbyNightdb.myfightscale then FeralbyNightdb.myfightscale = 1.15 end
          if not FeralbyNightdb.procscale then FeralbyNightdb.procscale = 1.15 end
    if not FeralbyNightdb.hudscale then FeralbyNightdb.hudscale = 0.75 end
    if not FeralbyNightdb.meleescale then FeralbyNightdb.meleescale = 0.75 end
    if not FeralbyNightdb.CPscale then FeralbyNightdb.CPscale = 1.6 end
     if not FeralbyNightdb.timetokillscale then FeralbyNightdb.timetokillscale = 1.6 end
    if not FeralbyNightdb.energyscale then FeralbyNightdb.energyscale = 1.6 end
    if not FeralbyNightdb.srscale then FeralbyNightdb.srscale = 1.3 end
     if not FeralbyNightdb.oocscale then FeralbyNightdb.oocscale = 2 end
     if not FeralbyNightdb.noticescale then FeralbyNightdb.noticescale = 0.25 end
  if FeralbyNightdb.locked == nil then FeralbyNightdb.locked = false end
  if FeralbyNightdb.showPrediction == nil then FeralbyNightdb.showPrediction = true end
  if FeralbyNightdb.SRCP == nil then FeralbyNightdb.SRCP = 2 end
  if FeralbyNightdb.manglebot == nil then FeralbyNightdb.manglebot = false end
  if FeralbyNightdb.FFF == nil then FeralbyNightdb.FFF = true end
  if FeralbyNightdb.Berserk == nil then FeralbyNightdb.Berserk = true end
  if FeralbyNightdb.hud == nil then FeralbyNightdb.hud = true end
  if FeralbyNightdb.hudshow == nil then FeralbyNightdb.hudshow = true end
  if FeralbyNightdb.cdmonshow1 == nil then FeralbyNightdb.cdmonshow1 = true end
   if FeralbyNightdb.cdmonshow2 == nil then FeralbyNightdb.cdmonshow2 = true end
  if FeralbyNightdb.cdmonshow3 == nil then FeralbyNightdb.cdmonshow3 = true end

   if FeralbyNightdb.bossfightshow == nil then FeralbyNightdb.bossfightshow = true end
  if FeralbyNightdb.myfightshow == nil then FeralbyNightdb.myfightshow = true end
  if FeralbyNightdb.procshow == nil then FeralbyNightdb.procshow = true end
    if FeralbyNightdb.timetokillframeshow == nil then FeralbyNightdb.timetokillframeshow = true end
  if FeralbyNightdb.energyframeshow == nil then FeralbyNightdb.energyframeshow = true end
  if FeralbyNightdb.cpframeshow == nil then FeralbyNightdb.cpframeshow = true end
  if FeralbyNightdb.statsframeshow == nil then FeralbyNightdb.statsframeshow = true end
  if FeralbyNightdb.suggesterframeshow == nil then FeralbyNightdb.suggesterframeshow = true end
  if FeralbyNightdb.oocframeshow == nil then FeralbyNightdb.oocframeshow = true end
  if FeralbyNightdb.noticeframeshow == nil then FeralbyNightdb.noticeframeshow = true end
   if FeralbyNightdb.srframeshow == nil then FeralbyNightdb.srframeshow = true end
      if FeralbyNightdb.shred == nil then FeralbyNightdb.shred = true end

		if FeralbyNightdb.showdummyvariables==nil then FeralbyNightdb.showdummyvariables=false end
		
		if FeralbyNightdb.MeleeFramefont==nil then FeralbyNightdb.MeleeFramefont=FeralbyNight.fontvector[1] end
		if FeralbyNightdb.MeleeFramefontsize==nil then FeralbyNightdb.MeleeFramefontsize=14 end
		if FeralbyNightdb.barfont==nil then FeralbyNightdb.barfont=FeralbyNight.fontvector[1] end
		if FeralbyNightdb.barfontsize==nil then FeralbyNightdb.barfontsize=14 end
		if FeralbyNightdb.energyFramefont==nil then FeralbyNightdb.energyFramefont=FeralbyNight.fontvector[4] end
		if FeralbyNightdb.energyFramefontsize==nil then FeralbyNightdb.energyFramefontsize=15 end
		if FeralbyNightdb.timetokillFramefont==nil then FeralbyNightdb.timetokillFramefont=FeralbyNight.fontvector[4] end
		if FeralbyNightdb.timetokillFramefontsize==nil then FeralbyNightdb.timetokillFramefontsize=15 end
		if FeralbyNightdb.cpFramefont==nil then FeralbyNightdb.cpFramefont=FeralbyNight.fontvector[4] end
		if FeralbyNightdb.cpFramefontsize==nil then FeralbyNightdb.cpFramefontsize=15 end
		if FeralbyNightdb.srFramefont==nil then FeralbyNightdb.srFramefont=FeralbyNight.fontvector[4] end
		if FeralbyNightdb.srFramefontsize==nil then FeralbyNightdb.srFramefontsize=15 end
		if FeralbyNightdb.cdmonFramefont1==nil then FeralbyNightdb.cdmonFramefont1=FeralbyNight.fontvector[4] end
		if FeralbyNightdb.cdmonFramefont2==nil then FeralbyNightdb.cdmonFramefont2=FeralbyNight.fontvector[4] end
		if FeralbyNightdb.cdmonFramefont3==nil then FeralbyNightdb.cdmonFramefont3=FeralbyNight.fontvector[4] end
 
		if FeralbyNightdb.cdmonFramefontsize1==nil then FeralbyNightdb.cdmonFramefontsize1=14 end
				if FeralbyNightdb.cdmonFramefontsize2==nil then FeralbyNightdb.cdmonFramefontsize2=14 end
		if FeralbyNightdb.cdmonFramefontsize3==nil then FeralbyNightdb.cdmonFramefontsize3=14 end

		if FeralbyNightdb.bossfightFramefont==nil then FeralbyNightdb.bossfightFramefont=FeralbyNight.fontvector[4] end
		if FeralbyNightdb.bossfightFramefontsize==nil then FeralbyNightdb.bossfightFramefontsize=14 end
		if FeralbyNightdb.myfightFramefont==nil then FeralbyNightdb.myfightFramefont=FeralbyNight.fontvector[4] end
		if FeralbyNightdb.myfightFramefontsize==nil then FeralbyNightdb.myfightFramefontsize=14 end
		if FeralbyNightdb.procFramefont==nil then FeralbyNightdb.procFramefont=FeralbyNight.fontvector[4] end
		if FeralbyNightdb.procFramefontsize==nil then FeralbyNightdb.procFramefontsize=14 end
		if FeralbyNightdb.bartexture==nil then FeralbyNightdb.bartexture=FeralbyNight.texturevector[61] end
		if FeralbyNightdb.bordertexture==nil then FeralbyNightdb.bordertexture="FBN_border.tga" end
		
		if FeralbyNightdb.suggestinterrupt==nil then FeralbyNightdb.suggestinterrupt=false end
		if FeralbyNightdb.showcast==nil then FeralbyNightdb.showcast=true end
		if  FeralbyNightdb.mincasttime==nil then FeralbyNightdb.mincasttime=1.5 end
		
		if FeralbyNightdb.bossmode==nil then FeralbyNightdb.bossmode=true end
		if FeralbyNightdb.killmode==nil then FeralbyNightdb.killmode=true end
		
		if FeralbyNightdb.targetidshow==nil then  FeralbyNightdb.targetidshow=false end 
		

		if FeralbyNightdb.interrupt.razorchain==nil then FeralbyNightdb.interrupt.razorchain=true end
		if FeralbyNightdb.interrupt.stormchain==nil then FeralbyNightdb.interrupt.stormchain=true end
		if FeralbyNightdb.interrupt.sentinelblast==nil then FeralbyNightdb.interrupt.sentinelblast=true end
		if FeralbyNightdb.interrupt.stormwhirl==nil then FeralbyNightdb.interrupt.stormwhirl=true end
		if FeralbyNightdb.interrupt.thorimGL==nil then FeralbyNightdb.interrupt.thorimGL=true end
		if FeralbyNightdb.interrupt.thorimRM==nil then FeralbyNightdb.interrupt.thorimRM=true end
		if FeralbyNightdb.interrupt.searingflame==nil then FeralbyNightdb.interrupt.searingflame=true end
		if FeralbyNightdb.interrupt.darkvolley==nil then FeralbyNightdb.interrupt.darkvolley=true end
		if FeralbyNightdb.interrupt.drainlife==nil then FeralbyNightdb.interrupt.drainlife=true end

		if FeralbyNightdb.saveforheart==nil then FeralbyNightdb.saveforheart=true end
		if FeralbyNightdb.saveforrazor==nil then FeralbyNightdb.saveforrazor=true end
		if FeralbyNightdb.shredontentacles==nil then FeralbyNightdb.shredontentacles=false end
		
		if FeralbyNightdb.energypooling==nil then FeralbyNightdb.energypooling=3 end
		if FeralbyNightdb.shredvsrake==nil then FeralbyNightdb.shredvsrake=0.9 end
		if FeralbyNightdb.ripvsfb==nil then FeralbyNightdb.ripvsfb=1 end
		if FeralbyNightdb.srvsfinisher==nil then FeralbyNightdb.srvsfinisher=1 end
		if FeralbyNightdb.manglepriority==nil then FeralbyNightdb.manglepriority=2 end
		
		if FeralbyNightdb.oocoverride==nil then FeralbyNightdb.oocoverride=true end
		if FeralbyNightdb.conservativeplay==nil then FeralbyNightdb.conservativeplay=true end


  -- Create GUI
  FeralbyNight:CreateGUI()
  FeralbyNight.displayFrame:SetScale(FeralbyNightdb.scale)
  FeralbyNight.hudFrame:SetScale(FeralbyNightdb.hudscale)
  FeralbyNight.MeleeFrame:SetScale(FeralbyNightdb.meleescale)
  FeralbyNight.oocFrame:SetScale(FeralbyNightdb.oocscale)
  FeralbyNight.noticeFrame:SetScale(FeralbyNightdb.noticescale)
  FeralbyNight.CPFrame:SetScale(FeralbyNightdb.CPscale)
  FeralbyNight.timetokillFrame:SetScale(FeralbyNightdb.timetokillscale)
  FeralbyNight.srFrame:SetScale(FeralbyNightdb.srscale)
  FeralbyNight.energyFrame:SetScale(FeralbyNightdb.energyscale)
  FeralbyNight.cdmonFrame1:SetScale(FeralbyNightdb.cdmonscale1)
    FeralbyNight.cdmonFrame2:SetScale(FeralbyNightdb.cdmonscale2)
  FeralbyNight.cdmonFrame3:SetScale(FeralbyNightdb.cdmonscale3)

  FeralbyNight.bossfightFrame:SetScale(FeralbyNightdb.bossfightscale)
  FeralbyNight.myfightFrame:SetScale(FeralbyNightdb.myfightscale)
    FeralbyNight.procFrame:SetScale(FeralbyNightdb.procscale)



  -- Create Options Frame
  FeralbyNight:CreateOptionFrame()
    FeralbyNight:CreateOptionFrame1()
    FeralbyNight:CreateOptionFrame5()
  if FeralbyNightdb.locked then
    FeralbyNight.displayFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.displayFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.displayFrame:SetScript("OnDragStop", nil)
    FeralbyNight.displayFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.displayFrame:EnableMouse(false)
    FeralbyNight.cdmonFrame1:SetScript("OnMouseDown", nil)
    FeralbyNight.cdmonFrame1:SetScript("OnMouseUp", nil)
    FeralbyNight.cdmonFrame1:SetScript("OnDragStop", nil)
    FeralbyNight.cdmonFrame1:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.cdmonFrame1:EnableMouse(false)

    FeralbyNight.cdmonFrame2:SetScript("OnMouseDown", nil)
    FeralbyNight.cdmonFrame2:SetScript("OnMouseUp", nil)
    FeralbyNight.cdmonFrame2:SetScript("OnDragStop", nil)
    FeralbyNight.cdmonFrame2:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.cdmonFrame2:EnableMouse(false)
	
	    FeralbyNight.cdmonFrame3:SetScript("OnMouseDown", nil)
    FeralbyNight.cdmonFrame3:SetScript("OnMouseUp", nil)
    FeralbyNight.cdmonFrame3:SetScript("OnDragStop", nil)
    FeralbyNight.cdmonFrame3:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.cdmonFrame3:EnableMouse(false)

    FeralbyNight.bossfightFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.bossfightFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.bossfightFrame:SetScript("OnDragStop", nil)
    FeralbyNight.bossfightFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.bossfightFrame:EnableMouse(false)
    FeralbyNight.myfightFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.myfightFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.myfightFrame:SetScript("OnDragStop", nil)
    FeralbyNight.myfightFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.myfightFrame:EnableMouse(false)
    FeralbyNight.procFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.procFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.procFrame:SetScript("OnDragStop", nil)
    FeralbyNight.procFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.procFrame:EnableMouse(false)
	FeralbyNight.hudFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.hudFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.hudFrame:SetScript("OnDragStop", nil)
    FeralbyNight.hudFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.hudFrame:EnableMouse(false)
	FeralbyNight.MeleeFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.MeleeFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.MeleeFrame:SetScript("OnDragStop", nil)
    FeralbyNight.MeleeFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.MeleeFrame:EnableMouse(false)
		FeralbyNight.CPFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.CPFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.CPFrame:SetScript("OnDragStop", nil)
    FeralbyNight.CPFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.CPFrame:EnableMouse(false)
		FeralbyNight.timetokillFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.timetokillFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.timetokillFrame:SetScript("OnDragStop", nil)
    FeralbyNight.timetokillFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.timetokillFrame:EnableMouse(false)
		FeralbyNight.energyFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.energyFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.energyFrame:SetScript("OnDragStop", nil)
    FeralbyNight.energyFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.energyFrame:EnableMouse(false)
		FeralbyNight.srFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.srFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.srFrame:SetScript("OnDragStop", nil)
    FeralbyNight.srFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.srFrame:EnableMouse(false)
		FeralbyNight.oocFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.oocFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.oocFrame:SetScript("OnDragStop", nil)
    FeralbyNight.oocFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.oocFrame:EnableMouse(false)
		FeralbyNight.noticeFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.noticeFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.noticeFrame:SetScript("OnDragStop", nil)
    FeralbyNight.noticeFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.noticeFrame:EnableMouse(false)
  else
    FeralbyNight.displayFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.displayFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.displayFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.displayFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.displayFrame:EnableMouse(true)
    FeralbyNight.cdmonFrame1:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.cdmonFrame1:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.cdmonFrame1:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.cdmonFrame1:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.cdmonFrame1:EnableMouse(true)
	
    FeralbyNight.cdmonFrame2:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.cdmonFrame2:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.cdmonFrame2:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.cdmonFrame2:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.cdmonFrame2:EnableMouse(true)

    FeralbyNight.cdmonFrame3:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.cdmonFrame3:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.cdmonFrame3:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.cdmonFrame3:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.cdmonFrame3:EnableMouse(true)
	
    FeralbyNight.bossfightFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.bossfightFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.bossfightFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.bossfightFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.bossfightFrame:EnableMouse(true)
    FeralbyNight.myfightFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.myfightFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.myfightFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.myfightFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.myfightFrame:EnableMouse(true)
    FeralbyNight.procFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.procFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.procFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.procFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.procFrame:EnableMouse(true)
	FeralbyNight.hudFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.hudFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.hudFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.hudFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.hudFrame:EnableMouse(true)
	FeralbyNight.MeleeFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.MeleeFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.MeleeFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.MeleeFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.MeleeFrame:EnableMouse(true)
		FeralbyNight.CPFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.CPFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.CPFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.CPFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.CPFrame:EnableMouse(true)
		FeralbyNight.timetokillFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.timetokillFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.timetokillFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.timetokillFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.timetokillFrame:EnableMouse(true)
		FeralbyNight.energyFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.energyFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.energyFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.energyFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.energyFrame:EnableMouse(true)
		FeralbyNight.srFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.srFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.srFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.srFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.srFrame:EnableMouse(true)
		FeralbyNight.oocFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.oocFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.oocFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.oocFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.oocFrame:EnableMouse(true)
		FeralbyNight.noticeFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.noticeFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.noticeFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.noticeFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.noticeFrame:EnableMouse(true)
  end

  -- Register for Slash Commands
  SlashCmdList["FeralbyNight"] = FeralbyNight.Options
  SLASH_FeralbyNight1 = "/FeralbyNight"
  SLASH_FeralbyNight2 = "/fbn"

end

function FeralbyNight.events.COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, arg9, arg10, arg11, arg12,...)
if (event == "SPELL_CAST_FAILED") then
if (arg12==SPELL_FAILED_OUT_OF_RANGE) then
		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["out of range"])
				FeralbyNight.noticestatus="out of range";
				FeralbyNight.notice_timer=GetTime()
				--				print(arg12);
elseif (arg12==SPELL_FAILED_NOT_BEHIND) then
		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["turn"])
						FeralbyNight.noticestatus="turn";
				FeralbyNight.notice_timer=GetTime()
							--					print(arg12);			
end
elseif (event == "SPELL_CAST_SUCCESS") then
if(FeralbyNight.noticestatus=="out of range" or FeralbyNight.noticestatus=="turn" or FeralbyNight.noticestatus=="can't use") then
		FeralbyNight.noticetexture:SetTexture(nil)
				FeralbyNight.noticestatus="nil";
end
end
end

function FeralbyNight.events.COMBAT_RATING_UPDATE(unit)
FeralbyNight:EquipBonuses()
end

function FeralbyNight.events.PLAYER_EQUIPMENT_CHANGED(...)
FeralbyNight:EquipBonuses()
end

function FeralbyNight.events.PLAYER_TARGET_CHANGED(...)
FeralbyNight:EquipBonuses()
  -- target changed, set last target, update current target, will be nil if no target
  if UnitGUID("target") then
  FeralbyNight.currentTarget.guid = UnitGUID("target")
  else
  FeralbyNight.currentTarget.guid = "A"
  end
  FeralbyNight.playertargetchanged=1
     --DEFAULT_CHAT_FRAME:AddMessage((FeralbyNight.currentTarget.guid));
  	FeralbyNight.time_to_die=9999999;
  	FeralbyNight.damage=nil

  FeralbyNight.currentTarget.bosshp = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	[6]=0,
	[7]=0,
	[8]=0,
	[9]=0,
	[10]=0,
	}
FeralbyNight.currentTarget.dps = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	[6]=0,
	[7]=0,
	[8]=0,
	[9]=0,
	[10]=0,
	}
FeralbyNight.currentTarget.bosshp_time = {
	[1]=1,
	[2]=2,
	[3]=3,
	[4]=4,
	[5]=5,
	[6]=6,
	[7]=7,
	[8]=8,
	[9]=9,
	[10]=10,
	}

  FeralbyNight.timetokillFrame:SetText("")
  FeralbyNight.timetokillFrame:Hide()

end
function FeralbyNight.events.PLAYER_REGEN_DISABLED(...)
	FeralbyNight.trinket1="nil";
	FeralbyNight.trinket2="nil";
	FeralbyNight.trinket1special=0;
	FeralbyNight.trinket2special=0;
	  FeralbyNight.trinket1cd=0
  FeralbyNight.trinket2cd=0
end

function FeralbyNight.events.PLAYER_REGEN_ENABLED(...)

	FeralbyNight.time_to_die=9999999;
	FeralbyNight.damage=nil;

FeralbyNight.currentTarget.bosshp = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	[6]=0,
	[7]=0,
	[8]=0,
	[9]=0,
	[10]=0,
	}
FeralbyNight.currentTarget.dps = {
	[1]=0,
	[2]=0,
	[3]=0,
	[4]=0,
	[5]=0,
	[6]=0,
	[7]=0,
	[8]=0,
	[9]=0,
	[10]=0,
	}
FeralbyNight.currentTarget.bosshp_time = {
	[1]=1,
	[2]=2,
	[3]=3,
	[4]=4,
	[5]=5,
	[6]=6,
	[7]=7,
	[8]=8,
	[9]=9,
	[10]=10,
	}
FeralbyNight.timetokillFrame:SetText("")
FeralbyNight.timetokillFrame:Hide()

--[[
local numTabs = GetNumTalentTabs();
for t=1, numTabs do
    DEFAULT_CHAT_FRAME:AddMessage(GetTalentTabInfo(t)..":");
    local numTalents = GetNumTalents(t);
    for i=1, numTalents do
        nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(t,i);
        DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank.." ("..t..", "..i..")");
    end
end
]]--



end
-- End Event Handlers



function FeralbyNight:CreateGUI()

  local hudFrame = CreateFrame("Frame","FeralbyNightHudFrame",UIParent)
  hudFrame:SetFrameStrata("Low")
  hudFrame:SetPoint("BOTTOM",0,150)
  hudFrame:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  			})


		local MeleeFrame = CreateFrame("SimpleHTML","FeralbyNightMeleeFrame",UIParent)
		MeleeFrame:SetFrameStrata("Low")
		MeleeFrame:SetWidth(220); 
		MeleeFrame:SetHeight(62);
		MeleeFrame:SetPoint("BOTTOM",250,140)
		MeleeFrame:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.MeleeFramefont, FeralbyNightdb.MeleeFramefontsize);
		MeleeFrame:SetTextColor(1,1,1,1)
		MeleeFrame:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  			})

  local displayFrame = CreateFrame("Frame","FeralbyNightDisplayFrame",UIParent)
  displayFrame:SetFrameStrata("Low")
  displayFrame:SetWidth(250)
  displayFrame:SetHeight(90)
  displayFrame:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  			})
 
   local oocFrame = CreateFrame("Frame","FeralbyNightoocFrame",UIParent)
  oocFrame:SetFrameStrata("Low")
  oocFrame:SetWidth(128)
  oocFrame:SetHeight(128)
  oocFrame:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  			})
   local noticeFrame = CreateFrame("Frame","FeralbyNightnoticeFrame",UIParent)
  noticeFrame:SetFrameStrata("Low")
  noticeFrame:SetWidth(256)
  noticeFrame:SetHeight(256)
  noticeFrame:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  			})
  
    local cdmonFrame1 = CreateFrame("Frame","FeralbyNightcdmonFrame1",UIParent)
  cdmonFrame1:SetFrameStrata("Low")
  cdmonFrame1:SetWidth(175)
  cdmonFrame1:SetHeight(30)
  cdmonFrame1:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  			})
  			
     local cdmonFrame2 = CreateFrame("Frame","FeralbyNightcdmonFrame2",UIParent)
  cdmonFrame2:SetFrameStrata("Low")
  cdmonFrame2:SetWidth(175)
  cdmonFrame2:SetHeight(30)
  cdmonFrame2:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  			})
 
     local cdmonFrame3 = CreateFrame("Frame","FeralbyNightcdmonFrame3",UIParent)
  cdmonFrame3:SetFrameStrata("Low")
  cdmonFrame3:SetWidth(175)
  cdmonFrame3:SetHeight(30)
  cdmonFrame3:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  			})
  			
     local bossfightFrame = CreateFrame("Frame","FeralbyNightbossfightFrame",UIParent)
  bossfightFrame:SetFrameStrata("Low")
  bossfightFrame:SetWidth(175)
  bossfightFrame:SetHeight(30)
  bossfightFrame:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  			})
     local myfightFrame = CreateFrame("Frame","FeralbyNightmyfightFrame",UIParent)
  myfightFrame:SetFrameStrata("Low")
  myfightFrame:SetWidth(175)
  myfightFrame:SetHeight(30)
  myfightFrame:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  			})
      local procFrame = CreateFrame("Frame","FeralbyNightprocFrame",UIParent)
  procFrame:SetFrameStrata("Low")
  procFrame:SetWidth(175)
  procFrame:SetHeight(30)
  procFrame:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  			})
  			
  					local CPFrame = CreateFrame("SimpleHTML","FeralbyNightCPFrame",UIParent)
		CPFrame:SetFrameStrata("Low")
		CPFrame:SetWidth(40); 
		CPFrame:SetHeight(20);
		CPFrame:SetPoint("CENTER",-100,0)
		CPFrame:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cpFramefont, FeralbyNightdb.cpFramefontsize);
		CPFrame:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  			})
  
    					local timetokillFrame = CreateFrame("SimpleHTML","FeralbyNighttimetokillFrame",UIParent)
		timetokillFrame:SetFrameStrata("Low")
		timetokillFrame:SetWidth(40); 
		timetokillFrame:SetHeight(20);
		timetokillFrame:SetPoint("CENTER",0,0)
		timetokillFrame:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cpFramefont, FeralbyNightdb.cpFramefontsize);
		timetokillFrame:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  			})
  			
    					local srFrame = CreateFrame("SimpleHTML","FeralbyNightsrFrame",UIParent)
		srFrame:SetFrameStrata("Low")
		srFrame:SetWidth(40); 
		srFrame:SetHeight(20);
		srFrame:SetPoint("CENTER",0,-50)
		srFrame:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.srFramefont, FeralbyNightdb.srFramefontsize);
		srFrame:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  			})
  			
  			
			local energyFrame = CreateFrame("SimpleHTML","FeralbyNightenergyFrame",UIParent)
		energyFrame:SetFrameStrata("Low")
		energyFrame:SetWidth(40); 
		energyFrame:SetHeight(20);
		energyFrame:SetPoint("CENTER",100,0)
		energyFrame:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.energyFramefont, FeralbyNightdb.energyFramefontsize);
		energyFrame:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 32,
  			})
  			
  displayFrame:SetBackdropColor(0, 0, 0, .4)
  displayFrame:EnableMouse(true)
  displayFrame:SetMovable(true)
  displayFrame:SetClampedToScreen(true)
  displayFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  displayFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
  displayFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  displayFrame:SetPoint("BOTTOM",0,260)
  
   oocFrame:SetBackdropColor(0, 0, 0, .4)
  oocFrame:EnableMouse(true)
  oocFrame:SetMovable(true)
  oocFrame:SetClampedToScreen(true)
  oocFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  oocFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
  oocFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  oocFrame:SetPoint("CENTER",0,0)

   noticeFrame:SetBackdropColor(0, 0, 0, .4)
  noticeFrame:EnableMouse(true)
  noticeFrame:SetMovable(true)
  noticeFrame:SetClampedToScreen(true)
  noticeFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  noticeFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
  noticeFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  noticeFrame:SetPoint("BOTTOM",-550,450)
  
  cdmonFrame1:SetBackdropColor(0, 0, 0, .4)
  cdmonFrame1:EnableMouse(true)
  cdmonFrame1:SetMovable(true)
  cdmonFrame1:SetClampedToScreen(true)
  cdmonFrame1:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  cdmonFrame1:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
  cdmonFrame1:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  cdmonFrame1:SetPoint("BOTTOM",-160,70)

  cdmonFrame2:SetBackdropColor(0, 0, 0, .4)
  cdmonFrame2:EnableMouse(true)
  cdmonFrame2:SetMovable(true)
  cdmonFrame2:SetClampedToScreen(true)
  cdmonFrame2:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  cdmonFrame2:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
  cdmonFrame2:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  cdmonFrame2:SetPoint("BOTTOM",20,70)

  cdmonFrame3:SetBackdropColor(0, 0, 0, .4)
  cdmonFrame3:EnableMouse(true)
  cdmonFrame3:SetMovable(true)
  cdmonFrame3:SetClampedToScreen(true)
  cdmonFrame3:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  cdmonFrame3:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
  cdmonFrame3:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  cdmonFrame3:SetPoint("BOTTOM",20,70)
  
    bossfightFrame:SetBackdropColor(0, 0, 0, .4)
  bossfightFrame:EnableMouse(true)
  bossfightFrame:SetMovable(true)
  bossfightFrame:SetClampedToScreen(true)
  bossfightFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  bossfightFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
  bossfightFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  bossfightFrame:SetPoint("BOTTOM",-160,150)
 
     myfightFrame:SetBackdropColor(0, 0, 0, .4)
  myfightFrame:EnableMouse(true)
  myfightFrame:SetMovable(true)
  myfightFrame:SetClampedToScreen(true)
 myfightFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  myfightFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
  myfightFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  myfightFrame:SetPoint("BOTTOM",160,150)

   procFrame:SetBackdropColor(0, 0, 0, .4)
  procFrame:EnableMouse(true)
  procFrame:SetMovable(true)
  procFrame:SetClampedToScreen(true)
 procFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  procFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
  procFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  procFrame:SetPoint("BOTTOM",160,300)
    
   hudFrame:SetBackdropColor(0, 0, 0, .4)
  hudFrame:EnableMouse(true)
  hudFrame:SetMovable(true)
  hudFrame:SetClampedToScreen(true)
  hudFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  hudFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
  hudFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  
  MeleeFrame:SetBackdropColor(0, 0, 0, .4)
  MeleeFrame:EnableMouse(true)
  MeleeFrame:SetMovable(true)
  MeleeFrame:SetClampedToScreen(true)
  MeleeFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  MeleeFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
  MeleeFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  
    CPFrame:SetBackdropColor(0, 0, 0, .4)
  CPFrame:EnableMouse(true)
  CPFrame:SetMovable(true)
  CPFrame:SetClampedToScreen(true)
  CPFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  CPFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
  CPFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
 
     timetokillFrame:SetBackdropColor(0, 0, 0, .4)
  timetokillFrame:EnableMouse(true)
  timetokillFrame:SetMovable(true)
  timetokillFrame:SetClampedToScreen(true)
  timetokillFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  timetokillFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
  timetokillFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  
     srFrame:SetBackdropColor(1, 0, 0, .4)
  srFrame:EnableMouse(true)
  srFrame:SetMovable(true)
  srFrame:SetClampedToScreen(true)
  srFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  srFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
  srFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  
    energyFrame:SetBackdropColor(0, 0, 0, .4)
  energyFrame:EnableMouse(true)
  energyFrame:SetMovable(true)
  energyFrame:SetClampedToScreen(true)
  energyFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  energyFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
  energyFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)


  local displayFrame_last = CreateFrame("Frame","$parent_last", FeralbyNightDisplayFrame)
  local displayFrame_current = CreateFrame("Frame","$parent_current", FeralbyNightDisplayFrame)
  local displayFrame_next = CreateFrame("Frame","$parent_next", FeralbyNightDisplayFrame)
  local displayFrame_misc = CreateFrame("Frame","$parent_misc", FeralbyNightDisplayFrame)
  local displayFrame_int = CreateFrame("Frame","$parent_int", FeralbyNightDisplayFrame)
  
  local hudFrame_powerbar=CreateFrame("Frame","$parent_powerbar",FeralbyNightHudFrame);
  local hudFrame_powerbar_frame=CreateFrame("StatusBar","$parent_frame",FeralbyNightHudFrame_powerbar);
  local hudFrame_castbar=CreateFrame("Frame","$parent_castbar",FeralbyNightHudFrame);
  local hudFrame_castbar_frame=CreateFrame("StatusBar","$parent_frame",FeralbyNightHudFrame_castbar);
  local hudFrame_healthbar=CreateFrame("Frame","$parent_healthbar",FeralbyNightHudFrame);
  local hudFrame_healthbar_frame=CreateFrame("StatusBar","$parent_frame",FeralbyNightHudFrame_healthbar);
  local hudFrame_bosspowerbar=CreateFrame("Frame","$parent_bosspowerbar",FeralbyNightHudFrame);
  local hudFrame_bosspowerbar_frame=CreateFrame("StatusBar","$parent_frame",FeralbyNightHudFrame_bosspowerbar);
  local hudFrame_bosshealthbar=CreateFrame("Frame","$parent_bosshealthbar",FeralbyNightHudFrame);
  local hudFrame_bosshealthbar_frame=CreateFrame("StatusBar","$parent_frame",FeralbyNightHudFrame_bosshealthbar);
  local hudFrame_manabar=CreateFrame("Frame","$parent_manabar",FeralbyNightHudFrame);
  local hudFrame_manabar_frame=CreateFrame("StatusBar","$parent_frame",FeralbyNightHudFrame_manabar);
  local hudFrame_threatbar=CreateFrame("Frame","$parent_threatbar",FeralbyNightHudFrame);
  local hudFrame_threatbar_frame=CreateFrame("StatusBar","$parent_frame",FeralbyNightHudFrame_threatbar);


   
for i = 1, 5 do
    local cdmonFramedumb1 = CreateFrame('SimpleHTML',"$parent_"..i,FeralbyNightcdmonFrame1)
    cdmonFramedumb1:SetWidth(30)
    cdmonFramedumb1:SetHeight(30)
    cdmonFramedumb1:SetPoint("LEFT",(i-1)*35,0)
	cdmonFramedumb1:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 30,
  			}) 
    cdmonFramedumb1:SetBackdropColor(0, 0, 0,0)
	cdmonFramedumb1:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont1, FeralbyNightdb.cdmonFramefontsize1);
   
  local t =cdmonFramedumb1:CreateTexture(nil,"Low")
  t:SetTexture(nil)
  t:SetAllPoints(cdmonFramedumb1)
  t:SetAlpha(0.1)
  cdmonFramedumb1.texture = t
  FeralbyNight.abilitycdmon1[i] = t
end

for i = 1, 5 do
    local cdmonFramedumb2 = CreateFrame('SimpleHTML',"$parent_"..i,FeralbyNightcdmonFrame2)
    cdmonFramedumb2:SetWidth(30)
    cdmonFramedumb2:SetHeight(30)
    cdmonFramedumb2:SetPoint("LEFT",(i-1)*35,0)
	cdmonFramedumb2:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 30,
  			}) 
    cdmonFramedumb2:SetBackdropColor(0, 0, 0,0)
	cdmonFramedumb2:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont2, FeralbyNightdb.cdmonFramefontsize2);
   
  local t =cdmonFramedumb2:CreateTexture(nil,"Low")
  t:SetTexture(nil)
  t:SetAllPoints(cdmonFramedumb2)
  t:SetAlpha(0.1)
  cdmonFramedumb2.texture = t
  FeralbyNight.abilitycdmon2[i] = t
end

for i = 1, 5 do
    local cdmonFramedumb3 = CreateFrame('SimpleHTML',"$parent_"..i,FeralbyNightcdmonFrame3)
    cdmonFramedumb3:SetWidth(30)
    cdmonFramedumb3:SetHeight(30)
    cdmonFramedumb3:SetPoint("LEFT",(i-1)*35,0)
	cdmonFramedumb3:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 30,
  			}) 
    cdmonFramedumb3:SetBackdropColor(0, 0, 0,0)
	cdmonFramedumb3:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont3, FeralbyNightdb.cdmonFramefontsize3);
   
  local t =cdmonFramedumb3:CreateTexture(nil,"Low")
  t:SetTexture(nil)
  t:SetAllPoints(cdmonFramedumb3)
  t:SetAlpha(0.1)
  cdmonFramedumb3.texture = t
  FeralbyNight.abilitycdmon3[i] = t
end

for i = 1, 5 do
    local bossfightFramedumb = CreateFrame('SimpleHTML',"$parent_"..i,FeralbyNightbossfightFrame)
    bossfightFramedumb:SetWidth(30)
    bossfightFramedumb:SetHeight(30)
    bossfightFramedumb:SetPoint("LEFT",(i-1)*35,0)
	bossfightFramedumb:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 30,
  			}) 
    bossfightFramedumb:SetBackdropColor(0, 0, 0,0)
	bossfightFramedumb:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.bossfightFramefont, FeralbyNightdb.bossfightFramefontsize);
   
  local t =bossfightFramedumb:CreateTexture(nil,"Low")
  t:SetTexture(nil)
  t:SetAllPoints(bossfightFramedumb)
  t:SetAlpha(0.1)
  bossfightFramedumb.texture = t
  FeralbyNight.bossfight[i] = t
end

for i = 1, 5 do
    local myfightFramedumb = CreateFrame('SimpleHTML',"$parent_"..i,FeralbyNightmyfightFrame)
    myfightFramedumb:SetWidth(30)
    myfightFramedumb:SetHeight(30)
    myfightFramedumb:SetPoint("LEFT",(i-1)*35,0)
	myfightFramedumb:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 30,
  			}) 
    myfightFramedumb:SetBackdropColor(0, 0, 0,0)
	myfightFramedumb:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.myfightFramefont, FeralbyNightdb.myfightFramefontsize);
   
  local t =myfightFramedumb:CreateTexture(nil,"Low")
  t:SetTexture(nil)
  t:SetAllPoints(myfightFramedumb)
  t:SetAlpha(0.1)
  myfightFramedumb.texture = t
  FeralbyNight.myfight[i] = t
end

for i = 1, 5 do
    local procFramedumb = CreateFrame('SimpleHTML',"$parent_"..i,FeralbyNightprocFrame)
    procFramedumb:SetWidth(30)
    procFramedumb:SetHeight(30)
    procFramedumb:SetPoint("LEFT",(i-1)*35,0)
	procFramedumb:SetBackdrop({
          bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 30,
  			}) 
    procFramedumb:SetBackdropColor(0, 0, 0,0)
	procFramedumb:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.procFramefont, FeralbyNightdb.procFramefontsize);
   
  local t =procFramedumb:CreateTexture(nil,"Low")
  t:SetTexture(nil)
  t:SetAllPoints(procFramedumb)
  t:SetAlpha(0.1)
  procFramedumb.texture = t
  FeralbyNight.proc[i] = t
end


  local t =oocFrame:CreateTexture(nil,"Low")
  t:SetTexture(nil)
  t:SetAllPoints(oocFrame)
  t:SetAlpha(0.5)
  oocFrame.texture = t
  FeralbyNight.ooctexture = t
  

  local tt =noticeFrame:CreateTexture(nil,"Low")
  tt:SetTexture(nil)
  tt:SetAllPoints(noticeFrame)
  tt:SetAlpha(0.5)
  noticeFrame.texture = tt
  FeralbyNight.noticetexture = tt

  displayFrame_last:SetWidth(45)
  displayFrame_current:SetWidth(70)
  displayFrame_next:SetWidth(45)
  displayFrame_misc:SetWidth(45)
  displayFrame_int:SetWidth(45)
  
  hudFrame:SetWidth(274);
  hudFrame_powerbar:SetWidth(238);
  hudFrame_powerbar_frame:SetWidth(228);
  hudFrame_castbar:SetWidth(238);
  hudFrame_castbar_frame:SetWidth(228);
  hudFrame_healthbar:SetWidth(238);
  hudFrame_healthbar_frame:SetWidth(228);
  hudFrame_bosspowerbar:SetWidth(238);
  hudFrame_bosspowerbar_frame:SetWidth(228);
  hudFrame_bosshealthbar:SetWidth(238);
  hudFrame_bosshealthbar_frame:SetWidth(228);
  hudFrame_manabar:SetWidth(24);
  hudFrame_manabar_frame:SetWidth(14);
  hudFrame_threatbar:SetWidth(24);
  hudFrame_threatbar_frame:SetWidth(14);

  displayFrame_last:SetHeight(45)
  displayFrame_current:SetHeight(70)
  displayFrame_next:SetHeight(45)
  displayFrame_misc:SetHeight(45)
  displayFrame_int:SetHeight(45)
  
  
  hudFrame_powerbar:SetHeight(24);
  hudFrame_powerbar_frame:SetHeight(14);
  hudFrame_castbar:SetHeight(16);
  hudFrame_castbar_frame:SetHeight(4);
  hudFrame_healthbar:SetHeight(24);
   hudFrame_healthbar_frame:SetHeight(14);
  hudFrame_bosspowerbar:SetHeight(24);
  hudFrame_bosspowerbar_frame:SetHeight(16);
  hudFrame_bosshealthbar:SetHeight(24);
   hudFrame_bosshealthbar_frame:SetHeight(14);
  
    local bar_height=180;
  
  if FeralbyNightdb.hud==false then
  bar_height=180;
  else
  bar_height=72;
  end
  
   hudFrame:SetHeight(bar_height+10);
  hudFrame_manabar:SetHeight(bar_height+10);
  hudFrame_manabar_frame:SetHeight(bar_height);
   hudFrame_threatbar:SetHeight(bar_height+10);
  hudFrame_threatbar_frame:SetHeight(bar_height);
  



  displayFrame_last:SetPoint("TOPLEFT", 0, -45)
  displayFrame_current:SetPoint("TOPLEFT", 90, -10)
  displayFrame_next:SetPoint("TOPLEFT", 200, -45)
  displayFrame_misc:SetPoint("TOPLEFT", 0, 0)
  displayFrame_int:SetPoint("TOPLEFT", 200, 0)
  
  
    
  hudFrame_healthbar:SetPoint("BOTTOM",0,0);
     hudFrame_healthbar:SetBackdropBorderColor(1,1,1,1)
    hudFrame_healthbar:SetBackdrop({
          edgeFile = "Interface\\AddOns\\FeralbyNight\\arts\\border\\"..FeralbyNightdb.bordertexture, tile = true, edgeSize = 16, insets = {left=8, right=8, top=8, bottom=8}
  			})  
  			 hudFrame_healthbar_frame:SetFrameStrata("BACKGROUND");
   hudFrame_healthbar_frame:SetPoint("CENTER",0,0);
  hudFrame_healthbar_frame:SetStatusBarTexture("Interface\\AddOns\\FeralbyNight\\arts\\statusbar\\"..FeralbyNightdb.bartexture);
  hudFrame_healthbar_frame:SetStatusBarColor(0,1,0,0.5)
  hudFrame_healthbar_frame:SetMinMaxValues(0,UnitHealthMax("player"))
  hudFrame_healthbar_frame:SetOrientation("HORIZONTAL")

  
  hudFrame_powerbar:SetPoint("BOTTOM",hudFrame_healthbar,"TOP", 0,-7);
     hudFrame_powerbar:SetBackdropBorderColor(1,1,1,1)
  hudFrame_powerbar:SetBackdrop({
          edgeFile = "Interface\\AddOns\\FeralbyNight\\arts\\border\\"..FeralbyNightdb.bordertexture, tile = true, edgeSize = 16, insets = {left=8, right=8, top=8, bottom=8}
  			})  
  			hudFrame_powerbar_frame:SetFrameStrata("BACKGROUND");
  hudFrame_powerbar_frame:SetPoint("CENTER",0,0);
  hudFrame_powerbar_frame:SetStatusBarTexture("Interface\\AddOns\\FeralbyNight\\arts\\statusbar\\"..FeralbyNightdb.bartexture);
  hudFrame_powerbar_frame:SetStatusBarColor(1,1,0,0.5)
  hudFrame_powerbar_frame:SetMinMaxValues(0,UnitPowerMax("player"));
  hudFrame_powerbar_frame:SetOrientation("HORIZONTAL")
 

      hudFrame_castbar:SetPoint("BOTTOM",hudFrame_powerbar,"TOP", 0,-8);
 hudFrame_castbar_frame:SetFrameStrata("BACKGROUND");
  hudFrame_castbar_frame:SetPoint("CENTER",0,0);
     hudFrame_castbar:SetBackdropBorderColor(1,1,1,1)
  hudFrame_castbar_frame:SetStatusBarTexture("Interface\\AddOns\\FeralbyNight\\arts\\statusbar\\"..FeralbyNightdb.bartexture);
  hudFrame_castbar_frame:SetStatusBarColor(1,1,0,0.5)
  hudFrame_castbar_frame:SetMinMaxValues(0,100)
  hudFrame_castbar_frame:SetOrientation("HORIZONTAL")
   
   
   
    hudFrame_bosshealthbar:SetPoint("TOP",0,0);
   hudFrame_bosshealthbar:SetBackdropBorderColor(1,1,1,1)
    hudFrame_bosshealthbar:SetBackdrop({
          edgeFile = "Interface\\AddOns\\FeralbyNight\\arts\\border\\"..FeralbyNightdb.bordertexture, tile = true, edgeSize = 16, insets = {left=8, right=8, top=8, bottom=8}
  			})  
  			hudFrame_bosshealthbar_frame:SetFrameStrata("BACKGROUND");
   hudFrame_bosshealthbar_frame:SetPoint("CENTER",0,0);
  hudFrame_bosshealthbar_frame:SetStatusBarTexture("Interface\\AddOns\\FeralbyNight\\arts\\statusbar\\"..FeralbyNightdb.bartexture);
  hudFrame_bosshealthbar_frame:SetStatusBarColor(0,1,0,0.5)
  hudFrame_bosshealthbar_frame:SetMinMaxValues(0,UnitHealthMax("Target"))
  hudFrame_bosshealthbar_frame:SetOrientation("HORIZONTAL")
  
 
   hudFrame_bosspowerbar:SetPoint("TOP",hudFrame_bosshealthbar,"BOTTOM",0,7);
      hudFrame_bosspowerbar:SetBackdropBorderColor(1,1,1,1)
  hudFrame_bosspowerbar:SetBackdrop({
          edgeFile = "Interface\\AddOns\\FeralbyNight\\arts\\border\\"..FeralbyNightdb.bordertexture, tile = true, edgeSize = 16, insets = {left=8, right=8, top=8, bottom=8}
  			})  
  			hudFrame_bosspowerbar_frame:SetFrameStrata("BACKGROUND");
  hudFrame_bosspowerbar_frame:SetPoint("CENTER",0,0);
  hudFrame_bosspowerbar_frame:SetStatusBarTexture("Interface\\AddOns\\FeralbyNight\\arts\\statusbar\\"..FeralbyNightdb.bartexture);
  hudFrame_bosspowerbar_frame:SetStatusBarColor(1,1,0,0.5)
  hudFrame_bosspowerbar_frame:SetMinMaxValues(0,UnitPowerMax("Target"));
  hudFrame_bosspowerbar_frame:SetOrientation("HORIZONTAL")
  

  
  hudFrame_manabar:SetPoint("BOTTOMLEFT",0,0);
    hudFrame_manabar:SetBackdropBorderColor(1,1,1,1)
    hudFrame_manabar:SetBackdrop({
          edgeFile = "Interface\\AddOns\\FeralbyNight\\arts\\border\\"..FeralbyNightdb.bordertexture, tile = true, edgeSize = 16, insets = {left=8, right=8, top=8, bottom=8}
  			})  
  			hudFrame_manabar_frame:SetFrameStrata("BACKGROUND");
    hudFrame_manabar_frame:SetPoint("BOTTOM",0,6);
  hudFrame_manabar_frame:SetStatusBarTexture("Interface\\AddOns\\FeralbyNight\\arts\\statusbar\\"..FeralbyNightdb.bartexture);
  hudFrame_manabar_frame:SetStatusBarColor(0,0,1,0.5)
  hudFrame_manabar_frame:SetMinMaxValues(0,100)
  hudFrame_manabar_frame:SetOrientation("VERTICAL")
  

  hudFrame_threatbar:SetPoint("BOTTOMRIGHT",0,0);
    hudFrame_threatbar:SetBackdropBorderColor(1,1,1,1)
    hudFrame_threatbar:SetBackdrop({
          edgeFile = "Interface\\AddOns\\FeralbyNight\\arts\\border\\"..FeralbyNightdb.bordertexture, tile = true, edgeSize = 16, insets = {left=8, right=8, top=8, bottom=8}
  			})  
  			hudFrame_threatbar_frame:SetFrameStrata("BACKGROUND");
    hudFrame_threatbar_frame:SetPoint("BOTTOM",0,6);
  hudFrame_threatbar_frame:SetStatusBarTexture("Interface\\AddOns\\FeralbyNight\\arts\\statusbar\\"..FeralbyNightdb.bartexture);
  hudFrame_threatbar_frame:SetStatusBarColor(1,0,0,0.5)
  hudFrame_threatbar_frame:SetMinMaxValues(0,100)
  hudFrame_threatbar_frame:SetOrientation("VERTICAL")
  

  local t = displayFrame_last:CreateTexture(nil,"Low")
  t:SetTexture(nil)
  t:SetAllPoints(displayFrame_last)
  t:SetAlpha(.8)
  displayFrame_last.texture = t
  FeralbyNight.textureList["last"] = t

  t = displayFrame_current:CreateTexture(nil,"Low")
  t:SetTexture(nil)
  t:ClearAllPoints()
  t:SetAllPoints(displayFrame_current)
  displayFrame_current.texture = t
  FeralbyNight.textureList["current"] = t



  t = displayFrame_next:CreateTexture(nil,"Low")
  t:SetTexture(nil)
  t:SetAllPoints(displayFrame_next)
  t:SetAlpha(.8)
  displayFrame_next.texture = t
  FeralbyNight.textureList["next"] = t

  t = displayFrame_misc:CreateTexture(nil,"Low")
  t:SetTexture(nil)
  t:SetAllPoints(displayFrame_misc)
  t:SetAlpha(.8)
  displayFrame_misc.texture = t
  FeralbyNight.textureList["misc"] = t

  t = displayFrame_int:CreateTexture(nil,"Low")
  t:SetTexture(nil)
  t:SetAllPoints(displayFrame_int)
  t:SetAlpha(.8)
  displayFrame_int.texture = t
  FeralbyNight.textureList["int"] = t



  displayFrame:SetScript("OnUpdate", function(self, elapsed)
    FeralbyNight:OnUpdate(elapsed)
  end)
  

  local cooldownFrame = CreateFrame("Cooldown","$parent_cooldown", FeralbyNightDisplayFrame_current)
  cooldownFrame:SetHeight(70)
  cooldownFrame:SetWidth(70)
  cooldownFrame:ClearAllPoints()
  cooldownFrame:SetPoint("CENTER", displayFrame_current, "CENTER", 0, 0)

  FeralbyNight.MeleeFrame = MeleeFrame
  FeralbyNight.displayFrame = displayFrame
  FeralbyNight.cdmonFrame1 = cdmonFrame1
    FeralbyNight.cdmonFrame2 = cdmonFrame2
  FeralbyNight.cdmonFrame3 = cdmonFrame3

   FeralbyNight.bossfightFrame = bossfightFrame
  FeralbyNight.myfightFrame = myfightFrame
    FeralbyNight.procFrame = procFrame


    FeralbyNight.hudFrame = hudFrame
    FeralbyNight.hudFrame_powerbar = hudFrame_powerbar
        FeralbyNight.hudFrame_powerbar_frame = hudFrame_powerbar_frame
    FeralbyNight.hudFrame_castbar = hudFrame_castbar
        FeralbyNight.hudFrame_castbar_frame = hudFrame_castbar_frame
    FeralbyNight.hudFrame_healthbar = hudFrame_healthbar
        FeralbyNight.hudFrame_healthbar_frame = hudFrame_healthbar_frame
    FeralbyNight.hudFrame_manabar = hudFrame_manabar
      FeralbyNight.hudFrame_manabar_frame = hudFrame_manabar_frame
    FeralbyNight.hudFrame_threatbar= hudFrame_threatbar
     FeralbyNight.hudFrame_threatbar_frame= hudFrame_threatbar_frame
    FeralbyNight.CPFrame = CPFrame
     FeralbyNight.timetokillFrame = timetokillFrame
    FeralbyNight.srFrame = srFrame
  FeralbyNight.energyFrame = energyFrame
  FeralbyNight.displayFrame_last = displayFrame_last
  FeralbyNight.displayFrame_current = displayFrame_current
  FeralbyNight.displayFrame_next = displayFrame_next
  FeralbyNight.displayFrame_misc =  displayFrame_misc
  FeralbyNight.displayFrame_int =  displayFrame_int
  FeralbyNight.cooldownFrame = cooldownFrame
     FeralbyNight.oocFrame = oocFrame
   FeralbyNight.noticeFrame = noticeFrame
     FeralbyNight.hudFrame_bosspowerbar = hudFrame_bosspowerbar
        FeralbyNight.hudFrame_bosspowerbar_frame = hudFrame_bosspowerbar_frame
    FeralbyNight.hudFrame_bosshealthbar = hudFrame_bosshealthbar
        FeralbyNight.hudFrame_bosshealthbar_frame = hudFrame_bosshealthbar_frame


  local text_cap = FeralbyNight.hudFrame_powerbar:CreateFontString("FeralbyNightHudFrame_powerbar_text","OVERLAY")
  text_cap:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize)
  text_cap:ClearAllPoints()
  text_cap:SetPoint("CENTER",0,0) 
  text_cap:SetTextColor(1,1,1,1)
  text_cap:SetJustifyV("CENTER")  
  text_cap:SetJustifyH("CENTER")  
  text_cap:SetText(nil)
text_cap:SetShadowColor(0,0,0,1)
text_cap:SetShadowOffset(1,-1)
  FeralbyNight.hudFrame_powerbar.text=text_cap
  
  text_cap = FeralbyNight.hudFrame_bosshealthbar:CreateFontString("FeralbyNightHudFrame_bosshealthbar_text","OVERLAY")
    text_cap:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize)
   text_cap:ClearAllPoints()
  text_cap:SetPoint("CENTER",0,0) 
  text_cap:SetTextColor(1,1,1,1)
  text_cap:SetJustifyV("CENTER")  
  text_cap:SetJustifyH("CENTER")  
  text_cap:SetText(nil)
text_cap:SetShadowColor(0,0,0,1)
text_cap:SetShadowOffset(1,-1)
  FeralbyNight.hudFrame_bosshealthbar.text=text_cap

  text_cap = FeralbyNight.hudFrame_healthbar:CreateFontString("FeralbyNightHudFrame_healthbar_text","OVERLAY")
   text_cap:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize)
   text_cap:ClearAllPoints()
  text_cap:SetPoint("CENTER",0,0) 
  text_cap:SetTextColor(1,1,1,1)
  text_cap:SetJustifyV("CENTER")  
  text_cap:SetJustifyH("CENTER")  
  text_cap:SetText(nil)
text_cap:SetShadowColor(0,0,0,1)
text_cap:SetShadowOffset(1,-1)
   FeralbyNight.hudFrame_healthbar.text=text_cap

  text_cap = FeralbyNight.hudFrame_bosspowerbar:CreateFontString("FeralbyNightHudFrame_bosspowerbar_text","OVERLAY")
    text_cap:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize)
  text_cap:ClearAllPoints()
  text_cap:SetPoint("CENTER",0,0) 
  text_cap:SetTextColor(1,1,1,1)
  text_cap:SetJustifyV("CENTER")  
  text_cap:SetJustifyH("CENTER")  
  text_cap:SetText(nil)
text_cap:SetShadowColor(0,0,0,1)
text_cap:SetShadowOffset(1,-1)
   FeralbyNight.hudFrame_bosspowerbar.text=text_cap


  text_cap = FeralbyNight.hudFrame_castbar:CreateFontString("FeralbyNightHudFrame_castbar_text","OVERLAY")
      text_cap:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize)
   text_cap:ClearAllPoints()
  text_cap:SetPoint("CENTER",0,0) 
  text_cap:SetTextColor(1,1,1,1)
  text_cap:SetJustifyV("CENTER")  
  text_cap:SetJustifyH("CENTER")  
  text_cap:SetText(nil)
text_cap:SetShadowColor(0,0,0,1)
text_cap:SetShadowOffset(1,-1)
    FeralbyNight.hudFrame_castbar.text=text_cap

  
  text_cap = FeralbyNight.hudFrame_threatbar:CreateFontString("FeralbyNightHudFrame_threatbar_text","OVERLAY")
   text_cap:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize)
   text_cap:ClearAllPoints()
  text_cap:SetPoint("CENTER",0,0) 
  text_cap:SetTextColor(1,1,1,1)
  text_cap:SetJustifyV("CENTER")  
  text_cap:SetJustifyH("CENTER")  
text_cap:SetText(nil)
text_cap:SetShadowColor(0,0,0,1)
text_cap:SetShadowOffset(1,-1)
   FeralbyNight.hudFrame_threatbar.text=text_cap

  
  text_cap = FeralbyNight.hudFrame_manabar:CreateFontString("FeralbyNightHudFrame_manabar_text","OVERLAY")
   text_cap:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize)
   text_cap:ClearAllPoints()
  text_cap:SetPoint("CENTER",0,0) 
  text_cap:SetTextColor(1,1,1,1)
  text_cap:SetJustifyV("CENTER")  
  text_cap:SetJustifyH("CENTER")  
  text_cap:SetText(nil)
text_cap:SetShadowColor(0,0,0,1)
text_cap:SetShadowOffset(1,-1)
   FeralbyNight.hudFrame_manabar.text=text_cap


if FeralbyNightdb.oocframeshow == false then
	FeralbyNight.oocFrame:Hide()
	else
	FeralbyNight.oocFrame:Show()
end
if FeralbyNightdb.noticeframeshow == false then
	FeralbyNight.noticeFrame:Hide()
	else
	FeralbyNight.noticeFrame:Show()
end
if FeralbyNightdb.cdmonshow1 == false then
	FeralbyNight.cdmonFrame1:Hide()
	else
	FeralbyNight.cdmonFrame1:Show()
end
if (FeralbyNightdb.cdmonshow2 == false or catform == nil) then
	FeralbyNight.cdmonFrame2:Hide()
	else
	FeralbyNight.cdmonFrame2:Show()
end
if (FeralbyNightdb.cdmonshow3 == false or bearform == nil) then
	FeralbyNight.cdmonFrame3:Hide()
	else
	FeralbyNight.cdmonFrame3:Show()
end
if FeralbyNightdb.bossfightshow == false then
	FeralbyNight.bossfightFrame:Hide()
	else
	FeralbyNight.bossfightFrame:Show()
end
if FeralbyNightdb.myfightshow == false then
	FeralbyNight.myfightFrame:Hide()
	else
	FeralbyNight.myfightFrame:Show()
end
if FeralbyNightdb.procshow == false then
	FeralbyNight.procFrame:Hide()
	else
	FeralbyNight.procFrame:Show()
end
if FeralbyNightdb.hudshow == false then
	FeralbyNight.hudFrame:Hide()
	else
	FeralbyNight.hudFrame:Show()
end
if FeralbyNightdb.suggesterframeshow == false then
		FeralbyNight.displayFrame_last:Hide()
		FeralbyNight.displayFrame_current:Hide()
		FeralbyNight.displayFrame_next:Hide()
		FeralbyNight.displayFrame_misc:Hide()
		FeralbyNight.displayFrame_int:Hide()
else
		FeralbyNight.displayFrame_last:Show()
		FeralbyNight.displayFrame_current:Show()
		FeralbyNight.displayFrame_next:Show()
		FeralbyNight.displayFrame_misc:Show()
		FeralbyNight.displayFrame_int:Show()
	end
if FeralbyNightdb.statsframeshow == false then
	FeralbyNight.MeleeFrame:Hide()
	else
	FeralbyNight.MeleeFrame:Show()
	end
if FeralbyNightdb.cpframeshow == false then
	FeralbyNight.CPFrame:Hide()
else
	FeralbyNight.CPFrame:Show()

	end
if (FeralbyNightdb.timetokillframeshow == true and FeralbyNight.time_to_die>0 and FeralbyNight.time_to_die<99999) then
	FeralbyNight.timetokillFrame:Show()
else
FeralbyNight.timetokillFrame:SetText("")
	FeralbyNight.timetokillFrame:Hide()

	end
if FeralbyNightdb.energyframeshow == false then
	FeralbyNight.energyFrame:Hide()
else
	FeralbyNight.energyFrame:Show()

	end
if FeralbyNightdb.srframeshow == false then
	FeralbyNight.srFrame:Hide()
else
	FeralbyNight.srFrame:Show()

end


end



function FeralbyNight:OnUpdate(elapsed)
  FeralbyNight.timeSinceLastUpdate = FeralbyNight.timeSinceLastUpdate + elapsed;
  while (FeralbyNight.timeSinceLastUpdate >= FeralbyNightdb.updateinterval) do
    
    	local catform, _, _, _, _, _, _, _, _ = UnitAura("player", FeralbyNight.L["Cat Form"]); 
	local bearform, _, _, _, _, _, _, _, _ = UnitAura("player", FeralbyNight.L["Dire Bear Form"]); 
	
	  ParseGUID(UnitGUID("target"))
if FeralbyNight.playertargetchanged == 1 then
      if FeralbyNightdb.targetidshow  then
        print("NPC, ID #",FeralbyNight.currentTarget.id)
        end
FeralbyNight.playertargetchanged = 0
end
	
	if (FeralbyNightdb.cdmonshow2 == false or catform == nil) then
	FeralbyNight.cdmonFrame2:Hide()
	else
	FeralbyNight.cdmonFrame2:Show()
end
if (FeralbyNightdb.cdmonshow3 == false or bearform == nil) then
	FeralbyNight.cdmonFrame3:Hide()
	else
	FeralbyNight.cdmonFrame3:Show()
end
	
    local spec=GetActiveTalentGroup(isInspect);


if( ((FeralbyNightdb.spec1==false and spec==1) or(FeralbyNightdb.spec2==false and spec==2))) then
 FeralbyNightdb.badspec=true;

	  FeralbyNight.MeleeFrame:Hide()
  FeralbyNight.cdmonFrame1:Hide()
    FeralbyNight.cdmonFrame2:Hide()
  FeralbyNight.cdmonFrame3:Hide()

   FeralbyNight.bossfightFrame:Hide()
  FeralbyNight.myfightFrame:Hide()
    FeralbyNight.procFrame:Hide()


    FeralbyNight.hudFrame:Hide()
    FeralbyNight.CPFrame:Hide()
     FeralbyNight.timetokillFrame:Hide()
    FeralbyNight.srFrame:Hide()
  FeralbyNight.energyFrame:Hide()
  FeralbyNight.displayFrame_last:Hide()
  FeralbyNight.displayFrame_current:Hide()
  FeralbyNight.displayFrame_next:Hide()
  FeralbyNight.displayFrame_misc:Hide()
  FeralbyNight.displayFrame_int:Hide()
  FeralbyNight.cooldownFrame:Hide()
   FeralbyNight.oocFrame:Hide()
   FeralbyNight.noticeFrame:Hide()


  end
  if( ((FeralbyNightdb.spec1==true and spec==1) or(FeralbyNightdb.spec2==true and spec==2)) and FeralbyNightdb.badspec==true) then
 FeralbyNightdb.badspec=false;
   if FeralbyNightdb.oocframeshow == false then
	FeralbyNight.oocFrame:Hide()
	else
	FeralbyNight.oocFrame:Show()
end
   if FeralbyNightdb.noticeframeshow == false then
	FeralbyNight.noticeFrame:Hide()
	else
	FeralbyNight.noticeFrame:Show()
end
if FeralbyNightdb.cdmonshow1 == false then
	FeralbyNight.cdmonFrame1:Hide()
	else
	FeralbyNight.cdmonFrame1:Show()
end
if (FeralbyNightdb.cdmonshow2 == false or catform == nil) then
	FeralbyNight.cdmonFrame2:Hide()
	else
	FeralbyNight.cdmonFrame2:Show()
end
if (FeralbyNightdb.cdmonshow3 == false or bearform == nil) then
	FeralbyNight.cdmonFrame3:Hide()
	else
	FeralbyNight.cdmonFrame3:Show()
end
if FeralbyNightdb.bossfightshow == false then
	FeralbyNight.bossfightFrame:Hide()
	else
	FeralbyNight.bossfightFrame:Show()
end
if FeralbyNightdb.myfightshow == false then
	FeralbyNight.myfightFrame:Hide()
	else
	FeralbyNight.myfightFrame:Show()
end
if FeralbyNightdb.procshow == false then
	FeralbyNight.procFrame:Hide()
	else
	FeralbyNight.procFrame:Show()
end
if FeralbyNightdb.hudshow == false then
	FeralbyNight.hudFrame:Hide()
	else
	FeralbyNight.hudFrame:Show()
end
if FeralbyNightdb.suggesterframeshow == false then
		FeralbyNight.displayFrame_last:Hide()
		FeralbyNight.displayFrame_current:Hide()
		FeralbyNight.displayFrame_next:Hide()
		FeralbyNight.displayFrame_misc:Hide()
		FeralbyNight.displayFrame_int:Hide()
else
		FeralbyNight.displayFrame_last:Show()
		FeralbyNight.displayFrame_current:Show()
		FeralbyNight.displayFrame_next:Show()
		FeralbyNight.displayFrame_misc:Show()
		FeralbyNight.displayFrame_int:Show()
	end
if FeralbyNightdb.statsframeshow == false then
	FeralbyNight.MeleeFrame:Hide()
	else
	FeralbyNight.MeleeFrame:Show()
	end
if FeralbyNightdb.cpframeshow == false then
	FeralbyNight.CPFrame:Hide()
else
	FeralbyNight.CPFrame:Show()

	end
if (FeralbyNightdb.timetokillframeshow == true and FeralbyNight.time_to_die>0 and FeralbyNight.time_to_die<99999) then
	FeralbyNight.timetokillFrame:Show()
else
FeralbyNight.timetokillFrame:SetText("")
	FeralbyNight.timetokillFrame:Hide()

	end
if FeralbyNightdb.energyframeshow == false then
	FeralbyNight.energyFrame:Hide()
else
	FeralbyNight.energyFrame:Show()

	end
if FeralbyNightdb.srframeshow == false then
	FeralbyNight.srFrame:Hide()
else
	FeralbyNight.srFrame:Show()

end
end



 
    local bar_height=180;
  
  if FeralbyNightdb.hud==false then
  bar_height=180;
  else
  bar_height=72;
  end
  
   FeralbyNight.hudFrame:SetHeight(bar_height+10);
  FeralbyNight.hudFrame_manabar:SetHeight(bar_height+10);
  FeralbyNight.hudFrame_manabar_frame:SetHeight(bar_height);
   FeralbyNight.hudFrame_threatbar:SetHeight(bar_height+10);
  FeralbyNight.hudFrame_threatbar_frame:SetHeight(bar_height);
  
  	local name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Mangle (Cat)"])
	 	mangle_energy=powerCost;
	
	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Shred"])
		shred_energy=powerCost;
	
	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Rake"])
		rake_energy=powerCost;

	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Rip"])
		rip_energy=powerCost;

	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Savage Roar"])
		sr_energy=powerCost;
	
	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Ferocious Bite"])
		fb_energy=powerCost;
		
	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Cat Form"])
		catform_mana=powerCost;
  
  
  	local currentTime = GetTime()
  	if (currentTime-FeralbyNight.notice_timer)>4 then
		FeralbyNight.noticetexture:SetTexture(nil)
		end
  	

  local	name, _, _, _, _, _, _, _, _ = UnitAura("player", FeralbyNight.L["Clearcasting"]); 
	if name ~= nil then
		FeralbyNight.ooctexture:SetTexture("Interface\\AddOns\\FeralbyNight\\arts\\clearcast.tga")
	else
		FeralbyNight.ooctexture:SetTexture(nil)
	end

local sr_frame_count=0
local name, _, _, _, _, _, expirationTime, _, _ = UnitAura("player", FeralbyNight.L["Savage Roar"]); 
	if name ~= nil then
		sr_frame_count = expirationTime - currentTime
	end	
	if (bearform~= nil) then
 name, _, _, _, _, _, expirationTime, _, _ = UnitAura("player", FeralbyNight.L["Barkskin"]); 
	if name ~= nil then
		sr_frame_count = expirationTime - currentTime
	end	
 name, _, _, _, _, _, expirationTime, _, _ = UnitAura("player", FeralbyNight.L["Survival Instincts"]); 
	if name ~= nil then
		sr_frame_count = expirationTime - currentTime
	end	
	end

  
    local lacerate=0
    local lacerate_stack=0
    
 	local	 name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Lacerate Debuff"]); 
	if name ~= nil and caster == "player" then
		lacerate = expirationTime - currentTime
		lacerate_stack=count
		end
	
		local cp = GetComboPoints("player")
  
  	local bosspower=UnitPower("Target");
	local bosshealth=UnitHealth("Target");
	local bossmaxhp=UnitHealthMax("Target");
	local bossmaxpower=UnitPowerMax("Target")
	local bossUID=UnitGUID("Target")
	--local bossindex=tonumber(string.sub(bossUID, 6,10),16)
	-- DEFAULT_CHAT_FRAME:AddMessage("Target ID: ", bossindex);



	local power=UnitPower("player");
local maxpower=UnitPowerMax("player")
local maxhp=UnitHealthMax("player");
	local energy=UnitPower("player",3);
	local rage=UnitPower("player",1);
	
	local mana=UnitPower("player",0);
	local health=UnitHealth("player");
	
	local bossname, _=UnitName("Target");
	local bosslevel = UnitLevel("Target");
	if bosslevel ==nil then
	bosslevel=0
	elseif bosslevel ==-1 then
	bosslevel = 83
	end
	FeralbyNight.hudFrame_bosspowerbar.text:SetText(nil)
	FeralbyNight.hudFrame_bosshealthbar.text:SetText(nil)
	FeralbyNight.hudFrame_threatbar.text:SetText(nil)
	


  while ((currentTime-FeralbyNight.timeSinceLastUpdate_dps) >= FeralbyNightdb.killmodeupdateinterval) do

	--FeralbyNight.time_to_die=9999999;
	--FeralbyNight.damage=0;

for i = 1, 9 do
    --DEFAULT_CHAT_FRAME:AddMessage(FeralbyNight.currentTarget.bosshp[i]..", "..FeralbyNight.currentTarget.bosshp[i]..", "..FeralbyNight.currentTarget.dps[i]);

FeralbyNight.currentTarget.bosshp[i]=FeralbyNight.currentTarget.bosshp[i+1]
FeralbyNight.currentTarget.bosshp_time[i]=FeralbyNight.currentTarget.bosshp_time[i+1]
FeralbyNight.currentTarget.dps[i]=FeralbyNight.currentTarget.dps[i+1]
end
    --DEFAULT_CHAT_FRAME:AddMessage(" ");
	FeralbyNight.currentTarget.bosshp[10]=bosshealth
	
	if FeralbyNight.currentTarget.bosshp[10]>FeralbyNight.currentTarget.bosshp[9] then
		for i=1,9 do
		FeralbyNight.currentTarget.bosshp[i]=FeralbyNight.currentTarget.bosshp[10]-10*(10-i)
		end
	end
	FeralbyNight.currentTarget.bosshp_time[10]=currentTime
	FeralbyNight.currentTarget.dps[10]=(FeralbyNight.currentTarget.bosshp[9]-FeralbyNight.currentTarget.bosshp[10])/(FeralbyNight.currentTarget.bosshp_time[10]-FeralbyNight.currentTarget.bosshp_time[9])

	FeralbyNight.damage=0.15*FeralbyNight.currentTarget.dps[10]+0.14*FeralbyNight.currentTarget.dps[9]
	+0.13*FeralbyNight.currentTarget.dps[8]+0.12*FeralbyNight.currentTarget.dps[7]
+0.11*FeralbyNight.currentTarget.dps[6]+0.10*FeralbyNight.currentTarget.dps[5]+0.08*FeralbyNight.currentTarget.dps[4]
+0.07*FeralbyNight.currentTarget.dps[3]+0.06*FeralbyNight.currentTarget.dps[2]+0.04*FeralbyNight.currentTarget.dps[1];
if (FeralbyNight.currentTarget.bosshp[1]>0 and FeralbyNight.currentTarget.dps[1]>0) then
FeralbyNight.time_to_die=bosshealth/FeralbyNight.damage
if ((FeralbyNight.time_to_die>0) and FeralbyNightdb.timetokillframeshow and FeralbyNight.time_to_die<99999) then
	FeralbyNight.timetokillFrame:Show()
if math.floor(FeralbyNight.time_to_die/60)<10 and (FeralbyNight.time_to_die-math.floor(FeralbyNight.time_to_die/60)*60)<10 then
FeralbyNight.timetokillFrame:SetText("0"..string.format("%.0f", math.floor(FeralbyNight.time_to_die/60))..":0"..string.format("%.0f", FeralbyNight.time_to_die-math.floor(FeralbyNight.time_to_die/60)*60))
elseif math.floor(FeralbyNight.time_to_die/60)<10 and (FeralbyNight.time_to_die-math.floor(FeralbyNight.time_to_die/60)*60)>10 then
FeralbyNight.timetokillFrame:SetText("0"..string.format("%.0f", math.floor(FeralbyNight.time_to_die/60))..":"..string.format("%.0f", FeralbyNight.time_to_die-math.floor(FeralbyNight.time_to_die/60)*60))
elseif math.floor(FeralbyNight.time_to_die/60)>10 and math.floor(FeralbyNight.time_to_die/60)<=59 and (FeralbyNight.time_to_die-math.floor(FeralbyNight.time_to_die/60)*60)<10 then
FeralbyNight.timetokillFrame:SetText(string.format("%.0f", math.floor(FeralbyNight.time_to_die/60))..":0"..string.format("%.0f", FeralbyNight.time_to_die-math.floor(FeralbyNight.time_to_die/60)*60))
elseif math.floor(FeralbyNight.time_to_die/60)>10 and math.floor(FeralbyNight.time_to_die/60)<=59 and (FeralbyNight.time_to_die-math.floor(FeralbyNight.time_to_die/60)*60)>10 then
FeralbyNight.timetokillFrame:SetText(string.format("%.0f", math.floor(FeralbyNight.time_to_die/60))..":"..string.format("%.0f", FeralbyNight.time_to_die-math.floor(FeralbyNight.time_to_die/60)*60))
else
FeralbyNight.timetokillFrame:SetText(" ")
end
else
FeralbyNight.timetokillFrame:SetText("")
FeralbyNight.timetokillFrame:Hide()
end
else
--FeralbyNight.time_to_die=9999999
end
 --  DEFAULT_CHAT_FRAME:AddMessage(FeralbyNight.currentTarget.bosshp[1]..", "..FeralbyNight.time_to_die..", "..FeralbyNight.currentTarget.dps[1]);

FeralbyNight.timeSinceLastUpdate_dps=currentTime

  end


  FeralbyNight.hudFrame_bosshealthbar_frame:SetMinMaxValues(0,bossmaxhp)
  FeralbyNight.hudFrame_bosspowerbar_frame:SetMinMaxValues(0,bossmaxpower)

  
  
     local durat=0
    local finish =0
    local castprc=0
  FeralbyNight.castfinish=currentTime-30
  FeralbyNight.castdurat=-30
  	
    local spell, _, stext, _, startTime, endTime,_,_,_ = UnitCastingInfo("Target")
     if spell then 
      durat=(endTime-startTime)/1000
       FeralbyNight.castdurat=durat
     finish = endTime/1000 - currentTime
       FeralbyNight.castfinish=finish
     castprc=(1-finish/durat)
    end
    
    local spellc, _, stextc, _, startTimec, endTimec,_,_ = UnitChannelInfo("Target")
     if spellc then 
     spell=spellc
      durat=(endTimec-startTimec)/1000
        FeralbyNight.castdurat=durat
     finish = endTimec/1000 - currentTime
       FeralbyNight.castfinish=finish
     castprc=(finish/durat)
    end	  
    
          FeralbyNight.castname=spell
          
          if(catform~=nil) then
          if((FeralbyNightdb.bossmode==true and FeralbyNight. castname==FeralbyNight.bosscast["Emalon - Lightning Nova"]) or (FeralbyNightdb.bossmode==true and FeralbyNight. castname==FeralbyNight.bosscast["Stormcaller - Council - Overload"]) or (FeralbyNightdb.bossmode==true and FeralbyNight. castname==FeralbyNight.bosscast["Mimiron - Shock Blast"])) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3;
end
end

          if(bearform~=nil) then
          if((FeralbyNightdb.bossmode==true and FeralbyNight. castname==FeralbyNight.bosscast["Stormcaller - Council - Overload"]) or (FeralbyNightdb.bossmode==true and FeralbyNight. castname==FeralbyNight.bosscast["Mimiron - Shock Blast"])) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3;
end

 	local isTanking, _, _, _, _ = UnitDetailedThreatSituation("player","target")
  	 if isTanking == nil then
  	 isTanking =0
  	 end
  	
         if((FeralbyNightdb.bossmode==true and FeralbyNight. castname==FeralbyNight.bosscast["Emalon - Lightning Nova"]) or (FeralbyNightdb.bossmode==true and FeralbyNight. castname==FeralbyNight.bosscast["Vezax - Surge of Darkness"] and isTanking~=0) or (FeralbyNightdb.bossmode==true and FeralbyNight. castname==FeralbyNight.bosscast["Mimiron - Plasma Blast"]  and isTanking~=0) or (FeralbyNightdb.bossmode==true and FeralbyNight. castname==FeralbyNight.bosscast["Steelbreaker - Council - Fusion Punch"]  and isTanking~=0) or (FeralbyNightdb.bossmode==true and FeralbyNight. castname==FeralbyNight.bosscast["Freya - Ground Tremor"]  and isTanking~=0) or (FeralbyNightdb.bossmode==true and FeralbyNight. castname==FeralbyNight.bosscast["Stonebark - Fist of Stone"]  and isTanking~=0)) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3;
end

end

         if((FeralbyNightdb.bossmode==true and FeralbyNight. castname==FeralbyNight.bosscast["Mimiron - Laser Barrage"]) or (FeralbyNightdb.bossmode==true and FeralbyNight. castname==FeralbyNight.bosscast["Auriaya - Terrifying Screech"]) or (FeralbyNightdb.bossmode==true and FeralbyNight. castname==FeralbyNight.bosscast["Auriaya - Sonic Screech"])) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["attention"])
		FeralbyNight.noticestatus="attention";
		FeralbyNight.notice_timer=GetTime()-3;
end


     local pdurat=0
    local pfinish =0
    local pcastprc=0
  
  	
    local pspell, _, pstext, _, startTime, endTime,_,_,_ = UnitCastingInfo("player")
     if pspell then 
      pdurat=(endTime-startTime)/1000
     pfinish = endTime/1000 - currentTime
     pcastprc=(1-pfinish/pdurat)
    end
    local pspellc, _,pstextc, _, startTimec, endTimec,_,_ = UnitChannelInfo("player")
     if pspellc then 
     pspell=pspellc
      pdurat=(endTimec-startTimec)/1000
     pfinish = endTimec/1000 - currentTime
     pcastprc=(pfinish/pdurat)
    end	  
    
      	if energy<(rake_energy) then
	FeralbyNight.hudFrame_castbar_frame:SetStatusBarColor(1,1,0,0.2)
	elseif energy<(rake_energy+shred_energy-10) then
		FeralbyNight.hudFrame_castbar_frame:SetStatusBarColor(1,1,0,0.5)
	elseif energy<(rake_energy+shred_energy+rip_energy-20) then
		FeralbyNight.hudFrame_castbar_frame:SetStatusBarColor(1,1,0,0.8)
	else
		FeralbyNight.hudFrame_castbar_frame:SetStatusBarColor(1,1,0,1)
	end
	  	FeralbyNight.hudFrame_castbar_frame:SetValue(energy)
	  	
	  	
		if sr_frame_count<0.1 then
	FeralbyNightsrFrame:SetTextColor(1,1,1,0)
	elseif sr_frame_count>4 then
	FeralbyNightsrFrame:SetTextColor(1,1,1,1)
	else
	    FeralbyNightsrFrame:SetTextColor(math.abs(math.sin(currentTime*3.28)),0,math.abs(math.cos(currentTime*3.28)),1);
	end
	FeralbyNightsrFrame:SetText(string.format("%.0f", sr_frame_count))
	  	

	FeralbyNight.hudFrame_powerbar_frame:SetMinMaxValues(0,maxpower);
	
	if UnitPowerType("Player")==3 then
	
	if power<(rake_energy) then
	FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(1,1,0,0.2)
	elseif power<(rake_energy+shred_energy-10) then
		FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(1,1,0,0.5)
	elseif power<(rake_energy+shred_energy+rip_energy-20) then
		FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(1,1,0,0.8)
	else
		FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(1,1,0,1)
	end
	
	 	if power<(rake_energy) then
	FeralbyNightenergyFrame:SetTextColor(1,1,1,1)
	elseif power<(rake_energy+shred_energy-10) then
	FeralbyNightenergyFrame:SetTextColor(1,1,0,1)
	elseif power<(rake_energy+shred_energy+rip_energy-20) then
	FeralbyNightenergyFrame:SetTextColor(1,0.5,0,1)
	else
	FeralbyNightenergyFrame:SetTextColor(1,0,0,1)
	end
	FeralbyNightenergyFrame:SetText(string.format("%.0f", energy))
	
		if cp<1 then
	FeralbyNightCPFrame:SetTextColor(1,1,1,1)
	elseif cp<FeralbyNightdb.SRCP then
		FeralbyNightCPFrame:SetTextColor(0,1,0,1)
	elseif cp<5 then
		FeralbyNightCPFrame:SetTextColor(1,1,0,1)
	elseif energy<35 then
		FeralbyNightCPFrame:SetTextColor(1,0,0,1)
	else
	    FeralbyNightCPFrame:SetTextColor(math.abs(math.sin(currentTime*3.28)),0,math.abs(math.cos(currentTime*3.28)),1);
	end
	FeralbyNightCPFrame:SetText(string.format("%.0f", cp))
	
	  	
	elseif UnitPowerType("Player")==1 then
	if power<10 then
	FeralbyNightenergyFrame:SetTextColor(1,1,1,1)
		elseif power<15 then
	FeralbyNightenergyFrame:SetTextColor(1,1,0.5,1)
		elseif power<25 then
	FeralbyNightenergyFrame:SetTextColor(1,1,0,1)
		elseif power<50 then
	FeralbyNightenergyFrame:SetTextColor(1,0.5,0,1)
		elseif power<75 then
	FeralbyNightenergyFrame:SetTextColor(1,0.2,0,1)
		else
	FeralbyNightenergyFrame:SetTextColor(1,0,0,1)
	end
	
		FeralbyNightenergyFrame:SetText(string.format("%.0f", rage))
		

		FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(1,0,0,1)
	if power<10 then
		FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(1,0,0,0.2)
		elseif power<15 then
		FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(1,0,0,0.4)
		elseif power<25 then
		FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(1,0,0,0.6)
		elseif power<50 then
		FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(1,0,0,0.6)
		elseif power<75 then
		FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(1,0,0,0.8)
		else
		FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(1,0,0,1)
	end
	
			if lacerate < 4.5 and lacerate_stack>0 then
	FeralbyNightCPFrame:SetTextColor(math.abs(math.sin(currentTime*3.28)),0,math.abs(math.cos(currentTime*3.28)),1);
	elseif lacerate_stack<1 then
	FeralbyNightCPFrame:SetTextColor(1,1,1,1)
	elseif lacerate_stack<3 then
		FeralbyNightCPFrame:SetTextColor(0,1,0,1)
	elseif lacerate_stack<5 then
		FeralbyNightCPFrame:SetTextColor(1,1,0,1)
	else
		FeralbyNightCPFrame:SetTextColor(1,0,0,1)
	end
		FeralbyNightCPFrame:SetText(string.format("%.0f", lacerate_stack))

	else
  	 FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(0,0,1,0.8)
  	 if mana>catform_mana*2 then
  	 FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(0,0,1,0.8)
  	 elseif mana>catform_mana then
  	 FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(0,0,1,0.4)
  	 else
  	 FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(0,0,1,0.2)
  	 end
  	 end
  		FeralbyNight.hudFrame_powerbar_frame:SetValue(power)


     FeralbyNight.hudFrame_healthbar_frame:SetMinMaxValues(0,maxhp)
     local healthpc=health/maxhp;
     if healthpc>=0.75 then
     FeralbyNight.hudFrame_healthbar_frame:SetStatusBarColor(0,1,0,0.25)
     elseif healthpc>=0.5 then
     FeralbyNight.hudFrame_healthbar_frame:SetStatusBarColor(0,1,0,0.5)
     elseif healthpc>=0.25 then
     FeralbyNight.hudFrame_healthbar_frame:SetStatusBarColor(0,1,0,0.75)
     else
     FeralbyNight.hudFrame_healthbar_frame:SetStatusBarColor(0,1,0,1)
     end
     FeralbyNight.hudFrame_healthbar_frame:SetValue(health)
     
     local	expheart=99999999
     local expheartpc=200
     local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitAura("target", FeralbyNight.bossaura["XT - Exposed Heart"]); 
	if name ~= nil then
	expheart = (expirationTime - currentTime)
	expheartpc = expheart/30
	end	
          FeralbyNight.hudFrame_bosshealthbar_frame:SetMinMaxValues(0,bossmaxhp)
     local bhealthpc=bosshealth/bossmaxhp;
     if bhealthpc>=0.75 then
     FeralbyNight.hudFrame_bosshealthbar_frame:SetStatusBarColor(0,1,0,0.25)
     elseif bhealthpc>=0.5 then
     FeralbyNight.hudFrame_bosshealthbar_frame:SetStatusBarColor(0,1,0,0.5)
     elseif bhealthpc>=0.25 then
     FeralbyNight.hudFrame_bosshealthbar_frame:SetStatusBarColor(0,1,0,0.75)
     else
     FeralbyNight.hudFrame_bosshealthbar_frame:SetStatusBarColor(0,1,0,1)
     end
     FeralbyNight.hudFrame_bosshealthbar_frame:SetValue(bosshealth)
     
    if (expheartpc<bhealthpc) then bhealthpc=expheartpc end
    -- if(FeralbyNight.time_to_die<expheart) then FeralbyNight.time_to_die=expheart end
  	 
  	 
  	 FeralbyNight.bosslifepc=bhealthpc
  	 
  	 local manabar_height=(bar_height)*mana/UnitPowerMax("player",0)
  	 FeralbyNight.hudFrame_manabar_frame:SetHeight(manabar_height);
  	 if mana>catform_mana*2 then
  	 FeralbyNight.hudFrame_manabar_frame:SetStatusBarColor(0,0,1,0.5)
  	 elseif mana>catform_mana then
  	 FeralbyNight.hudFrame_manabar_frame:SetStatusBarColor(1,1,0.5,0.5)
  	 else
  	 FeralbyNight.hudFrame_manabar_frame:SetStatusBarColor(1,0,1,0.5)
  	 end
  	 
 local bosspowerpct=(bosspower/bossmaxpower)*100
if UnitPowerType("Target")==1 then
		FeralbyNight.hudFrame_bosspowerbar_frame:SetStatusBarColor(1,0,0,0.5)
elseif UnitPowerType("Target")==3 then
        FeralbyNight.hudFrame_bosspowerbar_frame:SetStatusBarColor(1,1,0,0.5)
 else
         FeralbyNight.hudFrame_bosspowerbar_frame:SetStatusBarColor(0,0,1,0.5)
end
	  		FeralbyNight.hudFrame_bosspowerbar_frame:SetValue(bosspower)
	
	local isTanking=0
  	 local status=0
  	 local threatpct=0
  	 local rawthreatpct=0
  	 local threatvalue=0
  	 isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player","target")
  	 if isTanking == nil then
  	 isTanking =0
  	 end
  	 if status == nil then
  	 status =0
  	 end
  	 if threatpct == nil then
  	 threatpct =0
  	 end
  	 if rawthreatpct == nil then
  	 rawthreatpct =0
  	 end
  	 if threatvalue == nil then
  	 rawthreatpct =0
  	 end
  	 --Height based on % to pull aggro, Shading based on % of tank aggro, color based on threat status: red = tanking, yellow = losing aggro, orange = gaining aggro, grey = lower aggro than tank

    	local catform, _, _, _, _, _, _, _, _ = UnitAura("player", FeralbyNight.L["Cat Form"]); 
	local bearform, _, _, _, _, _, _, _, _ = UnitAura("player", FeralbyNight.L["Dire Bear Form"]); 
	
  	 local threatbar_height=(bar_height)*(threatpct/100)
  	 FeralbyNight.hudFrame_threatbar_frame:SetHeight(threatbar_height); 
  	 if status==0 then
  	   	 if(bearform == nil and FeralbyNight.noticestatus=="nil" and threatpct>90) then
  	 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["aggro1"])
  	 		FeralbyNight.noticestatus="aggro1";
				FeralbyNight.notice_timer=GetTime()
		end
  	 threatbar_height=(bar_height)*(rawthreatpct/100)
  	 FeralbyNight.hudFrame_threatbar_frame:SetStatusBarColor(0.69,0.69,0.69,(threatpct/100))
  	 FeralbyNight.hudFrame_threatbar_frame:SetHeight(threatbar_height); 
  	 elseif status==1 then
  	 if(bearform == nil and FeralbyNight.noticestatus=="nil") then
  	   	 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["aggro2"])
  	   	 		FeralbyNight.noticestatus="aggro2";
				FeralbyNight.notice_timer=GetTime()
		end
  	 threatbar_height=(bar_height)*(threatpct/100)
  	 if threatbar_height<10 then
  	 threatbar_height=10
  	 end
  	 FeralbyNight.hudFrame_threatbar_frame:SetStatusBarColor(1,1,0,1)
  	 FeralbyNight.hudFrame_threatbar_frame:SetHeight(threatbar_height); 
  	 elseif status==2 then
  	 threatbar_height=(bar_height)
  	 FeralbyNight.hudFrame_threatbar_frame:SetStatusBarColor(1,0.6,0,1)
  	 FeralbyNight.hudFrame_threatbar_frame:SetHeight(threatbar_height); 
  	 else
  	 threatbar_height=(bar_height)
  	 FeralbyNight.hudFrame_threatbar_frame:SetStatusBarColor(1,0,0,0.5)
  	 FeralbyNight.hudFrame_threatbar_frame:SetHeight(threatbar_height); 
	 end


if pspell==nil then
pspell=""
end
if spell==nil then
spell=""
end

local maxpower_unit=""
local power_unit=""
local maxhp_unit=""
local health_unit=""
local bossmaxpower_unit=""
local bosspower_unit=""
local bossmaxhp_unit=""
local bosshealth_unit=""

local powerpct=power/maxpower
local bosspowerpct=bosspower/bossmaxpower
local hppct=health/maxhp
local bosshppct=bosshealth/bossmaxhp
if maxpower>100000 then
maxpower=maxpower/1000
maxpower_unit="k"
end
if power>100000 then
power=power/1000
power_unit="k"
end
if maxhp>100000 then
maxhp=maxhp/1000
maxhp_unit="k"
end
if health>100000 then
health=health/1000
health_unit="k"
end
if bossmaxpower>100000 then
bossmaxpower=bossmaxpower/1000
bossmaxpower_unit="k"
end
if bosspower>100000 then
bosspower=bosspower/1000
bosspower_unit="k"
end
if bossmaxhp>100000 then
bossmaxhp=bossmaxhp/1000
bossmaxhp_unit="k"
end
if bosshealth>100000 then
bosshealth=bosshealth/1000
bosshealth_unit="k"
end

	    if pcastprc>0 and FeralbyNightdb.showcast then
	    FeralbyNight.hudFrame_powerbar_frame:SetStatusBarColor(0.7,0.7,1,1)
	    FeralbyNight.hudFrame_powerbar_frame:SetValue(pcastprc*maxpower)
	    FeralbyNight.hudFrame_powerbar.text:SetText(string.sub(pspell,1,20).."  ("..string.format("%.0f", ((1-pcastprc)*100)).."%)  "..string.format("%.2f", ((1-pcastprc)*pdurat)).."/"..string.format("%.2f", pdurat))
	    elseif power~= nil and power~=0 and maxpower~= nil and maxpower~=0 then
	    FeralbyNight.hudFrame_powerbar.text:SetText(string.format("%.0f",power)..power_unit.."/"..string.format("%.0f",maxpower)..maxpower_unit.."  ("..string.format("%.0f", (powerpct)*100).."%)")
	  	end
	  	if castprc>0 and FeralbyNightdb.showcast then
	    FeralbyNight.hudFrame_bosspowerbar_frame:SetStatusBarColor(0.7,0.7,1,1)
	    FeralbyNight.hudFrame_bosspowerbar_frame:SetValue(castprc*bossmaxpower)	
	    FeralbyNight.hudFrame_bosspowerbar.text:SetText(string.sub(spell,1,20).."  ("..string.format("%.0f", ((1-castprc)*100)).."%)  "..string.format("%.2f", ((1-castprc)*durat)).."/"..string.format("%.2f", durat))
	    elseif bosspower~= nil and bosspower~=0 and bossmaxpower~= nil and bossmaxpower~=0 then
	    	    FeralbyNight.hudFrame_bosspowerbar.text:SetText(string.format("%.0f",bosspower)..bosspower_unit.."/"..string.format("%.0f",bossmaxpower)..bossmaxpower_unit.."  ("..string.format("%.0f", (bosspowerpct)*100).."%)")
	    end 	
	    
	    if health~= nil and health~=0 and maxhp~= nil and maxhp~=0 then
	    FeralbyNight.hudFrame_healthbar.text:SetText(string.format("%.0f",health)..health_unit.."/"..string.format("%.0f",maxhp)..maxhp_unit.."  ("..string.format("%.0f", (hppct)*100).."%)")

	    end
	    if bosshealth~= nil and bosshealth~=0 and bossmaxhp~= nil and bossmaxhp~=0 then
		FeralbyNight.hudFrame_bosshealthbar.text:SetText(string.sub(bossname,1,10).." ("..bosslevel..") "..string.format("%.0f",bosshealth)..bosshealth_unit.."/"..string.format("%.0f",bossmaxhp)..bossmaxhp_unit.."  ("..string.format("%.1f", (bosshppct)*100).."%)")
	    end
	    

FeralbyNight.abilitycdmon1[1]:SetTexture(GetSpellTexture(FeralbyNight.getability[2]))
FeralbyNight.abilitycdmon1[2]:SetTexture(GetSpellTexture(FeralbyNight.getability[3]))
FeralbyNight.abilitycdmon1[3]:SetTexture(GetSpellTexture(FeralbyNight.getability[8]))
FeralbyNight.abilitycdmon1[4]:SetTexture(GetSpellTexture(FeralbyNight.L["First Aid"]))
FeralbyNight.abilitycdmon1[5]:SetTexture(GetSpellTexture(FeralbyNight.getability[9]))
FeralbyNight.abilitycdmon2[1]:SetTexture(GetSpellTexture(FeralbyNight.getability[10]))
FeralbyNight.abilitycdmon3[1]:SetTexture(GetSpellTexture(FeralbyNight.getability[10]))
FeralbyNight.abilitycdmon2[2]:SetTexture(GetSpellTexture(FeralbyNight.getability[11]))
FeralbyNight.abilitycdmon3[2]:SetTexture(GetSpellTexture(FeralbyNight.getability[5]))
FeralbyNight.abilitycdmon2[3]:SetTexture(GetSpellTexture(FeralbyNight.getability[12]))
FeralbyNight.abilitycdmon3[3]:SetTexture(GetSpellTexture(FeralbyNight.getability[4]))
FeralbyNight.abilitycdmon2[4]:SetTexture(GetSpellTexture(FeralbyNight.getability[13]))
FeralbyNight.abilitycdmon2[5]:SetTexture(GetSpellTexture(FeralbyNight.getability[14]))
FeralbyNight.abilitycdmon3[4]:SetTexture(GetSpellTexture(FeralbyNight.getability[6]))
FeralbyNight.abilitycdmon3[5]:SetTexture(GetSpellTexture(FeralbyNight.getability[1]))






			FeralbyNight:CooldownMonitor()
			FeralbyNight:BossauraMonitor()  ---QUIIIIIIIIIIIIIII
			if FeralbyNightdb.procshow then
			FeralbyNight:ProcauraMonitor()
			end

	local catform, _, _, _, _, _, _, _, _ = UnitAura("player", FeralbyNight.L["Cat Form"]); 
	local bearform, _, _, _, _, _, _, _, _ = UnitAura("player", FeralbyNight.L["Dire Bear Form"]); 
	if (UnitName("target") == nil or UnitIsFriend("player","target") ~= nil or UnitHealth("target") == 0 or ((catform == nil) and (bearform == nil))) and FeralbyNightdb.locked==true then
		FeralbyNight.displayFrame_last:Hide()
		FeralbyNight.displayFrame_current:Hide()
		FeralbyNight.displayFrame_next:Hide()
		FeralbyNight.displayFrame_misc:Hide()
		FeralbyNight.displayFrame_int:Hide()
	FeralbyNight.MeleeFrame:Hide()
	FeralbyNight.CPFrame:Hide()
	FeralbyNight.timetokillFrame:SetText("")
	FeralbyNight.timetokillFrame:Hide()
	FeralbyNight.energyFrame:Hide()
	FeralbyNight.srFrame:Hide()
			else
				if ((catform ~= nil) or (bearform ~= nil)) or FeralbyNightdb.locked==false then
					FeralbyNight.displayFrame_last:Show()
		FeralbyNight.displayFrame_current:Show()
		FeralbyNight.displayFrame_next:Show()
		FeralbyNight.displayFrame_misc:Show()
		FeralbyNight.displayFrame_int:Show()
	FeralbyNight.MeleeFrame:Show()
	FeralbyNight.CPFrame:Show()
	FeralbyNight.timetokillFrame:Show()
	FeralbyNight.energyFrame:Show()
	FeralbyNight.srFrame:Show()
		end
						if ((catform ~= nil) or (bearform ~= nil)) then
			FeralbyNight:DecideSpells()
end

if FeralbyNightdb.oocframeshow == false then
	FeralbyNight.oocFrame:Hide()
	else
	FeralbyNight.oocFrame:Show()
end
if FeralbyNightdb.noticeframeshow == false then
	FeralbyNight.noticeFrame:Hide()
	else
	FeralbyNight.noticeFrame:Show()
end

if FeralbyNightdb.cdmonshow1 == false then
	FeralbyNight.cdmonFrame1:Hide()
	else
	FeralbyNight.cdmonFrame1:Show()
end
if (FeralbyNightdb.cdmonshow2 == false or catform == nil) then
	FeralbyNight.cdmonFrame2:Hide()
	else
	FeralbyNight.cdmonFrame2:Show()
end
if (FeralbyNightdb.cdmonshow3 == false or bearform == nil) then
	FeralbyNight.cdmonFrame3:Hide()
	else
	FeralbyNight.cdmonFrame3:Show()
end
if FeralbyNightdb.bossfightshow == false then
	FeralbyNight.bossfightFrame:Hide()
	else
	FeralbyNight.bossfightFrame:Show()
end
if FeralbyNightdb.myfightshow == false then
	FeralbyNight.myfightFrame:Hide()
	else
	FeralbyNight.myfightFrame:Show()
end
if FeralbyNightdb.procshow == false then
	FeralbyNight.procFrame:Hide()
	else
	FeralbyNight.procFrame:Show()
end
if FeralbyNightdb.hudshow == false then
	FeralbyNight.hudFrame:Hide()
	else
	FeralbyNight.hudFrame:Show()
end
if FeralbyNightdb.suggesterframeshow == false then
		FeralbyNight.displayFrame_last:Hide()
		FeralbyNight.displayFrame_current:Hide()
		FeralbyNight.displayFrame_next:Hide()
		FeralbyNight.displayFrame_misc:Hide()
		FeralbyNight.displayFrame_int:Hide()
	end
if FeralbyNightdb.statsframeshow == false then
	FeralbyNight.MeleeFrame:Hide()
	end
if FeralbyNightdb.cpframeshow == false then
	FeralbyNight.CPFrame:Hide()
	end
if FeralbyNightdb.timetokillframeshow == false then
FeralbyNight.timetokillFrame:SetText("")
	FeralbyNight.timetokillFrame:Hide()
	end
if FeralbyNightdb.energyframeshow == false then
	FeralbyNight.energyFrame:Hide()
	end
if FeralbyNightdb.srframeshow == false then
	FeralbyNight.srFrame:Hide()
end

if (FeralbyNightdb.locked==false and FeralbyNightdb.showdummyvariables==true) then
		FeralbyNight.ooctexture:SetTexture("Interface\\AddOns\\FeralbyNight\\arts\\clearcast.tga")
		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["aggro2"])
		--	FeralbyNightsrFrame:SetText("SR/CD Frame")
		FeralbyNight.textureList["last"]:SetTexture(GetSpellTexture(FeralbyNight.L["Berserk"]))
		FeralbyNight.textureList["current"]:SetTexture(GetSpellTexture(FeralbyNight.L["Mangle (Cat)"]))
	--	FeralbyNight.textureList["next"]:SetTexture(GetSpellTexture(FeralbyNight.L["Rake"]))
		FeralbyNight.textureList["misc"]:SetTexture(GetSpellTexture(FeralbyNight.L["Tiger's Fury"]))
	--	FeralbyNight.textureList["int"]:SetTexture(GetSpellTexture(FeralbyNight.L["Savage Roar"]))
end


	
	end
		
	
		FeralbyNight.timeSinceLastUpdate = FeralbyNight.timeSinceLastUpdate - FeralbyNightdb.updateinterval;
  end

end


function FeralbyNight:ProcauraMonitor()
  	local currentTime = GetTime()

	--1-4---5-7---8-40
local jj=3
	    local procFramedumb = _G["FeralbyNightprocFrame_"..jj]
	FeralbyNight.proc[jj]:SetAlpha(0.8)
	FeralbyNight.proc[jj]:SetTexture(nil)
	procFramedumb:SetBackdropColor(0, 0, 0,0)
	procFramedumb:SetText(nil)

for i=9,13 do
		local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.procindex[i]); 
			if name ~= nil then
	  		  local procFramedumb = _G["FeralbyNightprocFrame_"..jj]
				FeralbyNight.getproc.stack[jj]=count;
				FeralbyNight.getproc.timer[jj] = expirationTime - currentTime;
				FeralbyNight.getproc.icon[jj]=icon;
				
				--AGGIUNGI UN GETPROC_CD!!!!!!!
				FeralbyNight.proc[jj]:SetTexture(FeralbyNight.getproc.icon[jj])
					if FeralbyNight.getproc.stack[jj]==0 then
						if FeralbyNight.getproc.timer[jj]>60 or FeralbyNight.getproc.timer[jj]<=0 then
						procFramedumb:SetText("");
						else
						procFramedumb:SetText(string.format("%.0f",FeralbyNight.getproc.timer[jj]));
						end
					else
						if FeralbyNight.getproc.timer[jj]>60 or FeralbyNight.getproc.timer[jj]<=0 then
						procFramedumb:SetText("  ".."      "..string.format("%.0f", FeralbyNight.getproc.stack[jj]))
						else
						procFramedumb:SetText(string.format("%.0f",FeralbyNight.getproc.timer[jj]).."      "..string.format("%.0f", FeralbyNight.getproc.stack[jj]))
						end
					end
			end	
	end	

if ((FeralbyNight.trinket1=="nil" and FeralbyNight.trinket2=="nil") or FeralbyNight.trinket1special == 1) then

local jj=1
for i=14,70 do
		if FeralbyNight.trinket1~="nil"	then break end
		local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.procindex[i]); 
			if (name ~= nil) then
							FeralbyNight.trinket1=(FeralbyNight.procindex[i])
							FeralbyNight.trinket1cd=(FeralbyNight.proccdindex[i])

 if (FeralbyNight.trinket1==(FeralbyNight.procindex[62]) or FeralbyNight.trinket1==(FeralbyNight.procindex[63]) or FeralbyNight.trinket1==(FeralbyNight.procindex[64])) then
 FeralbyNight.trinket1special = 1;
FeralbyNight.trinket1=(FeralbyNight.procindex[i])
FeralbyNight.trinket1cd=(FeralbyNight.proccdindex[i])
 end
			end	
	end
end

if ((FeralbyNight.trinket1~="nil" and FeralbyNight.trinket2=="nil") or FeralbyNight.trinket2special == 1) then
local jj=2

for i=14,70 do
		if FeralbyNight.trinket2~="nil"	then break end
		local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.procindex[i]); 
			if (name ~= nil and FeralbyNight.procindex[i] ~= FeralbyNight.trinket1) then
							FeralbyNight.trinket2=(FeralbyNight.procindex[i])
							FeralbyNight.trinket2cd=(FeralbyNight.proccdindex[i])

 if ((FeralbyNight.trinket2==(FeralbyNight.procindex[62]) or FeralbyNight.trinket2==(FeralbyNight.procindex[63]) or FeralbyNight.trinket2==(FeralbyNight.procindex[64])) and FeralbyNight.trinket1special == 0) then
 FeralbyNight.trinket2special = 1;
FeralbyNight.trinket2=(FeralbyNight.procindex[i])
FeralbyNight.trinket2cd=(FeralbyNight.proccdindex[i])
 end
													
			end	
	end
end




local jj=1
	  	local procFramedumb = _G["FeralbyNightprocFrame_"..jj]
		local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.trinket1); 
			if (name ~= nil) then
					FeralbyNight.proc[jj]:SetAlpha(0.8)
			 -- print(jj..","..FeralbyNight.getproc.cd[jj])
				FeralbyNight.getproc.stack[jj]=count;
				FeralbyNight.getproc.timer[jj] = expirationTime - currentTime;
				FeralbyNight.getproc.icon[jj]=icon;
			if FeralbyNight.getproc.cd[jj]==1 then
			FeralbyNight.getproc.finish[jj]=currentTime+FeralbyNight.trinket1cd
			FeralbyNight.getproc.cd[jj]=0
			--	print(jj..","..FeralbyNight.getproc.cd[jj])
			end
				FeralbyNight.proc[jj]:SetTexture(FeralbyNight.getproc.icon[jj])
				
					if FeralbyNight.getproc.stack[jj]==0 then
						if FeralbyNight.getproc.timer[jj]>60 or FeralbyNight.getproc.timer[jj]<=0 then
						procFramedumb:SetText("");
						else
						procFramedumb:SetText(string.format("%.0f",FeralbyNight.getproc.timer[jj]));
						end
					else
						if FeralbyNight.getproc.timer[jj]>60 or FeralbyNight.getproc.timer[jj]<=0 then
						procFramedumb:SetText("  ".."      "..string.format("%.0f", FeralbyNight.getproc.stack[jj]))
						else
						procFramedumb:SetText(string.format("%.0f",FeralbyNight.getproc.timer[jj]).."      "..string.format("%.0f", FeralbyNight.getproc.stack[jj]))
						end
					end
		else
		FeralbyNight.getproc.cd[jj]=1
		if ((FeralbyNight.getproc.finish[jj]-currentTime)>0.1) then
		procFramedumb:SetText("  ".."      "..string.format("%.0f", FeralbyNight.getproc.finish[jj]-currentTime))
		FeralbyNight.proc[jj]:SetAlpha(0.3)
		else
		FeralbyNight.proc[jj]:SetAlpha(0.5)
		procFramedumb:SetText(nil)
		end
		end	

local jj=2
	    local procFramedumb = _G["FeralbyNightprocFrame_"..jj]
		local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.trinket2); 
			if (name ~= nil) then
					FeralbyNight.proc[jj]:SetAlpha(0.8)
			 -- print(jj..","..FeralbyNight.getproc.cd[jj])
				FeralbyNight.getproc.stack[jj]=count;
				FeralbyNight.getproc.timer[jj] = expirationTime - currentTime;
				FeralbyNight.getproc.icon[jj]=icon;
			if FeralbyNight.getproc.cd[jj]==1 then
			FeralbyNight.getproc.finish[jj]=currentTime+FeralbyNight.trinket2cd
			FeralbyNight.getproc.cd[jj]=0
			--	print(jj..","..FeralbyNight.getproc.cd[jj])
			end
				FeralbyNight.proc[jj]:SetTexture(FeralbyNight.getproc.icon[jj])
				
					if FeralbyNight.getproc.stack[jj]==0 then
						if FeralbyNight.getproc.timer[jj]>60 or FeralbyNight.getproc.timer[jj]<=0 then
						procFramedumb:SetText("");
						else
						procFramedumb:SetText(string.format("%.0f",FeralbyNight.getproc.timer[jj]));
						end
					else
						if FeralbyNight.getproc.timer[jj]>60 or FeralbyNight.getproc.timer[jj]<=0 then
						procFramedumb:SetText("  ".."      "..string.format("%.0f", FeralbyNight.getproc.stack[jj]))
						else
						procFramedumb:SetText(string.format("%.0f",FeralbyNight.getproc.timer[jj]).."      "..string.format("%.0f", FeralbyNight.getproc.stack[jj]))
						end
					end
		else
		FeralbyNight.getproc.cd[jj]=1
		if ((FeralbyNight.getproc.finish[jj]-currentTime)>0.1) then
		procFramedumb:SetText("  ".."      "..string.format("%.0f", FeralbyNight.getproc.finish[jj]-currentTime))
		FeralbyNight.proc[jj]:SetAlpha(0.3)
		else
		FeralbyNight.proc[jj]:SetAlpha(0.5)
		procFramedumb:SetText(nil)
		end
			end	
	
local jj=4
	   for jj=4,5 do
	    local procFramedumb = _G["FeralbyNightprocFrame_"..jj]
	FeralbyNight.proc[jj]:SetAlpha(0.8)
	FeralbyNight.proc[jj]:SetTexture(nil)
	procFramedumb:SetBackdropColor(0, 0, 0,0)
	procFramedumb:SetText(nil)
	end
for i=1,8 do
		if jj>5 then break end
		local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.procindex[i]); 
			if name ~= nil then
	  		  local procFramedumb = _G["FeralbyNightprocFrame_"..jj]
				FeralbyNight.getproc.stack[jj]=count;
				FeralbyNight.getproc.timer[jj] = expirationTime - currentTime;
				FeralbyNight.getproc.icon[jj]=icon;
				
				--AGGIUNGI UN GETPROC_CD!!!!!!!
				FeralbyNight.proc[jj]:SetTexture(FeralbyNight.getproc.icon[jj])
					if FeralbyNight.getproc.stack[jj]==0 then
						if FeralbyNight.getproc.timer[jj]>60 or FeralbyNight.getproc.timer[jj]<=0 then
						procFramedumb:SetText("");
						else
						procFramedumb:SetText(string.format("%.0f",FeralbyNight.getproc.timer[jj]));
						end
					else
						if FeralbyNight.getproc.timer[jj]>60 or FeralbyNight.getproc.timer[jj]<=0 then
						procFramedumb:SetText("  ".."      "..string.format("%.0f", FeralbyNight.getproc.stack[jj]))
						else
						procFramedumb:SetText(string.format("%.0f",FeralbyNight.getproc.timer[jj]).."      "..string.format("%.0f", FeralbyNight.getproc.stack[jj]))
						end
					end
			jj=jj+1;
			end	
	end
for i=1,8 do
		if jj>5 then break end
		local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target",FeralbyNight.procindex[i]); 
			if name ~= nil then
	  		  local procFramedumb = _G["FeralbyNightprocFrame_"..jj]
				FeralbyNight.getproc.stack[jj]=count;
				FeralbyNight.getproc.timer[jj] = expirationTime - currentTime;
				FeralbyNight.getproc.icon[jj]=icon;
				
				--AGGIUNGI UN GETPROC_CD!!!!!!!
				FeralbyNight.proc[jj]:SetTexture(FeralbyNight.getproc.icon[jj])
					if FeralbyNight.getproc.stack[jj]==0 then
						if FeralbyNight.getproc.timer[jj]>60 or FeralbyNight.getproc.timer[jj]<=0 then
						procFramedumb:SetText("");
						else
						procFramedumb:SetText(string.format("%.0f",FeralbyNight.getproc.timer[jj]));
						end
					else
						if FeralbyNight.getproc.timer[jj]>60 or FeralbyNight.getproc.timer[jj]<=0 then
						procFramedumb:SetText("  ".."      "..string.format("%.0f", FeralbyNight.getproc.stack[jj]))
						else
						procFramedumb:SetText(string.format("%.0f",FeralbyNight.getproc.timer[jj]).."      "..string.format("%.0f", FeralbyNight.getproc.stack[jj]))
						end
					end
			jj=jj+1;
			end	
	end



end


function FeralbyNight:BossauraMonitor()

	local currentTime = GetTime()
	local catform, _, _, _, _, _, _, _, _ = UnitAura("player", FeralbyNight.L["Cat Form"]); 
	local bearform, _, _, _, _, _, _, _, _ = UnitAura("player", FeralbyNight.L["Dire Bear Form"]); 
	
	
		local jj=1

	if 	FeralbyNightdb.bossfightshow == true then
	for jj=1,5 do
	    local bossfightFramedumb = _G["FeralbyNightbossfightFrame_"..jj]
	FeralbyNight.bossfight[jj]:SetAlpha(0.5)
	FeralbyNight.bossfight[jj]:SetTexture(nil)
	bossfightFramedumb:SetBackdropColor(0, 0, 0,0)
	bossfightFramedumb:SetText(nil)
	end
		
	
	jj=1;
	
	local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaurabossindex[1]); 

	for i=1,57 do
		if jj>5 then break end
	local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaurabossindex[i]); 
			if name ~= nil then
	  		  local bossfightFramedumb = _G["FeralbyNightbossfightFrame_"..jj]
				FeralbyNight.getbossaura.stack[jj]=count;
				FeralbyNight.getbossaura.timer[jj] = expirationTime - currentTime;
				FeralbyNight.getbossaura.icon[jj]=icon;
				FeralbyNight.bossfight[jj]:SetTexture(FeralbyNight.getbossaura.icon[jj])
					if FeralbyNight.getbossaura.stack[jj]==0 then
						if FeralbyNight.getbossaura.timer[jj]>60 or FeralbyNight.getbossaura.timer[jj]<=0 then
						bossfightFramedumb:SetText("");
						else
						bossfightFramedumb:SetText(string.format("%.0f",FeralbyNight.getbossaura.timer[jj]));
						end
					else
						if FeralbyNight.getbossaura.timer[jj]>60 or FeralbyNight.getbossaura.timer[jj]<=0 then
						bossfightFramedumb:SetText("  ".."      "..string.format("%.0f", FeralbyNight.getbossaura.stack[jj]))
						else
						bossfightFramedumb:SetText(string.format("%.0f",FeralbyNight.getbossaura.timer[jj]).."      "..string.format("%.0f", FeralbyNight.getbossaura.stack[jj]))
						end
					end
			jj=jj+1;
			end	
	end

	for i=1,57 do
		if jj>5 then break end
		 name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target",FeralbyNight.bossaurabossindex[i]); 
			if name ~= nil then
	  		  local bossfightFramedumb = _G["FeralbyNightbossfightFrame_"..jj]
				FeralbyNight.getbossaura.stack[jj]=count;
				FeralbyNight.getbossaura.timer[jj] = expirationTime - currentTime;
				FeralbyNight.getbossaura.icon[jj]=icon;
				FeralbyNight.bossfight[jj]:SetTexture(FeralbyNight.getbossaura.icon[jj])
					if FeralbyNight.getbossaura.stack[jj]==0 then
						if FeralbyNight.getbossaura.timer[jj]>60 or FeralbyNight.getbossaura.timer[jj]<=0 then
						bossfightFramedumb:SetText("");
						else
						bossfightFramedumb:SetText(string.format("%.0f",FeralbyNight.getbossaura.timer[jj]));
						end
					else
						if FeralbyNight.getbossaura.timer[jj]>60 or FeralbyNight.getbossaura.timer[jj]<=0 then
						bossfightFramedumb:SetText("  ".."      "..string.format("%.0f", FeralbyNight.getbossaura.stack[jj]))
						else
						bossfightFramedumb:SetText(string.format("%.0f",FeralbyNight.getbossaura.timer[jj]).."      "..string.format("%.0f", FeralbyNight.getbossaura.stack[jj]))
						end
					end
			jj=jj+1;
			end	
	end
end

if 	FeralbyNightdb.myfightshow == true then
	for jj=1,5 do
	    local myfightFramedumb = _G["FeralbyNightmyfightFrame_"..jj]
	FeralbyNight.myfight[jj]:SetAlpha(0.5)
	FeralbyNight.myfight[jj]:SetTexture(nil)
	myfightFramedumb:SetBackdropColor(0, 0, 0,0)
	myfightFramedumb:SetText(nil)
	end
	jj=1;
	for i=1,57 do
		if jj>5 then break end
		 name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.bossauramyindex[i]); 
			if name ~= nil then
	  		  local myfightFramedumb = _G["FeralbyNightmyfightFrame_"..jj]
				FeralbyNight.getmyaura.stack[jj]=count;
				FeralbyNight.getmyaura.timer[jj] = expirationTime - currentTime;
				FeralbyNight.getmyaura.icon[jj]=icon;
				FeralbyNight.myfight[jj]:SetTexture(FeralbyNight.getmyaura.icon[jj])
					if FeralbyNight.getmyaura.stack[jj]==0 then
						if FeralbyNight.getmyaura.timer[jj]>60 or FeralbyNight.getmyaura.timer[jj]<=0 then
						myfightFramedumb:SetText("");
						else
						myfightFramedumb:SetText(string.format("%.0f",FeralbyNight.getmyaura.timer[jj]));
						end
					else
						if FeralbyNight.getmyaura.timer[jj]>60 or FeralbyNight.getmyaura.timer[jj]<=0 then
						myfightFramedumb:SetText("  ".."      "..string.format("%.0f", FeralbyNight.getmyaura.stack[jj]))
						else
						myfightFramedumb:SetText(string.format("%.0f",FeralbyNight.getmyaura.timer[jj]).."      "..string.format("%.0f", FeralbyNight.getmyaura.stack[jj]))
						end
					end
			jj=jj+1;
			end	
	end

	for i=1,57 do
		if jj>5 then break end
		 name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossauramyindex[i]); 
			if name ~= nil then
	  		  local myfightFramedumb = _G["FeralbyNightmyfightFrame_"..jj]
				FeralbyNight.getmyaura.stack[jj]=count;
				FeralbyNight.getmyaura.timer[jj] = expirationTime - currentTime;
				FeralbyNight.getmyaura.icon[jj]=icon;
				FeralbyNight.myfight[jj]:SetTexture(FeralbyNight.getmyaura.icon[jj])
					if FeralbyNight.getmyaura.stack[jj]==0 then
						if FeralbyNight.getmyaura.timer[jj]>60 or FeralbyNight.getmyaura.timer[jj]<=0 then
						myfightFramedumb:SetText("");
						else
						myfightFramedumb:SetText(string.format("%.0f",FeralbyNight.getmyaura.timer[jj]));
						end
					else
						if FeralbyNight.getmyaura.timer[jj]>60 or FeralbyNight.getmyaura.timer[jj]<=0 then
						myfightFramedumb:SetText("  ".."      "..string.format("%.0f", FeralbyNight.getmyaura.stack[jj]))
						else
						myfightFramedumb:SetText(string.format("%.0f",FeralbyNight.getmyaura.timer[jj]).."      "..string.format("%.0f", FeralbyNight.getmyaura.stack[jj]))
						end
					end
			jj=jj+1;
			end	
	end
end

--Emalon start
local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Tempest Minion - Overcharged"]) 
if name ~= nil then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go all out"])
		FeralbyNight.noticestatus="go all out";
		FeralbyNight.notice_timer=GetTime()-3.5;
end
--Emalon end
	
--Razor start
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Razor - Fuse Armor"])
if name ~= nil then
if  count>3 then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["taunt"])
		FeralbyNight.noticestatus="taunt";
		FeralbyNight.notice_timer=GetTime()-3.5;
end
end

name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Razor - Devouring Flame"]) 
if name ~= nil then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.7;
end
--Razor end

--Ignis start

name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Ignis - Strength of the Creator"])
if name ~= nil and bearform ~= nil then
if  count>=4 then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["attention"])
		FeralbyNight.noticestatus="attention";
		FeralbyNight.notice_timer=GetTime()-3.5;
end
if  count>=6 and bearform ~= nil then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.5;
end
end

name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Ignis - Slag Pot"]) 
if name ~= nil then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.7;
end

name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Ignis - Scorch"]) 
if name ~= nil then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.7;
end

name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target",FeralbyNight.bossaura["Ignis - Constructor - Molten"]) 
if name ~= nil then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["kitte"])
		FeralbyNight.noticestatus="kitte";
		FeralbyNight.notice_timer=GetTime()-3.7;
end

--Ignis end

--XT start
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["XT - Tympanic Tantrum"]) 
if name ~= nil then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["attention"])
		FeralbyNight.noticestatus="attention";
		FeralbyNight.notice_timer=GetTime()-3.7;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.bossaura["XT - Searing Light"]) 
if name ~= nil then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.7;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["XT - Searing Light"]) 
if name ~= nil then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.7;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.bossaura["XT - Gravity Bomb"]) 
if name ~= nil then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.7;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["XT - Gravity Bomb"]) 
if name ~= nil then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.7;
end
--XT end
--Iron council start
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["SteelBreaker - Council - Fusion Punch"]) 
if name ~= nil then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.7;
end

name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["SteelBreaker - Council - Static Disruption"]) 
if (name ~= nil and bearform== nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.7;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["SteelBreaker - Council - Static Disruption"]) 
if (name ~= nil and bearform== nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.7;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["SteelBreaker - Council - Overwhelming Power"]) 
if (name ~= nil) then
local 	timer2 = expirationTime - currentTime
if timer2>8 then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go all out"])
		FeralbyNight.noticestatus="go all out";
		FeralbyNight.notice_timer=GetTime()-3.7;
else
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.7;
end
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.bossaura["SteelBreaker - Council - Overwhelming Power"]) 
if (name ~= nil) then
local 	timer2 = expirationTime - currentTime
if timer2>8 then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go all out"])
		FeralbyNight.noticestatus="go all out";
		FeralbyNight.notice_timer=GetTime()-3.7;
else
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.7;
end
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Runemaster - Council - Runic Barrier"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["attention"])
		FeralbyNight.noticestatus="attention";
		FeralbyNight.notice_timer=GetTime()-3.7;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.bossaura["Runemaster - Council - Rune of Power"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go all out"])
		FeralbyNight.noticestatus="go all out";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Runemaster - Council - Rune of Power"]) 
if (name ~= nil and bearform~=nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["kitte"])
		FeralbyNight.noticestatus="kitte";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Runemaster - Council - Rune of Death"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Stormcaller - Council - Lightning Tendrils"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Stormcaller - Council - Lightning Whirl"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["attention"])
		FeralbyNight.noticestatus="attention";
		FeralbyNight.notice_timer=GetTime()-3.8;
		FeralbyNight.castname=FeralbyNight.bosscast["Stormcaller - Council - Lightning Whirl"]
end

--Iron council end	

--Kologarn start
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Kologarn - Rumbler - Stone Nova"]) 
if (name ~= nil and count>=5) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["attention"])
		FeralbyNight.noticestatus="attention";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
if (name ~= nil and count>=8) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Kologarn - Crunch Armor"]) 
if (name ~= nil and count>=2) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["taunt"])
		FeralbyNight.noticestatus="taunt";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Kologarn - Focused Eyebeam"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-2;
end
--Kologarn end

--Auriaya start
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Auriaya - Seeping Feral Essence"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.7;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Auriaya - Strength of the Pack"]) 
if (name ~= nil and count>=2) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["attention"])
		FeralbyNight.noticestatus="attention";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
--Auriaya end

--Freya start
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.bossaura["Freya - Fungi"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go all out"])
		FeralbyNight.noticestatus="go all out";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Freya - Conservator's Grip"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["kitte"])
		FeralbyNight.noticestatus="kitte";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Freya - Nature's Fury"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Snaplasher - Hardened Bark"]) 
if (name ~= nil and count>30) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
if (name ~= nil and count>50) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["kitte"])
		FeralbyNight.noticestatus="kitte";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Brightleaf - Brightleaf Flux"]) 
if (name ~= nil and count>5 and bearform~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Ironbranch - Impale"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Stonebark - Fist of Stone"]) 
if (name ~= nil and bearform~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Stonebark - Broken Bones"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["taunt"])
		FeralbyNight.noticestatus="taunt";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Stonebark - Petrified Bark"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["attention"])
		FeralbyNight.noticestatus="attention";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
--Freya end

--Mimiron start
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Mimiron - Napalm Shell"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Mimiron - Plasma Blast"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Mimiron - Plasma Blast"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target",FeralbyNight.bossaura["Mimiron - Magnetic Field"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go all out"])
		FeralbyNight.noticestatus="go all out";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
--Mimiron end

--Hodir start
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Hodir - Freeze"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["attention"])
		FeralbyNight.noticestatus="attention";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Hodir - Biting Cold"]) 
if (name ~= nil and count>=2) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["kitte"])
		FeralbyNight.noticestatus="kitte";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.bossaura["Hodir - Stormpower"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go all out"])
		FeralbyNight.noticestatus="go all out";
		FeralbyNight.notice_timer=GetTime()-3;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Hodir - Frozen Blow"]) 
if (name ~= nil and bearform ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
--Hodir end

--Thorim start
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Thorim - Lightning Charge"]) 
if (name ~= nil and bearform ~= nil and count>=8) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime();
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Thorim - Unbalancing Strike"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["taunt"])
		FeralbyNight.noticestatus="taunt";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Thorim - Frostbolt Volley"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Thorim - Blizzard"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["go away"])
		FeralbyNight.noticestatus="go away";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Thorim - Frostnova"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["attention"])
		FeralbyNight.noticestatus="attention";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Thorim - Runic Colossus - Runic Barrier"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["attention"])
		FeralbyNight.noticestatus="attention";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
--Thorim end

--Yog-Saron start
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.bossaura["Yogg - Sara's Blessing"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["attention"])
		FeralbyNight.noticestatus="attention";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.bossaura["Yogg - Sara's Blessing"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["attention"])
		FeralbyNight.noticestatus="attention";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.bossaura["Yogg - Sara's Fervor"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Yogg - Sara's Fervor"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Yogg - Sara's Anger"]) 
if (name ~= nil and bearform ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target",FeralbyNight.bossaura["Yogg - Sara's Anger"]) 
if (name ~= nil and bearform ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Yogg - Dark volley"]) 
if (name ~= nil and bearform ~= nil and count>2) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("player",FeralbyNight.bossaura["Yogg - Sanity"]) 
if (name ~= nil and count<30) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["attention"])
		FeralbyNight.noticestatus="attention";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target",FeralbyNight.bossaura["Yogg - Brain Link"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["attention"])
		FeralbyNight.noticestatus="attention";
		FeralbyNight.notice_timer=GetTime()-3.8;
end
--Yog-Saron end

--Vezax start
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("target",FeralbyNight.bossaura["Vezax - Surge of Darkness"]) 
if (name ~= nil) then
 		FeralbyNight.noticetexture:SetTexture(FeralbyNight.notice["use surv cd"])
		FeralbyNight.noticestatus="use surv cd";
		FeralbyNight.notice_timer=GetTime();
end
--Vezax end

end

function FeralbyNight:CooldownMonitor()

	local currentTime = GetTime()


   
	local GCD = 1
	local ooc = 0
	local rip = 0
	local rake = 0
	local mangle = 0
	local trauma = 0
	local sr = 0
	local tf = 0
	local berserk = 0
	local berserkbuff=0
	local berserk_up=0
	local fff = 0
	local fffdur = 0
	local mangle_trauma = 0
	local bleeds=0
	local bleeds_dumb=0
	
	
	local demoshout=0
	local lacerate=0
	local lacerate_stack=0
	local growl=0
	local surv=0
	local surv_up=0
	local enrage=0
	local bark=0
	local bark_up=0

	
	local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Rip Debuff"]); 
	if name ~= nil and caster == "player" then
		rip = expirationTime - currentTime
		if ((rip-FeralbyNight.old_rip)>=0 and (rip-FeralbyNight.old_rip)<=3 and (FeralbyNight.old_rip>0) and (rip>0) and FeralbyNight.shreded_rip<3) then
		FeralbyNight.shreded_rip=(FeralbyNight.shreded_rip+1);
		end
				if ((rip-FeralbyNight.old_rip)>8 and (FeralbyNight.old_rip>0) and (rip>0)) then
						FeralbyNight.shreded_rip=0;
			end
		FeralbyNight.elder_rip=FeralbyNight.old_rip;
		FeralbyNight.old_rip=rip;
		if rip<=0 then
		FeralbyNight.old_rip=0;
		FeralbyNight.shreded_rip=0;
	end
	end
			if FeralbyNight.shredglyph == 0 then FeralbyNight.shreded_rip=4 end

	
		local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitAura("player", FeralbyNight.L["Barkskin"]); 
	if name ~= nil then
		bark_up = expirationTime - currentTime
	end	
	
	
		name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitAura("player", FeralbyNight.L["Survival Instincts"]); 
	if name ~= nil then
		surv_up = expirationTime - currentTime
	end		
	
			 name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Lacerate Debuff"]); 
	if name ~= nil and caster == "player" then
		lacerate = expirationTime - currentTime
		lacerate_stack=count
	end	
	
		 name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Rake Debuff"]); 
	if name ~= nil and caster == "player" then
		rake = expirationTime - currentTime
	end	
	
		 name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Demoralizing Roar Debuff"]); 
	if name ~= nil then
		demoshout = expirationTime - currentTime
	end	

	 name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Demoralizing Shout"]); 
	if name ~= nil then
		demoshout = expirationTime - currentTime
	end	
	
	 name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Curse of Weakness"]); 
	if name ~= nil then
		demoshout = expirationTime - currentTime
	end	

	 name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Vindication"]); 
	if name ~= nil then
		demoshout = expirationTime - currentTime
	end	
	
	
		name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Mangle (Cat) Debuff"]); 
	if name ~= nil then
		mangle = expirationTime - currentTime
	end
	
	name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Mangle (Bear) Debuff"]); 
	if name ~= nil then
		mangle = expirationTime - currentTime
	end
	
	name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Trauma"]); 
	if name ~= nil then
		trauma = expirationTime - currentTime
	end

	
			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Faerie Fire (Feral)"]); 
		if name ~= nil then
			fffdur = expirationTime - currentTime
		end
		
						name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Sting"]); 
		if name ~= nil then
			fffdur = expirationTime - currentTime
		end
		
				name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Curse of Weakness"]); 
		if name ~= nil then
			fffdur = expirationTime - currentTime
		end


		name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Faerie Fire"]); 
		if name ~= nil then
			fffdur = expirationTime - currentTime
		end

		
		local start, duration, enabled = GetSpellCooldown(FeralbyNight.L["Faerie Fire (Feral)(Rank 6)"]);
		 	if duration ~= nil then
		fff = duration + start - currentTime	
		end
	

	name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitAura("player", FeralbyNight.L["Savage Roar"]); 
	if name ~= nil then
		sr = expirationTime - currentTime
	end	
	
	
			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Rend"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end

			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Garrote"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end

			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Rupture"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end

			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Pounce Bleed"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end

			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Savage Rend"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end

			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Rake (Pet)"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end
		
			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Deep Wounds"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end
		
			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Rake Debuff"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end

			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Rip Debuff"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end

			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Lacerate Debuff"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end
		
		
	

	start, duration, enabled = GetSpellCooldown(FeralbyNight.L["Berserk"]);
	if duration ~= nil then 
		berserk = duration + start - currentTime
	else
		berserk = 1000
	end
	
FeralbyNight.abilitycdmon[2]=FeralbyNight.abilitycdmon1[1]
FeralbyNight.abilitycdmon[3]=FeralbyNight.abilitycdmon1[2]
FeralbyNight.abilitycdmon[8]=FeralbyNight.abilitycdmon1[3]
 FeralbyNight.abilitycdmon[7]=FeralbyNight.abilitycdmon1[4]
  FeralbyNight.abilitycdmon[9]=FeralbyNight.abilitycdmon1[5]
 FeralbyNightcdmonFrame_2=FeralbyNightcdmonFrame1_1
 FeralbyNightcdmonFrame_3=FeralbyNightcdmonFrame1_2
 FeralbyNightcdmonFrame_8=FeralbyNightcdmonFrame1_3
 FeralbyNightcdmonFrame_7=FeralbyNightcdmonFrame1_4
  FeralbyNightcdmonFrame_9=FeralbyNightcdmonFrame1_5

 FeralbyNight.abilitycdmon[10]=FeralbyNight.abilitycdmon2[1]
FeralbyNight.abilitycdmon[11]=FeralbyNight.abilitycdmon2[2] 
 FeralbyNight.abilitycdmon[13]=FeralbyNight.abilitycdmon2[4]
FeralbyNight.abilitycdmon[14]=FeralbyNight.abilitycdmon2[5] 
 FeralbyNight.abilitycdmon[12]=FeralbyNight.abilitycdmon2[3]
 FeralbyNightcdmonFrame_10=FeralbyNightcdmonFrame2_1
 FeralbyNightcdmonFrame_11=FeralbyNightcdmonFrame2_2
 FeralbyNightcdmonFrame_13=FeralbyNightcdmonFrame2_4
 FeralbyNightcdmonFrame_14=FeralbyNightcdmonFrame2_5
 FeralbyNightcdmonFrame_12=FeralbyNightcdmonFrame2_3

 FeralbyNight.abilitycdmon[10]=FeralbyNight.abilitycdmon3[1]
  FeralbyNight.abilitycdmon[5]=FeralbyNight.abilitycdmon3[2]
 FeralbyNight.abilitycdmon[4]=FeralbyNight.abilitycdmon3[3]
FeralbyNight.abilitycdmon[6]=FeralbyNight.abilitycdmon3[4]
FeralbyNight.abilitycdmon[1]=FeralbyNight.abilitycdmon3[5]
 FeralbyNightcdmonFrame_10=FeralbyNightcdmonFrame3_1
 FeralbyNightcdmonFrame_5=FeralbyNightcdmonFrame3_2
 FeralbyNightcdmonFrame_4=FeralbyNightcdmonFrame3_3
 FeralbyNightcdmonFrame_6=FeralbyNightcdmonFrame3_4
  FeralbyNightcdmonFrame_1=FeralbyNightcdmonFrame3_5


		local start, duration, enabled = GetSpellCooldown(FeralbyNight.L["Enrage"]);
		if duration  ~= nil then
	enrage = duration + start - currentTime
	if enrage>50 then
	FeralbyNight.abilitycdmon[1]:SetAlpha(0.8)
	FeralbyNightcdmonFrame_1:SetText(string.format("%.0f",enrage-50))
	FeralbyNightcdmonFrame_1:SetBackdropColor(0, 0, 0,0)
	elseif enrage>1 then
	FeralbyNight.abilitycdmon[1]:SetAlpha(0.2)
	FeralbyNightcdmonFrame_1:SetText(string.format("%.0f", enrage))
	FeralbyNightcdmonFrame_1:SetBackdropColor(1, 0, 0,0.3)
	if enrage <=2 then
	FeralbyNight.abilitycdmon[1]:SetAlpha(math.abs(math.sin(enrage*3.28)))
	end
	else
	FeralbyNight.abilitycdmon[1]:SetAlpha(0.5)
	FeralbyNightcdmonFrame_1:SetBackdropColor(0, 0, 0,0)
	FeralbyNightcdmonFrame_1:SetText(nil)
	end	
	end
	
	 start, duration, enabled = GetSpellCooldown(FeralbyNight.L["Barkskin"]);
	 if duration ~= nil then
	bark = duration + start - currentTime
	if bark_up>0 then
	FeralbyNight.abilitycdmon[3]:SetAlpha(0.8)
	FeralbyNightcdmonFrame_3:SetText(string.format("%.0f",bark_up))
	FeralbyNightcdmonFrame_3:SetBackdropColor(0, 0, 0,0)
	elseif bark>1 then
	FeralbyNight.abilitycdmon[3]:SetAlpha(0.2)
	FeralbyNightcdmonFrame_3:SetText(string.format("%.0f", bark))
	FeralbyNightcdmonFrame_3:SetBackdropColor(1, 0, 0,0.3)
	if bark <=3 then
	FeralbyNight.abilitycdmon[3]:SetAlpha(math.abs(math.sin(bark*3.28)))
	end
	else
	FeralbyNight.abilitycdmon[3]:SetAlpha(0.5)
	FeralbyNightcdmonFrame_3:SetBackdropColor(0, 0, 0,0)
	FeralbyNightcdmonFrame_3:SetText(nil)
	end	
	end

	local start, duration, enabled = GetSpellCooldown(FeralbyNight.L["Survival Instincts"]);
	if duration  ~= nil then
	surv = duration + start - currentTime
	if surv_up>0 then
	FeralbyNight.abilitycdmon[2]:SetAlpha(0.8)
	FeralbyNightcdmonFrame_2:SetText(string.format("%.0f",surv_up))
	FeralbyNightcdmonFrame_2:SetBackdropColor(0, 0, 0,0)
	elseif surv>1 then
	FeralbyNight.abilitycdmon[2]:SetAlpha(0.2)
	FeralbyNightcdmonFrame_2:SetText(string.format("%.0f", surv))
	FeralbyNightcdmonFrame_2:SetBackdropColor(1, 0, 0,0.3)
	if surv <=3 then
	FeralbyNight.abilitycdmon[2]:SetAlpha(math.abs(math.sin(surv*3.28)))
	end
	else
	FeralbyNight.abilitycdmon[2]:SetAlpha(0.5)
	FeralbyNightcdmonFrame_2:SetBackdropColor(0, 0, 0,0)
	FeralbyNightcdmonFrame_2:SetText(nil)
	end	
end



		if lacerate>0 then
	FeralbyNight.abilitycdmon[5]:SetAlpha(0.8)
	FeralbyNightcdmonFrame_5:SetText(string.format("%.0f", lacerate).."      "..string.format("%.0f", lacerate_stack))
	if lacerate <=2 then
	FeralbyNight.abilitycdmon[5]:SetAlpha(math.abs(math.sin(lacerate*3.28)))
	end
	else
	FeralbyNight.abilitycdmon[5]:SetAlpha(0.1)
	FeralbyNightcdmonFrame_5:SetText(nil)
	end
	
	
	if rake>0 then
	FeralbyNight.abilitycdmon[11]:SetAlpha(0.8)
	FeralbyNightcdmonFrame_11:SetText(string.format("%.0f", rake))
	if rake <=2 then
	FeralbyNight.abilitycdmon[11]:SetAlpha(math.abs(math.sin(rake*3.28)))
	end
	else
	FeralbyNight.abilitycdmon[11]:SetAlpha(0.1)
	FeralbyNightcdmonFrame_11:SetText(nil)
	end
	
	
	if demoshout>0 then
	FeralbyNight.abilitycdmon[4]:SetAlpha(0.8)
	FeralbyNightcdmonFrame_4:SetText(string.format("%.0f", demoshout))
	if demoshout <=3 then
	FeralbyNight.abilitycdmon[4]:SetAlpha(math.abs(math.sin(demoshout*3.28)))
	end
	else
	FeralbyNight.abilitycdmon[4]:SetAlpha(0.1)
	FeralbyNightcdmonFrame_4:SetText(nil)
	end

	
	if rip>0 then
	FeralbyNight.abilitycdmon[12]:SetAlpha(0.8)
if FeralbyNight.shredglyph == 1 then
		FeralbyNightcdmonFrame_12:SetText(string.format("%.0f", rip).."     "..string.format("%.0f", FeralbyNight.shreded_rip))
	else
		FeralbyNightcdmonFrame_12:SetText(string.format("%.0f", rip))
	end
	if rip <=2 then
	FeralbyNight.abilitycdmon[12]:SetAlpha(math.abs(math.sin(rip*3.28)))
	end
	else
	FeralbyNight.abilitycdmon[12]:SetAlpha(0.1)
	FeralbyNightcdmonFrame_12:SetText(nil)
	end
	
	
	if mangle>trauma then
	mangle_trauma=mangle
	else
	mangle_trauma=trauma
	end
	if mangle_trauma>0 then
	FeralbyNight.abilitycdmon[10]:SetAlpha(0.8)
	FeralbyNight.abilitycdmon2[1]:SetAlpha(0.8)
	FeralbyNightcdmonFrame_10:SetText(string.format("%.0f", mangle_trauma))
	FeralbyNightcdmonFrame2_1:SetText(string.format("%.0f", mangle_trauma))
	if mangle_trauma <=2 then
	FeralbyNight.abilitycdmon[10]:SetAlpha(math.abs(math.sin(mangle_trauma*3.28)))
	FeralbyNight.abilitycdmon2[1]:SetAlpha(math.abs(math.sin(mangle_trauma*3.28)))
	end
	else
	FeralbyNight.abilitycdmon[10]:SetAlpha(0.1)
	FeralbyNight.abilitycdmon2[1]:SetAlpha(0.1)
	FeralbyNightcdmonFrame_10:SetText(nil)
	FeralbyNightcdmonFrame2_1:SetText(nil)
	end
	

		if fffdur>0  and fff>1.5 then
	FeralbyNight.abilitycdmon[9]:SetAlpha(0.8)
	FeralbyNightcdmonFrame_9:SetBackdropColor(1, 0, 0,0.3)
	FeralbyNightcdmonFrame_9:SetText(string.format("%.0f", fffdur).."     "..string.format("%.0f", fff))
	if fff<2 then
	FeralbyNight.abilitycdmon[9]:SetAlpha(math.abs(math.sin(fff*3.28)))
	end
	elseif fffdur <=0 and fff>1.5 then
FeralbyNight.abilitycdmon[9]:SetAlpha(0.8)
	FeralbyNightcdmonFrame_9:SetBackdropColor(1, 0, 0,0.3)
	FeralbyNightcdmonFrame_9:SetText(string.format("%.0f", fff))
	if fff<2 then
	FeralbyNight.abilitycdmon[9]:SetAlpha(math.abs(math.sin(fff*3.28)))
	end

	elseif fffdur>0 then
	FeralbyNightcdmonFrame_9:SetBackdropColor(0, 0, 0,0)
	FeralbyNight.abilitycdmon[9]:SetAlpha(0.8)
	FeralbyNightcdmonFrame_9:SetText(string.format("%.0f", fffdur))
	if fffdur <=2 then
	FeralbyNightcdmonFrame_9:SetBackdropColor(0, 0, 0,0)
	FeralbyNight.abilitycdmon[9]:SetAlpha(math.abs(math.sin(fffdur*3.28)))
	end
	else
	FeralbyNightcdmonFrame_9:SetBackdropColor(0, 0, 0,0)
	FeralbyNight.abilitycdmon[9]:SetAlpha(0.5)
	FeralbyNightcdmonFrame_9:SetText(nil)
	end	


	if bleeds>0 then
	FeralbyNight.abilitycdmon[7]:SetAlpha(0.8)
	FeralbyNightcdmonFrame_7:SetText(string.format("%.0f", bleeds, energy_x_sec))
	if bleeds <=2 then
	FeralbyNight.abilitycdmon[7]:SetAlpha(math.abs(math.sin(bleeds*3.28)))
	end
	else
	FeralbyNight.abilitycdmon[7]:SetAlpha(0.1)
	FeralbyNightcdmonFrame_7:SetText(nil)
	end
	
	name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitAura("player", FeralbyNight.L["Clearcasting"]); 
	if name ~= nil then
		ooc = expirationTime - currentTime
		if FeralbyNightdb.oocoverride==true and ooc>0 then
		FeralbyNight.abilitycdmon[7]:SetTexture(icon)
		end
	end
	
	if FeralbyNightdb.oocoverride==true and ooc>0 then
	if ooc>0 then
	FeralbyNight.abilitycdmon[7]:SetAlpha(0.8)
	FeralbyNightcdmonFrame_7:SetText(string.format("%.0f", ooc))
	if ooc <=2 then
	FeralbyNight.abilitycdmon[7]:SetAlpha(math.abs(math.sin(ooc*3.28)))
	end
	else
	FeralbyNight.abilitycdmon[7]:SetAlpha(0.1)
	FeralbyNightcdmonFrame_7:SetText(nil)
	end
	end
	
	
	if sr>0 then
	FeralbyNight.abilitycdmon[13]:SetAlpha(0.8)
	FeralbyNightcdmonFrame_13:SetText(string.format("%.0f", sr))
	if sr <=2 then
	FeralbyNight.abilitycdmon[13]:SetAlpha(math.abs(math.sin(sr*3.28)))
	end
	else
	FeralbyNight.abilitycdmon[13]:SetAlpha(0.1)
	FeralbyNightcdmonFrame_13:SetText(nil)
	end	
	

	start, duration, enabled = GetSpellCooldown(FeralbyNight.L["Growl"]);
		if duration ~= nil then
	growl = duration + start - currentTime
	if growl>0 then
	FeralbyNight.abilitycdmon[6]:SetAlpha(0.2)
	FeralbyNightcdmonFrame_6:SetText(string.format("%.0f", growl))
	FeralbyNightcdmonFrame_6:SetBackdropColor(1, 0, 0,0.3)
	if growl <=2 then
	FeralbyNight.abilitycdmon[6]:SetAlpha(math.abs(math.sin(growl*3.28)))
	end
	else
	FeralbyNight.abilitycdmon[6]:SetAlpha(0.5)
	FeralbyNightcdmonFrame_6:SetBackdropColor(0, 0, 0,0)
	FeralbyNightcdmonFrame_6:SetText(nil)
	end	
	end
	
	start, duration, enabled = GetSpellCooldown(FeralbyNight.L["Tiger's Fury"]);
	if duration ~= nil then
	tf = duration + start - currentTime
	
	if tf>24 then
	FeralbyNight.abilitycdmon[14]:SetAlpha(0.8)
	FeralbyNightcdmonFrame_14:SetText(string.format("%.0f", tf-24))
	FeralbyNightcdmonFrame_14:SetBackdropColor(0, 0, 0,0)
	elseif tf>1 then
	FeralbyNight.abilitycdmon[14]:SetAlpha(0.2)
	FeralbyNightcdmonFrame_14:SetText(string.format("%.0f", tf))
	FeralbyNightcdmonFrame_14:SetBackdropColor(1, 0, 0,0.3)
	if tf <=3 then
	FeralbyNight.abilitycdmon[14]:SetAlpha(math.abs(math.sin(tf*3.28)))
	end
	else
	FeralbyNight.abilitycdmon[14]:SetAlpha(0.5)
	FeralbyNightcdmonFrame_14:SetBackdropColor(0, 0, 0,0)
	FeralbyNightcdmonFrame_14:SetText(nil)
	end	
	end
	
	
	if berserk>=(165-FeralbyNight.berserkplyph) then
		berserk_up = berserk-(165-FeralbyNight.berserkplyph)
	end	
	if berserk_up>0 then
	FeralbyNight.abilitycdmon[8]:SetAlpha(0.8)
	FeralbyNightcdmonFrame_8:SetText(string.format("%.0f", berserk_up))
	FeralbyNightcdmonFrame_8:SetBackdropColor(0, 0, 0,0)
	elseif berserk>900 then
	FeralbyNight.abilitycdmon[8]:SetAlpha(0)
	FeralbyNightcdmonFrame_8:SetText(string.format("%.0f",""))
	FeralbyNightcdmonFrame_8:SetBackdropColor(1, 0, 0,0)
	elseif berserk>1.5 then
	FeralbyNight.abilitycdmon[8]:SetAlpha(0.2)
	FeralbyNightcdmonFrame_8:SetText(string.format("%.0f", berserk))
	FeralbyNightcdmonFrame_8:SetBackdropColor(1, 0, 0,0.3)
	if berserk <=3 then
	FeralbyNight.abilitycdmon[8]:SetAlpha(math.abs(math.sin(berserk*3.28)))
	end
	else
	FeralbyNight.abilitycdmon[8]:SetAlpha(0.5)
	FeralbyNightcdmonFrame_8:SetBackdropColor(0, 0, 0,0)
	FeralbyNightcdmonFrame_8:SetText(nil)
	end	
	


end








function FeralbyNight:DecideSpells()

	local guid = UnitGUID("target")


	if guid == nil then
		FeralbyNight.textureList["last"]:SetTexture(nil)
		FeralbyNight.textureList["current"]:SetTexture(nil)
		FeralbyNight.textureList["next"]:SetTexture(nil)
		FeralbyNight.textureList["misc"]:SetTexture(nil)
		FeralbyNight.textureList["int"]:SetTexture(nil)

		return
	end

	local energy = UnitPower("player",3)
	local cp = GetComboPoints("player")
	local health = UnitHealth("player")
	local mana = UnitPower("player",0)
	local power = UnitPower("player")
	local rage=UnitPower("player",1)
	local currentTime = GetTime()
	local _, status, _, _, _ = UnitDetailedThreatSituation("player","target")
	
	local catform, _, _, _, _, _, _, _, _ = UnitAura("player", FeralbyNight.L["Cat Form"]); 
	local bearform, _, _, _, _, _, _, _, _ = UnitAura("player", FeralbyNight.L["Dire Bear Form"]); 
	
			local base, posBuff, negBuff = UnitAttackPower("player");
	local moblevel = 0;
	moblevel = UnitLevel("target");
	if UnitLevel("target")==0 then
	moblevel = UnitLevel("player")
	end
	local mylevel = UnitLevel("player");
	if moblevel == -1 then
	moblevel = mylevel+3
	end


	local spell = ""
	local nextspell = ""
	local aoespell = ""
	local miscspell = ""
	local intspell = ""
  
	local GCD = 1
	local ooc = 0
	local rip = 0
	local rake = 0
	local mangle = 0
	local trauma = 0
	local sr = 0
	local tf = 0
	local berserk = 0
	local berserkbuff=0
	local fff = 0
	local fffdur = 0
	local ripvsfb = 0
	local bleeds=0
	local bleeds_dump=0
	local lag=0.0
	local sunder=0
	local sunderstack=0;
	local crittaken=0;
	local critmod =0;
	local real_ap =0;
	local savage_defense_absorb=0;
	local critChance =0;
	local hitChance =0;
	local missChance =0;
	local dodgechance=0;
	local totalmiss =0;
	local haste =0;
	local armorPenetration = 0;
	local bossarmor=10643
	bossarmor = 10643-(83-moblevel)*(914/3)
	local armorred = 0;
	
			local fury_m=0;
		local ret_m1=0;
		local ret_m2=0;
		

	
	local _, _, _, _, currRank, _= GetTalentInfo(2,29);
	local pg=currRank;
		_, _, _, _, currRank, _= GetTalentInfo(2,27);
	local impm = currRank*2;
		_, _, _, _, currRank, _= GetTalentInfo(2,9);
	local sa = currRank*9;
		_, _, _, _, currRank, _= GetTalentInfo(2,2);
	local fa = 0.03*currRank  
		_, _, _, _, currRank, _= GetTalentInfo(2,23);     
	local pistinct = 0.01+0.03*currRank;
		_, _, _, _, currRank, _= GetTalentInfo(2,25);
	local koj_m1=20*currRank;
			_, _, _, _, currRank, _= GetTalentInfo(2,4);
	local fury_m=0.1*currRank;
			_, _, _, _, currRank, _= GetTalentInfo(2,25);
	local ret_m1=0.04*currRank;
			_, _, _, _, currRank, _= GetTalentInfo(2,28);
	local ret_m2=0.05*currRank;
	


	
	local manglebot=0;


	local mangle_energy=1;
	local shred_energy=1;
	local rake_energy=1;
	local rip_energy=1;
	local sr_energy=1;
	local fb_energy=1;
	local catform_mana=1;
	local maim_energy=1;
	local bash_rage=1;
	
	
	local demoshout=0
	local lacerate=0
	local lacerate_stack=0
	local growl=0
	local surv=0
	local surv_up=0
	local enrage=0
	local bark=0
	local bark_up=0
	local mangle_bear=0
	local swipe=0
	
	local demoshout_rage=0
	local lacerate_rage=0
	local mangle_bear_rage=0
	local swipe_rage=0
	
	local FF=0
	local arpen_cap=0
	local heropres=0

	local maim=0
	local bash=0

	local bleeds_up=0
	
	
	
	
	if FeralbyNightdb.manglebot == true then
	manglebot=1
	else
	manglebot=0
	end

	local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitAura("player", FeralbyNight.L["Clearcasting"]); 
	if name ~= nil then
		ooc = expirationTime - currentTime
	end
	local ooc_down=1
	if ooc>0 then
	ooc_down=0
	else
	ooc_down=1
	end
	
	if ooc_down==1 then
	local name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Mangle (Cat)"])
	 	mangle_energy=powerCost;
	
	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Shred"])
		shred_energy=powerCost;
	
	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Rake"])
		rake_energy=powerCost;

	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Rip"])
		rip_energy=powerCost;

	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Savage Roar"])
		sr_energy=powerCost;
	
	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Ferocious Bite"])
		fb_energy=powerCost;

	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Maim"])
		maim_energy=powerCost;
		
	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Cat Form"])
		catform_mana=powerCost;
		
	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Mangle (Bear)"])
	 	mangle_bear_rage=powerCost;
	 	
	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Lacerate"])
	 	lacerate_rage=powerCost;

	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Demoralizing Roar"])
	 	demoshout_rage=powerCost;		
	
	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Swipe (Bear)"])
	 	swipe_rage=powerCost;	

	name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRang = GetSpellInfo(FeralbyNight.L["Bash"])
	 	swipe_rage=powerCost;	 	
end
	
	
				name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitAura("player", FeralbyNight.L["Heroic Presence (a)"]); 
	if name ~= nil then
		heropres =1
	else	
		name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitAura("player", FeralbyNight.L["Heroic Presence (b)"]); 
		if name ~= nil then
		heropres =1
	end
	end	
	
	
	--Stats Frame compute
	 critmod = -(moblevel-mylevel)*1.6;
	real_ap = base + posBuff + negBuff;
	savage_defense_absorb=real_ap/4;
	 critChance = (GetCritChance()+critmod)/100;
	 hitChance = GetCombatRatingBonus(CR_HIT_MELEE)+heropres;
	 missChance = 5+(moblevel-mylevel)*1.0-hitChance;
	if missChance<=0 then
	missChance = 0
	end
	dodgechance=(4.4+(moblevel-mylevel)*0.7)-GetExpertisePercent();
	if dodgechance<=0 then
	dodgechance = 0
	end
	totalmiss= missChance+dodgechance;
	local mainSpeed, offSpeed = UnitAttackSpeed("player");
	local lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentmod = UnitDamage("player");
	haste = GetCombatRatingBonus(18);
	armorPenetration = GetArmorPenetration();
	armorred = armorPenetration;
	--end
	
	name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Rake Debuff"]); 
	if name ~= nil and caster == "player" then
		rake = expirationTime - currentTime
	end	
	
	name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Rip Debuff"]); 
	if name ~= nil and caster == "player" then
		rip = expirationTime - currentTime
	end
	
	name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Mangle (Cat) Debuff"]); 
	if name ~= nil then
		mangle = expirationTime - currentTime
	end
	
	name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Mangle (Bear) Debuff"]); 
	if name ~= nil then
		mangle = expirationTime - currentTime
	end
	
	name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Trauma"]); 
	if name ~= nil then
		trauma = expirationTime - currentTime
	end
	
		name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Faerie Fire (Feral)"]); 
		if name ~= nil then
			fffdur = expirationTime - currentTime
		end
		
						name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Sting"]); 
		if name ~= nil then
			fffdur = expirationTime - currentTime
		end
		
				name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Curse of Weakness"]); 
		if name ~= nil then
			fffdur = expirationTime - currentTime
		end
		
		name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Faerie Fire"]); 
		if name ~= nil then
			fffdur = expirationTime - currentTime
		end
		
				local start, duration, enabled = GetSpellCooldown(FeralbyNight.L["Faerie Fire (Feral)(Rank 6)"]);
		if duration ~= nil then
		fff = duration + start - currentTime	
		end
		
						name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Acid Spit"]); 
		if name ~= nil then
			sunder = expirationTime - currentTime
			sunderstack=count
		end
		
						name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Expose Armor"]); 
		if name ~= nil then
			sunder = expirationTime - currentTime
			sunderstack=count
		end
		
						name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Sunder Armor"]); 
		if name ~= nil then
			sunder = expirationTime - currentTime
			sunderstack=count
		end
		
								name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Heart of the Crusader"]); 
		if name ~= nil then
			crittaken = expirationTime - currentTime
		end
		
								name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Master Poisoner"]); 
		if name ~= nil then
			crittaken = expirationTime - currentTime
		end
		
		
		


			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Rend"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end

			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Garrote"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end

			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Rupture"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end

			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Pounce Bleed"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end

			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Savage Rend"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end

			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Rake (Pet)"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end
		
			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Deep Wounds"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end
		
			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Rake Debuff"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end

			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Rip Debuff"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end

			name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Lacerate Debuff"]); 
		if name ~= nil then
			bleeds_dump = expirationTime - currentTime
			if bleeds_dump>bleeds then
			bleeds=bleeds_dump
			end
		end
		
		
		if FeralbyNightdb.lagcorrection then
		local bandwidthIn, bandwidthOut, latency = GetNetStats();
		if name ~= nil then
			lag = latency/100
		end
		
		if lag<=0.1 then
		lag=0.1
		end
		end
	
	name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitAura("player", FeralbyNight.L["Savage Roar"]); 
	if name ~= nil then
		sr = expirationTime - currentTime
	end	
	
		name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitAura("player", FeralbyNight.L["Totem of Wrath"]); 
	if name ~= nil then
		crittaken = 1
	end	
	
		start, duration, enabled = GetSpellCooldown(FeralbyNight.L["Maim"]);
		if duration ~= nil then
		maim = duration + start - currentTime	
		end
		
		start, duration, enabled = GetSpellCooldown(FeralbyNight.L["Bash"]);
		if duration ~= nil then
		bash = duration + start - currentTime	
		end
			
	local start, duration, enabled = GetSpellCooldown(FeralbyNight.L["Tiger's Fury"]);
	if duration ~= nil then
	tf = duration + start - currentTime
		if tf<=0 and catform ~= nil then
			FeralbyNight.textureList["misc"]:SetTexture(GetSpellTexture(FeralbyNight.L["Tiger's Fury"]))
		else
			FeralbyNight.textureList["misc"]:SetTexture(nil)
		end

	end
	
	local start, duration, enabled = GetSpellCooldown(FeralbyNight.L["Berserk"]);
	if duration ~= nil then 
		berserk = duration + start - currentTime
	else
		berserk = 1000
	end
	
		if berserk > (165-FeralbyNight.berserkplyph) then
		berserkbuff = 1
	else
		berserkbuff = 0
	end	
	
		if crittaken>0 then
		 critChance = (GetCritChance()+critmod+3.0)/100
		 end
		 
	 	--Compute ability usage (FB vs. RIP vs. SR)

		if fffdur>0 then
		FF=1
		else
		FF=0
		end
		
		if bleeds>0 then
		bleeds_up=1
		end
		
	arpen_cap=(((1-FF*0.05)*(1-0.04*sunderstack))*bossarmor+15232.5)/3
	if ((((1-FF*0.05)*(1-0.04*sunderstack))*bossarmor) < arpen_cap) then
		arpen_cap=(((1-FF*0.05)*(1-0.04*sunderstack))*bossarmor);
	end
	bossarmor=bossarmor*((1-FF*0.05)*(1-0.04*sunderstack))-(armorPenetration/100)*arpen_cap;	
	armorred=1-(15232.5 / (bossarmor + 15232.5))
	
	 					
	 					local yhitted=(1-totalmiss/100);
	 					local ycrit=yhitted*critChance;
	 					local yhit=yhitted-ycrit;
						local fb_crit=yhitted*(critChance+fourT9*0.05+bleeds_up*ret_m2); -- 3.1 ready
						local fb_hit=yhitted-fb_crit;
						
						if ((critChance+fourT9*0.05+bleeds_up*ret_m2)>=1) then -- 3.1 ready
							fb_crit=yhitted
							fb_hit=0
						end
												
						local extfben = energy-fb_energy;
							if extfben >30 then
							extfben = 30
							end
							
							if extfben <=0 then
								extfben = 0
							end

						
						local Fb_damage = (1-armorred)*(190+(290+0.07*real_ap)*5+(9.4+real_ap*0.002439)*extfben)*(1+fa)*(fb_hit+fb_crit*2*(1+pistinct)*(1+FeralbyNight.crit_meta));
						local rake_damage=((real_ap*0.01+176)*(yhit+ycrit*2*(1+pistinct)*(1+FeralbyNight.crit_meta))+(3+twoT9)*(real_ap*0.06+358)*(yhit+ycrit*(1-fourT10)+fourT10*ycrit*2*(1+pistinct)*(1+FeralbyNight.crit_meta)))*(1+fury_m)*1.3+idol_cryingmoon*500;
						local shred_damage=(((real_ap/14+54.857)*2.25+666+idol_shred*203.0)*(yhit+ycrit*2*(1+pistinct)*(1+FeralbyNight.crit_meta)))*(1+fury_m)*(1+bleeds_up*ret_m1)*1.3*(1-armorred);
						local rip_damagextick =1.3*((1-(critChance+fourT9*0.05)*pg)+(critChance+fourT9*0.05)*pg*2.0*(1+pistinct)*(1+FeralbyNight.crit_meta))*(real_ap*0.01*5+36+21.0*idol_ws*5+93*5);
						if((rip>0) and (rip-FeralbyNight.elder_rip)>10) then
						FeralbyNight.rip_damagextick_saved=rip_damagextick;
						end
						local use_rake=1
						local shredder=0;

						
		if ((FeralbyNight.shreded_rip<3) and (rip<(2.5*(3-FeralbyNight.shreded_rip))) and (tf>(rip-2)) and ((rip-(shred_energy-energy)/10)>GCD)) then
							shredder=1;
							end
						if ((((rake_damage+twoT8_rate*3*shred_damage)/(rake_energy))/((shred_damage+(FeralbyNight.rip_damagextick_saved*shredder))/shred_energy))<FeralbyNightdb.shredvsrake) then
							use_rake=0;
							end
							
name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitBuff("player",FeralbyNight.bossaura["Hodir - Stormpower"]) 
if ((name ~= nil) and FeralbyNightdb.bossmode==true) then
use_rake=0;
end

						
						
						local avg_cp = {
							(1/yhitted),
							(1/yhitted)*(2*yhit*yhit+2*yhit*ycrit+ycrit),
							(1/yhitted)*(3*yhit*yhit*yhit+4*ycrit*yhit+2*ycrit*ycrit+3*yhit*yhit*ycrit),
							(1/yhitted)*(4*yhit*yhit*yhit+9*yhit*yhit*ycrit+6*yhit*(ycrit)*ycrit+2*ycrit*ycrit),
							(1/yhitted)*(5*yhit*yhit*yhit*yhit*yhit+16*ycrit*yhit*yhit*yhit+5*ycrit*yhit*yhit*yhit*yhit+9*ycrit*ycrit*yhit+3*ycrit*ycrit*ycrit+12*ycrit*ycrit*yhit*yhit)
							};

						local cp_to_cycle=avg_cp[FeralbyNightdb.SRCP]+avg_cp[5];
						local energy_x_sec= 10;
						if (FeralbyNightdb.conservativeplay == false) then
							energy_x_sec= 10+2.33/mainSpeed+twoT8_rate*30;
						end
						
						local combovsfb_time=((0.694+0.036*manglebot)*shred_energy+(0.261+0.009*manglebot)*rake_energy+0.045*mangle_energy*(1-manglebot))*(cp_to_cycle/energy_x_sec)-(Fb_damage/rip_damagextick)*2+(sr_energy+rip_energy)/energy_x_sec;
						local combovsfb_time_koj=combovsfb_time-koj_m1/10.0;
						
						if combovsfb_time<ceil(cp_to_cycle)+2 then
							combovsfb_time=ceil(cp_to_cycle)+2;
						end
						if combovsfb_time_koj<ceil(cp_to_cycle)+2 then
							combovsfb_time_koj=ceil(cp_to_cycle)+2;
						end
						
						local max_rip_downtime=(((Fb_damage/rip_damagextick)*2)/FeralbyNightdb.ripvsfb)-((FeralbyNightdb.ripvsfb-1)/2)
						
						local ripvsfb_time=((0.694+0.036*manglebot)*shred_energy+(0.261+0.009*manglebot)*rake_energy+0.045*mangle_energy*(1-manglebot))*(avg_cp[5]/energy_x_sec)-max_rip_downtime+(rip_energy)/energy_x_sec;
						local ripvsfb_time_koj=ripvsfb_time-koj_m1/10.0;
							
							if ripvsfb_time_koj<ceil(avg_cp[5])+1 then
								ripvsfb_time_koj=ceil(avg_cp[5])+1;
							end
							if ripvsfb_time<ceil(avg_cp[5])+1 then
								ripvsfb_time=ceil(avg_cp[5])+1;
							end
							
						local srvsfb_time=FeralbyNightdb.srvsfinisher*(((0.694+0.036*manglebot)*shred_energy+(0.261+0.009*manglebot)*rake_energy+0.045*mangle_energy*(1-manglebot))*(avg_cp[FeralbyNightdb.SRCP]/energy_x_sec));
						local srvsfb_time_koj=srvsfb_time-koj_m1/10.0;
						
						if srvsfb_time<ceil(avg_cp[FeralbyNightdb.SRCP])+1 then
							srvsfb_time=ceil(avg_cp[FeralbyNightdb.SRCP])+1;
						end
						if srvsfb_time_koj<ceil(avg_cp[FeralbyNightdb.SRCP])+1 then
							srvsfb_time_koj=ceil(avg_cp[FeralbyNightdb.SRCP])+1;
						end

	 	
	 	--end cumpute ability usage

	 	--Melee Frame update---
		
		if bearform ~= nil then
		FeralbyNightMeleeFrame:SetText(string.format("%.3f",mainSpeed).." Speed, "..string.format("%.3f",haste).."% haste |n"..string.format("%.3f", missChance).."% miss, "..string.format("%.3f",dodgechance).."% dodged |n"..string.format("%.3f", armorPenetration).."% ArPen, "..string.format("%.3f",armorred*100).."% dmg red |n"..real_ap.." AP, "..string.format("%.3f",critChance*100).."% crit |n"..savage_defense_absorb.." Savage Defense Shield");
		else
		FeralbyNightMeleeFrame:SetText(string.format("%.3f",mainSpeed).." Speed, "..string.format("%.3f",haste).."% haste |n"..string.format("%.3f", missChance).."% miss, "..string.format("%.3f",dodgechance).."% dodged |n"..string.format("%.3f", armorPenetration).."% ArPen, "..string.format("%.3f",armorred*100).."% dmg red |n"..real_ap.." AP, "..string.format("%.3f",critChance*100).."% crit");
end

---bear
	local start, duration, _ = GetSpellCooldown(FeralbyNight.L["Enrage"]);
	if duration ~= nil then
	enrage = duration + start - currentTime
		if enrage<=0 and bearform ~= nil then
			FeralbyNight.textureList["misc"]:SetTexture(GetSpellTexture(FeralbyNight.L["Enrage"]))
		elseif catform == nil then
			FeralbyNight.textureList["misc"]:SetTexture(nil)
		end

	end
	
	 start, duration, _ = GetSpellCooldown(FeralbyNight.L["Barkskin"]);
	if duration ~= nil then
	bark = duration + start - currentTime
	end
	
	local start, duration, _ = GetSpellCooldown(FeralbyNight.L["Survival Instincts"]);
	if duration ~= nil then
	surv = duration + start - currentTime
	end
	
		 name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Lacerate Debuff"]); 
	if name ~= nil and caster == "player" then
		lacerate = expirationTime - currentTime
		lacerate_stack=count
	end	
	
	 name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Demoralizing Roar Debuff"]); 
	if name ~= nil then
		demoshout = expirationTime - currentTime
	end	

	 name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Demoralizing Shout"]); 
	if name ~= nil then
		demoshout = expirationTime - currentTime
	end	
	
	 name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Curse of Weakness"]); 
	if name ~= nil then
		demoshout = expirationTime - currentTime
	end	

	 name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitDebuff("target", FeralbyNight.L["Vindication"]); 
	if name ~= nil then
		demoshout = expirationTime - currentTime
	end	
	
	start, duration, enabled = GetSpellCooldown(FeralbyNight.L["Growl"]);
	if duration ~= nil then
	growl = duration + start - currentTime
	end
	
	start, duration, enabled = GetSpellCooldown(FeralbyNight.L["Mangle (Bear)"]);
	if duration ~= nil then
	mangle_bear = duration + start - currentTime
	end
--bear end

		local finish=FeralbyNight.castfinish
		local durat=FeralbyNight.castdurat
		local castname=FeralbyNight.castname
	 
	 
	 	 	
	spell = FeralbyNight:NextSpell(energy,cp,GCD,ooc,rip,rake,mangle,trauma,sr,tf,berserk,fff,fffdur,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy, rake_energy, shred_energy, sr_energy, fb_energy, rip_energy, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim, maim_energy, bash, bash_rage, finish, durat, castname, bleeds, energy_x_sec)
	if FeralbyNightdb.showPrediction == true then
		if spell == FeralbyNight.L["Tiger's Fury"] then
			nextspell = FeralbyNight:NextSpell(energy + koj_m1,cp,GCD,ooc - lag,rip-lag,rake - lag,mangle - lag,trauma - lag,sr - lag,tf - lag,berserk - lag,fff - lag,fffdur,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy, rake_energy, shred_energy, sr_energy, fb_energy, rip_energy, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim-1, maim_energy, bash, bash_rage, finish-1, durat, castname, bleeds, energy_x_sec)
			intspell = nextspell
		elseif spell == FeralbyNight.L["Mangle (Cat)"] then
				nextspell = FeralbyNight:NextSpell(energy - mangle_energy*ooc_down + 10, cp + 1,GCD, 0,rip - 1,rake - 1,17,trauma - 1,sr - 1,tf - 1,berserk - 1,fff - 1,fffdur-1,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy, rake_energy, shred_energy, sr_energy, fb_energy, rip_energy, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim-1, maim_energy, bash, bash_rage, finish-1, durat, castname, bleeds-1, energy_x_sec)
				intspell = FeralbyNight:NextSpell(energy - mangle_energy*ooc_down+ 10, cp + 2,GCD, 0,rip - 1,rake - 1,17,trauma - 1,sr - 1,tf - 1,berserk - 1,fff - 1,fffdur-1,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy, rake_energy, shred_energy, sr_energy, fb_energy, rip_energy, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim-1, maim_energy, bash, bash_rage, finish-1, durat, castname, bleeds-1, energy_x_sec)
		elseif spell == FeralbyNight.L["Maim"] then
				nextspell = FeralbyNight:NextSpell(energy - maim_energy*ooc_down + 10, 0,GCD, 0,rip - 1,rake - 1,17,trauma - 1,sr - 1,tf - 1,berserk - 1,fff - 1,fffdur-1,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy, rake_energy, shred_energy, sr_energy, fb_energy, rip_energy, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim, maim_energy, bash, bash_rage, finish-10, -10, castname, bleeds+5, energy_x_sec)
				intspell = nextspell
		elseif spell == FeralbyNight.L["Shred"] then
		nextspell = FeralbyNight:NextSpell(energy - shred_energy*ooc_down + 10, cp + 1,GCD, 0,rip - 1,rake - 1,mangle - 1,trauma - 1,sr - 1,tf - 1,berserk - 1,fff - 1,fffdur-1,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy, rake_energy, shred_energy, sr_energy, fb_energy, rip_energy, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim-1, maim_energy, bash, bash_rage, finish-1, durat, castname, bleeds-1, energy_x_sec)
				intspell = FeralbyNight:NextSpell(energy - shred_energy*ooc_down + 10, cp + 2,GCD, 0,rip - 1,rake - 1,mangle - 1,trauma - 1,sr - 1,tf - 1,berserk - 1,fff - 1,fffdur-1,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy, rake_energy, shred_energy, sr_energy, fb_energy, rip_energy, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim-1, maim_energy, bash, bash_rage, finish-1, durat, castname, bleeds-1, energy_x_sec)
		elseif spell == FeralbyNight.L["Rake"] then
				nextspell = FeralbyNight:NextSpell(energy - rake_energy*ooc_down + 10, cp + 1,GCD, 0,rip - 1,8,mangle - 1,trauma - 1,sr - 1,tf - 1,berserk - 1,fff - 1,fffdur-1,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy, rake_energy, shred_energy, sr_energy, fb_energy, rip_energy, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim-1, maim_energy, bash, bash_rage, finish-1, durat, castname, bleeds+8, energy_x_sec)
				intspell = FeralbyNight:NextSpell(energy - rake_energy*ooc_down + 10, cp + 2,GCD, 0,rip - 1,8,mangle - 1,trauma - 1,sr - 1,tf - 1,berserk - 1,fff - 1,fffdur-1,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy, rake_energy, shred_energy, sr_energy, fb_energy, rip_energy, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim-1, maim_energy, bash, bash_rage, finish-1, durat, castname, bleeds+8, energy_x_sec)
		elseif spell == FeralbyNight.L["Rip"] then
		nextspell = FeralbyNight:NextSpell(energy - rip_energy*ooc_down + 10, 0,GCD, 0,rip - 1,rake - 1,mangle - 1,trauma - 1,sr - 1,tf - 1,berserk - 1,fff - 1,fffdur-1,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy, rake_energy, shred_energy, sr_energy, fb_energy, rip_energy, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim-1, maim_energy, bash, bash_rage, finish-1, durat, castname, bleeds+11, energy_x_sec)
				intspell = nextspell
		elseif spell == FeralbyNight.L["Savage Roar"] then
				nextspell = FeralbyNight:NextSpell(energy - sr_energy + 10, 0,GCD, ooc - 1,rip - 1,rake - 1,mangle - 1,trauma - 1,sr - 1,tf - 1,berserk - 1,fff - 1,fffdur-1,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy, rake_energy, shred_energy, sr_energy, fb_energy, rip_energy, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim-1, maim_energy, bash, bash_rage, finish-1, durat, castname, bleeds-1, energy_x_sec)
				intspell = nextspell
			elseif spell == FeralbyNight.L["Ferocious Bite"] then
				if energy >=(fb_energy*ooc_down+30) then
					nextspell = FeralbyNight:NextSpell(energy - fb_energy*ooc_down - 30 + 10, 0,GCD, 0,rip - 1,rake - 1,mangle - 1,trauma - 1,sr - 1,tf - 1,berserk - 1,fff - 1,fffdur-1,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy, rake_energy, shred_energy, sr_energy, fb_energy, rip_energy, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim-1, maim_energy, bash, bash_rage, finish-1, durat, castname, bleeds-1, energy_x_sec)
					intspell = nextspell
				else
					nextspell = FeralbyNight:NextSpell(10, 0,GCD, 0,rip - 1,rake - 1,mangle - 1,trauma - 1,sr - 1,tf - 1,berserk - 1,fff - 1,fffdur-1,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy, rake_energy, shred_energy, sr_energy, fb_energy, rip_energy, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim-1, maim_energy, bash, bash_rage, finish-1, durat, castname, bleeds-1, energy_x_sec)
					intspell = nextspell
				end
		elseif spell == FeralbyNight.L["Berserk"] then
			nextspell = FeralbyNight:NextSpell(energy + 10, cp,GCD, ooc - 1,rip - 1,rake - 1,mangle - 1,trauma - 1,sr - 1,tf - 1,berserk - 1,fff - 1,fffdur-1,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy/2, rake_energy/2, shred_energy/2, sr_energy/2, fb_energy/2, rip_energy/2, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim-1, maim_energy, bash, bash_rage, finish-1, durat, castname, bleeds-1, energy_x_sec)
			intspell = nextspell
		elseif spell == "" then
			nextspell = FeralbyNight:NextSpell(energy + 10, cp,GCD, ooc - 1,rip - 1,rake - 1,mangle - 1,trauma - 1,sr - 1,tf - 1,berserk - 1,fff - 1,fffdur-1,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy, rake_energy, shred_energy, sr_energy, fb_energy, rip_energy, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim-1, maim_energy, bash, bash_rage, finish-1, durat, castname, bleeds-1, energy_x_sec)
			intspell = nextspell
		end
	end

	FeralbyNight.textureList["current"]:SetTexture(GetSpellTexture(spell))
	if berserk < 1 then
		FeralbyNight.textureList["last"]:SetTexture(GetSpellTexture(FeralbyNight.L["Berserk"]))
	else
		FeralbyNight.textureList["last"]:SetTexture(nil)
	end
	if catform~= nil then
	if FeralbyNightdb.showPrediction == true then
		FeralbyNight.textureList["next"]:SetTexture(GetSpellTexture(nextspell))
		FeralbyNight.textureList["int"]:SetTexture(GetSpellTexture(intspell))
	else
		FeralbyNight.textureList["next"]:SetTexture(nil)
		FeralbyNight.textureList["int"]:SetTexture(nil)
	end
	elseif bearform~= nil then
		if FeralbyNightdb.showPrediction == true then
		if rage>35 then
		FeralbyNight.textureList["next"]:SetTexture(GetSpellTexture(FeralbyNight.L["Maul"]))
		else
		FeralbyNight.textureList["next"]:SetTexture(nil)
		end
		if bark<1 then
		FeralbyNight.textureList["int"]:SetTexture(GetSpellTexture(FeralbyNight.L["Barkskin"]))
		else
		FeralbyNight.textureList["int"]:SetTexture(nil)
		end

	else
		FeralbyNight.textureList["next"]:SetTexture(nil)
		FeralbyNight.textureList["int"]:SetTexture(nil)
	end
	end
	

	if spell ~= "" and spell ~= nil then
	    local start, dur = GetSpellCooldown(spell)
		if dur == 0 or start == nil or dur == nil then
			FeralbyNight.cooldownFrame:SetAlpha(0)
		else
			FeralbyNight.cooldownFrame:SetAlpha(1)
			FeralbyNight.cooldownFrame:SetCooldown(start, dur)
		end
	end
	

end

function FeralbyNight:NextSpell(energy,cp,GCD,ooc,rip,rake,mangle,trauma,sr,tf,berserk,fff,fffdur,combovsfb_time, combovsfb_time_koj, ripvsfb_time, ripvsfb_time_koj, srvsfb_time, srvsfb_time_koj,lag, bossname,mangle_energy, rake_energy, shred_energy, sr_energy, fb_energy, rip_energy, koj_m1, status, catform, bearform, enrage, bark, surv, lacerate, lacerate_stack, demoshout, growl, mangle_bear_rage, mangle_bear, swipe_rage, lacerate_rage, max_rip_downtime,  demoshout_rage, rage, use_rake, maim, maim_energy, bash, bash_rage, finish, durat, castname, bleeds, energy_x_sec)

local shred_status=1
local rake_status=use_rake
local mangle_switch=1
if FeralbyNightdb.manglepriority==0 then
mangle_switch=0
end

if bleeds<=lag then
rake_status=1
shred_status=0
end

if (FeralbyNight.currentTarget.id==FeralbyNight.bossid["Training Dummy"] or FeralbyNight.currentTarget.id==FeralbyNight.bossid["Heroic Training Dummy"] or FeralbyNight.currentTarget.id==FeralbyNight.bossid["Expert's Training Dummy"] or FeralbyNight.currentTarget.id==FeralbyNight.bossid["Master's Training Dummy"] or FeralbyNight.currentTarget.id==FeralbyNight.bossid["Grandmaster's Training Dummy"]) then
FeralbyNight.time_to_die=60
end


if ((FeralbyNightdb.shred==false) or ((status==2) and (FeralbyNightdb.bossmode==true and FeralbyNight.currentTarget.id~=FeralbyNight.bossid["Razorscale"])) or ((status==3) and (FeralbyNightdb.bossmode==true and FeralbyNight.currentTarget.id~=FeralbyNight.bossid["Razorscale"])) or (FeralbyNightdb.bossmode==true and FeralbyNight.currentTarget.id==FeralbyNight.bossid["Flame Leviathan Turret"]) or (FeralbyNightdb.bossmode==true and FeralbyNight.currentTarget.id==FeralbyNight.bossid["Kologarn body"]) or (FeralbyNightdb.bossmode==true and FeralbyNight.currentTarget.id==FeralbyNight.bossid["Kologarn left arm"]) or (FeralbyNightdb.bossmode==true and FeralbyNight.currentTarget.id==FeralbyNight.bossid["Kologarn right arm"]) or (FeralbyNightdb.bossmode==true and FeralbyNightdb.shredontentacles==false and FeralbyNight.currentTarget.id==FeralbyNight.bossid["Crusher Tentacle"]) or (FeralbyNightdb.bossmode==true and FeralbyNightdb.shredontentacles==false and FeralbyNight.currentTarget.id==FeralbyNight.bossid["Constrictor Tentacle"]) or (FeralbyNightdb.bossmode==true and FeralbyNightdb.shredontentacles==false and FeralbyNight.currentTarget.id==FeralbyNight.bossid["Corruptor Tentacle"]) or (FeralbyNightdb.bossmode==true and FeralbyNight.currentTarget.id==FeralbyNight.bossid["Living Constellation"]) or (FeralbyNightdb.bossmode==true and FeralbyNight.currentTarget.id==FeralbyNight.bossid["Collapsing Star"]) or (FeralbyNightdb.bossmode==true and FeralbyNight.currentTarget.id==FeralbyNight.bossid["Eonar's Gift"])) then
shred_status=0
end



  	 if (catform~=nil) then
  	 
  	 if(((FeralbyNightdb.suggestinterrupt==true and durat>FeralbyNightdb.mincasttime) or (FeralbyNightdb.bossmode==true and ((castname==FeralbyNight.bosscast["Razor-Watcher-Chain 1"] and FeralbyNightdb.interrupt.razorchain==true) or (castname==FeralbyNight.bosscast["Razor-Watcher-Chain 2"] and FeralbyNightdb.interrupt.razorchain==true) or (castname==FeralbyNight.bosscast["Stormcaller - Council - Chain Lightning"] and FeralbyNightdb.interrupt.stormchain==true) or (castname==FeralbyNight.bosscast["Stormcaller - Council - Lightning Whirl"] and FeralbyNightdb.interrupt.stormwhirl==true) or (castname==FeralbyNight.bosscast["Auriaya - Sentinel Blast"] and FeralbyNightdb.interrupt.sentinelblast==true) or (castname==FeralbyNight.bosscast["Thorim - Acolyte - Greater Heal"] and FeralbyNightdb.interrupt.thorimGL==true) or (castname==FeralbyNight.bosscast["Thorim - Evoker - Runic Mending"] and FeralbyNightdb.interrupt.thorimRM==true) or (castname==FeralbyNight.bosscast["Vezax - Searing Flame"] and FeralbyNightdb.interrupt.searingflame==true) or (castname==FeralbyNight.bosscast["Yogg - Dark volley"] and FeralbyNightdb.interrupt.darkvolley==true) or (castname==FeralbyNight.bosscast["Yogg - Drain Life"] and FeralbyNightdb.interrupt.drainlife==true) or (castname==FeralbyNight.bosscast["Yogg - Drain Life"] and FeralbyNightdb.interrupt.drainlife==true)))) and finish>lag and maim<=lag and energy>=maim_energy and cp>0) then
  	 return FeralbyNight.L["Maim"]
  	 
  	 
  	   	 elseif ((FeralbyNightdb.bossmode==true and (FeralbyNight.currentTarget.id==FeralbyNight.bossid["XT-002"]) and (FeralbyNightdb.saveforheart==true) and (FeralbyNight.bosslifepc<0.78 and FeralbyNight.bosslifepc>0.70)) and sr<19 and cp>=2 and (energy>=sr_energy or ooc > 0)) then
	return FeralbyNight.L["Savage Roar"]
  	
  	 elseif ((FeralbyNightdb.bossmode==true and (FeralbyNight.currentTarget.id==FeralbyNight.bossid["XT-002"]) and (FeralbyNightdb.saveforheart==true) and (FeralbyNight.bosslifepc<0.78 and FeralbyNight.bosslifepc>0.70)) and energy<85) then
  	 return ""
  	 

		elseif ((((sr <=lag) and (cp>0)) or (cp==5 and sr < srvsfb_time)) and (energy>=sr_energy or ooc > 0) and (sr<FeralbyNight.time_to_die or FeralbyNightdb.killmode==false)) then
				return FeralbyNight.L["Savage Roar"]
			
        elseif ((ooc > 0) and (shred_status==1)) then
			if (mangle <=lag and trauma <=lag) then
				return FeralbyNight.L["Mangle (Cat)"]
			else
				return FeralbyNight.L["Shred"]
			end
			
        elseif ((ooc > 0) and (shred_status==0)) then
        			if (mangle <=lag and trauma <=lag and FeralbyNightdb.manglepriority==2) then
				return FeralbyNight.L["Mangle (Cat)"]
			elseif (rip <=lag and cp==5) then
						return FeralbyNight.L["Rip"]
			elseif (mangle <=lag and trauma <=lag) then
				return FeralbyNight.L["Mangle (Cat)"]
			elseif (rake <=lag) then
						return FeralbyNight.L["Rake"]
			else
				return FeralbyNight.L["Mangle (Cat)"]
			end
				
		elseif ((tf <=lag) and (energy < (95-koj_m1)) and (berserk < (165-FeralbyNight.berserkplyph)) and (cp<5 or rip<((95-koj_m1)/10)) and ((FeralbyNightdb.bossmode==false) or (FeralbyNight.currentTarget.id~=FeralbyNight.bossid["XT-002"]) or (FeralbyNightdb.saveforheart==false) or (FeralbyNight.bosslifepc>0.78 or FeralbyNight.bosslifepc<0.70))) then
			return FeralbyNight.L["Tiger's Fury"]

		
		elseif ((berserk <=lag) and (energy >= 70) and (sr > GCD+lag) and (FeralbyNightdb.Berserk == true) and ((FeralbyNightdb.bossmode==false) or (FeralbyNight.currentTarget.id~=FeralbyNight.bossid["XT-002"] or FeralbyNight.currentTarget.id~=FeralbyNight.bossid["Dark Rune Watcher"] or FeralbyNight.currentTarget.id~=FeralbyNight.bossid["Dark Rune Sentinel"] or FeralbyNight.currentTarget.id~=FeralbyNight.bossid["Dark Rune Guardian"]) or (FeralbyNight.currentTarget.id==FeralbyNight.bossid["XT-002"] and FeralbyNightdb.saveforheart==false) or (FeralbyNight.currentTarget.id==FeralbyNight.bossid["XT-002"] and FeralbyNight.bosslifepc<0.70) or ((FeralbyNight.currentTarget.id==FeralbyNight.bossid["Dark Rune Watcher"] or FeralbyNight.currentTarget.id==FeralbyNight.bossid["Dark Rune Sentinel"] or FeralbyNight.currentTarget.id==FeralbyNight.bossid["Dark Rune Guardian"]) and FeralbyNightdb.saveforrazor==false))) then
			return FeralbyNight.L["Berserk"]
		
		
		elseif ((mangle <=lag) and (trauma <=lag) and (energy>=mangle_energy)) then
			return FeralbyNight.L["Mangle (Cat)"]



		
		elseif ((rake <=lag) and cp<5 and (mangle >lag or trauma >lag)  and (rake_status==1) and (energy>=rake_energy) and ((mangle > ((rake_energy+mangle_switch*mangle_energy-10-energy)/10)) or cp>=FeralbyNightdb.energypooling) and (FeralbyNight.time_to_die>=9 or FeralbyNightdb.killmode==false) ) then
			return FeralbyNight.L["Rake"]
		
				elseif ((energy>=mangle_energy) and cp<5 and ((shred_status==0) or (shred_energy>49)) and ((((tf<((shred_energy+rake_energy-10-energy)/10) and (((( rake > ((mangle_energy+rake_energy-10-koj_m1-energy)/10))) and cp<3 and (mangle >lag+GCD or trauma >lag+GCD) and ((((rake>lag) or (FeralbyNight.time_to_die<9 and FeralbyNightdb.killmode==true))) or rake_status==0) ) or sr<(GCD+lag))) or (((((rake > ((mangle_energy+rake_energy-10-energy)/10))) and cp<3 and ((rake>lag) or (FeralbyNight.time_to_die<9 and FeralbyNightdb.killmode==true)) ) or sr<(GCD+lag)))) or cp>=FeralbyNightdb.energypooling) or (FeralbyNight.time_to_die<4))) then
			return FeralbyNight.L["Mangle (Cat)"]

				elseif (((energy>=shred_energy) and cp<5 and (shred_status==1) and ((((tf<((shred_energy+rake_energy-10-energy)/10) and ((mangle > ((shred_energy+mangle_switch*mangle_energy-10-koj_m1-energy)/10) and ((rake > ((shred_energy+rake_energy-10-koj_m1-energy)/10)) or rake_status==0) and cp<3 and (mangle >lag+GCD or trauma >lag+GCD) and ((rake>lag) or (FeralbyNight.time_to_die<9 and FeralbyNightdb.killmode==true)) ) or sr<(GCD+lag))) or (((mangle > ((shred_energy+mangle_switch*mangle_energy-10-energy)/10) and ((rake > ((shred_energy+rake_energy-10-energy)/10)) or rake_status==0) and cp<3 and (mangle >lag+GCD or trauma >lag+GCD) and ((((rake>lag) or (FeralbyNight.time_to_die<9 and FeralbyNightdb.killmode==true))) or rake_status==0) ) or sr<(GCD+lag)))) or cp>=FeralbyNightdb.energypooling) or ((FeralbyNight.time_to_die<4) and FeralbyNightdb.killmode==true)))) then
			return FeralbyNight.L["Shred"]
		
	elseif (((sr>lag) and (energy>=fb_energy or ooc > 0) and (cp==5)) and (((berserk<=(165-FeralbyNight.berserkplyph)) and (((((rip+sr)>(ripvsfb_time+srvsfb_time)) or ((tf<ripvsfb_time) and ((rip+sr)>(ripvsfb_time_koj+srvsfb_time))) or ((tf<srvsfb_time) and ((rip+sr)>(srvsfb_time_koj+ripvsfb_time)))) and ((rip>ripvsfb_time) or ((tf<ripvsfb_time) and (rip>ripvsfb_time_koj))) and ((sr>srvsfb_time) or ((tf<srvsfb_time) and (sr>srvsfb_time_koj)))) or  ((FeralbyNight.time_to_die<(max_rip_downtime+2)) and FeralbyNightdb.killmode==true))) or (((berserk>(165-FeralbyNight.berserkplyph) and energy<(fb_energy+5))) and (((((rip+sr)>(ripvsfb_time*1.8+srvsfb_time*1.8)) or ((tf<ripvsfb_time) and ((rip+sr)>(ripvsfb_time_koj*1.5+srvsfb_time*1.8))) or ((tf<srvsfb_time) and ((rip+sr)>(srvsfb_time_koj*1.5+ripvsfb_time*1.8)))) and ((rip>ripvsfb_time*1.8) or ((tf<ripvsfb_time) and (rip>ripvsfb_time_koj*1.5))) and ((sr>srvsfb_time*1.8) or ((tf<srvsfb_time) and (sr>srvsfb_time_koj*1.5)))) or  ((FeralbyNight.time_to_die<(max_rip_downtime+2)) and FeralbyNightdb.killmode==true))))) then
			return FeralbyNight.L["Ferocious Bite"]
	

		elseif ((sr>lag) and (energy>=rip_energy or ooc > 0) and (cp==5) and ((rip<=lag)) and ((FeralbyNight.time_to_die>(max_rip_downtime+2)) or FeralbyNightdb.killmode==false)) then
			return FeralbyNight.L["Rip"]
		
		
		elseif ((((energy >=(rake_energy+rip_energy-10)) or ((energy>=(fb_energy+5))  and berserk>(165-FeralbyNight.berserkplyph))) and (rip>=GCD+lag) and cp==5)) then
			if ((mangle <=lag and trauma <=lag) and (rip>=GCD) and (bleeds>0 or FeralbyNightdb.manglepriority==2)) then
				return FeralbyNight.L["Mangle (Cat)"]
			elseif ((rake <=lag) and (rip>=GCD) and (rake_status==1) and ((FeralbyNight.time_to_die>=9) or FeralbyNightdb.killmode==false)) then
				return FeralbyNight.L["Rake"]
			
		elseif(((energy>=90)  or ((energy>=shred_energy)  and berserk>(165-FeralbyNight.berserkplyph))) and ((shred_status==0) or (shred_energy>49)) and (mangle>=GCD or trauma >=GCD) and (rake>=GCD) and (rip>=GCD) and cp==5) then
			return FeralbyNight.L["Mangle (Cat)"]

		elseif(((energy>=90)  or ((energy>=shred_energy)  and berserk>(165-FeralbyNight.berserkplyph))) and (shred_status==1) and (mangle>=GCD or trauma >=GCD) and ((rake>=GCD) or rake_status==0) and (rip>=GCD) and cp==5) then
			return FeralbyNight.L["Shred"]
			
			end

		elseif ((FeralbyNightdb.FFF == true) and (fff <=lag) and (fffdur < 7)) then
			return FeralbyNight.L["Faerie Fire (Feral)(Rank 6)"]
		end

else

  	 if(((FeralbyNightdb.suggestinterrupt==true and durat>FeralbyNightdb.mincasttime) or (FeralbyNightdb.bossmode==true and ((castname==FeralbyNight.bosscast["Razor-Watcher-Chain 1"] and FeralbyNightdb.interrupt.razorchain==true) or (castname==FeralbyNight.bosscast["Razor-Watcher-Chain 2"] and FeralbyNightdb.interrupt.razorchain==true) or (castname==FeralbyNight.bosscast["Stormcaller - Council - Chain Lightning"] and FeralbyNightdb.interrupt.stormchain==true) or (castname==FeralbyNight.bosscast["Stormcaller - Council - Lightning Whirl"] and FeralbyNightdb.interrupt.stormwhirl==true) or (castname==FeralbyNight.bosscast["Auriaya - Sentinel Blast"] and FeralbyNightdb.interrupt.sentinelblast==true) or (castname==FeralbyNight.bosscast["Thorim - Acolyte - Greater Heal"] and FeralbyNightdb.interrupt.thorimGL==true) or (castname==FeralbyNight.bosscast["Thorim - Evoker - Runic Mending"] and FeralbyNightdb.interrupt.thorimRM==true) or (castname==FeralbyNight.bosscast["Vezax - Searing Flame"] and FeralbyNightdb.interrupt.searingflame==true) or (castname==FeralbyNight.bosscast["Yogg - Dark volley"] and FeralbyNightdb.interrupt.darkvolley==true)  or (castname==FeralbyNight.bosscast["Yogg - Drain Life"] and FeralbyNightdb.interrupt.drainlife==true) or (castname==FeralbyNight.bosscast["Yogg - Drain Life"] and FeralbyNightdb.interrupt.drainlife==true)))) and finish>lag and bash<=lag and rage>=bash_rage) then
  	 return FeralbyNight.L["Bash"]
  	 
 	 elseif (status==2 and growl<=lag) then
			return FeralbyNight.L["Growl"]
						
  	 elseif (mangle_bear<=lag and rage>=mangle_bear_rage) then
			return FeralbyNight.L["Mangle (Bear)"]
	
	elseif (fff<=lag) then
			return FeralbyNight.L["Faerie Fire (Feral)(Rank 6)"]
			
	elseif ((lacerate<=7.5 or lacerate_stack<5) and rage>=lacerate_rage) then
			return FeralbyNight.L["Lacerate"]

	elseif (demoshout<=3 and rage>=demoshout_rage) then
			return FeralbyNight.L["Demoralizing Roar"]
	
	elseif (demoshout>4.5 and lacerate>7.5 and mangle_bear>1.5 and fff>1.5 and rage>=swipe_rage) then
			return FeralbyNight.L["Swipe (Bear)"]
end

end
		
		return ""
end



--Function to compute set bonuses, idols, metagems and glyphs
function FeralbyNight:hasGlyph(id)
	for i = 1, 6 do
		local _, _, glyphSpell = GetGlyphSocketInfo(i)
		if glyphSpell == id then
			return true
		end
	end
end

function FeralbyNight:MetaGems()
	FeralbyNight.crit_meta = 0
	local helm = GetInventoryItemLink("player", 1)
	if helm then
		for i = 1, 3 do
			local mgem = tonumber(string.match(select(2, GetItemGem(helm, i)) or "",".-item:(%d+).*"))
			if mgem == 34220 or mgem == 41285 or mgem == 32409 or mgem == 41398 then
						 FeralbyNight.crit_meta = 0.03
				end
			end
		end
	end

	
function FeralbyNight:EquipBonuses()

FeralbyNight:MetaGems()
	
	 idol_ws=0;
	 idol_shred=0;
	 idol_cryingmoon=0;
	 twoT8_rate=0;
	 twoT9=0;
	 fourT9=0;
	 twoT10=0;
	 fourT10=0;
	 
local dummyboy = 0;

dummyboy=FeralbyNight:hasGlyph(62969)
if dummyboy == true then FeralbyNight.berserkplyph = 5 else FeralbyNight.berserkplyph = 0 end

dummyboy=FeralbyNight:hasGlyph(54813)
if dummyboy == true then FeralbyNight.mangleglyph = 1.1 else FeralbyNight.mangleglyph = 0 end

dummyboy=FeralbyNight:hasGlyph(54815)
if dummyboy == true then FeralbyNight.shredglyph = 1 else FeralbyNight.shredglyph = 0 end

dummyboy=FeralbyNight:hasGlyph(54818)
if dummyboy == true then FeralbyNight.ripglyph = 4 else FeralbyNight.ripglyph = 0 end

dummyboy=FeralbyNight:hasGlyph(63055)
if dummyboy == true then FeralbyNight.srglyph = 0.03 else FeralbyNight.srglyph = 0 end


	isEquipped = IsEquippedItem(40713)
	if isEquipped==1 then
	idol_shred=1
	else
	idol_shred=0
	end	
	
	isEquipped = IsEquippedItem(39757)
	if isEquipped==1 then
	idol_ws=1
	else
	idol_ws=0
	end	
	
	isEquipped = IsEquippedItem(50456)
	if isEquipped==1 then
	idol_cryingmoon=1
	else
	idol_cryingmoon=0
	end	
	
	add=0
	Tier8=0
	add = IsEquippedItem(45359)
	if add==1 then Tier8=Tier8+1 end
	add = IsEquippedItem(46159)
	if add==1 then Tier8=Tier8+1 end
	add = IsEquippedItem(45357)
	if add==1 then Tier8=Tier8+1 end
	add = IsEquippedItem(46161)
	if add==1 then Tier8=Tier8+1 end
	add = IsEquippedItem(46158)
	if add==1 then Tier8=Tier8+1 end
	add = IsEquippedItem(46157)
	if add==1 then Tier8=Tier8+1 end
	add = IsEquippedItem(45358)
	if add==1 then Tier8=Tier8+1 end
	add = IsEquippedItem(46160)
	if add==1 then Tier8=Tier8+1 end
	add = IsEquippedItem(45356)
	if add==1 then Tier8=Tier8+1 end
	add = IsEquippedItem(45355)
	if add==1 then Tier8=Tier8+1 end


	add=0
	Tier9=0
	add = IsEquippedItem(48213)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48214)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48215)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48216)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48217)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48188)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48189)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48190)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48191)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48192)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48203)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48204)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48205)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48206)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48207)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48208)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48209)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48210)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48211)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48212)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48199)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48198)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48200)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48201)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48202)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48193)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48194)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48195)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48196)
	if add==1 then Tier9=Tier9+1 end
	add = IsEquippedItem(48197)
	if add==1 then Tier9=Tier9+1 end

	add=0
	Tier10=0
	add = IsEquippedItem(50824)
	if add==1 then Tier10=Tier10+1 end
	add = IsEquippedItem(50825)
	if add==1 then Tier10=Tier10+1 end
	add = IsEquippedItem(50826)
	if add==1 then Tier10=Tier10+1 end
	add = IsEquippedItem(50827)
	if add==1 then Tier10=Tier10+1 end
	add = IsEquippedItem(50828)
	if add==1 then Tier10=Tier10+1 end
	add = IsEquippedItem(51295)
	if add==1 then Tier10=Tier10+1 end
	add = IsEquippedItem(51296)
	if add==1 then Tier10=Tier10+1 end
	add = IsEquippedItem(51297)
	if add==1 then Tier10=Tier10+1 end
	add = IsEquippedItem(51298)
	if add==1 then Tier10=Tier10+1 end
	add = IsEquippedItem(51299)
	if add==1 then Tier10=Tier10+1 end
	add = IsEquippedItem(51140)
	if add==1 then Tier10=Tier10+1 end
	add = IsEquippedItem(51141)
	if add==1 then Tier10=Tier10+1 end
	add = IsEquippedItem(51142)
	if add==1 then Tier10=Tier10+1 end
	add = IsEquippedItem(51143)
	if add==1 then Tier10=Tier10+1 end
	add = IsEquippedItem(51144)
	if add==1 then Tier10=Tier10+1 end

	if Tier8>=2 then
	twoT8_rate=0.02
	else
	twoT8_rate=0
	end	



	if Tier9>=2 then
	twoT9=1
	else
	twoT9=0
	end
	
	if Tier9>=4 then
	fourT9=1
	else
	fourT9=0
	end

	if Tier10>=2 then
	twoT10=1
	else
	twoT10=0
	end
	
	if Tier10>=4 then
	fourT10=1
	else
	fourT10=0
	end

end	
	


-- Options panel

function FeralbyNight:GetLocked()
  return FeralbyNightdb.locked
end

function FeralbyNight:ToggleLocked()
  if FeralbyNightdb.locked then
    FeralbyNightdb.locked = false
    FeralbyNight.displayFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.displayFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.displayFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.displayFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.displayFrame:EnableMouse(true)
    FeralbyNight.cdmonFrame1:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.cdmonFrame1:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.cdmonFrame1:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.cdmonFrame1:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.cdmonFrame1:EnableMouse(true)
    FeralbyNight.cdmonFrame2:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.cdmonFrame2:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.cdmonFrame2:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.cdmonFrame2:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.cdmonFrame2:EnableMouse(true)
    FeralbyNight.cdmonFrame3:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.cdmonFrame3:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.cdmonFrame3:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.cdmonFrame3:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.cdmonFrame3:EnableMouse(true)
    FeralbyNight.bossfightFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.bossfightFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.bossfightFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.bossfightFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.bossfightFrame:EnableMouse(true)
    FeralbyNight.myfightFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.myfightFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.myfightFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.myfightFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.myfightFrame:EnableMouse(true)
    FeralbyNight.procFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.procFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.procFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.procFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.procFrame:EnableMouse(true)
	FeralbyNight.hudFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.hudFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.hudFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.hudFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.hudFrame:EnableMouse(true)
	FeralbyNight.MeleeFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.MeleeFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.MeleeFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.MeleeFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.MeleeFrame:EnableMouse(true)
		FeralbyNight.CPFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.CPFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.CPFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.CPFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.CPFrame:EnableMouse(true)
		FeralbyNight.timetokillFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.timetokillFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.timetokillFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.timetokillFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.timetokillFrame:EnableMouse(true)
		FeralbyNight.energyFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.energyFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.energyFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.energyFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.energyFrame:EnableMouse(true)
		FeralbyNight.oocFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.oocFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.oocFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.oocFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.oocFrame:EnableMouse(true)
		FeralbyNight.noticeFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.noticeFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.noticeFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.noticeFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.noticeFrame:EnableMouse(true)
		FeralbyNight.srFrame:SetScript("OnMouseDown", function(self) self:StartMoving() end)
    FeralbyNight.srFrame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.srFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    FeralbyNight.srFrame:SetBackdropColor(0, 0, 0, .4)
	FeralbyNight.srFrame:EnableMouse(true)
  else
    FeralbyNightdb.locked = true
    FeralbyNight.displayFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.displayFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.displayFrame:SetScript("OnDragStop", nil)
    FeralbyNight.displayFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.displayFrame:EnableMouse(false)
    FeralbyNight.cdmonFrame1:SetScript("OnMouseDown", nil)
    FeralbyNight.cdmonFrame1:SetScript("OnMouseUp", nil)
    FeralbyNight.cdmonFrame1:SetScript("OnDragStop", nil)
    FeralbyNight.cdmonFrame1:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.cdmonFrame1:EnableMouse(false)
    FeralbyNight.cdmonFrame2:SetScript("OnMouseDown", nil)
    FeralbyNight.cdmonFrame2:SetScript("OnMouseUp", nil)
    FeralbyNight.cdmonFrame2:SetScript("OnDragStop", nil)
    FeralbyNight.cdmonFrame2:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.cdmonFrame2:EnableMouse(false)
    FeralbyNight.cdmonFrame3:SetScript("OnMouseDown", nil)
    FeralbyNight.cdmonFrame3:SetScript("OnMouseUp", nil)
    FeralbyNight.cdmonFrame3:SetScript("OnDragStop", nil)
    FeralbyNight.cdmonFrame3:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.cdmonFrame3:EnableMouse(false)
    FeralbyNight.bossfightFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.bossfightFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.bossfightFrame:SetScript("OnDragStop", nil)
    FeralbyNight.bossfightFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.bossfightFrame:EnableMouse(false)
    FeralbyNight.myfightFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.myfightFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.myfightFrame:SetScript("OnDragStop", nil)
    FeralbyNight.myfightFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.myfightFrame:EnableMouse(false)
    FeralbyNight.procFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.procFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.procFrame:SetScript("OnDragStop", nil)
    FeralbyNight.procFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.procFrame:EnableMouse(false)
	FeralbyNight.hudFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.hudFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.hudFrame:SetScript("OnDragStop", nil)
    FeralbyNight.hudFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.hudFrame:EnableMouse(false)
	FeralbyNight.MeleeFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.MeleeFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.MeleeFrame:SetScript("OnDragStop", nil)
    FeralbyNight.MeleeFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.MeleeFrame:EnableMouse(false)
		FeralbyNight.CPFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.CPFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.CPFrame:SetScript("OnDragStop", nil)
    FeralbyNight.CPFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.CPFrame:EnableMouse(false)
		FeralbyNight.timetokillFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.timetokillFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.timetokillFrame:SetScript("OnDragStop", nil)
    FeralbyNight.timetokillFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.timetokillFrame:EnableMouse(false)
		FeralbyNight.energyFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.energyFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.energyFrame:SetScript("OnDragStop", nil)
    FeralbyNight.energyFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.energyFrame:EnableMouse(false)
		FeralbyNight.oocFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.oocFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.oocFrame:SetScript("OnDragStop", nil)
    FeralbyNight.oocFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.oocFrame:EnableMouse(false)
		FeralbyNight.noticeFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.noticeFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.noticeFrame:SetScript("OnDragStop", nil)
    FeralbyNight.noticeFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.noticeFrame:EnableMouse(false)
		FeralbyNight.srFrame:SetScript("OnMouseDown", nil)
    FeralbyNight.srFrame:SetScript("OnMouseUp", nil)
    FeralbyNight.srFrame:SetScript("OnDragStop", nil)
    FeralbyNight.srFrame:SetBackdropColor(0, 0, 0, 0)
	FeralbyNight.srFrame:EnableMouse(false)
  end
end

function FeralbyNight:GetScale()
  return FeralbyNightdb.scale
end
function FeralbyNight:GetcdmonScale1()
  return FeralbyNightdb.cdmonscale1
end
function FeralbyNight:GetcdmonScale2()
  return FeralbyNightdb.cdmonscale2
end
function FeralbyNight:GetcdmonScale3()
  return FeralbyNightdb.cdmonscale3
end
function FeralbyNight:GetbossfightScale()
  return FeralbyNightdb.bossfightscale
end
function FeralbyNight:GetmyfightScale()
  return FeralbyNightdb.myfightscale
end
function FeralbyNight:GetprocScale()
  return FeralbyNightdb.procscale
end
function FeralbyNight:GetMeleeScale()
  return FeralbyNightdb.meleescale
end
function FeralbyNight:GetCPScale()
  return FeralbyNightdb.CPscale
end
function FeralbyNight:GettimetokillScale()
  return FeralbyNightdb.timetokillscale
end
function FeralbyNight:GetenergyScale()
  return FeralbyNightdb.energyscale
end
function FeralbyNight:GethudScale()
  return FeralbyNightdb.hudscale
end
function FeralbyNight:GetoocScale()
  return FeralbyNightdb.oocscale
end
function FeralbyNight:GetnoticeScale()
  return FeralbyNightdb.noticescale
end
function FeralbyNight:GetprocScale()
  return FeralbyNightdb.procscale
end
function FeralbyNight:GetsrScale()
  return FeralbyNightdb.srscale
end
function FeralbyNight:Getupdateinterval()
  return FeralbyNightdb.updateinterval
end


function FeralbyNight:GetsrFont()
local ik
for ik=1,20 do
if (FeralbyNight.fontvector[ik]==FeralbyNightdb.srFramefont) then
  return ik
else
 return 1
 end
 end
end


function FeralbyNight:SetsrFont(num)
FeralbyNightdb.srFramefont = FeralbyNight.fontvector[num]
FeralbyNight.srFrame:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.srFramefont, FeralbyNightdb.srFramefontsize);
end



function FeralbyNight:GetMeleeFont()
local ik
for ik=1,20 do
if (FeralbyNight.fontvector[ik]==FeralbyNightdb.MeleeFramefont) then
  return ik
else
 return 1
 end
 end
end

function FeralbyNight:SetMeleeFont(num)
FeralbyNightdb.MeleeFramefont = FeralbyNight.fontvector[num]
FeralbyNight.MeleeFrame:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.MeleeFramefont, FeralbyNightdb.MeleeFramefontsize);
end



function FeralbyNight:GetenergyFont()
local ik
for ik=1,20 do
if (FeralbyNight.fontvector[ik]==FeralbyNightdb.energyFramefont) then
  return ik
else
 return 1
 end
 end
end

function FeralbyNight:SetenergyFont(num)
FeralbyNightdb.energyFramefont = FeralbyNight.fontvector[num]
FeralbyNight.energyFrame:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.energyFramefont, FeralbyNightdb.energyFramefontsize);
end




function FeralbyNight:GettimetokillFont()
local ik
for ik=1,20 do
if (FeralbyNight.fontvector[ik]==FeralbyNightdb.timetokillFramefont) then
  return ik
else
 return 1
 end
 end
end

function FeralbyNight:SettimetokillFont(num)
FeralbyNightdb.timetokillFramefont = FeralbyNight.fontvector[num]
FeralbyNight.timetokillFrame:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.timetokillFramefont, FeralbyNightdb.timetokillFramefontsize);
end





function FeralbyNight:GetcpFont()
local ik
for ik=1,20 do
if (FeralbyNight.fontvector[ik]==FeralbyNightdb.cpFramefont) then
  return ik
else
 return 1
 end
 end
end

function FeralbyNight:SetcpFont(num)
FeralbyNightdb.cpFramefont = FeralbyNight.fontvector[num]
FeralbyNight.CPFrame:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cpFramefont, FeralbyNightdb.cpFramefontsize);
end



function FeralbyNight:GetbossfightFont()
local ik
for ik=1,20 do
if (FeralbyNight.fontvector[ik]==FeralbyNightdb.bossfightFramefont) then
  return ik
else
 return 1
 end
 end
end

function FeralbyNight:SetbossfightFont(num)
FeralbyNightdb.bossfightFramefont = FeralbyNight.fontvector[num]
  do jj=1,5
  local bossfightFramedumb = _G["FeralbyNightbossfightFrame_"..jj];
  bossfightFramedumb:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.bossfightFramefont, FeralbyNightdb.bossfightFramefontsize);
  end
end


function FeralbyNight:GetmyfightFont()
local ik
for ik=1,20 do
if (FeralbyNight.fontvector[ik]==FeralbyNightdb.myfightFramefont) then
  return ik
else
 return 1
 end
 end
end

function FeralbyNight:SetmyfightFont(num)
FeralbyNightdb.myfightFramefont = FeralbyNight.fontvector[num]
  do jj=1,5
  local myfightFramedumb = _G["FeralbyNightmyfightFrame_"..jj];
  myfightFramedumb:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.myfightFramefont, FeralbyNightdb.myfightFramefontsize);
  end
end


function FeralbyNight:GetprocFont()
local ik
for ik=1,20 do
if (FeralbyNight.fontvector[ik]==FeralbyNightdb.procFramefont) then
  return ik
else
 return 1
 end
 end
end

function FeralbyNight:SetprocFont(num)
FeralbyNightdb.procFramefont = FeralbyNight.fontvector[num]
  do jj=1,5
  local procFramedumb = _G["FeralbyNightprocFrame_"..jj];
  procFramedumb:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.procFramefont, FeralbyNightdb.procFramefontsize);
  end
end



function FeralbyNight:GetbarFont()
local ik
for ik=1,20 do
if (FeralbyNight.fontvector[ik]==FeralbyNightdb.barfont) then
  return ik
else
 return 1
 end
 end
end


function FeralbyNight:Getbartexture()
local ik
for ik=1,62 do
if (FeralbyNight.texturevector[ik]==FeralbyNightdb.bartexture) then
  return ik
else
 return 1
 end
 end
end

function FeralbyNight:SetbarFont(num)
FeralbyNightdb.barfont = FeralbyNight.fontvector[num]
FeralbyNight.hudFrame_manabar.text:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize);
FeralbyNight.hudFrame_threatbar.text:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize);
FeralbyNight.hudFrame_castbar.text:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize);
FeralbyNight.hudFrame_bosspowerbar.text:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize);
FeralbyNight.hudFrame_healthbar.text:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize);
FeralbyNight.hudFrame_bosshealthbar.text:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize);
FeralbyNight.hudFrame_powerbar.text:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize);
end

function FeralbyNight:Setbartexture(num)
FeralbyNightdb.bartexture = FeralbyNight.texturevector[num]
FeralbyNight.hudFrame_manabar_frame:SetStatusBarTexture("Interface\\AddOns\\FeralbyNight\\arts\\statusbar\\"..FeralbyNightdb.bartexture);
FeralbyNight.hudFrame_castbar_frame:SetStatusBarTexture("Interface\\AddOns\\FeralbyNight\\arts\\statusbar\\"..FeralbyNightdb.bartexture);
FeralbyNight.hudFrame_threatbar_frame:SetStatusBarTexture("Interface\\AddOns\\FeralbyNight\\arts\\statusbar\\"..FeralbyNightdb.bartexture);
FeralbyNight.hudFrame_bosspowerbar_frame:SetStatusBarTexture("Interface\\AddOns\\FeralbyNight\\arts\\statusbar\\"..FeralbyNightdb.bartexture);
FeralbyNight.hudFrame_healthbar_frame:SetStatusBarTexture("Interface\\AddOns\\FeralbyNight\\arts\\statusbar\\"..FeralbyNightdb.bartexture);
FeralbyNight.hudFrame_bosshealthbar_frame:SetStatusBarTexture("Interface\\AddOns\\FeralbyNight\\arts\\statusbar\\"..FeralbyNightdb.bartexture);
FeralbyNight.hudFrame_powerbar_frame:SetStatusBarTexture("Interface\\AddOns\\FeralbyNight\\arts\\statusbar\\"..FeralbyNightdb.bartexture);
end



function FeralbyNight:GetcdmonFont1()
local ik
for ik=1,20 do
if (FeralbyNight.fontvector[ik]==FeralbyNightdb.cdmonFramefont1) then
  return ik
else
 return 1
 end
 end
end

function FeralbyNight:SetcdmonFont1(num)
FeralbyNightdb.cdmonFramefont1 = FeralbyNight.fontvector[num]
FeralbyNightcdmonFrame1_1:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont1, FeralbyNightdb.cdmonFramefontsize1);
FeralbyNightcdmonFrame1_2:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont1, FeralbyNightdb.cdmonFramefontsize1);
FeralbyNightcdmonFrame1_3:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont1, FeralbyNightdb.cdmonFramefontsize1);
FeralbyNightcdmonFrame1_4:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont1, FeralbyNightdb.cdmonFramefontsize1);
FeralbyNightcdmonFrame1_5:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont1, FeralbyNightdb.cdmonFramefontsize1);
  end


function FeralbyNight:GetcdmonFont2()
local ik
for ik=1,20 do
if (FeralbyNight.fontvector[ik]==FeralbyNightdb.cdmonFramefont2) then
  return ik
else
 return 1
 end
 end
end

function FeralbyNight:SetcdmonFont2(num)
FeralbyNightdb.cdmonFramefont2 = FeralbyNight.fontvector[num]
FeralbyNightcdmonFrame2_1:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont2, FeralbyNightdb.cdmonFramefontsize2);
FeralbyNightcdmonFrame2_2:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont2, FeralbyNightdb.cdmonFramefontsize2);
FeralbyNightcdmonFrame2_3:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont2, FeralbyNightdb.cdmonFramefontsize2);
FeralbyNightcdmonFrame2_4:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont2, FeralbyNightdb.cdmonFramefontsize2);
FeralbyNightcdmonFrame2_5:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont2, FeralbyNightdb.cdmonFramefontsize2);
  end



function FeralbyNight:GetcdmonFont3()
local ik
for ik=1,20 do
if (FeralbyNight.fontvector[ik]==FeralbyNightdb.cdmonFramefont3) then
  return ik
else
 return 1
 end
 end
end

function FeralbyNight:SetcdmonFont3(num)
FeralbyNightdb.cdmonFramefont3 = FeralbyNight.fontvector[num]
FeralbyNightcdmonFrame3_1:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont3, FeralbyNightdb.cdmonFramefontsize3);
FeralbyNightcdmonFrame3_2:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont3, FeralbyNightdb.cdmonFramefontsize3);
FeralbyNightcdmonFrame3_3:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont3, FeralbyNightdb.cdmonFramefontsize3);
FeralbyNightcdmonFrame3_4:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont3, FeralbyNightdb.cdmonFramefontsize3);
FeralbyNightcdmonFrame3_5:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont3, FeralbyNightdb.cdmonFramefontsize3);
  end


function FeralbyNight:SetScale(num)
  FeralbyNightdb.scale = num
  FeralbyNight.displayFrame:SetScale(FeralbyNightdb.scale)
  FeralbyNight.cooldownFrame:SetScale(FeralbyNightdb.scale)
end
function FeralbyNight:SetMeleeScale(num)
  FeralbyNightdb.meleescale = num
  FeralbyNight.MeleeFrame:SetScale(FeralbyNightdb.meleescale)
end
function FeralbyNight:SetsrScale(num)
  FeralbyNightdb.srscale = num
  FeralbyNight.srFrame:SetScale(FeralbyNightdb.srscale)
end
function FeralbyNight:SetcdmonScale1(num)
  FeralbyNightdb.cdmonscale1 = num
  FeralbyNight.cdmonFrame1:SetScale(FeralbyNightdb.cdmonscale1)
end
function FeralbyNight:SetcdmonScale3(num)
  FeralbyNightdb.cdmonscale3 = num
  FeralbyNight.cdmonFrame3:SetScale(FeralbyNightdb.cdmonscale3)
end
function FeralbyNight:SetcdmonScale2(num)
  FeralbyNightdb.cdmonscale2 = num
  FeralbyNight.cdmonFrame2:SetScale(FeralbyNightdb.cdmonscale2)
end
function FeralbyNight:SetbossfightScale(num)
  FeralbyNightdb.bossfightscale = num
  FeralbyNight.bossfightFrame:SetScale(FeralbyNightdb.bossfightscale)
end
function FeralbyNight:SetmyfightScale(num)
  FeralbyNightdb.myfightscale = num
  FeralbyNight.myfightFrame:SetScale(FeralbyNightdb.myfightscale)
end

function FeralbyNight:SetprocScale(num)
  FeralbyNightdb.procscale = num
  FeralbyNight.procFrame:SetScale(FeralbyNightdb.procscale)
end

function FeralbyNight:Setupdateinterval(num)
  FeralbyNightdb.updateinterval = num
end
function FeralbyNight:SethudScale(num)
  FeralbyNightdb.hudscale = num
  FeralbyNight.hudFrame:SetScale(FeralbyNightdb.hudscale)
end
function FeralbyNight:SetCPScale(num)
  FeralbyNightdb.CPscale = num
  FeralbyNight.CPFrame:SetScale(FeralbyNightdb.CPscale)
end
function FeralbyNight:SettimetokillScale(num)
  FeralbyNightdb.timetokillscale = num
  FeralbyNight.timetokillFrame:SetScale(FeralbyNightdb.timetokillscale)
end
function FeralbyNight:SetenergyScale(num)
  FeralbyNightdb.energyscale = num
  FeralbyNight.energyFrame:SetScale(FeralbyNightdb.energyscale)
end
function FeralbyNight:SetoocScale(num)
  FeralbyNightdb.oocscale = num
  FeralbyNight.oocFrame:SetScale(FeralbyNightdb.oocscale)
end
function FeralbyNight:SetnoticeScale(num)
  FeralbyNightdb.noticescale = num
  FeralbyNight.noticeFrame:SetScale(FeralbyNightdb.noticescale)
end

function FeralbyNight:SetprocScale(num)
  FeralbyNightdb.procscale = num
  FeralbyNight.procFrame:SetScale(FeralbyNightdb.procscale)
end

function FeralbyNight:GetShowPrediction()
  return FeralbyNightdb.showPrediction
end

function FeralbyNight:ToggleShowPrediction()
  if FeralbyNightdb.showPrediction then
    FeralbyNightdb.showPrediction = false
  else
    FeralbyNightdb.showPrediction = true
  end
end

function FeralbyNight:Getoocoverride()
  return FeralbyNightdb.oocoverride
end

function FeralbyNight:Toggleoocoverride()
  if FeralbyNightdb.oocoverride then
    FeralbyNightdb.oocoverride = false
  else
    FeralbyNightdb.oocoverride = true
  end
end


function FeralbyNight:Getbossmode()
  return FeralbyNightdb.bossmode
end

function FeralbyNight:Togglebossmode()
  if FeralbyNightdb.bossmode then
    FeralbyNightdb.bossmode = false
  else
    FeralbyNightdb.bossmode= true
  end
end

function FeralbyNight:Getactivespec1()
  return FeralbyNightdb.spec1
end

function FeralbyNight:Toggleactivespec1()
  if FeralbyNightdb.spec1 then
    FeralbyNightdb.spec1 = false
  else
    FeralbyNightdb.spec1= true
  end
end

function FeralbyNight:Getactivespec2()
  return FeralbyNightdb.spec2
end

function FeralbyNight:Toggleactivespec2()
  if FeralbyNightdb.spec2 then
    FeralbyNightdb.spec2 = false
  else
    FeralbyNightdb.spec2= true
  end
end

function FeralbyNight:Getkillmode()
  return FeralbyNightdb.killmode
end

function FeralbyNight:Togglekillmode()
  if FeralbyNightdb.killmode then
    FeralbyNightdb.killmode = false
  else
    FeralbyNightdb.killmode= true
  end
end


function FeralbyNight:Gettargetidshow()
  return FeralbyNightdb.targetidshow
end

function FeralbyNight:Toggletargetidshow()
  if FeralbyNightdb.targetidshow then
    FeralbyNightdb.targetidshow = false
  else
    FeralbyNightdb.targetidshow= true
  end
end


function FeralbyNight:Getsaveforrazor()
  return FeralbyNightdb.saveforrazor
end

function FeralbyNight:Togglesaveforrazor()
  if FeralbyNightdb.saveforrazor then
    FeralbyNightdb.saveforrazor = false
  else
    FeralbyNightdb.saveforrazor= true
  end
end

function FeralbyNight:Getshredontentacles()
  return FeralbyNightdb.shredontentacles
end

function FeralbyNight:Toggleshredontentacles()
  if FeralbyNightdb.shredontentacles then
    FeralbyNightdb.shredontentacles = false
  else
    FeralbyNightdb.shredontentacles= true
  end
end

function FeralbyNight:Getsaveforheart()
  return FeralbyNightdb.saveforheart
end

function FeralbyNight:Togglesaveforheart()
  if FeralbyNightdb.saveforheart then
    FeralbyNightdb.saveforheart = false
  else
    FeralbyNightdb.saveforheart= true
  end
end

function FeralbyNight:Getdarkvolley()
  return FeralbyNightdb.interrupt.darkvolley
end

function FeralbyNight:Toggledarkvolley()
  if FeralbyNightdb.interrupt.darkvolley then
    FeralbyNightdb.interrupt.darkvolley = false
  else
    FeralbyNightdb.interrupt.darkvolley= true
  end
end

function FeralbyNight:Getdrainlife()
  return FeralbyNightdb.interrupt.drainlife
end

function FeralbyNight:Toggledrainlife()
  if FeralbyNightdb.interrupt.drainlife then
    FeralbyNightdb.interrupt.drainlife = false
  else
    FeralbyNightdb.interrupt.drainlife= true
  end
end

function FeralbyNight:Getsearingflame()
  return FeralbyNightdb.interrupt.searingflame
end

function FeralbyNight:Togglesearingflame()
  if FeralbyNightdb.interrupt.searingflame then
    FeralbyNightdb.interrupt.searingflame = false
  else
    FeralbyNightdb.interrupt.searingflame= true
  end
end


function FeralbyNight:GetthorimRM()
  return FeralbyNightdb.interrupt.thorimRM
end

function FeralbyNight:TogglethorimRM()
  if FeralbyNightdb.interrupt.thorimRM then
    FeralbyNightdb.interrupt.thorimRM = false
  else
    FeralbyNightdb.interrupt.thorimRM= true
  end
end


function FeralbyNight:GetthorimGL()
  return FeralbyNightdb.interrupt.thorimGL
end

function FeralbyNight:TogglethorimGL()
  if FeralbyNightdb.interrupt.thorimGL then
    FeralbyNightdb.interrupt.thorimGL = false
  else
    FeralbyNightdb.interrupt.thorimGL= true
  end
end


function FeralbyNight:Getstormwhirl()
  return FeralbyNightdb.interrupt.stormwhirl
end

function FeralbyNight:Togglestormwhirl()
  if FeralbyNightdb.interrupt.stormwhirl then
    FeralbyNightdb.interrupt.stormwhirl = false
  else
    FeralbyNightdb.interrupt.stormwhirl= true
  end
end


function FeralbyNight:Getsentinelblast()
  return FeralbyNightdb.interrupt.sentinelblast
end

function FeralbyNight:Togglesentinelblast()
  if FeralbyNightdb.interrupt.sentinelblast then
    FeralbyNightdb.interrupt.sentinelblast = false
  else
    FeralbyNightdb.interrupt.sentinelblast= true
  end
end

function FeralbyNight:Getstormchain()
  return FeralbyNightdb.interrupt.stormchain
end

function FeralbyNight:Togglestormchain()
  if FeralbyNightdb.interrupt.stormchain then
    FeralbyNightdb.interrupt.stormchain = false
  else
    FeralbyNightdb.interrupt.stormchain= true
  end
end

function FeralbyNight:Getrazorchain()
  return FeralbyNightdb.interrupt.razorchain
end

function FeralbyNight:Togglerazorchain()
  if FeralbyNightdb.interrupt.razorchain then
    FeralbyNightdb.interrupt.razorchain = false
  else
    FeralbyNightdb.interrupt.razorchain= true
  end
end

function FeralbyNight:Getinterrupt()
  return FeralbyNightdb.suggestinterrupt
end

function FeralbyNight:Toggleinterrupt()
  if FeralbyNightdb.suggestinterrupt then
    FeralbyNightdb.suggestinterrupt = false
  else
    FeralbyNightdb.suggestinterrupt= true
  end
end

function FeralbyNight:Getmanglebot()
  return FeralbyNightdb.manglebot
end

function FeralbyNight:Togglemanglebot()
  if FeralbyNightdb.manglebot then
    FeralbyNightdb.manglebot = false
  else
    FeralbyNightdb.manglebot = true
  end
end


function FeralbyNight:ToggleShred()
  if FeralbyNightdb.shred then
    FeralbyNightdb.shred = false
  else
    FeralbyNightdb.shred = true
  end
end

function FeralbyNight:ToggleBerserk()
  if FeralbyNightdb.Berserk then
    FeralbyNightdb.Berserk = false
  else
    FeralbyNightdb.Berserk = true
  end
end


function FeralbyNight:GetFFF()
  return FeralbyNightdb.FFF
end

function FeralbyNight:ToggleFFF()
  if FeralbyNightdb.FFF then
    FeralbyNightdb.FFF = false
  else
    FeralbyNightdb.FFF = true
  end
end

function FeralbyNight:Getlagcorrection()
  return FeralbyNightdb.lagcorrection
end

function FeralbyNight:Togglelagcorrection()
  if FeralbyNightdb.lagcorrection then
    FeralbyNightdb.lagcorrection = false
  else
    FeralbyNightdb.lagcorrection = true
  end
end

function FeralbyNight:Getconservative()
  return FeralbyNightdb.conservativeplay
end

function FeralbyNight:Toggleconservative()
  if FeralbyNightdb.conservativeplay then
    FeralbyNightdb.conservativeplay = false
  else
    FeralbyNightdb.conservativeplay = true
  end
end

function FeralbyNight:GetBerserk()
  return FeralbyNightdb.Berserk
end

function FeralbyNight:GetShred()
  return FeralbyNightdb.shred
end


function FeralbyNight:GetHud()
  return FeralbyNightdb.hud
end

function FeralbyNight:CropHud()
  if FeralbyNightdb.hud then
  FeralbyNightdb.hud = false
  else
  FeralbyNightdb.hud = true
  end
  end

function FeralbyNight:Getdummy()
  return FeralbyNightdb.showdummyvariables
end

function FeralbyNight:Toggledummy()
  if FeralbyNightdb.showdummyvariables then
  FeralbyNightdb.showdummyvariables = false
  else
  FeralbyNightdb.showdummyvariables = true
  end

end

function FeralbyNight:GetSRCP()
  return FeralbyNightdb.SRCP
end
function FeralbyNight:SetSRCP(num)
  FeralbyNightdb.SRCP = num
end

function FeralbyNight:Getshredvsrake()
  return FeralbyNightdb.shredvsrake
end
function FeralbyNight:Setshredvsrake(num)
  FeralbyNightdb.shredvsrake = num
end

function FeralbyNight:Getripvsfb()
  return FeralbyNightdb.ripvsfb
end
function FeralbyNight:Setripvsfb(num)
  FeralbyNightdb.ripvsfb = num
end

function FeralbyNight:Getsrvsfinisher()
  return FeralbyNightdb.srvsfinisher
end
function FeralbyNight:Setsrvsfinisher(num)
  FeralbyNightdb.srvsfinisher = num
end

function FeralbyNight:Getenergypooling()
  return FeralbyNightdb.energypooling
end
function FeralbyNight:Setenergypooling(num)
  FeralbyNightdb.energypooling = num
end

function FeralbyNight:Getmanglepriority()
  return FeralbyNightdb.manglepriority
end
function FeralbyNight:Setmanglepriority(num)
  FeralbyNightdb.manglepriority = num
end


function FeralbyNight:Getkillmodeupdateinterval()
  return FeralbyNightdb.killmodeupdateinterval*10
end
function FeralbyNight:Setkillmodeupdateinterval(num)
  FeralbyNightdb.killmodeupdateinterval = (num/10)
end

function FeralbyNight:Getinterruptinterval()
  return FeralbyNightdb.mincasttime
end
function FeralbyNight:Setinterruptinterval(num)
  FeralbyNightdb.mincasttime = num
end

function FeralbyNight:Gethudshow()
  return FeralbyNightdb.hudshow
end

function FeralbyNight:Togglehud()
  if FeralbyNightdb.hudshow then
    FeralbyNightdb.hudshow = false
	FeralbyNight.hudFrame:Hide()
  else
    FeralbyNightdb.hudshow = true
	FeralbyNight.hudFrame:Show()
  end
end


function FeralbyNight:Getcdmonshow1()
  return FeralbyNightdb.cdmonshow1
end

function FeralbyNight:Togglecdmon1()
  if FeralbyNightdb.cdmonshow1 then
    FeralbyNightdb.cdmonshow1 = false
    	FeralbyNight.cdmonFrame1:Hide()
  else
    FeralbyNightdb.cdmonshow1 = true
        	FeralbyNight.cdmonFrame1:Show()

  end
end


function FeralbyNight:Getcdmonshow2()
  return FeralbyNightdb.cdmonshow2
end

function FeralbyNight:Togglecdmon2()
  if FeralbyNightdb.cdmonshow2 then
    FeralbyNightdb.cdmonshow2 = false
    	FeralbyNight.cdmonFrame2:Hide()
  else
    FeralbyNightdb.cdmonshow2 = true
        	FeralbyNight.cdmonFrame2:Show()

  end
end


function FeralbyNight:Getcdmonshow3()
  return FeralbyNightdb.cdmonshow3
end

function FeralbyNight:Togglecdmon3()
  if FeralbyNightdb.cdmonshow3 then
    FeralbyNightdb.cdmonshow3 = false
    	FeralbyNight.cdmonFrame3:Hide()
  else
    FeralbyNightdb.cdmonshow3 = true
        	FeralbyNight.cdmonFrame3:Show()

  end
end



function FeralbyNight:Getbossfightshow()
  return FeralbyNightdb.bossfightshow
end

function FeralbyNight:Togglebossfight()
  if FeralbyNightdb.bossfightshow then
    FeralbyNightdb.bossfightshow = false
    	FeralbyNight.bossfightFrame:Hide()
  else
    FeralbyNightdb.bossfightshow = true
        	FeralbyNight.bossfightFrame:Show()

  end
end



function FeralbyNight:Getmyfightshow()
  return FeralbyNightdb.myfightshow
end

function FeralbyNight:Togglemyfight()
  if FeralbyNightdb.myfightshow then
    FeralbyNightdb.myfightshow = false
    	FeralbyNight.myfightFrame:Hide()
  else
    FeralbyNightdb.myfightshow = true
        	FeralbyNight.myfightFrame:Show()

  end
end

function FeralbyNight:Getprocshow()
  return FeralbyNightdb.procshow
end

function FeralbyNight:Toggleproc()
  if FeralbyNightdb.procshow then
    FeralbyNightdb.procshow = false
    	FeralbyNight.procFrame:Hide()
  else
    FeralbyNightdb.procshow = true
        	FeralbyNight.procFrame:Show()

  end
end




function FeralbyNight:Getenergyframeshow()
  return FeralbyNightdb.energyframeshow
end
function FeralbyNight:Toggleenergyframe()
  if FeralbyNightdb.energyframeshow then
    FeralbyNightdb.energyframeshow = false
  else
    FeralbyNightdb.energyframeshow = true
  end
end
function FeralbyNight:Getcpframeshow()
  return FeralbyNightdb.cpframeshow
end
function FeralbyNight:Gettimetokillframeshow()
  return FeralbyNightdb.timetokillframeshow
end
function FeralbyNight:Togglecpframe()
  if FeralbyNightdb.cpframeshow then
    FeralbyNightdb.cpframeshow = false
  else
    FeralbyNightdb.cpframeshow = true
  end
end
function FeralbyNight:Toggletimetokillframe()
  if FeralbyNightdb.timetokillframeshow then
    FeralbyNightdb.timetokillframeshow = false
  else
    FeralbyNightdb.timetokillframeshow = true
  end
end
function FeralbyNight:Getsrframeshow()
  return FeralbyNightdb.srframeshow
end
function FeralbyNight:Togglesrframe()
  if FeralbyNightdb.srframeshow then
    FeralbyNightdb.srframeshow = false
  else
    FeralbyNightdb.srframeshow = true
  end
end

function FeralbyNight:Getcastingbarshow()
  return FeralbyNightdb.showcast
end
function FeralbyNight:Togglecastingbarshow()
  if FeralbyNightdb.showcast then
    FeralbyNightdb.showcast = false
  else
    FeralbyNightdb.showcast = true
  end
end
function FeralbyNight:Getstatsframeshow()
  return FeralbyNightdb.statsframeshow
end
function FeralbyNight:Togglestatsframe()
  if FeralbyNightdb.statsframeshow then
    FeralbyNightdb.statsframeshow = false
  else
    FeralbyNightdb.statsframeshow = true
  end
end
function FeralbyNight:Getsuggesterframeshow()
  return FeralbyNightdb.suggesterframeshow
end
function FeralbyNight:Togglesuggesterframe()
  if FeralbyNightdb.suggesterframeshow then
    FeralbyNightdb.suggesterframeshow = false
  else
    FeralbyNightdb.suggesterframeshow = true
  end
end
function FeralbyNight:Getoocframeshow()
  return FeralbyNightdb.oocframeshow
end
function FeralbyNight:Toggleoocframe()
  if FeralbyNightdb.oocframeshow then
    FeralbyNightdb.oocframeshow = false
  else
    FeralbyNightdb.oocframeshow = true
  end
end
function FeralbyNight:Getnoticeframeshow()
  return FeralbyNightdb.noticeframeshow
end
function FeralbyNight:Togglenoticeframe()
  if FeralbyNightdb.noticeframeshow then
    FeralbyNightdb.noticeframeshow = false
  else
    FeralbyNightdb.noticeframeshow = true
  end
end

function FeralbyNight:CreateOptionFrame()
  local panel = CreateFrame("FRAME", "FeralbyNightOptions");
  panel.name = "Feral by Night";
    local panel2 = CreateFrame("FRAME", "$parent_2",FeralbyNightOptions);
  panel2.name = "Show Options a";
    panel2.parent="Feral by Night";
    local panel21 = CreateFrame("FRAME", "$parent_21",FeralbyNightOptions);
  panel21.name = "Show Options b";
   panel21.parent="Feral by Night";
   local panel3 = CreateFrame("FRAME", "$parent_3",FeralbyNightOptions);
  panel3.name = "Scale Options";
   panel3.parent="Feral by Night";
    local panel4 = CreateFrame("FRAME", "$parent_4",FeralbyNightOptions);
  panel4.name = "Fonts Options a";
   panel4.parent="Feral by Night";
     local panel41 = CreateFrame("FRAME", "$parent_41",FeralbyNightOptions);
  panel41.name = "Fonts Options b";
   panel41.parent="Feral by Night";
   
  --Main Panel
  local fstring1 = panel:CreateFontString("FeralbyNightOptions_string1","OVERLAY","GameFontNormal")
  fstring1:SetText("Lock")
  fstring1:SetPoint("TOPLEFT", 10, -10)
  local checkbox1 = CreateFrame("CheckButton", "$parent_cb1", panel, "OptionsCheckButtonTemplate")
  checkbox1:SetWidth(18)
  checkbox1:SetHeight(18)
  checkbox1:SetScript("OnClick", function() FeralbyNight:ToggleLocked() end)
  checkbox1:SetPoint("TOPRIGHT", -10, -10)
  checkbox1:SetChecked(FeralbyNight:GetLocked())
  
  local fstring13 = panel:CreateFontString("FeralbyNightOptions_string13","OVERLAY","GameFontNormal")
  fstring13:SetText("Crop Hud")
  fstring13:SetPoint("TOPLEFT", 10, -40)
  local checkbox6 = CreateFrame("CheckButton", "$parent_cb6", panel, "OptionsCheckButtonTemplate")
  checkbox6:SetWidth(18)
  checkbox6:SetHeight(18)
  checkbox6:SetScript("OnClick", function() FeralbyNight:CropHud() end)
  checkbox6:SetPoint("TOPRIGHT", -10, -40)
  checkbox6:SetChecked(FeralbyNight:GetHud())
  
   local fstring14 = panel:CreateFontString("FeralbyNightOptions_string14","OVERLAY","GameFontNormal")
  fstring14:SetText("Abilities & Timers update interval")
  fstring14:SetPoint("TOPLEFT", 10, -70)
  local slider11 = CreateFrame("Slider", "$parent_sl11", panel, "OptionsSliderTemplate")
  slider11:SetMinMaxValues(0.1, 1)
  slider11:SetValue(FeralbyNight:Getupdateinterval())
  slider11:SetValueStep(0.05)
  slider11:SetScript("OnValueChanged", function(self) FeralbyNight:Setupdateinterval(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider11:GetName() .. "Low"]:SetText("0.1")
  _G[slider11:GetName() .. "High"]:SetText("1 (sec)")
  _G[slider11:GetName() .. "Text"]:SetText(FeralbyNight:Getupdateinterval())
  slider11:SetPoint("TOPRIGHT", -10, -70)
  
    local fstring12 = panel:CreateFontString("FeralbyNightOptions_string12","OVERLAY","GameFontNormal")
  fstring12:SetText("Show dummy variables when unlocked")
  fstring12:SetPoint("TOPLEFT", 10, -100)
  local checkbox12 = CreateFrame("CheckButton", "$parent_cb12", panel, "OptionsCheckButtonTemplate")
  checkbox12:SetWidth(18)
  checkbox12:SetHeight(18)
  checkbox12:SetScript("OnClick", function() FeralbyNight:Toggledummy() end)
  checkbox12:SetPoint("TOPRIGHT", -10, -100)
  checkbox12:SetChecked(FeralbyNight:Getdummy())
  
      local fstring121 = panel:CreateFontString("FeralbyNightOptions_string121","OVERLAY","GameFontNormal")
  fstring121:SetText("Toggle Ulduar Boss Mode (Not yet Implemented)")
  fstring121:SetPoint("TOPLEFT", 10, -130)
  local checkbox121 = CreateFrame("CheckButton", "$parent_cb121", panel, "OptionsCheckButtonTemplate")
  checkbox121:SetWidth(18)
  checkbox121:SetHeight(18)
  checkbox121:SetScript("OnClick", function() FeralbyNight:Togglebossmode() end)
  checkbox121:SetPoint("TOPRIGHT", -10, -130)
  checkbox121:SetChecked(FeralbyNight:Getbossmode())
  
        local fstring1211 = panel:CreateFontString("FeralbyNightOptions_string1211","OVERLAY","GameFontNormal")
  fstring1211:SetText("Activate FBN addon for main spec")
  fstring1211:SetPoint("TOPLEFT", 10, -160)
  local checkbox1211 = CreateFrame("CheckButton", "$parent_cb1211", panel, "OptionsCheckButtonTemplate")
  checkbox1211:SetWidth(18)
  checkbox1211:SetHeight(18)
  checkbox1211:SetScript("OnClick", function() FeralbyNight:Toggleactivespec1() end)
  checkbox1211:SetPoint("TOPRIGHT", -10, -160)
  checkbox1211:SetChecked(FeralbyNight:Getactivespec1())
  
          local fstring1212 = panel:CreateFontString("FeralbyNightOptions_string1212","OVERLAY","GameFontNormal")
  fstring1212:SetText("Activate FBN addon for secondary spec")
  fstring1212:SetPoint("TOPLEFT", 10, -190)
  local checkbox1212 = CreateFrame("CheckButton", "$parent_cb1212", panel, "OptionsCheckButtonTemplate")
  checkbox1212:SetWidth(18)
  checkbox1212:SetHeight(18)
  checkbox1212:SetScript("OnClick", function() FeralbyNight:Toggleactivespec2() end)
  checkbox1212:SetPoint("TOPRIGHT", -10, -190)
  checkbox1212:SetChecked(FeralbyNight:Getactivespec2())
  
  fstring13673 = panel:CreateFontString("FeralbyNightOptions_string13673","OVERLAY","GameFontNormal")
  fstring13673:SetText("Lag correction (uncheck if you have problem with debuff sync)")
  fstring13673:SetPoint("TOPLEFT", 10, -220)
  checkbox13673 = CreateFrame("CheckButton", "$parent_cb13673", panel, "OptionsCheckButtonTemplate")
  checkbox13673:SetWidth(18)
  checkbox13673:SetHeight(18)
  checkbox13673:SetScript("OnClick", function() FeralbyNight:Togglelagcorrection() end)
  checkbox13673:SetPoint("TOPRIGHT", -10, -220)
  checkbox13673:SetChecked(FeralbyNight:Getlagcorrection())

  fstring136738 = panel:CreateFontString("FeralbyNightOptions_string136738","OVERLAY","GameFontNormal")
  fstring136738:SetText("Conservative play (for energy and dots uptime)")
  fstring136738:SetPoint("TOPLEFT", 10, -250)
  checkbox136738 = CreateFrame("CheckButton", "$parent_cb136738", panel, "OptionsCheckButtonTemplate")
  checkbox136738:SetWidth(18)
  checkbox136738:SetHeight(18)
  checkbox136738:SetScript("OnClick", function() FeralbyNight:Toggleconservative() end)
  checkbox136738:SetPoint("TOPRIGHT", -10, -250)
  checkbox136738:SetChecked(FeralbyNight:Getconservative())  
  
    --Panel 2: Show Options
  local fstring20 = panel2:CreateFontString("FeralbyNightOptions_2_string20","OVERLAY","GameFontNormal")
  fstring20:SetText("Omen of Clarity graphical effect")
  fstring20:SetPoint("TOPLEFT", 10, -10)
  local checkbox20 = CreateFrame("CheckButton", "$parent_cb20", panel2, "OptionsCheckButtonTemplate")
  checkbox20:SetWidth(18)
  checkbox20:SetHeight(18)
  checkbox20:SetScript("OnClick", function() FeralbyNight:Toggleoocframe() end)
  checkbox20:SetPoint("TOPRIGHT", -10, -10)
  checkbox20:SetChecked(FeralbyNight:Getoocframeshow())
  
   local fstring21 = panel2:CreateFontString("FeralbyNightOptions_2_string21","OVERLAY","GameFontNormal")
  fstring21:SetText("Show Hud")
  fstring21:SetPoint("TOPLEFT", 10, -40)
  local checkbox21 = CreateFrame("CheckButton", "$parent_cb21", panel2, "OptionsCheckButtonTemplate")
  checkbox21:SetWidth(18)
  checkbox21:SetHeight(18)
  checkbox21:SetScript("OnClick", function() FeralbyNight:Togglehud() end)
  checkbox21:SetPoint("TOPRIGHT", -10, -40)
  checkbox21:SetChecked(FeralbyNight:Gethudshow())  
  
   local fstring22 = panel2:CreateFontString("FeralbyNightOptions_2_string22","OVERLAY","GameFontNormal")
  fstring22:SetText("Show General Cooldown Monitor")
  fstring22:SetPoint("TOPLEFT", 10, -70)
  local checkbox22 = CreateFrame("CheckButton", "$parent_cb22", panel2, "OptionsCheckButtonTemplate")
  checkbox22:SetWidth(18)
  checkbox22:SetHeight(18)
  checkbox22:SetScript("OnClick", function() FeralbyNight:Togglecdmon1() end)
  checkbox22:SetPoint("TOPRIGHT", -10, -70)
  checkbox22:SetChecked(FeralbyNight:Getcdmonshow1())
  
    local fstring22cat = panel2:CreateFontString("FeralbyNightOptions_2_string22cat","OVERLAY","GameFontNormal")
  fstring22cat:SetText("Show Cat Abilities Monitor")
  fstring22cat:SetPoint("TOPLEFT", 10, -100)
  local checkbox22cat = CreateFrame("CheckButton", "$parent_cb22cat", panel2, "OptionsCheckButtonTemplate")
  checkbox22cat:SetWidth(18)
  checkbox22cat:SetHeight(18)
  checkbox22cat:SetScript("OnClick", function() FeralbyNight:Togglecdmon2() end)
  checkbox22cat:SetPoint("TOPRIGHT", -10, -100)
  checkbox22cat:SetChecked(FeralbyNight:Getcdmonshow2())
  
    local fstring22bear = panel2:CreateFontString("FeralbyNightOptions_2_string22bear","OVERLAY","GameFontNormal")
  fstring22bear:SetText("Show Bear Abilities Monitor")
  fstring22bear:SetPoint("TOPLEFT", 10, -130)
  local checkbox22bear = CreateFrame("CheckButton", "$parent_cb22bear", panel2, "OptionsCheckButtonTemplate")
  checkbox22bear:SetWidth(18)
  checkbox22bear:SetHeight(18)
  checkbox22bear:SetScript("OnClick", function() FeralbyNight:Togglecdmon3() end)
  checkbox22bear:SetPoint("TOPRIGHT", -10, -130)
  checkbox22bear:SetChecked(FeralbyNight:Getcdmonshow3())
  
   local fstring23 = panel2:CreateFontString("FeralbyNightOptions_2_string23","OVERLAY","GameFontNormal")
  fstring23:SetText("Big Energy/Rage Frame")
  fstring23:SetPoint("TOPLEFT", 10, -160)
  local checkbox23 = CreateFrame("CheckButton", "$parent_cb23", panel2, "OptionsCheckButtonTemplate")
  checkbox23:SetWidth(18)
  checkbox23:SetHeight(18)
  checkbox23:SetScript("OnClick", function() FeralbyNight:Toggleenergyframe() end)
  checkbox23:SetPoint("TOPRIGHT", -10, -160)
  checkbox23:SetChecked(FeralbyNight:Getenergyframeshow())
 
   local fstring24 = panel2:CreateFontString("FeralbyNightOptions_2_string24","OVERLAY","GameFontNormal")
  fstring24:SetText("Big CP/Lacerate Stack Frame")
  fstring24:SetPoint("TOPLEFT", 10, -190)
  local checkbox24 = CreateFrame("CheckButton", "$parent_cb24", panel2, "OptionsCheckButtonTemplate")
  checkbox24:SetWidth(18)
  checkbox24:SetHeight(18)
  checkbox24:SetScript("OnClick", function() FeralbyNight:Togglecpframe() end)
  checkbox24:SetPoint("TOPRIGHT", -10, -190)
  checkbox24:SetChecked(FeralbyNight:Getcpframeshow())
 
   local fstring25 = panel2:CreateFontString("FeralbyNightOptions_2_string25","OVERLAY","GameFontNormal")
  fstring25:SetText("Show Melee Stats Frame")
  fstring25:SetPoint("TOPLEFT", 10, -210)
  local checkbox25 = CreateFrame("CheckButton", "$parent_cb25", panel2, "OptionsCheckButtonTemplate")
  checkbox25:SetWidth(18)
  checkbox25:SetHeight(18)
  checkbox25:SetScript("OnClick", function() FeralbyNight:Togglestatsframe() end)
  checkbox25:SetPoint("TOPRIGHT", -10, -210)
  checkbox25:SetChecked(FeralbyNight:Getstatsframeshow())
 
   local fstring26 = panel2:CreateFontString("FeralbyNightOptions_2_string26","OVERLAY","GameFontNormal")
  fstring26:SetText("Show Move Prediction (+1sec in the future)")
  fstring26:SetPoint("TOPLEFT", 10, -240)
  local checkbox26 = CreateFrame("CheckButton", "$parent_cb26", panel2, "OptionsCheckButtonTemplate")
  checkbox26:SetWidth(18)
  checkbox26:SetHeight(18)
  checkbox26:SetScript("OnClick", function() FeralbyNight:ToggleShowPrediction() end)
  checkbox26:SetPoint("TOPRIGHT", -10, -240)
  checkbox26:SetChecked(FeralbyNight:GetShowPrediction())
  
    local fstring27 = panel2:CreateFontString("FeralbyNightOptions_2_string27","OVERLAY","GameFontNormal")
  fstring27:SetText("Show Move Suggestion")
  fstring27:SetPoint("TOPLEFT", 10, -270)
  local checkbox27 = CreateFrame("CheckButton", "$parent_cb27", panel2, "OptionsCheckButtonTemplate")
  checkbox27:SetWidth(18)
  checkbox27:SetHeight(18)
  checkbox27:SetScript("OnClick", function() FeralbyNight:Togglesuggesterframe() end)
  checkbox27:SetPoint("TOPRIGHT", -10, -270)
  checkbox27:SetChecked(FeralbyNight:Getsuggesterframeshow())
  
     local fstring28 = panel21:CreateFontString("FeralbyNightOptions_21_string28","OVERLAY","GameFontNormal")
  fstring28:SetText("Show SR/Barkskin/Surv.Inst. Frame")
  fstring28:SetPoint("TOPLEFT", 10, -10)
  local checkbox28 = CreateFrame("CheckButton", "$parent_cb28", panel21, "OptionsCheckButtonTemplate")
  checkbox28:SetWidth(18)
  checkbox28:SetHeight(18)
  checkbox28:SetScript("OnClick", function() FeralbyNight:Togglesrframe() end)
  checkbox28:SetPoint("TOPRIGHT", -10, -10)
  checkbox28:SetChecked(FeralbyNight:Getsrframeshow())
  
       local fstring29 = panel21:CreateFontString("FeralbyNightOptions_21_string29","OVERLAY","GameFontNormal")
  fstring29:SetText("Show expected time before boss kill")
  fstring29:SetPoint("TOPLEFT", 10, -40)
  local checkbox29 = CreateFrame("CheckButton", "$parent_cb29", panel21, "OptionsCheckButtonTemplate")
  checkbox29:SetWidth(18)
  checkbox29:SetHeight(18)
  checkbox29:SetScript("OnClick", function() FeralbyNight:Toggletimetokillframe() end)
  checkbox29:SetPoint("TOPRIGHT", -10, -40)
  checkbox29:SetChecked(FeralbyNight:Gettimetokillframeshow())
  
  
         local fstring291 = panel21:CreateFontString("FeralbyNightOptions_21_string291","OVERLAY","GameFontNormal")
  fstring291:SetText("Show target casting bar")
  fstring291:SetPoint("TOPLEFT", 10, -70)
  local checkbox291 = CreateFrame("CheckButton", "$parent_cb291", panel21, "OptionsCheckButtonTemplate")
  checkbox291:SetWidth(18)
  checkbox291:SetHeight(18)
  checkbox291:SetScript("OnClick", function() FeralbyNight:Togglecastingbarshow() end)
  checkbox291:SetPoint("TOPRIGHT", -10, -70)
  checkbox291:SetChecked(FeralbyNight:Getcastingbarshow())
  
     local fstring2222 = panel21:CreateFontString("FeralbyNightOptions_21_string2222","OVERLAY","GameFontNormal")
  fstring2222:SetText("Show fight specific player Monitor")
  fstring2222:SetPoint("TOPLEFT", 10, -100)
  local checkbox2222 = CreateFrame("CheckButton", "$parent_cb2222", panel21, "OptionsCheckButtonTemplate")
  checkbox2222:SetWidth(18)
  checkbox2222:SetHeight(18)
  checkbox2222:SetScript("OnClick", function() FeralbyNight:Togglemyfight() end)
  checkbox2222:SetPoint("TOPRIGHT", -10, -100)
  checkbox2222:SetChecked(FeralbyNight:Getmyfightshow())
  
    local fstring2223 = panel21:CreateFontString("FeralbyNightOptions_21_string2223","OVERLAY","GameFontNormal")
  fstring2223:SetText("Show fight specific boss Monitor")
  fstring2223:SetPoint("TOPLEFT", 10, -130)
  local checkbox2223 = CreateFrame("CheckButton", "$parent_cb2223", panel21, "OptionsCheckButtonTemplate")
  checkbox2223:SetWidth(18)
  checkbox2223:SetHeight(18)
  checkbox2223:SetScript("OnClick", function() FeralbyNight:Togglebossfight() end)
  checkbox2223:SetPoint("TOPRIGHT", -10, -130)
  checkbox2223:SetChecked(FeralbyNight:Getbossfightshow())
  
  
      local fstring22234 = panel21:CreateFontString("FeralbyNightOptions_21_string22234","OVERLAY","GameFontNormal")
  fstring22234:SetText("Show proc Monitor")
  fstring22234:SetPoint("TOPLEFT", 10, -160)
  local checkbox22234 = CreateFrame("CheckButton", "$parent_cb22234", panel21, "OptionsCheckButtonTemplate")
  checkbox22234:SetWidth(18)
  checkbox22234:SetHeight(18)
  checkbox22234:SetScript("OnClick", function() FeralbyNight:Toggleproc() end)
  checkbox22234:SetPoint("TOPRIGHT", -10, -160)
  checkbox22234:SetChecked(FeralbyNight:Getprocshow())
 
    local fstring20000 = panel21:CreateFontString("FeralbyNightOptions_21_string20000","OVERLAY","GameFontNormal")
  fstring20000:SetText("Notification icons")
  fstring20000:SetPoint("TOPLEFT", 10, -190)
  local checkbox20000 = CreateFrame("CheckButton", "$parent_cb20000", panel21, "OptionsCheckButtonTemplate")
  checkbox20000:SetWidth(18)
  checkbox20000:SetHeight(18)
  checkbox20000:SetScript("OnClick", function() FeralbyNight:Togglenoticeframe() end)
  checkbox20000:SetPoint("TOPRIGHT", -10, -190)
  checkbox20000:SetChecked(FeralbyNight:Getnoticeframeshow())
  
  
     local fstring20022 = panel21:CreateFontString("FeralbyNightOptions_21_string20022","OVERLAY","GameFontNormal")
  fstring20022:SetText("Print target ID in default chat")
  fstring20022:SetPoint("TOPLEFT", 10, -220)
  local checkbox20022 = CreateFrame("CheckButton", "$parent_cb20022", panel21, "OptionsCheckButtonTemplate")
  checkbox20022:SetWidth(18)
  checkbox20022:SetHeight(18)
  checkbox20022:SetScript("OnClick", function() FeralbyNight:Toggletargetidshow() end)
  checkbox20022:SetPoint("TOPRIGHT", -10, -220)
  checkbox20022:SetChecked(FeralbyNight:Gettargetidshow())
  
       local fstring20043 = panel21:CreateFontString("FeralbyNightOptions_21_string20043","OVERLAY","GameFontNormal")
  fstring20043:SetText("Show OOC proc in CD monitor")
  fstring20043:SetPoint("TOPLEFT", 10, -250)
  local checkbox20043 = CreateFrame("CheckButton", "$parent_cb20043", panel21, "OptionsCheckButtonTemplate")
  checkbox20043:SetWidth(18)
  checkbox20043:SetHeight(18)
  checkbox20043:SetScript("OnClick", function() FeralbyNight:Toggleoocoverride() end)
  checkbox20043:SetPoint("TOPRIGHT", -10, -250)
  checkbox20043:SetChecked(FeralbyNight:Getoocoverride())
  
  --Panel 3: Scale Options
  
  local fstring6 = panel3:CreateFontString("FeralbyNightOptions_3_string6","OVERLAY","GameFontNormal")
  fstring6:SetText("Suggestion Monitor Scale")
  fstring6:SetPoint("TOPLEFT", 10, -20)
  local slider2 = CreateFrame("Slider", "$parent_sl2", panel3, "OptionsSliderTemplate")
  slider2:SetMinMaxValues(.25, 2.0)
  slider2:SetValue(FeralbyNight:GetScale())
  slider2:SetValueStep(.05)
  slider2:SetScript("OnValueChanged", function(self) FeralbyNight:SetScale(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue())  end)
  _G[slider2:GetName() .. "Low"]:SetText("0.25")
  _G[slider2:GetName() .. "High"]:SetText("2.0")
  _G[slider2:GetName() .. "Text"]:SetText(FeralbyNight:GetScale())
  slider2:SetPoint("TOPRIGHT", -10, -20)
  
  
  local fstring8 = panel3:CreateFontString("FeralbyNightOptions_3_string8","OVERLAY","GameFontNormal")
  fstring8:SetText("General Cooldown Monitor Scale")
  fstring8:SetPoint("TOPLEFT", 10, -50)
  local slider3 = CreateFrame("Slider", "$parent_sl3", panel3, "OptionsSliderTemplate")
  slider3:SetMinMaxValues(.25, 2.0)
  slider3:SetValue(FeralbyNight:GetcdmonScale1())
  slider3:SetValueStep(.05)
  slider3:SetScript("OnValueChanged", function(self) FeralbyNight:SetcdmonScale1(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue())  end)
  _G[slider3:GetName() .. "Low"]:SetText("0.25")
  _G[slider3:GetName() .. "High"]:SetText("2.0")
  _G[slider3:GetName() .. "Text"]:SetText(FeralbyNight:GetcdmonScale1())
  slider3:SetPoint("TOPRIGHT", -10, -50)
  
   local fstring8cat = panel3:CreateFontString("FeralbyNightOptions_3_string8cat","OVERLAY","GameFontNormal")
  fstring8cat:SetText("Cat Ability Monitor Scale")
  fstring8cat:SetPoint("TOPLEFT", 10, -80)
  local slider3cat = CreateFrame("Slider", "$parent_sl3cat", panel3, "OptionsSliderTemplate")
  slider3cat:SetMinMaxValues(.25, 2.0)
  slider3cat:SetValue(FeralbyNight:GetcdmonScale2())
  slider3cat:SetValueStep(.05)
  slider3cat:SetScript("OnValueChanged", function(self) FeralbyNight:SetcdmonScale2(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue())  end)
  _G[slider3cat:GetName() .. "Low"]:SetText("0.25")
  _G[slider3cat:GetName() .. "High"]:SetText("2.0")
  _G[slider3cat:GetName() .. "Text"]:SetText(FeralbyNight:GetcdmonScale2())
  slider3cat:SetPoint("TOPRIGHT", -10, -80)
  
   local fstring8bear = panel3:CreateFontString("FeralbyNightOptions_3_string8bear","OVERLAY","GameFontNormal")
  fstring8bear:SetText("Bear Ability Monitor Scale")
  fstring8bear:SetPoint("TOPLEFT", 10, -110)
  local slider3bear = CreateFrame("Slider", "$parent_sl3bear", panel3, "OptionsSliderTemplate")
  slider3bear:SetMinMaxValues(.25, 2.0)
  slider3bear:SetValue(FeralbyNight:GetcdmonScale3())
  slider3bear:SetValueStep(.05)
  slider3bear:SetScript("OnValueChanged", function(self) FeralbyNight:SetcdmonScale3(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue())  end)
  _G[slider3bear:GetName() .. "Low"]:SetText("0.25")
  _G[slider3bear:GetName() .. "High"]:SetText("2.0")
  _G[slider3bear:GetName() .. "Text"]:SetText(FeralbyNight:GetcdmonScale3())
  slider3bear:SetPoint("TOPRIGHT", -10, -110)
  
   local fstring9 = panel3:CreateFontString("FeralbyNightOptions_3_string9","OVERLAY","GameFontNormal")
  fstring9:SetText("Stats Scale")
  fstring9:SetPoint("TOPLEFT", 10, -140)
  local slider4 = CreateFrame("Slider", "$parent_sl4", panel3, "OptionsSliderTemplate")
  slider4:SetMinMaxValues(.25, 2.0)
  slider4:SetValue(FeralbyNight:GetMeleeScale())
  slider4:SetValueStep(.05)
  slider4:SetScript("OnValueChanged", function(self) FeralbyNight:SetMeleeScale(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue())  end)
  _G[slider4:GetName() .. "Low"]:SetText("0.25")
  _G[slider4:GetName() .. "High"]:SetText("2.0")
  _G[slider4:GetName() .. "Text"]:SetText(FeralbyNight:GetMeleeScale())
  slider4:SetPoint("TOPRIGHT", -10, -140)
  
     local fstring100 = panel3:CreateFontString("FeralbyNightOptions_3_string100","OVERLAY","GameFontNormal")
  fstring100:SetText("CP/Lacerate Stack Scale")
  fstring100:SetPoint("TOPLEFT", 10, -170)
  local slider50 = CreateFrame("Slider", "$parent_sl50", panel3, "OptionsSliderTemplate")
  slider50:SetMinMaxValues(.25, 3.0)
  slider50:SetValue(FeralbyNight:GetCPScale())
  slider50:SetValueStep(.05)
  slider50:SetScript("OnValueChanged", function(self) FeralbyNight:SetCPScale(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue())  end)
  _G[slider50:GetName() .. "Low"]:SetText("0.25")
  _G[slider50:GetName() .. "High"]:SetText("3.0")
  _G[slider50:GetName() .. "Text"]:SetText(FeralbyNight:GetCPScale())
  slider50:SetPoint("TOPRIGHT", -10, -170)
  
     local fstring11 = panel3:CreateFontString("FeralbyNightOptions_3_string11","OVERLAY","GameFontNormal")
  fstring11:SetText("Energy/Rage Scale")
  fstring11:SetPoint("TOPLEFT", 10, -200)
  local slider6 = CreateFrame("Slider", "$parent_sl6", panel3, "OptionsSliderTemplate")
  slider6:SetMinMaxValues(.25, 3.0)
  slider6:SetValue(FeralbyNight:GetenergyScale())
  slider6:SetValueStep(.05)
  slider6:SetScript("OnValueChanged", function(self) FeralbyNight:SetenergyScale(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue())  end)
  _G[slider6:GetName() .. "Low"]:SetText("0.25")
  _G[slider6:GetName() .. "High"]:SetText("3.0")
  _G[slider6:GetName() .. "Text"]:SetText(FeralbyNight:GetenergyScale())
  slider6:SetPoint("TOPRIGHT", -10, -200)
  
  local fstring12 = panel3:CreateFontString("FeralbyNightOptions_3_string12","OVERLAY","GameFontNormal")
  fstring12:SetText("Hud Scale")
  fstring12:SetPoint("TOPLEFT", 10, -230)
  local slider7 = CreateFrame("Slider", "$parent_sl7", panel3, "OptionsSliderTemplate")
  slider7:SetMinMaxValues(.25, 2.0)
  slider7:SetValue(FeralbyNight:GethudScale())
  slider7:SetValueStep(.05)
  slider7:SetScript("OnValueChanged", function(self) FeralbyNight:SethudScale(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue())  end)
  _G[slider7:GetName() .. "Low"]:SetText("0.25")
  _G[slider7:GetName() .. "High"]:SetText("2.0")
  _G[slider7:GetName() .. "Text"]:SetText(FeralbyNight:GethudScale())
  slider7:SetPoint("TOPRIGHT", -10, -230)
  
  
 local fstring14 = panel3:CreateFontString("FeralbyNightOptions_3_string14","OVERLAY","GameFontNormal")
  fstring14:SetText("Clearcasting Texture Scale")
  fstring14:SetPoint("TOPLEFT", 10, -260)
  local slider8 = CreateFrame("Slider", "$parent_sl8", panel3, "OptionsSliderTemplate")
  slider8:SetMinMaxValues(.25, 2.0)
  slider8:SetValue(FeralbyNight:GetoocScale())
  slider8:SetValueStep(.05)
  slider8:SetScript("OnValueChanged", function(self) FeralbyNight:SetoocScale(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue())  end)
  _G[slider8:GetName() .. "Low"]:SetText("0.25")
  _G[slider8:GetName() .. "High"]:SetText("2.0")
  _G[slider8:GetName() .. "Text"]:SetText(FeralbyNight:GetoocScale())
  slider8:SetPoint("TOPRIGHT", -10, -260)
  
      local fstring15 = panel3:CreateFontString("FeralbyNightOptions_3_string15","OVERLAY","GameFontNormal")
  fstring15:SetText("SR/CD Frame Scale")
  fstring15:SetPoint("TOPLEFT", 10, -290)
  local slider9 = CreateFrame("Slider", "$parent_sl9", panel3, "OptionsSliderTemplate")
  slider9:SetMinMaxValues(.25, 3.0)
  slider9:SetValue(FeralbyNight:GetsrScale())
  slider9:SetValueStep(.05)
  slider9:SetScript("OnValueChanged", function(self) FeralbyNight:SetsrScale(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue())  end)
  _G[slider9:GetName() .. "Low"]:SetText("0.25")
  _G[slider9:GetName() .. "High"]:SetText("3.0")
  _G[slider9:GetName() .. "Text"]:SetText(FeralbyNight:GetsrScale())
  slider9:SetPoint("TOPRIGHT", -10, -290)
  
        local fstring150 = panel3:CreateFontString("FeralbyNightOptions_3_string150","OVERLAY","GameFontNormal")
  fstring150:SetText("Time before kill Frame Scale")
  fstring150:SetPoint("TOPLEFT", 10, -320)
  local slider90 = CreateFrame("Slider", "$parent_sl90", panel3, "OptionsSliderTemplate")
  slider90:SetMinMaxValues(.25, 3.0)
  slider90:SetValue(FeralbyNight:GettimetokillScale())
  slider90:SetValueStep(.05)
  slider90:SetScript("OnValueChanged", function(self) FeralbyNight:SettimetokillScale(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue())  end)
  _G[slider90:GetName() .. "Low"]:SetText("0.25")
  _G[slider90:GetName() .. "High"]:SetText("3.0")
  _G[slider90:GetName() .. "Text"]:SetText(FeralbyNight:GettimetokillScale())
  slider90:SetPoint("TOPRIGHT", -10, -320)
  
  
   local fstring14000 = panel3:CreateFontString("FeralbyNightOptions_3_string14000","OVERLAY","GameFontNormal")
  fstring14000:SetText("Notification Frame Scale")
  fstring14000:SetPoint("TOPLEFT", 10, -350)
  local slider8000 = CreateFrame("Slider", "$parent_sl8000", panel3, "OptionsSliderTemplate")
  slider8000:SetMinMaxValues(.10, 1.5)
  slider8000:SetValue(FeralbyNight:GetnoticeScale())
  slider8000:SetValueStep(.05)
  slider8000:SetScript("OnValueChanged", function(self) FeralbyNight:SetnoticeScale(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue())  end)
  _G[slider8000:GetName() .. "Low"]:SetText("0.1")
  _G[slider8000:GetName() .. "High"]:SetText("2.0")
  _G[slider8000:GetName() .. "Text"]:SetText(FeralbyNight:GetnoticeScale())
  slider8000:SetPoint("TOPRIGHT", -10, -350)
  
    local fstring15000 = panel3:CreateFontString("FeralbyNightOptions_3_string15000","OVERLAY","GameFontNormal")
  fstring15000:SetText("Proc Frame Scale")
  fstring15000:SetPoint("TOPLEFT", 10, -380)
  local slider8200 = CreateFrame("Slider", "$parent_sl8200", panel3, "OptionsSliderTemplate")
  slider8200:SetMinMaxValues(.25, 3.0)
  slider8200:SetValue(FeralbyNight:GetprocScale())
  slider8200:SetValueStep(.05)
  slider8200:SetScript("OnValueChanged", function(self) FeralbyNight:SetprocScale(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue())  end)
  _G[slider8200:GetName() .. "Low"]:SetText("0.25")
  _G[slider8200:GetName() .. "High"]:SetText("3.0")
  _G[slider8200:GetName() .. "Text"]:SetText(FeralbyNight:GetprocScale())
  slider8200:SetPoint("TOPRIGHT", -10, -380)
  
    --Panel 4: Fonts Options
  
   local fstring401 = panel4:CreateFontString("FeralbyNightOptions_4_string401","OVERLAY","GameFontNormal")
  fstring401:SetText("SR/CD Frame Font: "..FeralbyNightdb.srFramefont)
  fstring401:SetPoint("TOPLEFT", 10, -10)
  local slider401 = CreateFrame("Slider", "$parent_sl401", panel4, "OptionsSliderTemplate")
  slider401:SetMinMaxValues(1, 20)
  slider401:SetValue(FeralbyNight:GetsrFont())
  slider401:SetValueStep(1)
  slider401:SetScript("OnValueChanged", function(self) FeralbyNight:SetsrFont(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()); fstring401:SetText("SR/CD Frame Font: "..FeralbyNightdb.srFramefont)  end)
  _G[slider401:GetName() .. "Low"]:SetText("1")
  _G[slider401:GetName() .. "High"]:SetText("20")
  _G[slider401:GetName() .. "Text"]:SetText(FeralbyNight:GetsrFont())
  slider401:SetPoint("TOPRIGHT", -10, -10)
 
   local fstring4012 = panel4:CreateFontString("FeralbyNightOptions_4_string4012","OVERLAY","GameFontNormal")
  fstring4012:SetText("SR/CD Frame Font size")
  fstring4012:SetPoint("TOPLEFT", 10, -40)
  local slider4012 = CreateFrame("Slider", "$parent_sl4012", panel4, "OptionsSliderTemplate")
  slider4012:SetMinMaxValues(6, 40)
  slider4012:SetValue(tonumber(FeralbyNightdb.srFramefontsize))
  slider4012:SetValueStep(1)
  slider4012:SetScript("OnValueChanged", function(self) FeralbyNightdb.srFramefontsize=tostring(self:GetValue()); FeralbyNight.srFrame:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.srFramefont, FeralbyNightdb.srFramefontsize); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)  
  _G[slider4012:GetName() .. "Low"]:SetText("6")
  _G[slider4012:GetName() .. "High"]:SetText("40")
  _G[slider4012:GetName() .. "Text"]:SetText(tonumber(FeralbyNightdb.srFramefontsize))
  slider4012:SetPoint("TOPRIGHT", -10, -40)
 
 
     local fstring402 = panel4:CreateFontString("FeralbyNightOptions_4_string402","OVERLAY","GameFontNormal")
  fstring402:SetText("energy/rage Frame Font: "..FeralbyNightdb.energyFramefont)
  
  fstring402:SetPoint("TOPLEFT", 10, -70)
  local slider402 = CreateFrame("Slider", "$parent_sl402", panel4, "OptionsSliderTemplate")
  slider402:SetMinMaxValues(1, 20)
  slider402:SetValue(FeralbyNight:GetenergyFont())
  slider402:SetValueStep(1)
  slider402:SetScript("OnValueChanged", function(self) FeralbyNight:SetenergyFont(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()); fstring402:SetText("energy/rage Frame Font: "..FeralbyNightdb.energyFramefont)  end)
  _G[slider402:GetName() .. "Low"]:SetText("1")
  _G[slider402:GetName() .. "High"]:SetText("20")
  _G[slider402:GetName() .. "Text"]:SetText(FeralbyNight:GetenergyFont())
  slider402:SetPoint("TOPRIGHT", -10, -70)
  
   local fstring4022 = panel4:CreateFontString("FeralbyNightOptions_4_string4022","OVERLAY","GameFontNormal")
  fstring4022:SetText("energy/rage Frame Font size")
  
  fstring4022:SetPoint("TOPLEFT", 10, -100)
  local slider4022 = CreateFrame("Slider", "$parent_sl4022", panel4, "OptionsSliderTemplate")
  slider4022:SetMinMaxValues(6, 40)
  slider4022:SetValue(tonumber(FeralbyNightdb.energyFramefontsize))
  slider4022:SetValueStep(1)
  slider4022:SetScript("OnValueChanged", function(self) FeralbyNightdb.energyFramefontsize=tostring(self:GetValue()); FeralbyNight.energyFrame:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.energyFramefont, FeralbyNightdb.energyFramefontsize); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider4022:GetName() .. "Low"]:SetText("6")
  _G[slider4022:GetName() .. "High"]:SetText("40")
  _G[slider4022:GetName() .. "Text"]:SetText(tonumber(FeralbyNightdb.energyFramefontsize))
  slider4022:SetPoint("TOPRIGHT", -10, -100)
  
  
   local fstring403 = panel4:CreateFontString("FeralbyNightOptions_4_string403","OVERLAY","GameFontNormal")
  fstring403:SetText("cp/lacerate Frame Font: "..FeralbyNightdb.cpFramefont)
  
  fstring403:SetPoint("TOPLEFT", 10, -130)
  local slider403 = CreateFrame("Slider", "$parent_sl403", panel4, "OptionsSliderTemplate")
  slider403:SetMinMaxValues(1, 20)
  slider403:SetValue(FeralbyNight:GetcpFont())
  slider403:SetValueStep(1)
  slider403:SetScript("OnValueChanged", function(self) FeralbyNight:SetcpFont(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()); fstring403:SetText("cp/lacerate Frame Font: "..FeralbyNightdb.cpFramefont)  end)
  _G[slider403:GetName() .. "Low"]:SetText("1")
  _G[slider403:GetName() .. "High"]:SetText("20")
  _G[slider403:GetName() .. "Text"]:SetText(FeralbyNight:GetcpFont())
  slider403:SetPoint("TOPRIGHT", -10, -130)
  
   local fstring4032 = panel4:CreateFontString("FeralbyNightOptions_4_string4032","OVERLAY","GameFontNormal")
  fstring4032:SetText("cp/lacerate Frame Font size")
  
  fstring4032:SetPoint("TOPLEFT", 10, -160)
  local slider4032 = CreateFrame("Slider", "$parent_sl4032", panel4, "OptionsSliderTemplate")
  slider4032:SetMinMaxValues(6, 40)
  slider4032:SetValue(tonumber(FeralbyNightdb.cpFramefontsize))
  slider4032:SetValueStep(1)
  slider4032:SetScript("OnValueChanged", function(self) FeralbyNightdb.cpFramefontsize=tostring(self:GetValue()); FeralbyNight.CPFrame:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cpFramefont, FeralbyNightdb.cpFramefontsize); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end) 
  _G[slider4032:GetName() .. "Low"]:SetText("6")
  _G[slider4032:GetName() .. "High"]:SetText("40")
  _G[slider4032:GetName() .. "Text"]:SetText(tonumber(FeralbyNightdb.cpFramefontsize))
  slider4032:SetPoint("TOPRIGHT", -10, -160)
  
  
  
  
     local fstring404 = panel4:CreateFontString("FeralbyNightOptions_4_string404","OVERLAY","GameFontNormal")
  fstring404:SetText("Time to Die Frame Font: "..FeralbyNightdb.timetokillFramefont)
  
  fstring404:SetPoint("TOPLEFT", 10, -190)
  local slider404 = CreateFrame("Slider", "$parent_sl404", panel4, "OptionsSliderTemplate")
  slider404:SetMinMaxValues(1, 20)
  slider404:SetValue(FeralbyNight:GettimetokillFont())
  slider404:SetValueStep(1)
  slider404:SetScript("OnValueChanged", function(self) FeralbyNight:SettimetokillFont(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()); fstring404:SetText("Time to Die Frame Font: "..FeralbyNightdb.timetokillFramefont)  end)
  _G[slider404:GetName() .. "Low"]:SetText("1")
  _G[slider404:GetName() .. "High"]:SetText("20")
  _G[slider404:GetName() .. "Text"]:SetText(FeralbyNight:GettimetokillFont())
  slider404:SetPoint("TOPRIGHT", -10, -190)
  
   local fstring4042 = panel4:CreateFontString("FeralbyNightOptions_4_string4042","OVERLAY","GameFontNormal")
  fstring4042:SetText("Time to Die Frame Font size")
  
  fstring4042:SetPoint("TOPLEFT", 10, -220)
  local slider4042 = CreateFrame("Slider", "$parent_sl4042", panel4, "OptionsSliderTemplate")
  slider4042:SetMinMaxValues(6, 40)
  slider4042:SetValue(tonumber(FeralbyNightdb.timetokillFramefontsize))
  slider4042:SetValueStep(1)
  slider4042:SetScript("OnValueChanged", function(self) FeralbyNightdb.timetokillFramefontsize=tostring(self:GetValue()); FeralbyNight.timetokillFrame:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.timetokillFramefont, FeralbyNightdb.timetokillFramefontsize); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end) 
  _G[slider4042:GetName() .. "Low"]:SetText("6")
  _G[slider4042:GetName() .. "High"]:SetText("40")
  _G[slider4042:GetName() .. "Text"]:SetText(tonumber(FeralbyNightdb.timetokillFramefontsize))
  slider4042:SetPoint("TOPRIGHT", -10, -220)
  
  
  

   local fstring405 = panel4:CreateFontString("FeralbyNightOptions_4_string405","OVERLAY","GameFontNormal")
  fstring405:SetText("Stats Frame Font: "..FeralbyNightdb.MeleeFramefont)
  
  fstring405:SetPoint("TOPLEFT", 10, -250)
  local slider405 = CreateFrame("Slider", "$parent_sl405", panel4, "OptionsSliderTemplate")
  slider405:SetMinMaxValues(1, 20)
  slider405:SetValue(FeralbyNight:GetMeleeFont())
  slider405:SetValueStep(1)
  slider405:SetScript("OnValueChanged", function(self) FeralbyNight:SetMeleeFont(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()); fstring405:SetText("Stats Frame Font: "..FeralbyNightdb.MeleeFramefont)  end)
  _G[slider405:GetName() .. "Low"]:SetText("1")
  _G[slider405:GetName() .. "High"]:SetText("20")
  _G[slider405:GetName() .. "Text"]:SetText(FeralbyNight:GetMeleeFont())
  slider405:SetPoint("TOPRIGHT", -10, -250)
  
   local fstring4052 = panel4:CreateFontString("FeralbyNightOptions_4_string4052","OVERLAY","GameFontNormal")
  fstring4052:SetText("Stats Frame Font size")
  
  fstring4052:SetPoint("TOPLEFT", 10, -280)
  local slider4052 = CreateFrame("Slider", "$parent_sl4052", panel4, "OptionsSliderTemplate")
  slider4052:SetMinMaxValues(6, 40)
  slider4052:SetValue(tonumber(FeralbyNightdb.MeleeFramefontsize))
  slider4052:SetValueStep(1)
  slider4052:SetScript("OnValueChanged", function(self) FeralbyNightdb.MeleeFramefontsize=tostring(self:GetValue()); FeralbyNight.MeleeFrame:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.MeleeFramefont, FeralbyNightdb.MeleeFramefontsize); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider4052:GetName() .. "Low"]:SetText("6")
  _G[slider4052:GetName() .. "High"]:SetText("40")
  _G[slider4052:GetName() .. "Text"]:SetText(tonumber(FeralbyNightdb.MeleeFramefontsize))
  slider4052:SetPoint("TOPRIGHT", -10, -280)
  
  
     local fstring408 = panel41:CreateFontString("FeralbyNightOptions_4_string408","OVERLAY","GameFontNormal")
  fstring408:SetText("CD monitor Frame Font: "..FeralbyNightdb.cdmonFramefont1)
  
  fstring408:SetPoint("TOPLEFT", 10, -10)
  local slider408 = CreateFrame("Slider", "$parent_sl408", panel41, "OptionsSliderTemplate")
  slider408:SetMinMaxValues(1, 20)
  slider408:SetValue(FeralbyNight:GetcdmonFont1())
  slider408:SetValueStep(1)
  slider408:SetScript("OnValueChanged", function(self) FeralbyNight:SetcdmonFont1(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()); fstring408:SetText("CD monitor Frame Font: "..FeralbyNightdb.cdmonFramefont1)  end)
  _G[slider408:GetName() .. "Low"]:SetText("1")
  _G[slider408:GetName() .. "High"]:SetText("20")
  _G[slider408:GetName() .. "Text"]:SetText(FeralbyNight:GetcdmonFont1())
  slider408:SetPoint("TOPRIGHT", -10, -10)
  
   local fstring4082 = panel41:CreateFontString("FeralbyNightOptions_4_string4082","OVERLAY","GameFontNormal")
  fstring4082:SetText("CD monitor Frame Font size")
  
  fstring4082:SetPoint("TOPLEFT", 10, -40)
  local slider4082 = CreateFrame("Slider", "$parent_sl4082", panel41, "OptionsSliderTemplate")
  slider4082:SetMinMaxValues(6, 40)
  slider4082:SetValue(tonumber(FeralbyNightdb.cdmonFramefontsize1))
  slider4082:SetValueStep(1)
  slider4082:SetScript("OnValueChanged", function(self) FeralbyNightdb.cdmonFramefontsize1=tostring(self:GetValue()); 
FeralbyNightcdmonFrame1_1:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont1, FeralbyNightdb.cdmonFramefontsize1);
FeralbyNightcdmonFrame1_2:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont1, FeralbyNightdb.cdmonFramefontsize1);
FeralbyNightcdmonFrame1_3:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont1, FeralbyNightdb.cdmonFramefontsize1);
FeralbyNightcdmonFrame1_4:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont1, FeralbyNightdb.cdmonFramefontsize1);
FeralbyNightcdmonFrame1_5:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont1, FeralbyNightdb.cdmonFramefontsize1); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider4082:GetName() .. "Low"]:SetText("6")
  _G[slider4082:GetName() .. "High"]:SetText("40")
  _G[slider4082:GetName() .. "Text"]:SetText(tonumber(FeralbyNightdb.cdmonFramefontsize1))
  slider4082:SetPoint("TOPRIGHT", -10, -40)
  



   local fstring409 = panel41:CreateFontString("FeralbyNightOptions_4_string409","OVERLAY","GameFontNormal")
  fstring409:SetText("cat monitor Frame Font: "..FeralbyNightdb.cdmonFramefont2)
  
  fstring409:SetPoint("TOPLEFT", 10, -70)
  local slider409 = CreateFrame("Slider", "$parent_sl409", panel41, "OptionsSliderTemplate")
  slider409:SetMinMaxValues(1, 20)
  slider409:SetValue(FeralbyNight:GetcdmonFont2())
  slider409:SetValueStep(1)
  slider409:SetScript("OnValueChanged", function(self) FeralbyNight:SetcdmonFont2(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()); fstring409:SetText("cat monitor Frame Font: "..FeralbyNightdb.cdmonFramefont2)  end)
  _G[slider409:GetName() .. "Low"]:SetText("1")
  _G[slider409:GetName() .. "High"]:SetText("20")
  _G[slider409:GetName() .. "Text"]:SetText(FeralbyNight:GetcdmonFont2())
  slider409:SetPoint("TOPRIGHT", -10, -70)
  
   local fstring4092 = panel41:CreateFontString("FeralbyNightOptions_4_string4092","OVERLAY","GameFontNormal")
  fstring4092:SetText("cat monitor Frame Font size")
  
  fstring4092:SetPoint("TOPLEFT", 10, -100)
  local slider4092 = CreateFrame("Slider", "$parent_sl4092", panel41, "OptionsSliderTemplate")
  slider4092:SetMinMaxValues(6, 40)
  slider4092:SetValue(tonumber(FeralbyNightdb.cdmonFramefontsize2))
  slider4092:SetValueStep(1)
  slider4092:SetScript("OnValueChanged", function(self) FeralbyNightdb.cdmonFramefontsize2=tostring(self:GetValue()); 
FeralbyNightcdmonFrame2_1:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont2, FeralbyNightdb.cdmonFramefontsize2);
FeralbyNightcdmonFrame2_2:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont2, FeralbyNightdb.cdmonFramefontsize2);
FeralbyNightcdmonFrame2_3:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont2, FeralbyNightdb.cdmonFramefontsize2);
FeralbyNightcdmonFrame2_4:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont2, FeralbyNightdb.cdmonFramefontsize2);
FeralbyNightcdmonFrame2_5:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont2, FeralbyNightdb.cdmonFramefontsize2); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider4092:GetName() .. "Low"]:SetText("6")
  _G[slider4092:GetName() .. "High"]:SetText("40")
  _G[slider4092:GetName() .. "Text"]:SetText(tonumber(FeralbyNightdb.cdmonFramefontsize2))
  slider4092:SetPoint("TOPRIGHT", -10, -100)
  
  
     local fstring410 = panel41:CreateFontString("FeralbyNightOptions_4_string410","OVERLAY","GameFontNormal")
  fstring410:SetText("Bear monitor Frame Font: "..FeralbyNightdb.cdmonFramefont3)
  
  fstring410:SetPoint("TOPLEFT", 10, -130)
  local slider410 = CreateFrame("Slider", "$parent_sl410", panel41, "OptionsSliderTemplate")
  slider410:SetMinMaxValues(1, 30)
  slider410:SetValue(FeralbyNight:GetcdmonFont3())
  slider410:SetValueStep(1)
  slider410:SetScript("OnValueChanged", function(self) FeralbyNight:SetcdmonFont3(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()); fstring410:SetText("Bear monitor Frame Font: "..FeralbyNightdb.cdmonFramefont3)  end)
  _G[slider410:GetName() .. "Low"]:SetText("1")
  _G[slider410:GetName() .. "High"]:SetText("20")
  _G[slider410:GetName() .. "Text"]:SetText(FeralbyNight:GetcdmonFont3())
  slider410:SetPoint("TOPRIGHT", -10, -130)
  
   local fstring4103 = panel41:CreateFontString("FeralbyNightOptions_4_string4103","OVERLAY","GameFontNormal")
  fstring4103:SetText("Bear monitor Frame Font size")
  
  fstring4103:SetPoint("TOPLEFT", 10, -160)
  local slider4103 = CreateFrame("Slider", "$parent_sl4103", panel41, "OptionsSliderTemplate")
  slider4103:SetMinMaxValues(6, 40)
  slider4103:SetValue(tonumber(FeralbyNightdb.cdmonFramefontsize3))
  slider4103:SetValueStep(1)
  slider4103:SetScript("OnValueChanged", function(self) FeralbyNightdb.cdmonFramefontsize3=tostring(self:GetValue()); 
  FeralbyNightcdmonFrame3_1:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont3, FeralbyNightdb.cdmonFramefontsize3);
FeralbyNightcdmonFrame3_2:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont3, FeralbyNightdb.cdmonFramefontsize3);
FeralbyNightcdmonFrame3_3:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont3, FeralbyNightdb.cdmonFramefontsize3);
FeralbyNightcdmonFrame3_4:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont3, FeralbyNightdb.cdmonFramefontsize3);
FeralbyNightcdmonFrame3_5:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.cdmonFramefont3, FeralbyNightdb.cdmonFramefontsize3);
   _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider4103:GetName() .. "Low"]:SetText("6")
  _G[slider4103:GetName() .. "High"]:SetText("40")
  _G[slider4103:GetName() .. "Text"]:SetText(tonumber(FeralbyNightdb.cdmonFramefontsize3))
  slider4103:SetPoint("TOPRIGHT", -10, -160)
  
  
  
     local fstring412 = panel41:CreateFontString("FeralbyNightOptions_4_string412","OVERLAY","GameFontNormal")
  fstring412:SetText("Hud Font: "..FeralbyNightdb.barfont)
  
  fstring412:SetPoint("TOPLEFT", 10, -190)
  local slider412 = CreateFrame("Slider", "$parent_sl412", panel41, "OptionsSliderTemplate")
  slider412:SetMinMaxValues(1, 30)
  slider412:SetValue(FeralbyNight:GetbarFont())
  slider412:SetValueStep(1)
  slider412:SetScript("OnValueChanged", function(self) FeralbyNight:SetbarFont(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()); fstring412:SetText("Hud Font: "..FeralbyNightdb.barfont)  end)
  _G[slider412:GetName() .. "Low"]:SetText("1")
  _G[slider412:GetName() .. "High"]:SetText("20")
  _G[slider412:GetName() .. "Text"]:SetText(FeralbyNight:GetbarFont())
  slider412:SetPoint("TOPRIGHT", -10, -190)
  
   local fstring4123 = panel41:CreateFontString("FeralbyNightOptions_4_string4123","OVERLAY","GameFontNormal")
  fstring4123:SetText("Hud Font size")
  
  fstring4123:SetPoint("TOPLEFT", 10, -220)
  local slider4123 = CreateFrame("Slider", "$parent_sl4123", panel41, "OptionsSliderTemplate")
  slider4123:SetMinMaxValues(6, 40)
  slider4123:SetValue(tonumber(FeralbyNightdb.barfontsize))
  slider4123:SetValueStep(1)
  slider4123:SetScript("OnValueChanged", function(self) FeralbyNightdb.barfontsize=tostring(self:GetValue()); 
FeralbyNight.hudFrame_manabar.text:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize);
FeralbyNight.hudFrame_threatbar.text:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize);
FeralbyNight.hudFrame_castbar.text:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize);
FeralbyNight.hudFrame_bosspowerbar.text:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize);
FeralbyNight.hudFrame_healthbar.text:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize);
FeralbyNight.hudFrame_bosshealthbar.text:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize);
FeralbyNight.hudFrame_powerbar.text:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.barfont, FeralbyNightdb.barfontsize);
_G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider4123:GetName() .. "Low"]:SetText("6")
  _G[slider4123:GetName() .. "High"]:SetText("40")
  _G[slider4123:GetName() .. "Text"]:SetText(tonumber(FeralbyNightdb.barfontsize))
  slider4123:SetPoint("TOPRIGHT", -10, -220)
  
   local fstring4124 = panel41:CreateFontString("FeralbyNightOptions_4_string4124","OVERLAY","GameFontNormal")
  fstring4124:SetText("Hud Bar texture: "..FeralbyNightdb.bartexture)
  
  fstring4124:SetPoint("TOPLEFT", 10, -250)
  local slider4124 = CreateFrame("Slider", "$parent_sl4123", panel41, "OptionsSliderTemplate")
  slider4124:SetMinMaxValues(1, 62)
  slider4124:SetValue(FeralbyNight:Getbartexture())
  slider4124:SetValueStep(1)
  slider4124:SetScript("OnValueChanged", function(self) FeralbyNight:Setbartexture(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()); fstring4124:SetText("Hud Bar texture: "..FeralbyNightdb.bartexture)  end)  
  _G[slider4124:GetName() .. "Low"]:SetText("1")
  _G[slider4124:GetName() .. "High"]:SetText("62")
  _G[slider4124:GetName() .. "Text"]:SetText(FeralbyNight:Getbartexture())
  slider4124:SetPoint("TOPRIGHT", -10, -250)
  
 
  
  InterfaceOptions_AddCategory(panel);
   InterfaceOptions_AddCategory(panel2);
   InterfaceOptions_AddCategory(panel21);
  InterfaceOptions_AddCategory(panel3);
  InterfaceOptions_AddCategory(panel4);
  InterfaceOptions_AddCategory(panel41);


end

 function FeralbyNight:CreateOptionFrame1()

  local panel1 = CreateFrame("FRAME", "$parent_1",FeralbyNightOptions);
  panel1.name = "Cycle Options";
  panel1.parent="Feral by Night";
 
  --Panel 1: Cycle Options
  local fstring3 = panel1:CreateFontString("FeralbyNightOptions_1_string3","OVERLAY","GameFontNormal")
  fstring3:SetText("Check if other players keep mangle-debuff active")
  fstring3:SetPoint("TOPLEFT", 10, -10)
  local checkbox3 = CreateFrame("CheckButton", "$parent_cb3", panel1, "OptionsCheckButtonTemplate")
  checkbox3:SetWidth(18)
  checkbox3:SetHeight(18)
  checkbox3:SetScript("OnClick", function() FeralbyNight:Togglemanglebot() end)
  checkbox3:SetPoint("TOPRIGHT", -10, -10)
  checkbox3:SetChecked(FeralbyNight:Getmanglebot())
  
  local fstring4 = panel1:CreateFontString("FeralbyNightOptions_1_string4","OVERLAY","GameFontNormal")
  fstring4:SetText("Suggest FFF")
  fstring4:SetPoint("TOPLEFT", 10, -40)
  local checkbox4 = CreateFrame("CheckButton", "$parent_cb4", panel1, "OptionsCheckButtonTemplate")
  checkbox4:SetWidth(18)
  checkbox4:SetHeight(18)
  checkbox4:SetScript("OnClick", function() FeralbyNight:ToggleFFF() end)
  checkbox4:SetPoint("TOPRIGHT", -10, -40)
  checkbox4:SetChecked(FeralbyNight:GetFFF())
  
  local fstring5 = panel1:CreateFontString("FeralbyNightOptions_1_string5","OVERLAY","GameFontNormal")
  fstring5:SetText("Savage Roar Minimum Refresh CP")
  fstring5:SetPoint("TOPLEFT", 10, -70)
  local slider1 = CreateFrame("Slider", "$parent_sl1", panel1, "OptionsSliderTemplate")
  slider1:SetMinMaxValues(1, 5)
  slider1:SetValue(FeralbyNight:GetSRCP())
  slider1:SetValueStep(1)
  slider1:SetScript("OnValueChanged", function(self) FeralbyNight:SetSRCP(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider1:GetName() .. "Low"]:SetText("1")
  _G[slider1:GetName() .. "High"]:SetText("5")
  _G[slider1:GetName() .. "Text"]:SetText(FeralbyNight:GetSRCP())
  slider1:SetPoint("TOPRIGHT", -10, -70)
  
    local fstring7 = panel1:CreateFontString("FeralbyNightOptions_1_string7","OVERLAY","GameFontNormal")
  fstring7:SetText("Suggest Berserk")
  fstring7:SetPoint("TOPLEFT", 10, -100)
  local checkbox5 = CreateFrame("CheckButton", "$parent_cb5", panel1, "OptionsCheckButtonTemplate")
  checkbox5:SetWidth(18)
  checkbox5:SetHeight(18)
  checkbox5:SetScript("OnClick", function() FeralbyNight:ToggleBerserk() end)
  checkbox5:SetPoint("TOPRIGHT", -10, -100)
  checkbox5:SetChecked(FeralbyNight:GetBerserk())
  

    local fstring8 = panel1:CreateFontString("FeralbyNightOptions_1_string8","OVERLAY","GameFontNormal")
  fstring8:SetText("Use Shred (if efficient)")
  fstring8:SetPoint("TOPLEFT", 10, -130)
  local checkbox55 = CreateFrame("CheckButton", "$parent_cb55", panel1, "OptionsCheckButtonTemplate")
  checkbox55:SetWidth(18)
  checkbox55:SetHeight(18)
  checkbox55:SetScript("OnClick", function() FeralbyNight:ToggleShred() end)
  checkbox55:SetPoint("TOPRIGHT", -10, -130)
  checkbox55:SetChecked(FeralbyNight:GetShred())
  
  
      local fstring77 = panel1:CreateFontString("FeralbyNightOptions_1_string77","OVERLAY","GameFontNormal")
  fstring77:SetText("Toggle kill mode (avoid rip/rake at target low hp)")
  fstring77:SetPoint("TOPLEFT", 10, -160)
  local checkbox77 = CreateFrame("CheckButton", "$parent_cb77", panel1, "OptionsCheckButtonTemplate")
  checkbox77:SetWidth(18)
  checkbox77:SetHeight(18)
  checkbox77:SetScript("OnClick", function() FeralbyNight:Togglekillmode() end)
  checkbox77:SetPoint("TOPRIGHT", -10, -160)
  checkbox77:SetChecked(FeralbyNight:Getkillmode())
  
  
   local fstring78 = panel1:CreateFontString("FeralbyNightOptions_1_string78","OVERLAY","GameFontNormal")
  fstring78:SetText("Set time to die sample interval")
  fstring78:SetPoint("TOPLEFT", 10, -190)
  local slider78 = CreateFrame("Slider", "$parent_sl78", panel1, "OptionsSliderTemplate")
  slider78:SetMinMaxValues(2, 30)
  slider78:SetValue(FeralbyNight:Getkillmodeupdateinterval())
  slider78:SetValueStep(1)
  slider78:SetScript("OnValueChanged", function(self) FeralbyNight:Setkillmodeupdateinterval(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider78:GetName() .. "Low"]:SetText("2")
  _G[slider78:GetName() .. "High"]:SetText("30")
  _G[slider78:GetName() .. "Text"]:SetText(FeralbyNight:Getkillmodeupdateinterval())
  slider78:SetPoint("TOPRIGHT", -10, -190)
  
        local fstring771 = panel1:CreateFontString("FeralbyNightOptions_1_string771","OVERLAY","GameFontNormal")
  fstring771:SetText("Toggle interrupt (use maim/bash if the target is casting)")
  fstring771:SetPoint("TOPLEFT", 10, -220)
  local checkbox771 = CreateFrame("CheckButton", "$parent_cb771", panel1, "OptionsCheckButtonTemplate")
  checkbox771:SetWidth(18)
  checkbox771:SetHeight(18)
  checkbox771:SetScript("OnClick", function() FeralbyNight:Toggleinterrupt() end)
  checkbox771:SetPoint("TOPRIGHT", -10, -220)
  checkbox771:SetChecked(FeralbyNight:Getinterrupt())
  
   local fstring781 = panel1:CreateFontString("FeralbyNightOptions_1_string781","OVERLAY","GameFontNormal")
  fstring781:SetText("Set minimum cast time to interrupt")
  fstring781:SetPoint("TOPLEFT", 10, -250)
  local slider781 = CreateFrame("Slider", "$parent_sl781", panel1, "OptionsSliderTemplate")
  slider781:SetMinMaxValues(0.5, 5)
  slider781:SetValue(FeralbyNight:Getinterruptinterval())
  slider781:SetValueStep(0.5)
  slider781:SetScript("OnValueChanged", function(self) FeralbyNight:Setinterruptinterval(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider781:GetName() .. "Low"]:SetText("0.5")
  _G[slider781:GetName() .. "High"]:SetText("5")
  _G[slider781:GetName() .. "Text"]:SetText(FeralbyNight:Getinterruptinterval())
  slider781:SetPoint("TOPRIGHT", -10, -250)
  
  
   local fstring782 = panel1:CreateFontString("FeralbyNightOptions_1_string782","OVERLAY","GameFontNormal")
  fstring782:SetText("Set energy pooling magnitude")
  fstring782:SetPoint("TOPLEFT", 10, -280)
  local slider782 = CreateFrame("Slider", "$parent_sl782", panel1, "OptionsSliderTemplate")
  slider782:SetMinMaxValues(0, 4)
  slider782:SetValue(FeralbyNight:Getenergypooling())
  slider782:SetValueStep(1)
  slider782:SetScript("OnValueChanged", function(self) FeralbyNight:Setenergypooling(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider782:GetName() .. "Low"]:SetText("Low")
  _G[slider782:GetName() .. "High"]:SetText("Hight")
  _G[slider782:GetName() .. "Text"]:SetText(FeralbyNight:Getenergypooling())
  slider782:SetPoint("TOPRIGHT", -10, -280)
  
     local fstring783 = panel1:CreateFontString("FeralbyNightOptions_1_string783","OVERLAY","GameFontNormal")
  fstring783:SetText("Set wanted RIP uptime")
  fstring783:SetPoint("TOPLEFT", 10, -310)
  local slider783 = CreateFrame("Slider", "$parent_sl783", panel1, "OptionsSliderTemplate")
  slider783:SetMinMaxValues(0.2, 10)
  slider783:SetValue(FeralbyNight:Getripvsfb())
  slider783:SetValueStep(0.2)
  slider783:SetScript("OnValueChanged", function(self) FeralbyNight:Setripvsfb(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider783:GetName() .. "Low"]:SetText("Min")
  _G[slider783:GetName() .. "High"]:SetText("Max")
  _G[slider783:GetName() .. "Text"]:SetText(FeralbyNight:Getripvsfb())
  slider783:SetPoint("TOPRIGHT", -10, -310)
  
     local fstring784 = panel1:CreateFontString("FeralbyNightOptions_1_string784","OVERLAY","GameFontNormal")
  fstring784:SetText("Set SR priority")
  fstring784:SetPoint("TOPLEFT", 10, -340)
  local slider784 = CreateFrame("Slider", "$parent_sl784", panel1, "OptionsSliderTemplate")
  slider784:SetMinMaxValues(0, 3)
  slider784:SetValue(FeralbyNight:Getsrvsfinisher())
  slider784:SetValueStep(0.2)
  slider784:SetScript("OnValueChanged", function(self) FeralbyNight:Setsrvsfinisher(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider784:GetName() .. "Low"]:SetText("Low")
  _G[slider784:GetName() .. "High"]:SetText("High")
  _G[slider784:GetName() .. "Text"]:SetText(FeralbyNight:Getsrvsfinisher())
  slider784:SetPoint("TOPRIGHT", -10, -340)
  
     local fstring785 = panel1:CreateFontString("FeralbyNightOptions_1_string785","OVERLAY","GameFontNormal")
  fstring785:SetText("Set DPE % difference to avoid rake")
  fstring785:SetPoint("TOPLEFT", 10, -370)
  local slider785 = CreateFrame("Slider", "$parent_sl785", panel1, "OptionsSliderTemplate")
  slider785:SetMinMaxValues(0, 2)
  slider785:SetValue(FeralbyNight:Getshredvsrake())
  slider785:SetValueStep(0.05)
  slider785:SetScript("OnValueChanged", function(self) FeralbyNight:Setshredvsrake(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider785:GetName() .. "Low"]:SetText("always rake")
  _G[slider785:GetName() .. "High"]:SetText("always shred")
  _G[slider785:GetName() .. "Text"]:SetText(FeralbyNight:Getshredvsrake())
  slider785:SetPoint("TOPRIGHT", -10, -370)
  
     local fstring786 = panel1:CreateFontString("FeralbyNightOptions_1_string786","OVERLAY","GameFontNormal")
  fstring786:SetText("Prioritize Mangle")
  fstring786:SetPoint("TOPLEFT", 10, -400)
  local slider786 = CreateFrame("Slider", "$parent_sl786", panel1, "OptionsSliderTemplate")
  slider786:SetMinMaxValues(0, 2)
  slider786:SetValue(FeralbyNight:Getmanglepriority())
  slider786:SetValueStep(1)
  slider786:SetScript("OnValueChanged", function(self) FeralbyNight:Setmanglepriority(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider786:GetName() .. "Low"]:SetText("Never")
  _G[slider786:GetName() .. "High"]:SetText("Always")
  _G[slider786:GetName() .. "Text"]:SetText(FeralbyNight:Getmanglepriority())
  slider786:SetPoint("TOPRIGHT", -10, -400)
     
    InterfaceOptions_AddCategory(panel1);
  
  end

      --Panel 5: Boss Mod Options
      
      function FeralbyNight:CreateOptionFrame5()
     local panel5 = CreateFrame("FRAME", "$parent_5",FeralbyNightOptions);
  panel5.name = "Boss Mod Options";
   panel5.parent="Feral by Night";
   
     local panel_ulduar = CreateFrame("FRAME", "$parent_ulduar",FeralbyNightOptions_5);
  panel_ulduar.name = "Boss Mod Options Ulduar";
   panel_ulduar.parent="Boss Mod Options";
      
           local fstring2222 = panel5:CreateFontString("FeralbyNightOptions_5_string2222","OVERLAY","GameFontNormal")
  fstring2222:SetText("Show fight specific player Monitor")
  fstring2222:SetPoint("TOPLEFT", 10, -10)
  local checkbox2222 = CreateFrame("CheckButton", "$parent_cb2222", panel5, "OptionsCheckButtonTemplate")
  checkbox2222:SetWidth(18)
  checkbox2222:SetHeight(18)
  checkbox2222:SetScript("OnClick", function() FeralbyNight:Togglemyfight() end)
  checkbox2222:SetPoint("TOPRIGHT", -10, -10)
  checkbox2222:SetChecked(FeralbyNight:Getmyfightshow())
  
    local fstring2223 = panel5:CreateFontString("FeralbyNightOptions_5_string2223","OVERLAY","GameFontNormal")
  fstring2223:SetText("Show fight specific boss Monitor")
  fstring2223:SetPoint("TOPLEFT", 10, -40)
  local checkbox2223 = CreateFrame("CheckButton", "$parent_cb2223", panel5, "OptionsCheckButtonTemplate")
  checkbox2223:SetWidth(18)
  checkbox2223:SetHeight(18)
  checkbox2223:SetScript("OnClick", function() FeralbyNight:Togglebossfight() end)
  checkbox2223:SetPoint("TOPRIGHT", -10, -40)
  checkbox2223:SetChecked(FeralbyNight:Getbossfightshow())

      
    local fstring8888 = panel5:CreateFontString("FeralbyNightOptions_5_string8888","OVERLAY","GameFontNormal")
  fstring8888:SetText("Fight specific player Monitor Scale")
  fstring8888:SetPoint("TOPLEFT", 10, -70)
  local slider3888 = CreateFrame("Slider", "$parent_sl3888", panel5, "OptionsSliderTemplate")
  slider3888:SetMinMaxValues(.25, 2.0)
  slider3888:SetValue(FeralbyNight:GetmyfightScale())
  slider3888:SetValueStep(.05)
  slider3888:SetScript("OnValueChanged", function(self) FeralbyNight:SetmyfightScale(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue())  end)
  _G[slider3888:GetName() .. "Low"]:SetText("0.25")
  _G[slider3888:GetName() .. "High"]:SetText("2.0")
  _G[slider3888:GetName() .. "Text"]:SetText(FeralbyNight:GetmyfightScale())
  slider3888:SetPoint("TOPRIGHT", -10, -70)
  
      local fstring8889 = panel5:CreateFontString("FeralbyNightOptions_5_string8889","OVERLAY","GameFontNormal")
  fstring8889:SetText("Fight specific boss Monitor Scale")
  fstring8889:SetPoint("TOPLEFT", 10, -110)
  local slider3889 = CreateFrame("Slider", "$parent_sl3889", panel5, "OptionsSliderTemplate")
  slider3889:SetMinMaxValues(.25, 2.0)
  slider3889:SetValue(FeralbyNight:GetbossfightScale())
  slider3889:SetValueStep(.05)
  slider3889:SetScript("OnValueChanged", function(self) FeralbyNight:SetbossfightScale(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue())  end)
  _G[slider3889:GetName() .. "Low"]:SetText("0.25")
  _G[slider3889:GetName() .. "High"]:SetText("2.0")
  _G[slider3889:GetName() .. "Text"]:SetText(FeralbyNight:GetbossfightScale())
  slider3889:SetPoint("TOPRIGHT", -10, -110)
  
     local fstring506 = panel5:CreateFontString("FeralbyNightOptions_5_string506","OVERLAY","GameFontNormal")
  fstring506:SetText("boss fight buff/debuff Frame Font: "..FeralbyNightdb.bossfightFramefont)
  
  fstring506:SetPoint("TOPLEFT", 10, -140)
  local slider506 = CreateFrame("Slider", "$parent_sl506", panel5, "OptionsSliderTemplate")
  slider506:SetMinMaxValues(1, 20)
  slider506:SetValue(FeralbyNight:GetbossfightFont())
  slider506:SetValueStep(1)
  slider506:SetScript("OnValueChanged", function(self) FeralbyNight:SetbossfightFont(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()); fstring506:SetText("boss fight buff/debuff Frame Font: "..FeralbyNightdb.bossfightFramefont)  end)
  _G[slider506:GetName() .. "Low"]:SetText("1")
  _G[slider506:GetName() .. "High"]:SetText("20")
  _G[slider506:GetName() .. "Text"]:SetText(FeralbyNight:GetbossfightFont())
  slider506:SetPoint("TOPRIGHT", -10, -140)
  
   local fstring5062 = panel5:CreateFontString("FeralbyNightOptions_5_string5062","OVERLAY","GameFontNormal")
  fstring5062:SetText("boss fight buff/debuff Frame Font size")
  
  fstring5062:SetPoint("TOPLEFT", 10, -170)
  local slider5062 = CreateFrame("Slider", "$parent_sl5062", panel5, "OptionsSliderTemplate")
  slider5062:SetMinMaxValues(6, 40)
  slider5062:SetValue(tonumber(FeralbyNightdb.bossfightFramefontsize))
  slider5062:SetValueStep(1)
  slider5062:SetScript("OnValueChanged", function(self) FeralbyNightdb.bossfightFramefontsize=tostring(self:GetValue()); 
  do jj=1,5
  local bossfightFramedumb = _G["FeralbyNightbossfightFrame_"..jj];
  bossfightFramedumb:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.bossfightFramefont, FeralbyNightdb.bossfightFramefontsize);
  end; _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider5062:GetName() .. "Low"]:SetText("6")
  _G[slider5062:GetName() .. "High"]:SetText("50")
  _G[slider5062:GetName() .. "Text"]:SetText(tonumber(FeralbyNightdb.bossfightFramefontsize))
  slider5062:SetPoint("TOPRIGHT", -10, -170)
  
  
  
  
     local fstring507 = panel5:CreateFontString("FeralbyNightOptions_5_string507","OVERLAY","GameFontNormal")
  fstring507:SetText("my fight buff/debuff Frame Font: "..FeralbyNightdb.myfightFramefont)
  
  fstring507:SetPoint("TOPLEFT", 10, -200)
  local slider507 = CreateFrame("Slider", "$parent_sl507", panel5, "OptionsSliderTemplate")
  slider507:SetMinMaxValues(1, 20)
  slider507:SetValue(FeralbyNight:GetmyfightFont())
  slider507:SetValueStep(1)
  slider507:SetScript("OnValueChanged", function(self) FeralbyNight:SetmyfightFont(self:GetValue()); _G[self:GetName() .. "Text"]:SetText(self:GetValue()); fstring507:SetText("my fight buff/debuff Frame Font: "..FeralbyNightdb.myfightFramefont)  end)
  _G[slider507:GetName() .. "Low"]:SetText("1")
  _G[slider507:GetName() .. "High"]:SetText("20")
  _G[slider507:GetName() .. "Text"]:SetText(FeralbyNight:GetmyfightFont())
  slider507:SetPoint("TOPRIGHT", -10, -200)
  
   local fstring5072 = panel5:CreateFontString("FeralbyNightOptions_5_string5072","OVERLAY","GameFontNormal")
  fstring5072:SetText("my fight buff/debuff Frame Font size")
  
  local fstring5072 = panel5:CreateFontString("FeralbyNightOptions_5_string5072","OVERLAY","GameFontNormal")
  fstring5072:SetText("my fight buff/debuff Frame Font size")
  
  fstring5072:SetPoint("TOPLEFT", 10, -230)
  local slider5072 = CreateFrame("Slider", "$parent_sl5072", panel5, "OptionsSliderTemplate")
  slider5072:SetMinMaxValues(6, 40)
  slider5072:SetValue(tonumber(FeralbyNightdb.myfightFramefontsize))
  slider5072:SetValueStep(1)
  slider5072:SetScript("OnValueChanged", function(self) FeralbyNightdb.myfightFramefontsize=tostring(self:GetValue()); 
  do jj=1,5
  local myfightFramedumb = _G["FeralbyNightmyfightFrame_"..jj];
  myfightFramedumb:SetFont("Interface\\AddOns\\FeralbyNight\\arts\\fonts\\"..FeralbyNightdb.myfightFramefont, FeralbyNightdb.myfightFramefontsize);
  end; _G[self:GetName() .. "Text"]:SetText(self:GetValue()) end)
  _G[slider5072:GetName() .. "Low"]:SetText("6")
  _G[slider5072:GetName() .. "High"]:SetText("50")
  _G[slider5072:GetName() .. "Text"]:SetText(tonumber(FeralbyNightdb.myfightFramefontsize))
  slider5072:SetPoint("TOPRIGHT", -10, -230)
  
             local fstring5000 = panel_ulduar:CreateFontString("FeralbyNightOptions_5_string5000","OVERLAY","GameFontNormal")
  fstring5000:SetText("Interrupt chain lightning (Razorscale)")
  fstring5000:SetPoint("TOPLEFT", 10, -10)
  local checkbox5000 = CreateFrame("CheckButton", "$parent_cb5000", panel_ulduar, "OptionsCheckButtonTemplate")
  checkbox5000:SetWidth(18)
  checkbox5000:SetHeight(18)
  checkbox5000:SetScript("OnClick", function() FeralbyNight:Togglerazorchain() end)
  checkbox5000:SetPoint("TOPRIGHT", -10, -10)
  checkbox5000:SetChecked(FeralbyNight:Getrazorchain())
  
  local fstring5001 = panel_ulduar:CreateFontString("FeralbyNightOptions_5_string5001","OVERLAY","GameFontNormal")
  fstring5001:SetText("Interrupt chain lightning (Council)")
  fstring5001:SetPoint("TOPLEFT", 10, -40)
  local checkbox5001 = CreateFrame("CheckButton", "$parent_cb5001", panel_ulduar, "OptionsCheckButtonTemplate")
  checkbox5001:SetWidth(18)
  checkbox5001:SetHeight(18)
  checkbox5001:SetScript("OnClick", function() FeralbyNight:Togglestormchain() end)
  checkbox5001:SetPoint("TOPRIGHT", -10, -40)
  checkbox5001:SetChecked(FeralbyNight:Getstormchain())
  
               local fstring5002 = panel_ulduar:CreateFontString("FeralbyNightOptions_5_string5002","OVERLAY","GameFontNormal")
  fstring5002:SetText("Interrupt lightning whirlwind (Council)")
  fstring5002:SetPoint("TOPLEFT", 10, -70)
  local checkbox5002 = CreateFrame("CheckButton", "$parent_cb5002", panel_ulduar, "OptionsCheckButtonTemplate")
  checkbox5002:SetWidth(18)
  checkbox5002:SetHeight(18)
  checkbox5002:SetScript("OnClick", function() FeralbyNight:Togglestormwhirl() end)
  checkbox5002:SetPoint("TOPRIGHT", -10, -70)
  checkbox5002:SetChecked(FeralbyNight:Getstormwhirl())
  
               local fstring5003 = panel_ulduar:CreateFontString("FeralbyNightOptions_5_string5003","OVERLAY","GameFontNormal")
  fstring5003:SetText("Interrupt sentinel blast")
  fstring5003:SetPoint("TOPLEFT", 10, -110)
  local checkbox5003 = CreateFrame("CheckButton", "$parent_cb5003", panel_ulduar, "OptionsCheckButtonTemplate")
  checkbox5003:SetWidth(18)
  checkbox5003:SetHeight(18)
  checkbox5003:SetScript("OnClick", function() FeralbyNight:Togglesentinelblast() end)
  checkbox5003:SetPoint("TOPRIGHT", -10, -110)
  checkbox5003:SetChecked(FeralbyNight:Getsentinelblast())
  
               local fstring5004 = panel_ulduar:CreateFontString("FeralbyNightOptions_5_string5004","OVERLAY","GameFontNormal")
  fstring5004:SetText("Interrupt Greater Heal (Thorim)")
  fstring5004:SetPoint("TOPLEFT", 10, -140)
  local checkbox5004 = CreateFrame("CheckButton", "$parent_cb5004", panel_ulduar, "OptionsCheckButtonTemplate")
  checkbox5004:SetWidth(18)
  checkbox5004:SetHeight(18)
  checkbox5004:SetScript("OnClick", function() FeralbyNight:TogglethorimGL() end)
  checkbox5004:SetPoint("TOPRIGHT", -10, -140)
  checkbox5004:SetChecked(FeralbyNight:GetthorimGL())
  
               local fstring5005 = panel_ulduar:CreateFontString("FeralbyNightOptions_5_string5005","OVERLAY","GameFontNormal")
  fstring5005:SetText("Interrupt Runic Mending (Thorim)")
  fstring5005:SetPoint("TOPLEFT", 10, -170)
  local checkbox5005 = CreateFrame("CheckButton", "$parent_cb5005", panel_ulduar, "OptionsCheckButtonTemplate")
  checkbox5005:SetWidth(18)
  checkbox5005:SetHeight(18)
  checkbox5005:SetScript("OnClick", function() FeralbyNight:TogglethorimRM() end)
  checkbox5005:SetPoint("TOPRIGHT", -10, -170)
  checkbox5005:SetChecked(FeralbyNight:GetthorimRM())
  
  
               local fstring5006 = panel_ulduar:CreateFontString("FeralbyNightOptions_5_string5006","OVERLAY","GameFontNormal")
  fstring5006:SetText("Interrupt Searing Flame")
  fstring5006:SetPoint("TOPLEFT", 10, -200)
  local checkbox5006 = CreateFrame("CheckButton", "$parent_cb5006", panel_ulduar, "OptionsCheckButtonTemplate")
  checkbox5006:SetWidth(18)
  checkbox5006:SetHeight(18)
  checkbox5006:SetScript("OnClick", function() FeralbyNight:Toggletsearingflame() end)
  checkbox5006:SetPoint("TOPRIGHT", -10, -200)
  checkbox5006:SetChecked(FeralbyNight:Getsearingflame())
  
  
               local fstring5007 = panel_ulduar:CreateFontString("FeralbyNightOptions_5_string5007","OVERLAY","GameFontNormal")
  fstring5007:SetText("Interrupt Dark Volley")
  fstring5007:SetPoint("TOPLEFT", 10, -230)
  local checkbox5007 = CreateFrame("CheckButton", "$parent_cb5007", panel_ulduar, "OptionsCheckButtonTemplate")
  checkbox5007:SetWidth(18)
  checkbox5007:SetHeight(18)
  checkbox5007:SetScript("OnClick", function() FeralbyNight:Toggledarkvolley() end)
  checkbox5007:SetPoint("TOPRIGHT", -10, -230)
  checkbox5007:SetChecked(FeralbyNight:Getdarkvolley())
  
  
                 local fstring5020 = panel_ulduar:CreateFontString("FeralbyNightOptions_5_string5020","OVERLAY","GameFontNormal")
  fstring5020:SetText("Interrupt Drain Life")
  fstring5020:SetPoint("TOPLEFT", 10, -260)
  local checkbox5020 = CreateFrame("CheckButton", "$parent_cb5020", panel_ulduar, "OptionsCheckButtonTemplate")
  checkbox5020:SetWidth(18)
  checkbox5020:SetHeight(18)
  checkbox5020:SetScript("OnClick", function() FeralbyNight:Toggledrainlife() end)
  checkbox5020:SetPoint("TOPRIGHT", -10, -260)
  checkbox5020:SetChecked(FeralbyNight:Getdrainlife())
  
               local fstring5008 = panel_ulduar:CreateFontString("FeralbyNightOptions_5_string5008","OVERLAY","GameFontNormal")
  fstring5008:SetText("Save Berserk for Heart phase")
  fstring5008:SetPoint("TOPLEFT", 10, -290)
  local checkbox5008 = CreateFrame("CheckButton", "$parent_cb5008", panel_ulduar, "OptionsCheckButtonTemplate")
  checkbox5008:SetWidth(18)
  checkbox5008:SetHeight(18)
  checkbox5008:SetScript("OnClick", function() FeralbyNight:Togglesaveforheart() end)
  checkbox5008:SetPoint("TOPRIGHT", -10, -290)
  checkbox5008:SetChecked(FeralbyNight:Getsaveforheart())
  
  
               local fstring5009 = panel_ulduar:CreateFontString("FeralbyNightOptions_5_string5009","OVERLAY","GameFontNormal")
  fstring5009:SetText("Save Berserk for Razorscale chained phase")
  fstring5009:SetPoint("TOPLEFT", 10, -320)
  local checkbox5009 = CreateFrame("CheckButton", "$parent_cb5009", panel_ulduar, "OptionsCheckButtonTemplate")
  checkbox5009:SetWidth(18)
  checkbox5009:SetHeight(18)
  checkbox5009:SetScript("OnClick", function() FeralbyNight:Togglesaveforrazor() end)
  checkbox5009:SetPoint("TOPRIGHT", -10, -320)
  checkbox5009:SetChecked(FeralbyNight:Getsaveforrazor())
  
                local fstring5009 = panel_ulduar:CreateFontString("FeralbyNightOptions_5_string5009","OVERLAY","GameFontNormal")
  fstring5009:SetText("Save Berserk for Razorscale chained phase")
  fstring5009:SetPoint("TOPLEFT", 10, -350)
  local checkbox5009 = CreateFrame("CheckButton", "$parent_cb5009", panel_ulduar, "OptionsCheckButtonTemplate")
  checkbox5009:SetWidth(18)
  checkbox5009:SetHeight(18)
  checkbox5009:SetScript("OnClick", function() FeralbyNight:Togglesaveforrazor() end)
  checkbox5009:SetPoint("TOPRIGHT", -10, -350)
  checkbox5009:SetChecked(FeralbyNight:Getsaveforrazor())
 
 
                 local fstring5030 = panel_ulduar:CreateFontString("FeralbyNightOptions_5_string5030","OVERLAY","GameFontNormal")
  fstring5030:SetText("Don't use shred on Yogg-Saron tentacles")
  fstring5030:SetPoint("TOPLEFT", 10, -380)
  local checkbox5030 = CreateFrame("CheckButton", "$parent_cb5030", panel_ulduar, "OptionsCheckButtonTemplate")
  checkbox5030:SetWidth(18)
  checkbox5030:SetHeight(18)
  checkbox5030:SetScript("OnClick", function() FeralbyNight:Toggleshredontentacles() end)
  checkbox5030:SetPoint("TOPRIGHT", -10, -380)
  checkbox5030:SetChecked(FeralbyNight:Getshredontentacles()) 
  
  
  InterfaceOptions_AddCategory(panel5);
    InterfaceOptions_AddCategory(panel_ulduar);

end

function FeralbyNight.Options()
  InterfaceOptionsFrame_OpenToCategory(_G["FeralbyNightOptions"])
end