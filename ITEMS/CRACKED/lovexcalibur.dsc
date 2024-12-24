lovexcalibur:
  type: item
  material: golden_sword
  display name: <element[「「「].color_gradient[from=#FFC040;to=#FFFFFF]><element[LOVEXC].color_gradient[from=#FFC040;to=#FFFFFF]><element[ALIBUR].color_gradient[from=#FFFFFF;to=#FFC040]><element[」」」].color_gradient[from=#FFFFFF;to=#FFC040]>
  enchantments:
  - infinity:1
  - sharpness:20
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374323
  recipes:
    1:
      type: shapeless
      output_quantity: 1
#      input: kingcard|devilsknife|chainsaw|blingsword[attribute_modifiers=map@[GENERIC_ATTACK_SPEED=li@map@[name=GENERIC_ATTACK_SPEED;amount=8;operation=ADD_SCALAR;slot=HAND;id=10000000-1000-1000-1000-100000000000]|];enchantments=map@[sharpness=10;thorns=10]]|gloryhammer[enchantments=map@[smite=2]]|twistedsword[attribute_modifiers=map@[GENERIC_ATTACK_DAMAGE=li@map@[name=GENERIC_ATTACK_DAMAGE;amount=16;operation=ADD_NUMBER;slot=HAND;id=10000000-1000-1000-1000-100000000000]|]]|epichoe[enchantments=map@[damage_all=3]]|powertool|katana[attribute_modifiers=map@[GENERIC_ATTACK_SPEED=li@map@[name=GENERIC_ATTACK_SPEED;amount=0.15;operation=ADD_SCALAR;slot=HAND;id=10000000-1000-1000-1000-100000000000]|]]
#
      input: kingcard|devilsknife|chainsaw|gloryhammer[enchantments=map@[smite=2]]|blingblingsword[attribute_modifiers=map@[GENERIC_ATTACK_SPEED=li@map@[name=GENERIC_ATTACK_SPEED;amount=8;operation=ADD_SCALAR;slot=HAND;id=10000000-1000-1000-1000-100000000000]|];enchantments=map@[sharpness=10]]|epichoe[enchantments=map@[damage_all=3]]|powertool|caledscratch[custom_model_data=13376942]|twistedsword[attribute_modifiers=map@[GENERIC_ATTACK_DAMAGE=li@map@[name=GENERIC_ATTACK_DAMAGE;amount=16;operation=ADD_NUMBER;slot=HAND;id=10000000-1000-1000-1000-100000000000]|]]
  lore:
  - <element[-=-= ].color_gradient[from=#808080;to=#806020]><element[Cre].color_gradient[from=#808080;to=#806020]><element[ate].color_gradient[from=#806020;to=#808080]><element[ =-=-].color_gradient[from=#806020;to=#808080]>
  - 
  - <element[CRACKED].color[#600048].bold>

lovexcaliburfall:
  type: item
  material: golden_sword
  display name: <element[「「「].color_gradient[from=#FFC040;to=#FFFFFF]><element[LOVEXC].color_gradient[from=#FFC040;to=#FFFFFF]><element[ALIBUR].color_gradient[from=#FFFFFF;to=#FFC040]><element[」」」].color_gradient[from=#FFFFFF;to=#FFC040]><element[ (Falling)].color[#FFFFFF]>
  enchantments:
  - infinity:1
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374324
  lore:
  - <element[-=-= ].color_gradient[from=#808080;to=#806020]><element[Cre].color_gradient[from=#808080;to=#806020]><element[ate].color_gradient[from=#806020;to=#808080]><element[ =-=-].color_gradient[from=#806020;to=#808080]>
  - 
  - <element[CRACKED].color[#600048].bold>


lovexcaliburtriggers:
  type: world
  events:
    on player right clicks block with:lovexcalibur:
    - determine cancelled passively
    - if <player.has_flag[lxcooldown]>:
      - stop
    - flag <player> lxcooldown expire:7t
    - itemcooldown golden_sword duration:7t
    - define aimtarg <player.eye_location.ray_trace[range=50;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.5]>
    - define posline <player.eye_location.points_between[<[aimtarg]>].distance[0.5]>
    - playsound sound:item_trident_throw pitch:1 at:<player.eye_location> volume:2
    - playsound sound:entity_evoker_cast_spell pitch:1 at:<player.eye_location> volume:2
    - playsound sound:custom.psychicfire pitch:2 at:<player.eye_location> volume:2 custom
    - playsound sound:custom.psychichit pitch:0 at:<player.eye_location> volume:2 custom
    - random:
      - repeat 1:
        - title title:<element[FIRE!].bold.color[#FF0000]> subtitle: targets:<player> stay:3t fade_in:0t fade_out:10t
        - foreach <[posline]> as:pointloc:
          - playeffect effect:redstone special_data:1|<color[#FF0000]> quantity:3 at:<[pointloc]> offset:0.01 visibility:100
          - define aroundme <[pointloc].find_entities.within[1].exclude[<player>]>
          - if !<[aroundme].is_empty>:
            - foreach <[aroundme]>:
              - hurt <[value]> amount:5 source:fire
              - burn <[value]> duration:2s
          - if <[loop_index].mod[5]> == 0:
            - wait 1t
      - repeat 1:
        - title title:<element[EXPLOSIONS!].bold.color[#FF8040]> subtitle: targets:<player> stay:3t fade_in:0t fade_out:10t
        - foreach <[posline]> as:pointloc:
          - playeffect effect:redstone special_data:1|<color[#FF8040]> quantity:3 at:<[pointloc]> offset:0.01 visibility:100
          - define aroundme <[pointloc].find_entities.within[1].exclude[<player>]>
          - if !<[aroundme].is_empty>:
            - foreach <[aroundme]>:
              - if <util.random_chance[25]>:
                - explode <[value].location.random_offset[0.2]> power:2 source:<player>
          - if <[loop_index].mod[5]> == 0:
            - wait 1t
        - explode <[aimtarg]> power:3 source:<player>
      - repeat 1:
        - title title:<element[LIFE!].bold.color[#80FF80]> subtitle: targets:<player> stay:3t fade_in:0t fade_out:10t
        - foreach <[posline]> as:pointloc:
          - playeffect effect:redstone special_data:1|<color[#80FF80]> quantity:3 at:<[pointloc]> offset:0.01 visibility:100
          - define aroundme <[pointloc].find_entities.within[4].exclude[<player>].first[3]>
          - if !<[aroundme].is_empty>:
            - foreach <[aroundme]>:
              - playeffect effect:villager_happy quantity:3 at:<[value].location.add[0,1,0]> offset:0.5 visibility:100
              - heal <player> 0.1
          - if <[loop_index].mod[5]> == 0:
            - wait 1t
      - repeat 1:
        - title title:<element[STUN!].bold.color[#FFFF20]> subtitle: targets:<player> stay:3t fade_in:0t fade_out:10t
        - foreach <[posline]> as:pointloc:
          - playeffect effect:redstone special_data:1|<color[#FFFF20]> quantity:3 at:<[pointloc]> offset:0.01 visibility:100
          - define aroundme <[pointloc].find_entities.within[4].exclude[<player>]>
          - if !<[aroundme].is_empty>:
            - foreach <[aroundme]>:
              - playeffect effect:crit quantity:5 at:<[value].location> offset:0.25 visibility:100
              - cast <[value]> SLOWNESS amplifier:10 duration:10t no_icon no_ambient hide_particles
          - if <[loop_index].mod[5]> == 0:
            - wait 1t
      - repeat 1:
        - title title:<element[VOID!].bold.color[#000000]> subtitle: targets:<player> stay:3t fade_in:0t fade_out:10t
        - foreach <[posline]> as:pointloc:
          - playeffect effect:redstone special_data:3|<color[#000000]> quantity:3 at:<[pointloc]> offset:0.01 visibility:100
          - define aroundme <[pointloc].find_entities.within[6].exclude[<player>]>
          - if !<[aroundme].is_empty>:
            - foreach <[aroundme]>:
              - adjust <[value]> velocity:<[value].location.sub[<[pointloc]>].normalize.mul[-0.5]>
          - wait 1t
      - repeat 1:
        - title title:<element[SLASH!].bold.color[#FFFFFF]> subtitle: targets:<player> stay:3t fade_in:0t fade_out:10t
        - foreach <[posline]> as:pointloc:
          - playeffect effect:redstone special_data:1|<color[#FFFFFF]> quantity:3 at:<[pointloc]> offset:0.01 visibility:100
          - define aroundme <[pointloc].find_entities.within[1].exclude[<player>]>
          - if !<[aroundme].is_empty>:
            - foreach <[aroundme]>:
              - hurt <[value]> amount:15 source:<player>
              - playeffect effect:sweep_attack quantity:2 at:<[value].eye_location.sub[0,0.5.0]> offset:1 visibility:100
              - playsound sound:item_trident_throw pitch:1 at:<[value].eye_location> volume:2
          - if <[loop_index].mod[3]> == 0:
            - wait 1t
      - repeat 1:
        - title title:<element[PSI!].bold.color[#FF00FF]> subtitle: targets:<player> stay:3t fade_in:0t fade_out:10t
        - foreach <[posline]> as:pointloc:
          - playeffect effect:redstone special_data:1|<color[#FF00FF]> quantity:3 at:<[pointloc]> offset:0.01 visibility:100
          - define aroundme <[pointloc].find_entities.within[6].exclude[<player>]>
          - if !<[aroundme].is_empty>:
            - foreach <[aroundme]>:
              - adjust <[value]> velocity:<[value].location.sub[<[pointloc]>].normalize.mul[1]>
          - if <[loop_index].mod[2]> == 0:
            - wait 1t
      - repeat 1:
        - title title:<element[TESLA!].bold.color[#20FFFF]> subtitle: targets:<player> stay:3t fade_in:0t fade_out:10t
        - foreach <[posline]> as:pointloc:
          - if <[loop_index].mod[5]> == 0:
            - define aroundme <[pointloc].find_entities.within[4].exclude[<player>]>
            - if !<[aroundme].is_empty>:
              - foreach <[aroundme]>:
                - playeffect effect:magic_crit quantity:20 at:<[value].location> offset:1 visibility:100
                - flag <[value]> lightningjusthit expire:2t
                - run mgk_chainlightning def:<player>|<[value]>|<element[10]>
            - wait 1t
          - playeffect effect:redstone special_data:1|<color[#20FFFF]> quantity:3 at:<[pointloc]> offset:0.01 visibility:100
      - repeat 1:
        - title title:<element[WATER!].bold.color[#4040FF]> subtitle: targets:<player> stay:3t fade_in:0t fade_out:10t
        - foreach <[posline]> as:pointloc:
          - playeffect effect:redstone special_data:1|<color[#4040FF]> quantity:3 at:<[pointloc]> offset:0.01 visibility:100
          - define aroundme <[pointloc].find_entities.within[4].exclude[<player>]>
          - if !<[aroundme].is_empty>:
            - foreach <[aroundme]>:
              - playeffect effect:water_wake quantity:20 at:<[value].location> offset:1 visibility:100
              - adjust <[value]> fire_time:0t
#               - adjust <[value]> velocity:<[lookvec].add[0,1,0].mul[0.5]>
              - if !<[value].has_flag[mgk_wet]>:
                - flag <[value]> mgk_wet expire:8s
                - run wet_run def:<[value]>
              - else:
                - flag <[value]> mgk_wet expire:8s
          - if <[loop_index].mod[5]> == 0:
            - wait 1t
      - repeat 1:
        - title title:<element[INFECTION!].bold.color[#8000FF]> subtitle: targets:<player> stay:3t fade_in:0t fade_out:10t
        - foreach <[posline]> as:pointloc:
          - playeffect effect:redstone special_data:2|<color[#8000FF]> quantity:3 at:<[pointloc]> offset:0.01 visibility:100
          - define aroundme <[pointloc].find_entities.within[1].exclude[<player>]>
          - if !<[aroundme].is_empty>:
            - foreach <[aroundme]>:
              - flag <[value]> infected expire:4s
              - cast <[value]> poison duration:25t amplifier:6 hide_particles no_icon no_ambient
              - playsound sound:entity_zombie_villager_step pitch:0 at:<[value].location> volume:1
              - playeffect effect:redstone special_data:4|<color[#8000FF]> quantity:60 at:<[value].eye_location> offset:1
          - if <[loop_index].mod[4]> == 0:
            - wait 1t
      - repeat 1:
        - title title:<element[CHARISMA!].bold.color[#800040]> subtitle: targets:<player> stay:3t fade_in:0t fade_out:10t
        - foreach <[posline]> as:pointloc:
          - playeffect effect:redstone special_data:2|<color[#800040]> quantity:3 at:<[pointloc]> offset:0.01 visibility:100
          - if <[loop_index].mod[5]> == 0:
            - define aroundme <[pointloc].find_entities.within[4].exclude[<player>]>
            - if !<[aroundme].is_empty>:
              - foreach <[aroundme]>:
                - playeffect effect:damage_indicator quantity:10 at:<[value].location> offset:0.5 visibility:100
                - attack <[value]> target:<[value].location.find.living_entities.within[16].exclude[<player>].exclude[<[value]>].get[1]||0>
            - wait 1t
      #- repeat 1:
      #- repeat 1:
      #- repeat 1:
    on player left clicks block with:lovexcalibur:
    - determine cancelled passively
    - if <player.attack_cooldown_percent> < 100:
      - stop
    - playsound at:<player.location> volume:2 sound:item_trident_throw pitch:1
    - playsound at:<player.location> volume:2 sound:item_trident_throw pitch:0
    - flag <player> melee_parrying duration:6t
    - define lookpos <player.eye_location.forward[3]>
    - define lookray <player.eye_location.points_between[<[lookpos]>].distance[0.8]>
    - foreach <[lookray]>:
      - foreach <[value].find_entities.within[1.5].filter_tag[<[filter_value].is_projectile>]> as:deflected:
        - if <[deflected].script.name> == coin:
          - foreach next
        - if <[deflected].has_flag[parried]>:
          - foreach next
        - playsound at:<[deflected].location> volume:2 sound:entity_arrow_hit_player pitch:1
        - playsound at:<[deflected].location> volume:2 sound:entity_wither_break_block pitch:2
        - playeffect at:<[deflected].location> effect:crit offset:0.5 quantity:10 visibility:100
        - playeffect at:<[deflected].location> effect:explosion_large offset:0 quantity:1 visibility:100
        - if <[deflected].shooter||0> == <player> || <[deflected].shooter||0> == 0:
          - adjust <[deflected]> velocity:<player.eye_location.direction.vector.mul[2]>
        - else:
          - adjust <[deflected]> velocity:<[deflected].location.sub[<[deflected].shooter.eye_location>].normalize.mul[-5]>
        - flag <[deflected]> parried
        - heal <player> <player.health_max>
        - narrate <element[+ ].italicize.bold.color[#FFFFFF]><element[PARRY].italicize.bold.color[#80FF80]> targets:<player>
        - flag <player> stylestatus:<player.flag[stylestatus].add[150]>
      - foreach <[value].find_entities[coin].within[1.5].filter_tag[<[filter_value].has_flag[parried].not>]> as:deflected:
        - flag <[deflected]> parried
        - playsound at:<[deflected].location> volume:2 sound:entity_arrow_hit_player pitch:2
        - playsound at:<[deflected].location> volume:2 sound:entity_wither_break_block pitch:2
        - playeffect at:<[deflected].location> effect:crit offset:0.5 quantity:5 visibility:100
        - playeffect at:<[deflected].location> effect:explosion_large offset:0 quantity:1 visibility:100
        - define targetnearby <player.location.find.living_entities.within[35].exclude[<player>].filter_tag[<[filter_value].eye_location.line_of_sight[<player.eye_location>]>].get[1]||null>
        - if <[targetnearby]> != null:
          - define posline <[deflected].location.points_between[<[targetnearby].eye_location>].distance[0.5]>
          - foreach <[posline]>:
            - playeffect at:<[value]> effect:redstone special_data:1|<color[#FFD820]> quantity:1 offset:0 visibility:100
          - remove <[deflected]>
          - spawn coin[velocity=<location[0,0.35,0]>] <[targetnearby].eye_location> save:coinpunching
          - define coinproj <entry[coinpunching].spawned_entity>
          - run coinprojhandlertask def:<[coinproj]>|<player>
          - hurt <[targetnearby]> amount:<[deflected].flag[coindmg]||1> source:<player>
          - flag <[coinproj]> coindmg:<[deflected].flag[coindmg].mul[2]||1>
          - narrate <element[+ ].italicize.bold.color[#FFFFFF]><element[FISTFUL O' DOLLAR].italicize.bold.color[#00FFFF]> targets:<player>
          - flag <player> stylestatus:<player.flag[stylestatus].add[50]>
        - else:
          - define aimtarg <player.eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.1]>
          - define posline <[deflected].location.points_between[<[aimtarg].forward[0.15]>].distance[0.5]>
          - foreach <[posline]>:
            - playeffect at:<[value]> effect:redstone special_data:1|<color[#FFD820]> quantity:1 offset:0 visibility:100
          - remove <[deflected]>
          - spawn coin[velocity=<location[0,0.35,0]>] <[aimtarg].forward[0.15]> save:coinpunching
          - define coinproj <entry[coinpunching].spawned_entity>
          - flag <[coinproj]> coindmg:<[deflected].flag[coindmg].add[2]||1>
          - run coinprojhandlertask def:<[coinproj]>|<player>
        - stop