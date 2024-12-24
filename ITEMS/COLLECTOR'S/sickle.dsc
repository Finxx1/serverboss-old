sickle:
  type: item
  material: golden_hoe
  display name: <element[Eldritch Sickle].color_gradient[from=#808000;to=#D0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374214
    attribute_modifiers:
      GENERIC_ATTACK_SPEED:
        1:
          operation: add_scalar
          amount: 0.15
          slot: hand
          id: 10000000-1000-1000-1000-100000000000
  lore:
  - <element[Old time religion habits].color_gradient[from=#404000;to=#606060]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>



sickletriggers:
  type: world
  events:
    on player left clicks block with:sickle:
    - determine cancelled passively
    - if <player.attack_cooldown_percent> < 100:
      - stop
    - playsound at:<player.location> volume:2 sound:item_trident_throw pitch:2
    - define lookpos <player.eye_location.forward[3]>
    - define lookray <player.eye_location.points_between[<[lookpos]>].distance[0.8]>
    - foreach <[lookray]>:
      - foreach <[value].find_entities.within[1.5].filter_tag[<[filter_value].is_projectile>]> as:deflected:
        - if <[deflected].script.name> == coin:
          - foreach next
        - if <[deflected].has_flag[parried]>:
          - foreach next
        - if <[deflected].script.name> == missile:
          - playeffect at:<[deflected].location> effect:flash offset:0 quantity:1 visibility:100
          - playsound at:<[deflected].location> volume:3 sound:entity_zombie_attack_iron_door pitch:0
          - narrate <element[+ ].italicize.bold.color[#FFFFFF]><element[DAVY CROCKETT].italicize.bold.color[#FF40FF]> targets:<player>
          - run achievementgive def:<player>|homer
          - flag <player> stylestatus:<player.flag[stylestatus].add[1000]>
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
        - if <[deflected].script.name||0> != missile:
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