kavruka:
  type: item
  material: clay_ball
  display name: <element[Kavruka].color_gradient[from=#FF00FF;to=#00FFFF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374351
  lore:
  - <element[Our only option is to fight].color_gradient[from=#800080;to=#008080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

kavrukaproj:
  type: entity
  entity_type: snowball
  mechanisms:
    item: kavruka

kavrukatriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:kavruka:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot kavrukaproj speed:1 spread:5 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:kavrukascript
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0

kavrukascript:
  type: task
  script:
  - playeffect at:<[location]> effect:flash offset:0 quantity:1 visibility:100
  - define hittargs <[location].find.living_entities.within[6].exclude[<player>].first[8]||0>
  - repeat 32:
    - playeffect at:<[location]> effect:item_crack special_data:kavruka visibility:100 velocity:<location[0,0,0].random_offset[0.4].add[0,0.2,0]> quantity:2 offset:0.5
  - if <[hittargs]> == 0:
    - playsound at:<[location]> sound:custom.shot<list[1|2|3|4|5|6|7].random> pitch:<list[0.7|0.8|0.9].random> volume:2 custom
    - playeffect at:<[location]> effect:large_explode offset:0 quantity:1 visibility:100
    - stop
  - foreach <[hittargs]>:
    - playeffect at:<[location]> effect:large_explode offset:0.1 quantity:2 visibility:100
    - playeffect at:<[value].eye_location> effect:large_explode offset:0 quantity:1 visibility:100
    - hurt <[value]> amount:<list[6|6|6|18].random> source:<player>
    - playsound at:<[location]> sound:custom.shot<list[1|2|3|4|5|6|7].random> pitch:<list[0.9|1|1.1].random> volume:2 custom
    - wait 4t