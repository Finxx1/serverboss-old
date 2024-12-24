aimacyst:
  type: item
  material: clay_ball
  display name: <element[Aima].color_gradient[from=#800080;to=#000000]><element[ ]><element[Cyst].color_gradient[from=#000000;to=#00FFFF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374352
  lore:
  - <element[We are beset by].color_gradient[from=#400040;to=#000000]><element[ ]><element[incoherent foes].color_gradient[from=#000000;to=#008080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

aimacystproj:
  type: entity
  entity_type: snowball
  mechanisms:
    item: aimacyst

aimacysttriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:aimacyst:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot aimacystproj speed:0.5 spread:5 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:aimacystscript
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0
    on entity damaged:
    - if <context.entity.has_flag[vulnerability]>:
      - determine <context.damage.mul[3]> passively
      - playsound at:<context.entity.eye_location> sound:block_glass_break volume:2 pitch:0
      - playsound at:<context.entity.eye_location> sound:entity_zombie_attack_wooden_door volume:2 pitch:0
      - playsound at:<context.entity.eye_location> sound:entity_zombie_attack_iron_door volume:2 pitch:0
      - playsound at:<context.entity.eye_location> sound:entity_iron_golem_hurt volume:2 pitch:0
#      - playsound at:<context.entity.eye_location> sound:block_anvil_place volume:2 pitch:0
      - if <context.entity.flag[vulnerability]> > 1:
        - flag <context.entity> vulnerability:--
      - else:
        - flag <context.entity> vulnerability:!
    on delta time secondly:
    - foreach <server.online_players>:
      - foreach <[value].eye_location.find.living_entities.within[25].exclude[<[value]>].filter_tag[<[filter_value].has_flag[vulnerability]>]> as:madoarepula:
        - playeffect at:<[madoarepula].eye_location> effect:redstone special_data:1|<color[#C000C0]> offset:1 quantity:5 visibility:100
#doarepula
#doarepula
#doarepula
#doarepula
#doarepula
#doarepula
#doarepula
#doarepula
#doarepula
#doarepula
#doarepula

aimacystscript:
  type: task
  script:
  - playeffect at:<[location]> effect:redstone special_data:2.5|<color[#C000C0]> offset:0.5 quantity:10 visibility:100
  - playsound at:<[location]> sound:block_glass_break volume:2 pitch:1
  - playsound at:<[location]> sound:block_glass_break volume:2 pitch:0
  - playsound at:<[location]> sound:item_bucket_fill_lava volume:2 pitch:0
  - playsound at:<[location]> sound:item_bottle_fill_dragonbreath volume:2 pitch:1
  - playsound at:<[location]> sound:item_bottle_fill_dragonbreath volume:2 pitch:0
  - playsound at:<[location]> sound:block_brewing_stand_brew volume:2 pitch:0
  - define hittargs <[location].find.living_entities.within[6].exclude[<player>]||0>
  - repeat 12:
    - playeffect at:<[location]> effect:item_crack special_data:aimacyst visibility:100 velocity:<location[0,0,0].random_offset[0.2].add[0,0.1,0]> quantity:2 offset:0.5
  - if <[hittargs]> == 0:
    - stop
  - foreach <[hittargs]>:
    - playeffect at:<[value].eye_location> effect:redstone special_data:2|<color[#C000C0]> offset:0.5 quantity:5 visibility:100
    - flag <[value]> vulnerability:<[value].flag[vulnerability].add[3]||3> expire:400t
    - wait 4t