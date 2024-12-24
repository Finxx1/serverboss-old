mgk_water:
  type: item
  material: blue_concrete
  display name: <element[WATER].color[#4060FF]>
  lore:
  - <element[With mass, but no shape].color[#203080]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

mgk_life:
  type: item
  material: lime_concrete
  display name: <element[LIFE].color[#80FF80]>
  lore:
  - <element[Pure life energy].color[#408040]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

mgk_shield:
  type: item
  material: yellow_concrete
  display name: <element[SHIELD].color[#FFFF80]>
  lore:
  - <element[Annulation].color[#808040]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

mgk_cold:
  type: item
  material: white_concrete
  display name: <element[COLD].color[#C0FFFF]>
  lore:
  - <element[Spread draining of energy].color[#608080]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

# ROW 2

#this first one will be hell

# 24 11 2024 ^^^^^^ clueless
mgk_lightning: 
  type: item
  material: purple_concrete
  display name: <element[LIGHTNING].color[#8040C0]>
  lore:
  - <element[With shape, but no mass].color[#402060]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

mgk_arcane:
  type: item
  material: red_concrete
  display name: <element[ARCANE].color[#C00000]>
  lore:
  - <element[Energetic overload, causes kaboom!].color[#600000]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

# UPDATE 24 11 2024 I WAS WRONG EARTH IS THE WORST ONE HOLY FUCK
mgk_earth:
  type: item
  material: brown_concrete
  display name: <element[EARTH].color[#804030]>
  lore:
  - <element[With mass and shape].color[#402018]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

mgk_fire:
  type: item
  material: orange_concrete
  display name: <element[FIRE].color[#FFC040]>
  lore:
  - <element[Of which all come from and all turn to].color[#806020]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

magickbook:
  type: book
  title: Spellbook
  author: Ȥuiiğy Baȥuyčiede
  signed: true
  # Each -line in the text section represents an entire page.
  # To create a newline, use the tag <n>. To create a paragraph, use <p>.
  # | All book scripts MUST have this key!
  text:
  - Loading... <n>



mgktriggers:
  debug: false
  type: world
  events: 
#    on player right clicks block with:magickbook:
#    - determine cancelled passively
#    - adjust <player.item_in_hand>
    on player left clicks block with:mgk_water:
    - determine cancelled passively
    - run water_mgk def:<player>
    on player right clicks block with:mgk_water:
    - determine cancelled passively
    - run water_mgk2 def:<player>
    on player left clicks block with:mgk_life:
    - determine cancelled passively
    - run life_mgk def:<player>
    on player right clicks block with:mgk_life:
    - determine cancelled passively
    - run life_mgk2 def:<player>
    on player left clicks block with:mgk_shield:
    - determine cancelled passively
    - run shield_mgk def:<player>
    on player left clicks block with:mgk_cold:
    - determine cancelled passively
    - run cold_mgk def:<player>
    on player right clicks block with:mgk_cold:
    - determine cancelled passively
    - run cold_mgk2 def:<player>
    on player left clicks block with:mgk_lightning:
    - determine cancelled passively
    - run lightning_mgk def:<player>
    on player right clicks block with:mgk_lightning:
    - determine cancelled passively
    - run lightning_mgk2 def:<player>
    on player left clicks block with:mgk_arcane:
    - determine cancelled passively
    - run arcane_mgk def:<player>
    on player right clicks block with:mgk_arcane:
    - determine cancelled passively
    - run arcane_mgk2 def:<player>
    on player left clicks block with:mgk_earth:
    - determine cancelled passively
    - run earth_mgk def:<player>
    on player right clicks block with:mgk_earth:
    - determine cancelled passively
    - run earth_mgk2 def:<player>
    on player left clicks block with:mgk_fire:
    - determine cancelled passively
    - run fire_mgk def:<player>
    on player right clicks block with:mgk_fire:
    - determine cancelled passively
    - run fire_mgk2 def:<player>
    on player damaged:
    - if <context.entity.flag[mgk_shieldpower]> > 0:
      - determine cancelled passively
      - ratelimit <context.entity> <context.entity.last_damage.max_duration>
      - define damagetaken <context.damage.div[0.95].round_up_to_precision[1]>
      - if <context.entity.flag[mgk_shieldpower]> >= <[damagetaken]>:
        - flag <context.entity> mgk_shieldpower:<context.entity.flag[mgk_shieldpower].sub[<[damagetaken]>]>
        - playeffect effect:flash quantity:1 at:<context.entity.location> offset:0
        - playsound <context.entity.location> sound:item_totem_use pitch:2 volume:1
      - else:
        - flag <context.entity> mgk_shieldpower:0
        - playeffect effect:flash quantity:1 at:<context.entity.location> offset:0
        - playsound <context.entity.location> sound:item_totem_use pitch:1 volume:1
        - playsound <context.entity.location> sound:item_totem_use pitch:0 volume:1
    on frosted_ice fades:
    - determine cancelled passively
    on player walks:
    - if <player.has_flag[mgk_frozen]>:
      - determine cancelled
    #on entity damaged:
    #- if <context.damage> > <context.entity.health_max.mul[3]>:
    #  - run goreburstatloc def:<context.entity.location>
    on block falls:
    - if <context.entity.has_flag[unfalling]>:
      - playeffect effect:block_crack quantity:128 special_data:coarse_dirt at:<context.location> offset:0.7 velocity:<random_offset[1,1,1]> visibility:100
      - playeffect effect:block_crack quantity:128 special_data:coarse_dirt at:<context.location> offset:0.7 velocity:<random_offset[1,1,1]> visibility:100
      - playsound at:<context.location> sound:block_gravel_break pitch:0 volume:4
      - playsound at:<context.location> sound:block_stone_break pitch:0 volume:4
      - playsound at:<context.location> sound:block_sand_break pitch:0 volume:4
      - playsound at:<context.location> sound:entity_zombie_attack_wooden_door pitch:0 volume:4
      - determine cancelled passively
      - remove <context.entity>
    on entity dies:
    - if <context.entity.has_flag[arcanegib]>:
      - explode <context.entity.eye_location> power:2
      - run goreburstatloc def:<context.entity.location>
    on experience orbs merge:
    - determine cancelled passively
    on player steps on water:
    - if <player.has_flag[unwettable]> || <player.has_flag[wetresistance]>:
      - if !<player.has_flag[mgk_wet]>:
        - flag <player> mgk_wet expire:10s
        - run wet_run def:<player>
      - else:
        - flag <player> mgk_wet expire:10s
    on tick every:10:
    - foreach <server.online_players>:
      - foreach <[value].location.find_entities.within[40].filter_tag[<[filter_value].entity_type.is[==].to[ITEM_FRAME].not>]>:
        - if <[value].location.light.sky> == 15 && <[value].location.world.has_storm>:
          - if !<[value].has_flag[unwettable]> && !<[value].has_flag[wetresistance]>:
            - if !<[value].has_flag[mgk_wet]> &&:
              - flag <[value]> mgk_wet expire:4s
              - run wet_run def:<[value]>
            - else:
              - flag <[value]> mgk_wet expire:4s
        - if <[value].location.block.material.name> == water:
          - if !<[value].has_flag[unwettable]> && !<[value].has_flag[wetresistance]>:
            - if !<[value].has_flag[mgk_wet]>:
              - flag <[value]> mgk_wet expire:4s
              - run wet_run def:<[value]>
            - else:
              - flag <[value]> mgk_wet expire:4s

 

wet_run:
  debug: false
  definitions: wetentity
  type: task
  script:
    - while <[wetentity].has_flag[mgk_wet]>:
      - playeffect effect:splash quantity:4 at:<[wetentity].location.add[0,0.5,0]> offset:0.5,0.5,0.5 velocity:<location[0,0,0]>
      - wait 5t
      - adjust <[wetentity]> fire_time:0t


goreburstatloc:
  debug: false
  definitions: goreloc
  type: task
  script:
    - repeat 3:
      - playeffect effect:block_crack quantity:120 special_data:<list[redstone_wire|redstone_block].random> at:<[goreloc]> offset:0.5 velocity:<random_offset[4,4,4]>
      - playeffect effect:redstone quantity:10 special_data:1.2|red at:<[goreloc]> offset:1
    - repeat 5:
      - playsound at:<[goreloc]> sound:<list[block_honey_break|block_slime_block_break|block_honey_slide|block_slime_block_step].random> pitch:<list[0.5|0.6|0.7|0.9|1].random> volume:2
    - repeat 8:
      - shoot gore origin:<[goreloc]> spread:90 speed:<list[0.25|0.375|0.5|0.525].random> destination:<[goreloc].add[0,1,0]> save:goresaving
      - run gibbingtask def:<entry[goresaving].shot_entity>

goreburstpro:
  debug: false
  definitions: goreloc|speedset
  type: task
  script:
    - repeat 3:
      - playeffect effect:block_crack quantity:120 special_data:<list[redstone_wire|redstone_block].random> at:<[goreloc]> offset:0.5 velocity:<random_offset[4,4,4]>
      - playeffect effect:redstone quantity:10 special_data:1.2|red at:<[goreloc]> offset:1
    - repeat 5:
      - playsound at:<[goreloc]> sound:<list[block_honey_break|block_slime_block_break|block_honey_slide|block_slime_block_step].random> pitch:<list[0.5|0.6|0.7|0.9|1].random> volume:2
    - repeat 8:
      - shoot gore origin:<[goreloc]> spread:90 speed:<[speedset].add[<list[0.25|0.375|0.5|0.525].random>]> destination:<[goreloc].add[0,1,0]> save:goresaving
      - run gibbingtask def:<entry[goresaving].shot_entity>

goreburst:
  debug: false
  definitions: wetentity
  type: task
  script:
    - adjust <[wetentity]> visible:false
    - wait 1t
    - repeat 3:
      - playeffect effect:block_crack quantity:120 special_data:<list[redstone_wire|redstone_block].random> at:<[wetentity].eye_location> offset:0.5 velocity:<random_offset[4,4,4]>  visibility:64
      - playeffect effect:redstone quantity:10 special_data:1.2|red at:<[wetentity].eye_location> offset:1  visibility:64
    - repeat 5:
      - playsound at:<[wetentity].location> sound:<list[block_honey_block_break|block_slime_block_break|block_honey_block_slide|block_slime_block_step].random> pitch:<list[0.5|0.6|0.7|0.9|1].random> volume:2
    - repeat 8:
      - shoot gore origin:<[wetentity].location> spread:90 speed:<list[0.5|0.75|1|1.25].random> destination:<[wetentity].location.add[0,1,0]> save:goresaving
      - run gibbingtask def:<entry[goresaving].shot_entity>
    - playsound at:<[wetentity].location> sound:weather_rain pitch:0 volume:2
    - waituntil rate:10t !<[wetentity].is_spawned> max:3s
    - waituntil rate:10t <[wetentity].is_spawned> max:3s
    - adjust <[wetentity]> visible:true

frosty_run:
  debug: false
  definitions: wetentity
  type: task
  script:
    - if <[wetentity].has_flag[mgk_wet]>:
      - flag <[wetentity]> mgk_frozen expire:80t
      - define loc <[wetentity].location.block.add[0.5,0,0.5]>
      - adjust <[wetentity]> velocity:<location[0,0,0]>
      - adjust <[wetentity]> gravity:false
      - adjust <[wetentity]> has_ai:false
      - teleport <[wetentity]> <[loc]>
      - repeat 4:
        - cast <[wetentity]> slow duration:21t amplifier:7 no_icon hide_particles no_ambient
        - modifyblock <[loc]> frosted_ice[age=<[value].sub[1]>]
        - modifyblock <[loc].add[0,1,0]> frosted_ice[age=<[value].sub[1]>]
        - adjust <[wetentity]> velocity:<location[0,0,0]>
        - wait 20t
        - playeffect effect:block_crack special_data:ice quantity:16 at:<[loc].add[0,1,0]> offset:0.4,0.5,0.4
        - playsound <[loc]> sound:block_glass_hit pitch:1 volume:1
      - playeffect effect:block_crack special_data:ice quantity:128 at:<[loc].add[0,1,0]> offset:0.4,0.5,0.4
      - playsound <[loc]> sound:block_glass_break pitch:1 volume:1
      - modifyblock <[loc]> air no_physics
      - modifyblock <[loc].add[0,1,0]> air no_physics
      - flag <[wetentity]> mgk_wet:!
      - adjust <[wetentity]> gravity:true
      - adjust <[wetentity]> has_ai:true
      - stop
    - while <[wetentity].has_flag[mgk_frosty]>:
      - cast <[wetentity]> slow duration:11t amplifier:2 no_icon hide_particles no_ambient
      #- cast <[wetentity]> jump duration:11t amplifier:254 no_icon hide_particles no_ambient
      - playeffect effect:redstone quantity:5 at:<[wetentity].eye_location> special_data:2|white
      - wait 10t

frosty_run_forcefreeze:
  debug: false
  definitions: wetentity
  type: task
  script:
    - flag <[wetentity]> mgk_frozen expire:80t
    - define loc <[wetentity].location.block.add[0.5,0,0.5]>
    - define awarenessEnt <[wetentity].has_ai>
    - adjust <[wetentity]> velocity:<location[0,0,0]>
    - adjust <[wetentity]> gravity:false
    - adjust <[wetentity]> has_ai:false
    - teleport <[wetentity]> <[loc]>
    - repeat 4:
      - cast <[wetentity]> slow duration:21t amplifier:7 no_icon hide_particles no_ambient
      - modifyblock <[loc]> frosted_ice[age=<[value].sub[1]>]
      - modifyblock <[loc].add[0,1,0]> frosted_ice[age=<[value].sub[1]>]
      - adjust <[wetentity]> velocity:<location[0,0,0]>
      - wait 20t
      - playeffect effect:block_crack special_data:ice quantity:16 at:<[loc].add[0,1,0]> offset:0.4,0.5,0.4
      - playsound <[loc]> sound:block_glass_hit pitch:1 volume:1
    - playeffect effect:block_crack special_data:ice quantity:128 at:<[loc].add[0,1,0]> offset:0.4,0.5,0.4
    - playsound <[loc]> sound:block_glass_break pitch:1 volume:1
    - modifyblock <[loc]> air no_physics
    - modifyblock <[loc].add[0,1,0]> air no_physics
    - flag <[wetentity]> mgk_wet:!
    - adjust <[wetentity]> gravity:true
    - adjust <[wetentity]> has_ai:<[awarenessEnt]>


water_mgk:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[mgk_watercooldown]>:
      - stop
    - flag <[mgk_player]> mgk_watercooldown expire:1s
    - itemcooldown blue_concrete duration:1s
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - define lookpos <[mgk_player].eye_location.add[<[lookvec].mul[7]>]>
    - define posline <[mgk_player].eye_location.points_between[<[lookpos]>].distance[1]>
    - playsound <[mgk_player].location> sound:entity_generic_splash pitch:1 volume:1
    - playsound <[mgk_player].location> sound:entity_generic_splash pitch:0 volume:1
    - foreach <[posline]>:
      - define blasted <[value].find_entities.within[2].exclude[<[mgk_player]>]||0>
      - adjust <[blasted]> velocity:<[lookvec].add[0,1,0].mul[0.5]>
      - adjust <[blasted]> fire_time:0t
      - foreach <[blasted]>:
      - if !<[value].has_flag[mgk_wet]>:
        - flag <[value]> mgk_wet expire:8s
        - run wet_run def:<[value]>
      - else:
        - flag <[value]> mgk_wet expire:8s
      - playeffect effect:splash quantity:100 at:<[value]> offset:0.5,0.5,0.5
      - playeffect effect:bubble_pop quantity:100 at:<[value]> offset:0.5,0.5,0.5
      - playeffect effect:falling_water quantity:100 at:<[value]> offset:0.5,0.5,0.5
      - playsound <[value]> sound:weather_rain pitch:1 volume:1
      - wait 3t

water_mgk2:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[mgk_watercooldown]>:
      - stop
    - flag <[mgk_player]> mgk_watercooldown expire:1s
    - itemcooldown blue_concrete duration:1s
    - adjust <[mgk_player]> fire_time:0t
    - if !<[mgk_player].has_flag[mgk_wet]>:
      - flag <[mgk_player]> mgk_wet expire:6s
      - run wet_run def:<[mgk_player]>
    - else:
      - flag <[mgk_player]> mgk_wet expire:6s
    - playeffect effect:splash quantity:100 at:<[mgk_player].eye_location> offset:0.5,0.5,0.5
    - playeffect effect:bubble_pop quantity:100 at:<[mgk_player].eye_location> offset:0.5,0.5,0.5
    - playeffect effect:falling_water quantity:100 at:<[mgk_player].eye_location> offset:0.5,0.5,0.5
    - playsound <[mgk_player].eye_location> sound:entity_generic_splash pitch:1 volume:1
    - playsound <[mgk_player].eye_location> sound:entity_generic_splash pitch:0 volume:1
    - playsound <[mgk_player].eye_location> sound:weather_rain pitch:1 volume:1

shield_mgk:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[mgk_shieldcooldown]>:
      - stop
    - flag <[mgk_player]> mgk_shieldcooldown
    - flag <[mgk_player]> mgk_shieldpower:100
    - itemcooldown yellow_concrete duration:0.2s
    - playsound <[mgk_player].eye_location> sound:entity_ender_eye_death pitch:0 volume:2
    - playsound <[mgk_player].eye_location> sound:block_beacon_activate pitch:0 volume:2
    - playeffect effect:redstone special_data:0.5|<color[#FFFF80]> quantity:120 at:<player.eye_location> offset:1 visibility:64
    - while <[mgk_player].flag[mgk_shieldpower]> > 0:
      - cast glowing <[mgk_player]> amplifier:0 duration:6t no_icon hide_particles no_ambient
      - actionbar <element[<[mgk_player].flag[mgk_shieldpower]>%].color[#FFFF80]> targets:<[mgk_player]>
      - itemcooldown yellow_concrete duration:20s
      - wait 5t
    - actionbar <element[0%].color[#FF8080]> targets:<[mgk_player]>
    - flag <[mgk_player]> mgk_shieldcooldown expire:35s
    - itemcooldown yellow_concrete duration:35s

water_mgk:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[mgk_watercooldown]>:
      - stop
    - flag <[mgk_player]> mgk_watercooldown expire:2s
    - itemcooldown blue_concrete duration:2s
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - define lookpos <[mgk_player].eye_location.add[<[lookvec].mul[8]>]>
    - define posline <[mgk_player].eye_location.points_between[<[lookpos]>].distance[1]>
    - playsound <[mgk_player].location> sound:entity_generic_splash pitch:1 volume:1
    - playsound <[mgk_player].location> sound:entity_generic_splash pitch:0 volume:1
    - foreach <[posline]>:
      - define blasted <[value].find_entities.within[1.5].exclude[<[mgk_player]>]||0>
      - adjust <[blasted]> velocity:<[lookvec].add[0,1,0].mul[0.5]>
      - adjust <[blasted]> fire_time:0t
      - foreach <[blasted]>:
        - if !<[value].has_flag[mgk_wet]>
        - flag <[value]> mgk_wet expire:10s
        - run wet_run def:<[value]>
      - playeffect effect:splash quantity:100 at:<[value]> offset:0.5,0.5,0.5
      - playeffect effect:bubble_pop quantity:100 at:<[value]> offset:0.5,0.5,0.5
      - playeffect effect:falling_water quantity:100 at:<[value]> offset:0.5,0.5,0.5
      - playsound <[value]> sound:weather_rain pitch:1 volume:1
      - wait 2t

life_mgk2:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[mgk_lifecooldown]>:
      - stop
    - flag <[mgk_player]> mgk_lifecooldown expire:5s
    - itemcooldown lime_concrete duration:5s	
    - heal <[mgk_player]> <[mgk_player].health_max.div[3]>
    - playsound <[mgk_player].eye_location> sound:entity_evoker_cast_spell pitch:0 volume:2
    - playeffect effect:redstone special_data:2|<color[#80FF80]> quantity:120 at:<[mgk_player].eye_location> offset:1
    - playeffect effect:villager_happy quantity:120 at:<[mgk_player].eye_location> offset:2.5

arcane_mgk2:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[mgk_arcanecooldown]>:
      - stop
    - flag <[mgk_player]> mgk_arcanecooldown expire:1s
    - itemcooldown red_concrete duration:1s
    - if <[mgk_player].health> <= <[mgk_player].health_max.div[7]>:
      - explode <[mgk_player].location> power:2
      - run goreburst def:<[mgk_player]>
      - kill <[mgk_player]>
    - else:
      - hurt <[mgk_player]> <[mgk_player].health_max.div[7]>
    - playsound <[mgk_player].eye_location> sound:entity_evoker_prepare_summon pitch:0 volume:2
    - playeffect effect:redstone special_data:2|<color[#800000]> quantity:120 at:<[mgk_player].eye_location> offset:1
    - playeffect effect:smoke quantity:120 at:<[mgk_player].eye_location> offset:2.5

life_mgk:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[mgk_lifecooldown]>:
      - stop
    - flag <[mgk_player]> mgk_lifecooldown expire:1s
    - itemcooldown lime_concrete duration:1s	
    - define aimtarg <[mgk_player].eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;entities=*;ignore=<[mgk_player]>;raysize=0.5]>
    - define posline <[mgk_player].eye_location.points_between[<[aimtarg]>].distance[0.5]>
    - define prenderdist <[mgk_player].eye_location.distance[<[aimtarg]>].add[5]>
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - foreach <[posline]>:
      - playeffect effect:redstone special_data:2|<color[#80FF80]> quantity:3 at:<[value]> offset:0.01 visibility:<[prenderdist]>
      - playeffect effect:villager_happy quantity:1 at:<[value]> offset:0.15 visibility:<[prenderdist]>
    - define healtarg <[aimtarg].find_entities.within[2].exclude[<[mgk_player]>]> 
    - foreach <[healtarg]>:
      - heal <[value]> <[value].health_max.div[7]>
      - attack <[value]> cancel
    - playsound <[aimtarg]> sound:entity_evoker_cast_spell pitch:1 volume:2
    - playeffect effect:redstone special_data:2|<color[#80FF80]> quantity:120 at:<[aimtarg]> offset:1 visibility:<[prenderdist]>
    - playeffect effect:villager_happy quantity:120 at:<[aimtarg]> offset:2.5 visibility:<[prenderdist]>

arcane_mgk:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[mgk_arcanecooldown]>:
      - stop
    - flag <[mgk_player]> mgk_arcanecooldown expire:5s
    - itemcooldown red_concrete duration:5s	
    - define aimtarg <[mgk_player].eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;entities=*;ignore=<[mgk_player]>;raysize=0.5]>
    - define posline <[mgk_player].eye_location.points_between[<[aimtarg]>].distance[0.5]>
    - define prenderdist <[mgk_player].eye_location.distance[<[aimtarg]>].add[5]>
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - foreach <[posline]>:
      - playeffect effect:redstone special_data:2|<color[#800000]> quantity:3 at:<[value]> offset:0.01 visibility:<[prenderdist]>
      - playeffect effect:smoke quantity:1 at:<[value]> offset:0.15 visibility:<[prenderdist]>
    - define healtarg <[aimtarg].find_entities.within[2].exclude[<[mgk_player]>]> 
    - foreach <[healtarg]>:
      - if <[value].health> <= 15:
        - flag <[value]> arcanegib expire:1t
        - hurt <[value]> 15
      - else:
        - hurt <[value]> 15
    - playsound <[aimtarg]> sound:entity_evoker_prepare_summon pitch:1 volume:2
    - playeffect effect:redstone special_data:2|<color[#800000]> quantity:120 at:<[aimtarg]> offset:1 visibility:<[prenderdist]>
    - playeffect effect:smoke quantity:120 at:<[aimtarg]> offset:2.5 visibility:<[prenderdist]>

cold_mgk2:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[mgk_coldcooldown]>:
      - stop
    - flag <[mgk_player]> mgk_coldcooldown expire:5s
    - itemcooldown white_concrete duration:5s
    - playsound <[mgk_player].location> sound:entity_snowball_throw pitch:0 volume:1
    - playsound <[mgk_player].eye_location> sound:entity_ender_dragon_flap pitch:0 volume:1
    - playeffect effect:end_rod quantity:10 at:<[mgk_player].eye_location> offset:0.5,0.5,0.5
    - playeffect effect:redstone quantity:34 at:<[mgk_player].eye_location> special_data:0.8|white offset:1.24,1.24,1.24
    - playeffect effect:cloud quantity:100 at:<[mgk_player].eye_location> offset:1,1,1
    - if !<[mgk_player].has_flag[mgk_frosty]>
    - flag <[mgk_player]> mgk_frosty expire:10s
    - run frosty_run def:<[mgk_player]>

cold_mgk:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[mgk_coldcooldown]>:
      - stop
    - flag <[mgk_player]> mgk_coldcooldown expire:4s
    - itemcooldown white_concrete duration:4s
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - define lookpos <[mgk_player].eye_location.add[<[lookvec].mul[11]>]>
    - define posline <[mgk_player].eye_location.points_between[<[lookpos]>].distance[2]>
    - playsound <[mgk_player].location> sound:entity_snowball_throw pitch:0 volume:1
    - playsound <[mgk_player].location> sound:entity_blaze_shoot pitch:0 volume:1
    #- playsound <[mgk_player].location> sound:entity_generic_splash pitch:0 volume:1
    - playsound <[mgk_player].eye_location> sound:entity_ender_dragon_flap pitch:0 volume:1
    - foreach <[posline]>:
      - define blasted <[value].find_entities.within[2.5].exclude[<[mgk_player]>]||0>
      #- adjust <[blasted]> velocity:<[lookvec].add[0,1,0].mul[0.35]>
      - adjust <[blasted]> fire_time:0t
      - foreach <[blasted]>:
        - if !<[value].has_flag[mgk_frosty]>:
          - flag <[value]> mgk_frosty expire:10s
          - run frosty_run def:<[value]>
      - playeffect effect:end_rod quantity:10 at:<[value]> offset:0.5,0.5,0.5
      - playeffect effect:redstone quantity:34 at:<[value]> special_data:0.8|white offset:1.24,1.24,1.24
      - playeffect effect:cloud quantity:100 at:<[value]> offset:1,1,1
      #- playeffect effect:falling_water quantity:100 at:<[value]> offset:0.5,0.5,0.5
      - wait 1t

fire_mgk:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[mgk_firecooldown]>:
      - stop
    - flag <[mgk_player]> mgk_firecooldown expire:7s
    - itemcooldown orange_concrete duration:7s
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - playsound <[mgk_player].location> sound:block_fire_ambient pitch:0 volume:1
    - playsound <[mgk_player].location> sound:block_fire_ambient pitch:1 volume:1
    - playsound <[mgk_player].location> sound:block_fire_ambient pitch:0 volume:1
    - playsound <[mgk_player].location> sound:entity_blaze_shoot pitch:0 volume:1
    - define lookpos <[mgk_player].eye_location.add[<[lookvec].mul[11]>]>
    #- playsound <[mgk_player].location> sound:entity_generic_splash pitch:0 volume:1
    #- playsound <[mgk_player].eye_location> sound:entity_ender_dragon_flap pitch:0 volume:1
    - repeat 20:
      - playeffect effect:lava quantity:1 at:<[mgk_player].eye_location.forward[1]> offset:1 velocity:<[lookvec].div[6].random_offset[0.15]>
    - repeat 125:
      - playeffect effect:flame quantity:2 at:<[mgk_player].eye_location.forward[1]> offset:1 velocity:<[lookvec].div[3].random_offset[0.3]>
      - playeffect effect:smoke quantity:2 at:<[mgk_player].eye_location.forward[1]> offset:1 velocity:<[lookvec].random_offset[0.6]>
    - repeat 6 as:rep: 
      - define lookpos <[mgk_player].eye_location.add[<[lookvec].mul[<[rep].mul[1.5]>]>]>
      - define posline <[mgk_player].eye_location.points_between[<[lookpos]>].distance[2]>
      - foreach <[posline]>:
        - define blasted <[value].find_entities.within[<[rep].div[1.5]>].exclude[<[mgk_player]>]||0>
        - adjust <[blasted]> velocity:<[lookvec].add[0,1,0].mul[0.15]>
        - foreach <[blasted]>:
          - if <[value].has_flag[mgk_wet]>:
            - playeffect effect:cloud quantity:16 at:<[value].eye_location> offset:0.4,0.7,0.4
            - playsound <[value].eye_location> sound:block_fire_extinguish pitch:0 volume:1
            - flag <[value]> mgk_wet:!
            - hurt <[value]> 1
          - else:
            - hurt <[value]> 2 source:<[mgk_player]>
            - burn <[value]> 7s
      - wait 1t

fire_mgk2:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[mgk_firecooldown]>:
      - stop
    - flag <[mgk_player]> mgk_firecooldown expire:2s
    - itemcooldown orange_concrete duration:2s
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - playsound <[mgk_player].location> sound:block_fire_ambient pitch:0 volume:1
    - playsound <[mgk_player].location> sound:block_fire_ambient pitch:0 volume:1
    - playsound <[mgk_player].location> sound:block_fire_ambient pitch:0 volume:1
    - playsound <[mgk_player].location> sound:entity_blaze_shoot pitch:0 volume:1
    - if <[mgk_player].has_flag[mgk_wet]>:
      - playeffect effect:cloud quantity:8 at:<[mgk_player].eye_location> offset:0.4,0.7,0.4
      - playsound <[mgk_player].eye_location> sound:block_fire_extinguish pitch:0 volume:1
      - flag <[mgk_player]> mgk_wet:!
      - hurt <[mgk_player]> 1
    - else:
      - hurt <[mgk_player]> 1
      - burn <[mgk_player]> 3.5s
      - repeat 16:
        - playeffect effect:lava quantity:1 at:<[mgk_player].eye_location> offset:0,1,0 velocity:<location[0,0,0].random_offset[0.025]>
        - playeffect effect:flame quantity:2 at:<[mgk_player].eye_location> offset:1,2,1 velocity:<location[0,0,0].random_offset[0.05]>
        - playeffect effect:smoke quantity:3 at:<[mgk_player].eye_location> offset:2,2.5,2 velocity:<location[0,0,0].random_offset[0.1]>

earth_mgk2:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[held_earth_ball]>:
      - flag <[mgk_player]> mgk_earthcooldown expire:1s
      - playsound <[mgk_player].location> sound:block_note_block_bass pitch:0 volume:1
      - itemcooldown brown_concrete duration:1s
      - stop
    - if <[mgk_player].has_flag[mgk_earthcooldown]>:
      - stop
    - flag <[mgk_player]> mgk_earthcooldown expire:0.8s
    - itemcooldown brown_concrete duration:0.8s
    - define aimtarg <[mgk_player].eye_location.ray_trace[range=3;return=precise;default=air;nonsolids=false]>
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - playsound <[mgk_player].location> sound:block_dirt_break pitch:0 volume:1
    - playsound <[mgk_player].location> sound:block_sand_break pitch:0 volume:1
    - playsound <[mgk_player].location> sound:block_stone_break pitch:0 volume:1
    - flag <[mgk_player]> held_earth_ball
    - playeffect effect:block_crack quantity:128 special_data:coarse_dirt at:<[aimtarg]> offset:0.7 velocity:<random_offset[1,1,1]>
    - playsound at:<[aimtarg]> sound:block_gravel_break pitch:0 volume:2
    - playsound at:<[aimtarg]> sound:block_stone_break pitch:0 volume:2
    - playsound at:<[aimtarg]> sound:block_sand_break pitch:0 volume:2
    - playsound at:<[aimtarg]> sound:entity_zombie_attack_wooden_door pitch:0 volume:2
    - flag <[mgk_player]> earthcharge:0
    - while !<player.has_flag[mgk_justshotdirt]>:
      #- teleport <[earthball]> <[mgk_player].eye_location.forward[3]>
      - define aimtarg <[mgk_player].eye_location.ray_trace[range=3;return=precise;default=air;nonsolids=false].sub[0,0.5,0]>
      - if <[mgk_player].flag[earthcharge]> < 100:
        - flag <[mgk_player]> earthcharge:<[mgk_player].flag[earthcharge].add[1]>
      - title "title:" "subtitle:<element[<player.flag[earthcharge]>%].color[#804030]>" fade_in:0 stay:2t targets:<[mgk_player]>
      #- announce <[mgk_player].flag[earthcharge]>
      - spawn falling_block[fallingblock_type=coarse_dirt;gravity=false] <[aimtarg]> save:balzacsave
      - remove <entry[balzacsave].spawned_entity>
      - if <[loop_index]> > 120:
        - while stop
      - playeffect effect:block_crack quantity:16 special_data:coarse_dirt at:<[aimtarg].add[0,0.5,0]> offset:0.3 velocity:<random_offset[1,1,1]>
      - if <util.random_chance[25]>:
        - playsound <[mgk_player].location> sound:block_sand_hit pitch:0 volume:1
        - playsound <[mgk_player].location> sound:block_gravel_hit pitch:0 volume:1
        - playsound <[mgk_player].location> sound:block_stone_hit pitch:0 volume:1
      - wait 1t
    - flag <[mgk_player]> earthcharge:!
    - flag <[mgk_player]> held_earth_ball:!
    - if !<[mgk_player].has_flag[justfired]>:
      - flag <[mgk_player]> mgk_earthcooldown expire:7s
      - itemcooldown brown_concrete duration:7s
      - spawn falling_block[fallingblock_type=coarse_dirt] <[mgk_player].eye_location.ray_trace[range=3;return=precise;default=air;nonsolids=false].sub[0,0.5,0]> save:balzacsave
      - define earthball <entry[balzacsave].spawned_entity>
      - flag <[earthball]> unfalling

earth_mgk:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if !<[mgk_player].has_flag[held_earth_ball]>:
      - flag <[mgk_player]> mgk_earthcooldown expire:1s
      - playsound <[mgk_player].location> sound:block_note_block_bass pitch:0 volume:1
      - itemcooldown brown_concrete duration:1s
      - stop
    - if <[mgk_player].has_flag[mgk_earthcooldown]>:
      - stop
    - flag <[mgk_player]> mgk_earthcooldown expire:4s
    - flag <[mgk_player]> justfired expire:1s
    - itemcooldown brown_concrete duration:4s
    - define charge <[mgk_player].flag[earthcharge]>
    - define aimtarg <[mgk_player].eye_location.ray_trace[range=3;return=precise;default=air;nonsolids=false]>
    - spawn falling_block[fallingblock_type=coarse_dirt;gravity=false;visible=false] <[aimtarg].sub[0,0.5,0]> save:dirtsave
    - define earthball <entry[dirtsave].spawned_entity>
    - flag <[earthball]> unfalling
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - playsound <[mgk_player].location> sound:entity_wither_break_block pitch:0 volume:1
    - flag <[mgk_player]> mgk_justshotdirt expire:2t
    - adjust <[earthball]> gravity:true
    - adjust <[earthball]> velocity:<[lookvec].mul[<[charge].div[35]>].add[0,0.25,0]>
    - playeffect effect:block_crack quantity:128 special_data:coarse_dirt at:<[earthball].location> offset:0.7 velocity:<random_offset[1,1,1]>
    - playsound at:<[earthball].location> sound:block_gravel_break pitch:0 volume:2
    - playsound at:<[earthball].location> sound:block_stone_break pitch:0 volume:2
    - playsound at:<[earthball].location> sound:block_sand_break pitch:0 volume:2
    - playsound at:<[earthball].location> sound:entity_zombie_attack_wooden_door pitch:0 volume:2
    - run earthscript def:<[earthball]>|<[mgk_player]>|<[charge]>

#/ex announce <player.location.find_path[<player.location.find_entities.within[10].exclude[<player>].first.location>]>
mgk_chainlightning:
  debug: false
  definitions: mgk_player|shockedentity|shockpower
  type: task
  script:
    - wait 3t
    - if <[shockpower]> < 2:
      - stop
    - playsound at:<[shockedentity].location> sound:custom.lightning_discharge pitch:1 volume:3 custom
    - if !<[shockedentity].has_flag[electrid]>:
      - run mgk_chainlightning2 def:<[mgk_player]>|<[shockedentity]>|<[shockpower]>
    - if <[shockedentity].entity_type> == CREEPER:
      - adjust <[shockedentity]> powered:true
    - if <[shockedentity].has_flag[mgk_wet]>:
      - hurt <[shockedentity]> <[shockpower].mul[2.5]>
    - else if !<[shockedentity].has_flag[noouchy]>:
      - hurt <[shockedentity]> <[shockpower].mul[1.25]>
    - flag <[shockedentity]> noouchy expire:1s
    - playeffect effect:magic_crit quantity:36 at:<[shockedentity].eye_location> offset:<element[1].add[<[shockpower].mul[0.25]>]> velocity:<location[0,0,0].random_offset[0.1]> visibility:100

mgk_chainlightning3:
  debug: false
  definitions: mgk_player|shockedentity|shockpower
  type: task
  script:
    - wait 3t
    - if <[shockpower]> < 2:
      - stop
    - playsound at:<[shockedentity].location> sound:custom.lightning_discharge pitch:1 volume:3 custom
    - if !<[shockedentity].has_flag[electrid]>:
      - run mgk_chainlightning4 def:<[mgk_player]>|<[shockedentity]>|<[shockpower]>
    - playeffect effect:magic_crit quantity:36 at:<[shockedentity].eye_location> offset:<element[1].add[<[shockpower].mul[0.25]>]> velocity:<location[0,0,0].random_offset[0.1]> visibility:100

mgk_chainlightning2:
  debug: false
  definitions: mgk_player|shockedentity|shockpower
  type: task
  script:
    - flag <[shockedentity]> electrid expire:1s
    - if !<[shockedentity].has_flag[mgk_wet]>:
      - define chained <[shockedentity].location.find_entities.within[<[shockpower].mul[2]>].filter[has_flag[electrid].not].exclude[<[mgk_player]>].exclude[<[shockedentity]>].first[<list[1|1|2].random>]>
    - else:
      - define chained <[shockedentity].location.find_entities.within[<[shockpower].mul[3]>].filter[has_flag[electrid].not].exclude[<[mgk_player]>].exclude[<[shockedentity]>].first[<list[1|2|3].random>]>
    - if <[chained].is_empty>:
      - stop
    - foreach <[chained]>:
      - if <[value].has_flag[electrid]> || <[value]> == <[shockedentity]> || <[value]> == <[mgk_player]>:
        - foreach stop
      - define bolt <[shockedentity].eye_location.points_between[<[value].eye_location>].distance[0.25]>
      - foreach <[bolt]>:
        - playeffect effect:magic_crit quantity:1 at:<[value]> offset:0 velocity:<location[0,0,0].random_offset[0.1]> visibility:100
      - if !<[value].has_flag[mgk_wet]>:
        - run mgk_chainlightning def:<[mgk_player]>|<[value]>|<[shockpower].sub[1]>
      - else:
        - run mgk_chainlightning def:<[mgk_player]>|<[value]>|<[shockpower]>

mgk_chainlightning4:
  debug: false
  definitions: mgk_player|shockedentity|shockpower
  type: task
  script:
   - flag <[shockedentity]> electrid expire:1s
   - define chained <[shockedentity].location.find_entities.within[<[shockpower].mul[2]>].filter[has_flag[electrid].not].exclude[<[mgk_player]>].exclude[<[shockedentity]>].first[5]>
   - if <[chained].is_empty>:
     - stop
   - foreach <[chained]>:
     - if <[value].has_flag[electrid]> || <[value]> == <[shockedentity]> || <[value]> == <[mgk_player]>:
       - stop
     - define bolt <[shockedentity].eye_location.points_between[<[value].eye_location>].distance[0.25]>
     - foreach <[bolt]>:
       - playeffect effect:magic_crit quantity:1 at:<[value]> offset:0 velocity:<location[0,0,0].random_offset[0.1]> visibility:100
     - run mgk_chainlightning def:<[mgk_player]>|<[value]>|<[shockpower].sub[1]>

lightning_mgk:
  debug: false
  definitions: mgk_player
  type: task
  script:
#    - if <[mgk_player].has_flag[mgk_lightningcooldown]>:
#      - stop
#    - flag <[mgk_player]> mgk_lightningcooldown expire:4s
#    - itemcooldown purple_concrete duration:4s
    - if <[mgk_player].has_flag[mgk_wet]>:
      - playeffect effect:magic_crit quantity:1 at:<[mgk_player]> offset:0 velocity:<location[0,0,0].random_offset[0.1]> visibility:100
      - hurt <[mgk_player]> 15
    - playsound at:<[mgk_player].location> sound:custom.lightning_charge pitch:1 volume:3 custom
    - define aimtarg <[mgk_player].eye_location.ray_trace[range=13;return=precise;default=air;ignore=<[mgk_player]>;nonsolids=false]>
    - define posline <[mgk_player].eye_location.points_between[<[aimtarg]>].distance[1]>
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - flag <[mgk_player]> chainedup:0
    #- flag <[mgk_player]> electrid expire:2s
    - foreach <[posline]>:
      - playeffect effect:magic_crit quantity:2 at:<[value]> offset:1 visibility:100
      - define hitent <[value].find_entities.within[2].exclude[<player>].filter[has_flag[lightningjusthit].not].first||0>      
      - if <[hitent]> != 0:
        - flag <[mgk_player]> chainedup:<[mgk_player].flag[chainedup].add[1]>
      - flag <[hitent]> lightningjusthit expire:2t
      - run mgk_chainlightning def:<[mgk_player]>|<[hitent]>|<element[10]>
      - define bolt <[mgk_player].eye_location.points_between[<[hitent].eye_location>].distance[0.25]>
      - foreach <[bolt]>:
        - playeffect effect:magic_crit quantity:1 at:<[value]> offset:0 velocity:<location[0,0,0].random_offset[0.1]> visibility:100
      - if <[mgk_player].flag[chainedup]> > 0:
        - foreach stop

lightning_mgk2:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[mgk_lightningcooldown]>:
      - stop
    - flag <[mgk_player]> mgk_lightningcooldown expire:4s
    - itemcooldown purple_concrete duration:4s
    - if <[mgk_player].has_flag[mgk_wet]>:
      - playeffect effect:magic_crit quantity:36 at:<[mgk_player].eye_location> offset:3.25 velocity:<location[0,0,0].random_offset[0.1]> visibility:100
      - hurt <[mgk_player]> 15
    - else:
      - playeffect effect:magic_crit quantity:36 at:<[mgk_player].eye_location> offset:1.25 velocity:<location[0,0,0].random_offset[0.1]> visibility:100
      - hurt <[mgk_player]> 4
    - playsound at:<[mgk_player].location> sound:custom.lightning_charge pitch:1 volume:3 custom
    - cast <[mgk_player]> fast_digging duration:6s amplifier:3 no_icon hide_particles no_ambient
    - cast <[mgk_player]> speed duration:6s amplifier:3 no_icon hide_particles no_ambient

shieldfix:
  type: command
  debug: false
  name: shieldfix
  description: fix shields
  usage: /shieldfix
  script:
    - foreach <server.online_players>:
      - flag <[value]> mgk_shieldcooldown:!
      - flag <[value]> mgk_shieldpower:0

magicka:
  type: command
  debug: false
  name: magicka
  description: magicka items
  usage: /magicka
  script:
    - give <player> mgk_water
    - wait 2t
    - give <player> mgk_life
    - wait 2t
    - give <player> mgk_shield
    - wait 2t
    - give <player> mgk_cold
    - wait 2t
    - give <player> mgk_lightning
    - wait 2t
    - give <player> mgk_arcane
    - wait 2t
    - give <player> mgk_earth
    - wait 2t
    - give <player> mgk_fire
    - wait 2t