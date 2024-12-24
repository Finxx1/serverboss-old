crackedgift:
  type: item
  material: paper
  display name: <element[「「「Cracked Gift」」」].color_gradient[from=#500030;to=#902070]>
  enchantments:
  - infinity:1
  mechanisms:
    hides: all
    custom_model_data: 13375508
  lore:
  - <element[-=-= The Highest Tier... =-=-].color_gradient[from=#300010;to=#500030]>
  - <&7>
  - <element[CRACKED].color[#700050].bold>

vintagegift:
  type: item
  material: paper
  display name: <element[Vintage Gift].color_gradient[from=#404878;to=#606898]>
  mechanisms:
    hides: all
    custom_model_data: 13375506
  lore:
  - <element[By your side].color_gradient[from=#20243C;to=#30344C]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

unusualgift:
  type: item
  material: paper
  display name: <element[「Unusual Gift」].color_gradient[from=#7020A0;to=#B060E0]>
  enchantments:
  - infinity:1
  mechanisms:
    hides: all
    custom_model_data: 13375505
  lore:
  - <element[-= Free Gift! =-].color_gradient[from=#500080;to=#7020A0]>
  - <&7>
  - <element[UNUSUAL].color[#9040C0].bold>

genuinegift:
  type: item
  material: paper
  display name: <element[Genuine Gift].color_gradient[from=#206030;to=#40A070]>
  mechanisms:
    hides: all
    custom_model_data: 13375503
  lore:
  - <element[It's like shovelware, but real!].color_gradient[from=#103018;to=#305038]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

uniquegift:
  type: item
  material: paper
  display name: <element[Unique Gift].color_gradient[from=#FFEF10;to=#FFFF30]>
  mechanisms:
    hides: all
    custom_model_data: 13375502
  lore:
  - <element[Actually kinda dime-a-dozen].color_gradient[from=#807808;to=#A09828]>
  - <&7>
  - <element[UNIQUE].color[#FFEF10].bold>

normalgift:
  type: item
  material: paper
  display name: <element[Normal Gift].color_gradient[from=#A0A0A0;to=#C0C0C0]>
  mechanisms:
    hides: all
    custom_model_data: 13375500
  lore:
  - <element[Summer Crate #46].color_gradient[from=#505050;to=#707070]>
  - <&7>
  - <element[NORMAL].color[#A0A0A0].bold>

communitygift:
  type: item
  material: paper
  display name: <element[Community Gift].color_gradient[from=#B0E060;to=#D0FF80]>
  mechanisms:
    hides: all
    custom_model_data: 13375504
  lore:
  - <element[You're missing a crystal ball].color_gradient[from=#587030;to=#789050]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

collectorsgift:
  type: item
  material: paper
  display name: <element[Collector's Gift].color_gradient[from=#600000;to=#A02020]>
  mechanisms:
    hides: all
    custom_model_data: 13375507
  lore:
  - <element[Free Souvenir!].color_gradient[from=#400000;to=#600000]>
  - <&7>
  - <element[COLLECTOR'S].color[#800000].bold>

decoratedgift:
  type: item
  material: paper
  display name: <element[Decorated Gift].color_gradient[from=#DFDFDF;to=#FFFFFF]>
  mechanisms:
    hides: all
    custom_model_data: 13375509
  lore:
  - <element[This is why the game exists!].color_gradient[from=#808080;to=#A0A0A0]>
  - <&7>
  - <element[DECORATED].color[#FFFFFF].bold>

strangegift:
  type: item
  material: paper
  display name: <element[Strange Gift].color_gradient[from=#D87840;to=#F89860]>
  mechanisms:
    hides: all
    custom_model_data: 13375501
  lore:
  - <element[To keep track of your sins].color_gradient[from=#6C3C20;to=#8C5C40]>
  - <&7>
  - <element[STRANGE].color[#D87840].bold>

hauntedgift:
  type: item
  material: paper
  display name: <element[Haunted Gift].color_gradient[from=#38F0A8;to=#58FFC8]>
  mechanisms:
    hides: all
    custom_model_data: 13375510
  lore:
  - <element[Spooky!].color_gradient[from=#1C7854;to=#3C9874]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

fuckedgift:
  type: item
  material: paper
  display name: <element[FUCKED].obfuscate.color_gradient[from=#00FFFF;to=#FF0000;style=hsb]><element[ Gift 「「「「].color_gradient[from=#00FFFF;to=#FF0000;style=hsb]>
  mechanisms:
    hides: all
    custom_model_data: 13375511
  lore:
  - <element[???F?fsfs ifyouca  urcecodeor it fucked up  ].obfuscate.color_gradient[from=#FF0000;to=#2000FF;style=hsb]>
  - <&7>
  - <element[HA].color[#38F0A8].bold><element[fDlsdg].obfuscate.color_gradient[from=#FF0000;to=#2FF0FF;style=hsb]><&k.end_format><element[UNL].color[#9040C0].bold><element[fDlsdg].obfuscate.color_gradient[from=#FF0000;to=#2000FF;style=hsb]><&k.end_format><element['S].color[#800000].bold><element[fDlsdg].obfuscate.color_gradient[from=#FF00F0;to=#0000FF;style=hsb]><&k.end_format><element[ED].color[#700050].bold>

reloadloot:
  type: task
  debug: false
  script:
  - playsound sound:custom.reload_correct pitch:0 volume:2 at:<player.location> custom
  - flag server loot_cracked:<list[worldcontrolwand|ikeaticket|lovexcalibur|angelwings|meatballs]>
  - announce <element[Reloaded!].color[#700050]>
  - flag server loot_unusual:<list[anomaloussponge|theworlditem|thehand2|thebucketnerfed|sunsetsea|gloryhammer|epichoe|blingblingsword|grapple]>
  - announce <element[Reloaded!].color[#9040C0]>
  - flag server loot_collectors:<list[redglare|captivators|converter|rubberchicken|chainsaw|moonshoes|tntboots|maneax|icering|zillyhoo|loudcream|ballin|abrose|jokercard|powertool|vampscythe|sickle|lightblade|cybersword|gasoline|saintsrow|powerdash|caledscratch|katana|holymackarel|blingring|cageofwrath|thebible|anarchistcookbook|lotr|necronomicon|homestuck|290000dollar|fork|spoon|knife|thelantern|therock|deadringer|dealmaker|hl1crowbar|jujucrowbar|postalshovel|sledgehammer|zirconiumpants|repulsionplate|philosopherstone|acidbucket|oilbucket|australium|rewindshard|replayshard|firesword|icesword|knightboots|knightleggings|knightchestplate|knighthelmet|knightaxe|knightsword|knightpan|equalizer|kunai]>
  - announce <element[Reloaded!].color[#800000]>
  - flag server loot_community:<list[aries|taurus|gemini|ophiuchus|leo|virgo|libra|scorpio|sagittarius|capricorn|aquarius|pisces|cetus|sol|nullyx]>
# NO OUROBOROS TOO OP
  - announce <element[Reloaded!].color[#B0E060]>
  - flag server loot_vintage:<list[pistol|rifle|shotgun|supershotgun|kitchengun|minigun|olympia|shotcoil|grenadelauncher|rocketlauncher|srsrocketlauncher|ffrocketlauncher|piercer|marksman|sharpshooter|hominggun|sniperrifle|rifle3|weezer|flamethrower|electricrailcannon|screwdriverrailcannon|maliciousrailcannon|taucannon|teslarifle|redrifle|napalmcannon|dnagun|dubstepgun|beegun|microwavegun|pipispopper|flammenwerfer|chaingun|rocketjumper|rocketgrabber|nailgun|betabow|etherealcrossbow|brightweapon|displacercannon|annabelle|bfg9k|nullrifle|perforator|milf|toolgun|uzi|sawedoff|dinnerblaster|glasscannon]>
  - announce <element[Reloaded!].color[#404878]>
  - flag server loot_genuine:<list[1up|3up|starman|crack|pocketsand|pocketfuck|hellfirevial|holycard|fuckingbrick|heartcookie|diamondcookie|spadecookie|clubscookie|dynamite|holydynamite|nucleardynamite|armingdynamite|glassamyte|jumperdynamite|midasdynamite|reactiondynamite|heartscard|diamondscard|spadescard|clubscard|jackcard|kingcard|queencard|voidcard|blankcard|rouxlscard|torncard|scribbledcard|ambrosium|flashbang|24kpotato|stickybomb|jarate|madmilk|nitrojar|ndurian|poisonapple|ipineapple|cbanana|lgrape|betachop|betasteak|pipis|elixirofvitality|elixirofcorruption|elixirofdetonation|elixirofdispelling|elixirofwarping|elixirofinvulnerability|elixirofweightlessness|elixirofoverdrive|elixirofcharisma|elixiroffamishing|elixirofdeluge|elixirofinebriation|elixirofbrutality|elixirofnirvana|elixirofheritage|elixirofcorsucation|elixirofcryomania|elixirofblazing|elixiroffreedom|elixirofxerox|elixirofphantasmagoria|elixirofpandora|serapheye|toaster|toast|kavruka|aimacyst|fraggrenade|incendiarygrenade|smokegrenade|snarks|ballz|dinner]>
  - announce <element[Reloaded!].color[#206030]>
  - flag server loot_strange:<list[celestialclaw|bloodbucket]>
  - announce <element[Reloaded!].color[#D87840]>
  - flag server loot_unique:<list[glasssword|fireaxe|holysword|femboyboots|femboyleggings|femboychestplate|femboyhelmet|quiver|riftaxe|riftmace]>
  - announce <element[Reloaded!].color[#FFEF10]>
  - flag server loot_decorated:<list[disc_iceaxy|disc_apollyon|disc_box|disc_jose|disc_derzox|disc_ikea|disc_keygenmaze|disc_planetarium|disc_heaponsneo|disc_skeleking|disc_stephen|disc_speeder]>
  - announce <element[Reloaded!].color[#FFFFFF]>
  - flag server loot_normal:<list[iron_sword|iron_axe|diamond_sword|diamond_axe|cooked_beef|cooked_porkchop|apple|golden_apple|enchanted_golden_apple|stone_axe|stone_sword|iron_helmet|iron_chestplate|iron_boots|iron_leggings|chainmail_helmet|chainmail_chestplate|chainmail_boots|chainmail_leggings|shield]>
  - announce <element[Reloaded!].color[#A0A0A0]>
  - flag server loot_haunted:<list[sentientsword|devilsknife|devilwings|teslastick|gaussstick|psiwand|twistedsword|thornring|soporpie|skelekingskull|kunai]>

gifttriggers:
  type: world
  debug: false
  events:
    on server start:
    - run reloadloot

    on player right clicks block with:fuckedgift:
    - determine cancelled passively
    - define giftrewardlist <list[<server.flag[loot_cracked]>|<server.flag[loot_unusual]>|<server.flag[loot_haunted]>|<server.flag[loot_collectors]>|<server.flag[loot_community]>|<server.flag[loot_genuine]>|<server.flag[loot_vintage]>|<server.flag[loot_strange]>|<server.flag[loot_unique]>|<server.flag[loot_normal]>]>
    - define rewardget <[giftrewardlist].random>
    - title "title:<element[<list[:SKFJIOD|pddlgfgo|.png.jpeg?].random>SF<list[LETMEGOPLEAS|awanawungus|Magnetic Cir4444.|//set stone].random>  <list[dfd|0(OUF98iszAYf89|zigzag crossmotor|green idea|lf,g,,,].random>].color_gradient[from=#<list[00|40|80|C0|FF].random><list[00|40|80|C0|FF].random><list[00|40|80|C0|FF].random>;to=#<list[00|40|80|C0|FF].random><list[00|40|80|C0|FF].random><list[00|40|80|C0|FF].random>;style=hsb]>" "subtitle:<item[<[rewardget]>].display>" fade_in:0 stay:2s fade_out:10t targets:<player>
    - take <player.inventory> iteminhand quantity:1
    - give <player.inventory> <[rewardget]> quantity:1 slot:hand
    - playeffect effect:FIREWORKS_SPARK at:<player.location> visibility:100 quantity:200 data:0.3 offset:0
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:1 volume:2 at:<player.location>
    - playsound sound:ENTITY_FIREWORK_ROCKET_LARGE_BLAST pitch:1 volume:2 at:<player.location>
    - playsound sound:ENTITY_WITHER_DEATH pitch:2 volume:2 at:<player.location>
    - playsound sound:custom.reload_correct pitch:2 volume:2 at:<player.location> custom
    - playsound sound:custom.reload_correct pitch:1 volume:2 at:<player.location> custom
    - playsound sound:custom.reload_correct pitch:0 volume:2 at:<player.location> custom


    on player right clicks block with:unusualgift:
    - determine cancelled passively
    - define giftrewardlist <server.flag[loot_unusual]>
    - define tr2 <element[0]>
    - foreach <[giftrewardlist]>:
      - if !<player.inventory.contains_item[<[value]>]>:
        - define tr2 <element[1]>
#        - announce <[value]>
#    - announce <[tr2]>
    - if <[tr2]> == 0:
      - title "title:<element[「YOU ARE UNUSUALLY GIFTED!!!」].color_gradient[from=#7020A0;to=#B060E0]>" "subtitle:<element[ALL POSSIBLE REWARDS ALREADY IN INVENTORY].bold.color_gradient[from=#500080;to=#7020A0]>" fade_in:0 stay:0 targets:<player>
      - playsound <player.location> sound:BLOCK_NOTE_BLOCK_BASS pitch:0 v:3
      - playsound sound:custom.reload_error pitch:2 volume:2 at:<player.location> custom
      - playsound sound:custom.reload_error pitch:1 volume:2 at:<player.location> custom
      - playsound sound:custom.reload_error pitch:0 volume:2 at:<player.location> custom
      - stop
    - define rewardget <[giftrewardlist].random>
    - define testresult <element[0]>
    - while <[testresult]> == 0:
      - if <player.inventory.contains_item[<[rewardget]>]>:
        - define rewardget <[giftrewardlist].random>
      - else:
        - define testresult <element[1]>
    - title "title:<element[「YOU ARE UNUSUALLY GIFTED!!!」].color_gradient[from=#7020A0;to=#B060E0]>" "subtitle:<item[<[rewardget]>].display>" fade_in:0 stay:2s fade_out:10t targets:<player>
    - take <player.inventory> iteminhand quantity:1
    - give <player.inventory> <[rewardget]> quantity:1 slot:hand
    - playeffect effect:FIREWORKS_SPARK at:<player.location> visibility:100 quantity:200 data:0.3 offset:0
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:1 volume:2 at:<player.location>
    - playsound sound:ENTITY_FIREWORK_ROCKET_LARGE_BLAST pitch:1 volume:2 at:<player.location>
    - playsound sound:ENTITY_WITHER_DEATH pitch:2 volume:2 at:<player.location>
    - playsound sound:custom.reload_correct pitch:2 volume:2 at:<player.location> custom
    - playsound sound:custom.reload_correct pitch:1 volume:2 at:<player.location> custom
    - playsound sound:custom.reload_correct pitch:0 volume:2 at:<player.location> custom

    on player right clicks block with:crackedgift:
    - determine cancelled passively
    - define giftrewardlist <server.flag[loot_cracked]>
    - define tr2 <element[0]>
    - foreach <[giftrewardlist]>:
      - if !<player.inventory.contains_item[<[value]>]>:
        - define tr2 <element[1]>
#        - announce <[value]>
#    - announce <[tr2]>
    - if <[tr2]> == 0:
      - title "title:<element[「「「YOU ARE CRACKED!!!」」」].color_gradient[from=#500030;to=#902070]>" "subtitle:<element[ALL POSSIBLE REWARDS ALREADY IN INVENTORY].bold.color_gradient[from=#300010;to=#500030]>" fade_in:0 stay:0 targets:<player>
      - playsound <player.location> sound:BLOCK_NOTE_BLOCK_BASS pitch:0 v:3
      - playsound sound:custom.reload_error pitch:2 volume:2 at:<player.location> custom
      - wait 3t
      - playsound sound:custom.reload_error pitch:1 volume:2 at:<player.location> custom
      - wait 3t
      - playsound sound:custom.reload_error pitch:0 volume:2 at:<player.location> custom
      - wait 3t
      - stop
    - define rewardget <[giftrewardlist].random>
    - define testresult <element[0]>
    - while <[testresult]> == 0:
      - if <player.inventory.contains_item[<[rewardget]>]>:
        - define rewardget <[giftrewardlist].random>
      - else:
        - define testresult <element[1]>
    - title "title:<element[「「「YOU ARE CRACKED!!!」」」].color_gradient[from=#500030;to=#902070]>" "subtitle:<item[<[rewardget]>].display>" fade_in:0 stay:2s fade_out:10t targets:<player>
    - take <player.inventory> iteminhand quantity:1
    - give <player.inventory> <[rewardget]> quantity:1 slot:hand
    - playeffect effect:FIREWORKS_SPARK at:<player.location> visibility:100 quantity:200 data:0.5 offset:0
    - playeffect effect:FLASH at:<player.location> visibility:100 quantity:1 offset:0
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:1 volume:2 at:<player.location>
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE_FAR pitch:0 volume:2 at:<player.location>
    - playsound sound:ENTITY_FIREWORK_ROCKET_LARGE_BLAST pitch:1 volume:2 at:<player.location>
    - playsound sound:ENTITY_FIREWORK_ROCKET_LARGE_BLAST_FAR pitch:0 volume:2 at:<player.location>
    - playsound sound:ENTITY_WITHER_DEATH pitch:2 volume:2 at:<player.location>
    - playsound sound:ENTITY_WITHER_DEATH pitch:1 volume:2 at:<player.location>
    - playsound sound:custom.reload_correct pitch:2 volume:2 at:<player.location> custom
    - playsound sound:custom.reload_correct pitch:1 volume:2 at:<player.location> custom
    - playsound sound:custom.reload_correct pitch:0.5 volume:2 at:<player.location> custom
    - wait 5t
    - playsound sound:custom.reload_correct pitch:1.8 volume:2 at:<player.location> custom
    - playsound sound:custom.reload_correct pitch:0.9 volume:2 at:<player.location> custom
    - playsound sound:custom.reload_correct pitch:0.5 volume:2 at:<player.location> custom
    - wait 5t
    - playsound sound:custom.reload_correct pitch:1.6 volume:2 at:<player.location> custom
    - playsound sound:custom.reload_correct pitch:0.8 volume:2 at:<player.location> custom
    - playsound sound:custom.reload_correct pitch:0.5 volume:2 at:<player.location> custom
    - wait 5t
    - playsound sound:custom.reload_correct pitch:1.4 volume:2 at:<player.location> custom
    - playsound sound:custom.reload_correct pitch:0.7 volume:2 at:<player.location> custom
    - playsound sound:custom.reload_correct pitch:0.5 volume:2 at:<player.location> custom
    - wait 5t
    - playsound sound:custom.reload_correct pitch:1.2 volume:2 at:<player.location> custom
    - playsound sound:custom.reload_correct pitch:0.6 volume:2 at:<player.location> custom
    - playsound sound:custom.reload_correct pitch:0.5 volume:2 at:<player.location> custom


    on player right clicks block with:collectorsgift:
    - determine cancelled passively
    - define giftrewardlist <server.flag[loot_collectors]>
    - define tr2 <element[0]>
    - foreach <[giftrewardlist]>:
      - if !<player.inventory.contains_item[<[value]>]>:
        - define tr2 <element[1]>
#        - announce <[value]>
#    - announce <[tr2]>
    - if <[tr2]> == 0:
      - title "title:<element[COLLECTED].color_gradient[from=#600000;to=#A02020]>" "subtitle:<element[ALL POSSIBLE REWARDS ALREADY IN INVENTORY].bold.color_gradient[from=#400000;to=#600000]>" fade_in:0 stay:0 targets:<player>
      - playsound <player.location> sound:BLOCK_NOTE_BLOCK_BASS pitch:0 v:3
      - playsound sound:custom.reload_error pitch:1 volume:2 at:<player.location> custom
    - define rewardget <[giftrewardlist].random>
    - define testresult <element[0]>
    - while <[testresult]> == 0:
      - if <player.inventory.contains_item[<[rewardget]>]>:
        - define rewardget <[giftrewardlist].random>
      - else:
        - define testresult <element[1]>
    - title "title:<element[YOU HAVE COLLECTED YOUR REWARD].color_gradient[from=#600000;to=#A02020]>" "subtitle:<item[<[rewardget]>].display>" fade_in:0 stay:2s fade_out:10t targets:<player>
    - take <player.inventory> iteminhand quantity:1
    - give <player.inventory> <[rewardget]> quantity:1 slot:hand
    - playeffect effect:FIREWORKS_SPARK at:<player.location> visibility:100 quantity:200 data:0.2 offset:0
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:1 volume:2 at:<player.location>
    - playsound sound:ENTITY_WITHER_DEATH pitch:1 volume:2 at:<player.location>
    - playsound sound:custom.reload_correct pitch:1 volume:2 at:<player.location> custom

    on player right clicks block with:vintagegift:
    - determine cancelled passively
    - define giftrewardlist <server.flag[loot_vintage]>
    - define tr2 <element[0]>
    - foreach <[giftrewardlist]>:
      - if !<player.inventory.contains_item[<[value]>]>:
        - define tr2 <element[1]>
#        - announce <[value]>
#    - announce <[tr2]>
    - if <[tr2]> == 0:
      - title "title:<element[SECOND AMENDMENT RIGHTS].color_gradient[from=#404878;to=#606898]>" "subtitle:<element[ALL POSSIBLE REWARDS ALREADY IN INVENTORY].bold.color_gradient[from=#400000;to=#600000]>" fade_in:0 stay:0 targets:<player>
      - playsound <player.location> sound:BLOCK_NOTE_BLOCK_BASS pitch:0 v:3
      - playsound sound:custom.reload_error pitch:1 volume:2 at:<player.location> custom
    - define rewardget <[giftrewardlist].random>
    - define testresult <element[0]>
    - while <[testresult]> == 0:
      - if <player.inventory.contains_item[<[rewardget]>]>:
        - define rewardget <[giftrewardlist].random>
      - else:
        - define testresult <element[1]>
    - title "title:<element[SECOND AMENDMENT RIGHTS].color_gradient[from=#404878;to=#606898]>" "subtitle:<item[<[rewardget]>].display>" fade_in:0 stay:2s fade_out:10t targets:<player>
    - take <player.inventory> iteminhand quantity:1
    - give <player.inventory> <[rewardget]> quantity:1 slot:hand
    - playeffect effect:FIREWORKS_SPARK at:<player.location> visibility:100 quantity:200 data:0.2 offset:0
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:1 volume:2 at:<player.location>
    - playsound sound:ENTITY_WITHER_DEATH pitch:1 volume:2 at:<player.location>
    - playsound sound:custom.click1 pitch:0 at:<player.location> volume:2 custom
    - playsound sound:custom.click1 pitch:1 at:<player.location> volume:2 custom
    - wait 5t
    - playsound sound:custom.click1 pitch:0 at:<player.location> volume:2 custom
    - playsound sound:custom.click1 pitch:0.9 at:<player.location> volume:2 custom

    on player right clicks block with:genuinegift:
    - determine cancelled passively
    - define giftrewardlist <server.flag[loot_genuine]>
    - define tr2 <element[0]>
    - foreach <[giftrewardlist]>:
      - if !<player.inventory.contains_item[<[value]>]>:
        - define tr2 <element[1]>
#        - announce <[value]>
#    - announce <[tr2]>
    - if <[tr2]> == 0:
      - title "title:<element[IT'S DANGEROUS TO GO ALONE].color_gradient[from=#206030;to=#40A070]>" "subtitle:<element[ALL POSSIBLE REWARDS ALREADY IN INVENTORY].bold.color_gradient[from=#400000;to=#600000]>" fade_in:0 stay:0 targets:<player>
      - playsound <player.location> sound:BLOCK_NOTE_BLOCK_BASS pitch:0 v:3
      - playsound sound:custom.reload_error pitch:1 volume:2 at:<player.location> custom
    - define rewardget <[giftrewardlist].random>
    - define testresult <element[0]>
    - while <[testresult]> == 0:
      - if <player.inventory.contains_item[<[rewardget]>]>:
        - define rewardget <[giftrewardlist].random>
      - else:
        - define testresult <element[1]>
    - title "title:<element[IT'S DANGEROUS TO GO ALONE].color_gradient[from=#206030;to=#40A070]>" "subtitle:<item[<[rewardget]>].display>" fade_in:0 stay:2s fade_out:10t targets:<player>
    - take <player.inventory> iteminhand quantity:1
    - repeat <list[4|4|4|4|16|16|64].random.min[<item[<[rewardget]>].material.max_stack_size>]>:
      - give <player.inventory> <[rewardget]> quantity:1 slot:hand
    - playeffect effect:FIREWORKS_SPARK at:<player.location> visibility:100 quantity:200 data:0.2 offset:0
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:1 volume:2 at:<player.location>
    - playsound sound:ENTITY_WITHER_DEATH pitch:1 volume:2 at:<player.location>
    - playsound sound:custom.classic_explode pitch:1 volume:2 at:<player.location> custom
    - playsound sound:BLOCK_BREWING_STAND_BREW pitch:0 volume:2 at:<player.location> custom

    on player right clicks block with:uniquegift:
    - determine cancelled passively
    - define giftrewardlist <server.flag[loot_unique]>
    - define tr2 <element[0]>
    - foreach <[giftrewardlist]>:
      - if !<player.inventory.contains_item[<[value]>]>:
        - define tr2 <element[1]>
#        - announce <[value]>
#    - announce <[tr2]>
    - if <[tr2]> == 0:
      - title "title:<element[NOTHING NEW].color_gradient[from=#FFEF10;to=#FFFF30]>" "subtitle:<element[ALL POSSIBLE REWARDS ALREADY IN INVENTORY].bold.color_gradient[from=#807808;to=#A09828]>" fade_in:0 stay:0 targets:<player>
      - playsound <player.location> sound:BLOCK_NOTE_BLOCK_BASS pitch:0 v:3
      - playsound sound:custom.reload_error pitch:1 volume:2 at:<player.location> custom
    - define rewardget <[giftrewardlist].random>
    - define testresult <element[0]>
    - while <[testresult]> == 0:
      - if <player.inventory.contains_item[<[rewardget]>]>:
        - define rewardget <[giftrewardlist].random>
      - else:
        - define testresult <element[1]>
    - title "title:<element[NOTHING NEW].color_gradient[from=#FFEF10;to=#FFFF30]>" "subtitle:<item[<[rewardget]>].display>" fade_in:0 stay:2s fade_out:10t targets:<player>
    - take <player.inventory> iteminhand quantity:1
    - give <player.inventory> <[rewardget]> quantity:1 slot:hand
    - playeffect effect:FIREWORKS_SPARK at:<player.location> visibility:100 quantity:200 data:0.2 offset:0
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:1 volume:2 at:<player.location>

    on player right clicks block with:strangegift:
    - determine cancelled passively
    - define giftrewardlist <server.flag[loot_strange]>
    - define tr2 <element[0]>
    - foreach <[giftrewardlist]>:
      - if !<player.inventory.contains_item[<[value]>]>:
        - define tr2 <element[1]>
#        - announce <[value]>
#    - announce <[tr2]>
    - if <[tr2]> == 0:
      - title "title:<element[WHAT IS THIS?].color_gradient[from=#D87840;to=#F89860]>" "subtitle:<element[ALL POSSIBLE REWARDS ALREADY IN INVENTORY].bold.color_gradient[from=#6C3C20;to=#8C5C40]>" fade_in:0 stay:0 targets:<player>
      - playsound <player.location> sound:BLOCK_NOTE_BLOCK_BASS pitch:0 v:3
      - playsound sound:custom.reload_error pitch:1 volume:2 at:<player.location> custom
    - define rewardget <[giftrewardlist].random>
    - define testresult <element[0]>
    - while <[testresult]> == 0:
      - if <player.inventory.contains_item[<[rewardget]>]>:
        - define rewardget <[giftrewardlist].random>
      - else:
        - define testresult <element[1]>
    - title "title:<element[WHAT IS THIS?].color_gradient[from=#D87840;to=#F89860]>" "subtitle:<item[<[rewardget]>].display>" fade_in:0 stay:2s fade_out:10t targets:<player>
    - take <player.inventory> iteminhand quantity:1
    - give <player.inventory> <[rewardget]> quantity:1 slot:hand
    - playeffect effect:FIREWORKS_SPARK at:<player.location> visibility:100 quantity:200 data:0.2 offset:0
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:0 volume:2 at:<player.location>
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:1 volume:2 at:<player.location>
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:2 volume:2 at:<player.location>


    on player right clicks block with:communitygift:
    - determine cancelled passively
    - define giftrewardlist <server.flag[loot_community]>
    - define tr2 <element[0]>
    - foreach <[giftrewardlist]>:
      - if !<player.inventory.contains_item[<[value]>]>:
        - define tr2 <element[1]>
#        - announce <[value]>
#    - announce <[tr2]>
    - if <[tr2]> == 0:
      - title "title:<element[HAVE YOU READ HOMESTUCK?].color_gradient[from=#D87840;to=#F89860]>" "subtitle:<element[ALL POSSIBLE REWARDS ALREADY IN INVENTORY].bold.color_gradient[from=#587030;to=#789050]>" fade_in:0 stay:0 targets:<player>
      - playsound <player.location> sound:BLOCK_NOTE_BLOCK_BASS pitch:0 v:3
      - playsound sound:custom.reload_error pitch:1 volume:2 at:<player.location> custom
    - define rewardget <[giftrewardlist].random>
    - define testresult <element[0]>
    - while <[testresult]> == 0:
      - if <player.inventory.contains_item[<[rewardget]>]>:
        - define rewardget <[giftrewardlist].random>
      - else:
        - define testresult <element[1]>
    - title "title:<element[HAVE YOU READ HOMESTUCK?].color_gradient[from=#D87840;to=#F89860]>" "subtitle:<item[<[rewardget]>].display>" fade_in:0 stay:2s fade_out:10t targets:<player>
    - take <player.inventory> iteminhand quantity:1
    - give <player.inventory> <[rewardget]> quantity:1 slot:hand
    - playeffect effect:FIREWORKS_SPARK at:<player.location> visibility:100 quantity:200 data:0.2 offset:0
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:1 volume:2 at:<player.location>
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:2 volume:2 at:<player.location>
    - playsound sound:ENTITY_EVOKER_CAST_SPELL pitch:2 volume:2 at:<player.location>
    - playsound sound:BLOCK_BELL_RESONATE pitch:2 volume:2 at:<player.location>



    on player right clicks block with:normalgift:
    - determine cancelled passively
    - define giftrewardlist <server.flag[loot_normal]>
    - define tr2 <element[0]>
    - foreach <[giftrewardlist]>:
      - if !<player.inventory.contains_item[<[value]>]>:
        - define tr2 <element[1]>
#        - announce <[value]>
#    - announce <[tr2]>
    - if <[tr2]> == 0:
      - title "title:<element[OPENED!].color_gradient[from=#A0A0A0;to=#C0C0C0]>" "subtitle:<element[ALL POSSIBLE REWARDS ALREADY IN INVENTORY].bold.color_gradient[from=#505050;to=#707070]>" fade_in:0 stay:0 targets:<player>
      - playsound <player.location> sound:BLOCK_NOTE_BLOCK_BASS pitch:0 v:3
      - playsound sound:custom.reload_error pitch:1 volume:2 at:<player.location> custom
    - define rewardget <[giftrewardlist].random>
    - define testresult <element[0]>
    - while <[testresult]> == 0:
      - if <player.inventory.contains_item[<[rewardget]>]>:
        - define rewardget <[giftrewardlist].random>
      - else:
        - define testresult <element[1]>
    - title "title:<element[OPENED!].color_gradient[from=#A0A0A0;to=#C0C0C0]>" "subtitle:<item[<[rewardget]>].material.translated_name>" fade_in:0 stay:2s fade_out:10t targets:<player>
    - take <player.inventory> iteminhand quantity:1
    - give <player.inventory> <[rewardget]> quantity:1 slot:hand
    - playeffect effect:FIREWORKS_SPARK at:<player.location> visibility:100 quantity:200 data:0.2 offset:0


    on player right clicks block with:decoratedgift:
    - determine cancelled passively
    - define giftrewardlist <server.flag[loot_decorated]>
    - define tr2 <element[0]>
    - foreach <[giftrewardlist]>:
      - if !<player.inventory.contains_item[<[value]>]>:
        - define tr2 <element[1]>
#        - announce <[value]>
#    - announce <[tr2]>
    - if <[tr2]> == 0:
      - title "title:<element[SICK BEAT].color_gradient[from=#DFDFDF;to=#FFFFFF]>" "subtitle:<element[ALL POSSIBLE REWARDS ALREADY IN INVENTORY].bold.color_gradient[from=#808080;to=#A0A0A0]>" fade_in:0 stay:0 targets:<player>
      - playsound <player.location> sound:BLOCK_NOTE_BLOCK_BASS pitch:0 v:3
      - playsound sound:custom.reload_error pitch:1 volume:2 at:<player.location> custom
    - define rewardget <[giftrewardlist].random>
    - define testresult <element[0]>
    - while <[testresult]> == 0:
      - if <player.inventory.contains_item[<[rewardget]>]>:
        - define rewardget <[giftrewardlist].random>
      - else:
        - define testresult <element[1]>
    - title "title:<element[SICK BEAT].color_gradient[from=#DFDFDF;to=#FFFFFF]>" "subtitle:<item[<[rewardget]>].material.translated_name>" fade_in:0 stay:2s fade_out:10t targets:<player>
    - take <player.inventory> iteminhand quantity:1
    - give <player.inventory> <[rewardget]> quantity:1 slot:hand
    - playeffect effect:FIREWORKS_SPARK at:<player.location> visibility:100 quantity:200 data:0.2 offset:0
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:1 volume:2 at:<player.location>
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:2 volume:2 at:<player.location>
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:2 volume:2 at:<player.location>
    - playsound sound:custom.yoi pitch:0 volume:2 at:<player.location> custom
    - playsound sound:custom.yoi pitch:2 volume:2 at:<player.location> custom

    on player right clicks block with:hauntedgift:
    - determine cancelled passively
    - define giftrewardlist <server.flag[loot_haunted]>
    - define tr2 <element[0]>
    - foreach <[giftrewardlist]>:
      - if !<player.inventory.contains_item[<[value]>]>:
        - define tr2 <element[1]>
#        - announce <[value]>
#    - announce <[tr2]>
    - if <[tr2]> == 0:
      - title "title:<element[BOOO!!!].color_gradient[from=#38F0A8;to=#58FFC8]>" "subtitle:<element[ALL POSSIBLE REWARDS ALREADY IN INVENTORY].bold.color_gradient[from=#1C7854;to=#3C9874]>" fade_in:0 stay:0 targets:<player>
      - playsound <player.location> sound:BLOCK_NOTE_BLOCK_BASS pitch:0 v:3
      - playsound sound:custom.reload_error pitch:1 volume:2 at:<player.location> custom
    - define rewardget <[giftrewardlist].random>
    - define testresult <element[0]>
    - while <[testresult]> == 0:
      - if <player.inventory.contains_item[<[rewardget]>]>:
        - define rewardget <[giftrewardlist].random>
      - else:
        - define testresult <element[1]>
    - title "title:<element[BOOO!!!].color_gradient[from=#38F0A8;to=#58FFC8]>" "subtitle:<item[<[rewardget]>].display>" fade_in:0 stay:2s fade_out:10t targets:<player>
    - take <player.inventory> iteminhand quantity:1
    - give <player.inventory> <[rewardget]> quantity:1 slot:hand
    - playeffect effect:FIREWORKS_SPARK at:<player.location> visibility:100 quantity:200 data:0.2 offset:0
    - playeffect effect:SOUL at:<player.location> visibility:100 quantity:60 offset:3
    - playsound sound:ENTITY_FIREWORK_ROCKET_TWINKLE pitch:1 volume:2 at:<player.location>
    - playsound sound:ENTITY_WITHER_DEATH pitch:1 volume:1 at:<player.location>
    - playsound sound:ENTITY_VEX_CHARGE pitch:1 volume:2 at:<player.location>
    - playsound sound:ENTITY_VEX_CHARGE pitch:0 volume:2 at:<player.location>