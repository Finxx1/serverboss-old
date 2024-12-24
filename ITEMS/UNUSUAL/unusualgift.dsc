crackedgift:
  type: item
  material: magenta_glazed_terracotta
  display name: <element[「「「Cracked Gift」」」].color_gradient[from=#500030;to=#902070]>
  enchantments:
  - infinity:1
  mechanisms:
    hides: all
  lore:
  - <element[-=-= The Highest Tier... =-=-].color_gradient[from=#300010;to=#500030]>
  - <&7>
  - <element[CRACKED].color[#700050].bold>

unusualgift:
  type: item
  material: purple_glazed_terracotta
  display name: <element[「Unusual Gift」].color_gradient[from=#7020A0;to=#B060E0]>
  enchantments:
  - infinity:1
  mechanisms:
    hides: all
  lore:
  - <element[-= Free Gift! =-].color_gradient[from=#500080;to=#7020A0]>
  - <&7>
  - <element[UNUSUAL].color[#9040C0].bold>

collectorsgift:
  type: item
  material: black_glazed_terracotta
  display name: <element[Collector's Gift].color_gradient[from=#600000;to=#A02020]>
  mechanisms:
    hides: all
  lore:
  - <element[Free Gift!].color_gradient[from=#400000;to=#600000]>
  - <&7>
  - <element[COLLECTOR'S].color[#800000].bold>


gifttriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:unusualgift:
    - determine cancelled passively
    - define giftrewardlist <list[anomaloussponge|theworlditem|thehand2|thebucketnerfed|sunsetsea|gloryhammer|epichoe|sentientsword|grapple]>
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
    - define giftrewardlist <list[angelwings|worldcontrolwand|ikeaticket|lovexcalibur]>
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
    - define giftrewardlist <list[ballin|chainsaw|converter|gasoline|gunkheels|hermesflops|icesword|firesword|lightblade|thebible3|moonshoes|postalshovel|powerdash|powertool|abrose|saintsrow|scythe|sickle|cageofwrath|thebible|thelantern|therock|tntboots]>
    - define tr2 <element[0]>
    - foreach <[giftrewardlist]>:
      - if !<player.inventory.contains_item[<[value]>]>:
        - define tr2 <element[1]>
#        - announce <[value]>
#    - announce <[tr2]>
    - if <[tr2]> == 0:
      - title "title:<element[YOU HAVE COLLECTED YOUR REWARD].color_gradient[from=#600000;to=#A02020]>" "subtitle:<element[ALL POSSIBLE REWARDS ALREADY IN INVENTORY].bold.color_gradient[from=#400000;to=#600000]>" fade_in:0 stay:0 targets:<player>
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