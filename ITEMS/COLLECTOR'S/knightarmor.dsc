knighthelmet:
  type: item
  material: golden_helmet
  display name: <element[Knight Helmet].color_gradient[from=#606060;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374201
    attribute_modifiers:
      generic_movement_speed:
        1:
          operation: multiply_scalar_1
          amount: -0.1
          slot: chest
          id: 10000000-1000-1000-1000-100000000000
  lore:
  - <element[You have my sword].color_gradient[from=#303030;to=#606060]>
  - <&7>
  - <element[COLLECTOR'S].color[#800000].bold>

knightchestplate:
  type: item
  material: diamond_chestplate
  display name: <element[Knight Chestplate].color_gradient[from=#606060;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374202
    attribute_modifiers:
      generic_movement_speed:
        1:
          operation: multiply_scalar_1
          amount: -0.3
          slot: chest
          id: 10000000-1000-1000-1000-100000000000
  lore:
  - <element[And my bow].color_gradient[from=#303030;to=#606060]>
  - <&7>
  - <element[COLLECTOR'S].color[#800000].bold>

knightleggings:
  type: item
  material: golden_leggings
  display name: <element[Knight Leggings].color_gradient[from=#606060;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374202
    attribute_modifiers:
      generic_movement_speed:
        1:
          operation: multiply_scalar_1
          amount: -0.2
          slot: chest
          id: 10000000-1000-1000-1000-100000000000
  lore:
  - <element[And my axe].color_gradient[from=#303030;to=#606060]>
  - <&7>
  - <element[COLLECTOR'S].color[#800000].bold>

knightboots:
  type: item
  material: golden_boots
  display name: <element[Knight Boots].color_gradient[from=#606060;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374202
    attribute_modifiers:
      generic_movement_speed:
        1:
          operation: multiply_scalar_1
          amount: -0.1
          slot: chest
          id: 10000000-1000-1000-1000-100000000000
  lore:
  - <element[And your brother!].color_gradient[from=#303030;to=#606060]>
  - <&7>
  - <element[COLLECTOR'S].color[#800000].bold>

knightarmortrigger:
  type: world
  debug: false
  events:
    on player damaged by FALL:
    - define entdam <context.entity.location>
    - define falldam <context.damage>
#    - announce <[falldam]>
    - if <context.entity.has_equipped[knightboots]>:
      - repeat <[falldam].mul[0.4].round_down>:
        - foreach <[entdam].points_around_y[points=<[value].mul[2].round_down.add[4]>;radius=<[value]>]> as:pre_ringloc:
#          - announce <[pre_ringloc].with_pitch[90].ray_trace[range=4;return=block;default=air;ignore=<context.entity>;nonsolids=false]||0>
          - define ringloc <[pre_ringloc].with_pitch[90].ray_trace[range=8;return=block;default=air;ignore=<context.entity>;nonsolids=false;fluids=true]||0>
          - if <[ringloc].material.name> != air:
#            - announce <[ringloc]>
#            - explode <[ringloc].add[0.5,1,0.5]> power:1
            - if <[ringloc].block.material.name> == water:
#              - playsound at:<[ringloc].above[2]> sound:entity_generic_splash pitch:0 volume:1
              - playsound at:<[ringloc].above[2]> sound:entity_generic_splash pitch:1 volume:1
              - playsound at:<[ringloc].above[2]> sound:weather_rain pitch:1 volume:1
              - playsound at:<[ringloc].above[2]> sound:weather_rain pitch:2 volume:1
              - playeffect at:<[ringloc].add[0.5,0,0.5]> effect:water_bubble quantity:12 offset:2,1,2 visibility:100 velocity:<location[0,-1,0]>
              - repeat 4:
                - playeffect at:<[ringloc].add[0.5,2,0.5]> effect:water_splash quantity:48 offset:0.5,1,0.5 visibility:100
              - playeffect at:<[ringloc].add[0.5,1,0.5]> effect:water_wake quantity:20 offset:0.35,0.2,0.35 visibility:100
              - foreach <[ringloc].find_entities.within[4].exclude[<context.entity>]> as:hurter:
                - adjust <[hurter]> velocity:<[hurter].velocity.add[<[hurter].eye_location.sub[<[entdam]>].normalize.mul[1]>].add[0,0.5,0]>
                - hurt <[hurter]> <[falldam]>
            - else:
              - playsound at:<[ringloc]> sound:entity_generic_explode pitch:1 volume:1
              - playeffect at:<[ringloc].add[0.5,1,0.5]> effect:block_crack special_data:<[ringloc].block.material.name> quantity:48 offset:0.35,0,0.35 visibility:100
              - playeffect at:<[ringloc].add[0.5,1,0.5]> effect:cloud quantity:2 offset:0.5 visibility:100 velocity:<location[0,0.2,0].add[<[ringloc].sub[<[entdam]>].normalize.mul[0.2].with_y[0]>]>
              - foreach <[ringloc].find_entities.within[2].exclude[<context.entity>]> as:hurter:
                - adjust <[hurter]> velocity:<[hurter].velocity.add[<[hurter].eye_location.sub[<[entdam]>].normalize.mul[2]>].add[0,0.5,0]>
                - hurt <[hurter]> <[falldam]>
        - wait 3t
    on entity knocks back player:
    - if <context.entity.inventory.contains_any[knighthelmet|knightchestplate|knightleggings|knightboots]>:
      - define result <context.acceleration>
      - if <context.entity.has_equipped[knighthelmet]>:
        - define result <[result].mul[0.7]>
      - if <context.entity.has_equipped[knightchestplate]>:
        - define result <[result].mul[0.5]>
      - if <context.entity.has_equipped[knightleggings]>:
        - define result <[result].mul[0.6]>
      - if <context.entity.has_equipped[knightboots]>:
        - define result <[result].mul[0.8]>
      - determine <[result]>
    on player damaged:
    - if <context.entity.inventory.contains_any[knighthelmet|knightchestplate|knightleggings|knightboots]>:
      - define result <context.damage>
      - if <context.entity.has_equipped[knighthelmet]>:
        - playsound sound:item_armor_equip_iron at:<context.entity.eye_location> pitch:1 volume:1
        - define result <[result].mul[0.7]>
      - if <context.entity.has_equipped[knightchestplate]>:
        - playsound sound:item_armor_equip_netherite at:<context.entity.eye_location> pitch:1 volume:1
        - define result <[result].mul[0.5]>
      - if <context.entity.has_equipped[knightleggings]>:
        - playsound sound:block_chain_break at:<context.entity.eye_location> pitch:0 volume:1
        - define result <[result].mul[0.6]>
      - if <context.entity.has_equipped[knightboots]>:
        - playsound sound:item_armor_equip_iron at:<context.entity.eye_location> pitch:0 volume:1
        - define result <[result].mul[0.8]>
      - determine <[result]>