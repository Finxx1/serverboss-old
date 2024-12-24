ballin:
  type: item
  material: clay_ball
  display name: <element[Basketball].color_gradient[from=#C06000;to=#404040]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374242
    attribute_modifiers:
      GENERIC_ATTACK_SPEED:
        1:
          operation: add_scalar
          amount: -0.75
          slot: hand
  lore:
  - <element[OMARITO I AM FUCKING BALLIN!!!!!].color_gradient[from=#603000;to=#202020]>
  - <&7>
  - <element[COLLECTOR'S].color[#800000].bold>

balltriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:ballin:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot basketball speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3]> script:bouncy def:<player>|<player.eye_location.below[0.2].right[0.3]>|1
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:6 pitch:0
    on player left clicks block with:ballin:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:6 pitch:0
    - playsound at:<player.eye_location> sound:entity_wither_shoot volume:6 pitch:0
    - foreach <player.eye_location.below[0.2].right[0.3].points_between[<player.eye_location.below[0.2].right[0.3].forward[6]>].distance[0.5]>:
      - playeffect effect:smoke quantity:3 offset:0.25 visibility:100 at:<[value]>
    - shoot basketball speed:2 spread:0 shooter:<player> origin:<player.eye_location.below[0.2].right[0.3]> script:bouncyhard def:<player>|<player.eye_location.below[0.2].right[0.3]>|1

bouncy:
  type: task
  debug: false
  definitions: shooterplayer|originpos|bounces
  script:
  - if <[bounces]> > 16:
    - foreach <[location].points_between[<[shooterplayer].eye_location.below[0.2].right[0.3]>].distance[0.5]>:
      - playeffect at:<[value].sub[0,1,0]> effect:portal quantity:8 offset:1 visibility:100
      - playeffect at:<[value]> effect:redstone special_data:1|<color[#C06000]> quantity:8 offset:0 visibility:100
      - if <[loop_index].mod[10]> == 0:
        - wait 1t
    - give to:<[shooterplayer].inventory> ballin quantity:1
    - playsound at:<[location]> sound:entity_enderman_teleport volume:6 pitch:1
    - stop
  - define motherfucker <[location].find.living_entities.within[1.5].get[1]||0>
  - if <[motherfucker]> == <[shooterplayer]>:
    - give to:<[shooterplayer].inventory> ballin quantity:1
  - else:
    - if <[motherfucker]> != 0:
      - playsound at:<[location]> sound:custom.ballhit volume:3 pitch:<list[0.8|0.9|1|1.1|1.2].random> custom
    - else:
      - playsound at:<[location]> sound:custom.ballbounce volume:3 pitch:<list[0.8|0.9|1|1.1|1.2].random> custom
    - flag <[motherfucker]> balled expire:4s
    - hurt <[motherfucker]> amount:3
    - adjust <[motherfucker]> velocity:<[motherfucker].eye_location.sub[<[originpos]>].normalize.mul[2]>
    - define bouncetarget <[location].find.living_entities.within[15].filter_tag[<[filter_value].has_flag[balled].not.and[<[filter_value].location.line_of_sight[<[location]>].or[<[filter_value].eye_location.line_of_sight[<[location]>]>]>]>].get[1].eye_location.add[0,0.25,0]||0>
    - if <[bouncetarget]> == 0:
      - shoot basketball speed:1 spread:0 origin:<[location]> destination:<[location].add[0,1,0].random_offset[0.5]> script:bouncy def:<[shooterplayer]>|<[location]>|<[bounces].add[1]>
    - else:
      - shoot basketball speed:1 spread:0 origin:<[location]> destination:<[bouncetarget]> script:bouncy def:<[shooterplayer]>|<[location]>|<[bounces].add[1]>
  

bouncyhard:
  type: task
  debug: false
  definitions: shooterplayer|originpos|bounces
  script:
  - if <[bounces]> > 4:
    - foreach <[location].points_between[<[shooterplayer].eye_location.below[0.2].right[0.3]>].distance[0.5]>:
      - playeffect at:<[value].sub[0,1,0]> effect:portal quantity:8 offset:1 visibility:100
      - playeffect at:<[value]> effect:redstone special_data:2|<color[#C06000]> quantity:8 offset:0 visibility:100
    - give to:<[shooterplayer].inventory> ballin quantity:1
    - playsound at:<[location]> sound:entity_enderman_teleport volume:6 pitch:1
    - stop
  - define motherfucker <[location].find.living_entities.within[1.5].get[1]||0>
  - if <[motherfucker]> == <[shooterplayer]>:
    - give to:<[shooterplayer].inventory> ballin quantity:1
  - else:
    - playeffect at:<[location]> effect:flash quantity:1 offset:0.1 visibility:100
    - if <[motherfucker]> != 0:
      - playsound at:<[location]> sound:custom.ballhit volume:5 pitch:<list[0.8|0.9|1|1.1|1.2].random> custom
#      - playsound at:<[location]> sound:custom.classic_explode volume:5 pitch:<list[0.8|0.9|1|1.1|1.2].random> custom
      - playsound at:<[location]> sound:entity_generic_explode volume:5 pitch:<list[0.8|0.9|1|1.1|1.2].random>
    - else:
      - playsound at:<[location]> sound:custom.ballbounce volume:5 pitch:<list[0.8|0.9|1|1.1|1.2].random> custom
#      - playsound at:<[location]> sound:custom.classic_explode volume:5 pitch:<list[0.8|0.9|1|1.1|1.2].random> custom
      - playsound at:<[location]> sound:entity_generic_explode volume:5 pitch:<list[0.8|0.9|1|1.1|1.2].random>
    - flag <[motherfucker]> balled expire:4s
    - hurt <[motherfucker]> amount:7
    - adjust <[motherfucker]> velocity:<[motherfucker].eye_location.sub[<[originpos]>].normalize.mul[5]>
    - define bouncetarget <[location].find.living_entities.within[35].filter_tag[<[filter_value].has_flag[balled].not.and[<[filter_value].location.line_of_sight[<[location]>].or[<[filter_value].eye_location.line_of_sight[<[location]>]>]>]>].get[1].eye_location.add[0,0.25,0]||0>
    - if <[bouncetarget]> == 0:
      - shoot basketball speed:2 spread:0 origin:<[location]> destination:<[location].add[0,1,0].random_offset[0.5]> script:bouncyhard def:<[shooterplayer]>|<[location]>|<[bounces].add[1]>
    - else:
      - shoot basketball speed:2 spread:0 origin:<[location]> destination:<[bouncetarget]> script:bouncyhard def:<[shooterplayer]>|<[location]>|<[bounces].add[1]>
  