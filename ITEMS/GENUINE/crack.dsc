crack:
  type: item
  material: diamond
  display name: <element[Crack].color_gradient[from=#C0FFFF;to=#FFFFFF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375238
  lore:
  - <element[EVERY CELL OF MY BEING BURNS WITH WHITE-HOT ECSTASY].color_gradient[from=#608080;to=#808080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

pocketfuck:
  type: item
  material: diamond
  display name: <element[Pocket <&k>FUCK<&r>!].color_gradient[from=#8000FF;to=#FF0000;style=HSB]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375239
  lore:
  - <element[???].color_gradient[from=#400080;to=#800000;style=HSB]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>


pocketsand:
  type: item
  material: diamond
  display name: <element[Pocket Sand!].color_gradient[from=#FFC060;to=#C08020]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375240
  lore:
  - <element[AArhgh!].color_gradient[from=#806030;to=#604010]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

sandstun:
  type: task
  definitions: hittarg|durat
  script:
  - if !<[hittarg].is_player>:
    - define awareness <[hittarg].is_aware>
    - adjust <[hittarg]> is_aware:false
    - wait <[durat]>t
    - adjust <[hittarg]> is_aware:<[awareness]>
  - else:
    - cast <[hittarg]> blindness duration:<[durat].add[50]>t amplifier:2 no_icon hide_particles no_ambient

cracktriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:crack:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - playeffect at:<player.eye_location> quantity:16 special_data:2|<color[#C0FFFF]> offset:0.4 visibility:100 effect:redstone
    - playsound sound:entity_blaze_shoot pitch:2 volume:2 at:<player.eye_location>
    - playsound sound:entity_player_levelup pitch:1 volume:2 at:<player.eye_location>
    - flag <player> withdrawn:!
    - if <player.has_flag[high]>:
      - flag <player> high expire:400t
    - else:
      - flag <player> high expire:400t
      - while <player.has_flag[high]>:
        - cast <player> speed duration:4t amplifier:2 no_icon hide_particles no_ambient
        - cast <player> fast_digging duration:4t amplifier:2 no_icon hide_particles no_ambient
        - cast <player> jump duration:4t amplifier:1 no_icon hide_particles no_ambient
        - cast <player> regeneration duration:4t amplifier:0 no_icon hide_particles no_ambient
        - wait 3t
    - flag <player> withdrawn expire:700t
    - while <player.has_flag[withdrawn]>:
      - cast <player> slow duration:4t amplifier:0 no_icon hide_particles no_ambient
      - cast <player> weakness duration:4t amplifier:0 no_icon hide_particles no_ambient
      - cast <player> slow_digging duration:4t amplifier:0 no_icon hide_particles no_ambient
      - if <util.random_chance[5]> && <player.health> > 1:
        - hurt <player> amount:1
      - wait 3t
    on player right clicks block with:pocketsand:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - define lookvec <player.eye_location.direction.vector>
    - define lookpos <player.eye_location.add[<[lookvec].mul[6]>]>
    - define lookline <player.eye_location.points_between[<[lookpos]>].distance[1]>
    - playsound sound:block_sand_place at:<player.eye_location> pitch:0 volume:2
    - playsound sound:block_sand_place at:<player.eye_location> pitch:1 volume:2
    - playsound sound:block_sand_place at:<player.eye_location> pitch:2 volume:2
    - foreach <[lookline]>:
      - playeffect at:<[value]> quantity:6 special_data:2|<color[#FFC060]> offset:0.5 visibility:100 effect:redstone
      - wait 1t
      - foreach <[value].find.living_entities.within[2].exclude[<player>].filter_tag[<[filter_value].has_flag[sanded].not>]||0> as:val2:
        - flag <[val2]> sanded expire:40t
        - run sandstun def:<[val2]>|30
        - playsound sound:block_sand_step at:<[val2].eye_location> pitch:0 volume:2
        - playsound sound:block_sand_step at:<[val2].eye_location> pitch:1 volume:2
        - playsound sound:block_sand_step at:<[val2].eye_location> pitch:2 volume:2
    on player right clicks block with:pocketfuck:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - define lookvec <player.eye_location.direction.vector>
    - define lookpos <player.eye_location.add[<[lookvec].mul[6]>]>
    - define lookline <player.eye_location.points_between[<[lookpos]>].distance[1]>
    - playsound sound:custom.glitchthrow at:<player.eye_location> pitch:1 volume:2 custom
    - foreach <[lookline]>:
      - playeffect at:<[value]> quantity:5 offset:0.5 visibility:100 effect:flame
      - playeffect at:<[value]> quantity:5 offset:0.5 visibility:100 effect:soul_fire_flame
      - playeffect at:<[value]> quantity:5 offset:0.5 visibility:100 effect:smoke
      - playeffect at:<[value]> quantity:5 offset:0.5 visibility:100 effect:soul
      - playeffect at:<[value]> quantity:5 offset:0.5 visibility:100 effect:villager_happy
      - playeffect at:<[value]> quantity:5 offset:0.5 visibility:100 effect:crit
      - playeffect at:<[value]> quantity:5 offset:0.5 visibility:100 effect:magic_crit
      - repeat 3 as:norepval:
 #       - playeffect at:<[value]> quantity:1 offset:0.5 visibility:100 effect:random
        - playeffect at:<[value]> quantity:3 special_data:2|<color[#<list[FF|C0|80|60|40|00].random><list[FF|C0|80|60|40|00].random><list[FF|C0|80|60|40|00].random>]> offset:0.5 visibility:100 effect:redstone
      - wait 1t
      - foreach <[value].find.living_entities.within[2].exclude[<player>].filter_tag[<[filter_value].has_flag[sanded].not>]||0> as:val2:
        - teleport <[val2]> <[val2].location.random_offset[3,3,3].add[0,3,0].find_spawnable_blocks_within[4].get[1]>
        - hurt <[val2]> amount:<list[5|10|20].random>
    - playeffect at:<[lookpos]> quantity:5 offset:0.5 visibility:100 effect:barrier
    on tick every:2:
    - foreach <server.online_players||0>:
      - if <[value].has_flag[high]> && !<[value].is_on_ground>:
        - adjust <[value]> velocity:<[value].eye_location.direction.vector.normalize.mul[<[value].velocity.vector_length.mul[1.1]>].with_y[<[value].velocity.y>]>