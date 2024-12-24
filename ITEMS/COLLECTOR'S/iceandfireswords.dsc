icesword:
  type: item
  material: diamond_sword
  display name: <element[Ice Sword].color_gradient[from=#20C0C0;to=#C0FFFF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374206
    attribute_modifiers:
      GENERIC_ATTACK_SPEED:
        1:
          operation: add_scalar
          amount: -0.75
          slot: hand
  lore:
  - <element[One of two kinds].color_gradient[from=#106060;to=#608080]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>


firesword:
  type: item
  material: golden_sword
  display name: <element[Fire Sword].color_gradient[from=#602020;to=#C0C060]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374207
    attribute_modifiers:
      GENERIC_ATTACK_SPEED:
        1:
          operation: add_scalar
          amount: -0.9
          slot: hand
  lore:
  - <element[One of two kinds].color_gradient[from=#301010;to=#606030]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>


fswordtriggers:
  type: world
  debug: false
  events:
    on player left clicks block with:firesword:
    - if <player.attack_cooldown_percent> < 100:
      - stop
    - run fireswordswipe def:<player>
    on player damages entity with:firesword:
    - if <player.attack_cooldown_percent> < 100 || <context.cause> == ENTITY_SWEEP_ATTACK:
      - stop
    - run fireswordswipe def:<player>

iswordtriggers:
  type: world
  debug: false
  events:
    on player left clicks block with:icesword:
    - if <player.attack_cooldown_percent> < 100:
      - stop
    - run iceswordswipe def:<player>
    on player damages entity with:icesword:
    - if <player.attack_cooldown_percent> < 100 || <context.cause> == ENTITY_SWEEP_ATTACK:
      - stop
    - run iceswordswipe def:<player>

iceswordswipe:
  type: task
  debug: false
  definitions: swinger
  script:
  - playsound at:<[swinger].location> volume:2 sound:item_trident_throw pitch:0
  - define lookinplace <[swinger].eye_location>
  - foreach <list[<[lookinplace].forward[2].above[1.5].left[1.5]>|<[lookinplace].forward[2.5].above[0.75].left[0.75]>|<[lookinplace].forward[2.5].above[-0.75].left[-0.75]>|<[lookinplace].forward[2].above[-1.5].left[-1.5]>]> as:val2:
    - playeffect at:<[val2]> effect:sweep_attack offset:0.1 quantity:1 visibility:100
    - playeffect at:<[val2]> effect:block_crack special_data:ice offset:0.3 visibility:100 quantity:15
    - define hittarg <[val2].find.living_entities.within[1.25].exclude[<[swinger]>]>
    - foreach <[hittarg]>:
      - hurt <[value]> 5 source:<[swinger]> cause:ENTITY_SWEEP_ATTACK
      - cast <[value]> slow duration:1s amplifier:3 no_icon hide_particles no_ambient
      - cast <[value]> weakness duration:1s amplifier:3 no_icon hide_particles no_ambient
      - cast <[value]> slow_digging duration:1s amplifier:3 no_icon hide_particles no_ambient
      - playeffect at:<[value].eye_location.sub[0,1,0]> effect:block_crack special_data:ice offset:0.7 visibility:100 quantity:60
      - playsound at:<[value].eye_location> sound:entity_zombie_villager_cure pitch:2 volume:2
      - playsound at:<[value].eye_location> sound:block_glass_break pitch:1 volume:2
      - playsound at:<[value].eye_location> sound:block_glass_break pitch:0 volume:2
    - wait 1t

fireswordswipe:
  type: task
  debug: false
  definitions: swinger
  script:
  - playsound at:<[swinger].location> volume:2 sound:item_trident_throw pitch:0
  - define lookinplace <[swinger].eye_location>
  - foreach <list[<[lookinplace].forward[2].above[1.5].left[-1.5]>|<[lookinplace].forward[2.5].above[0.75].left[-0.75]>|<[lookinplace].forward[2.5].above[-0.75].left[0.75]>|<[lookinplace].forward[2].above[-1.5].left[1.5]>]> as:val2:
    - playeffect at:<[val2]> effect:sweep_attack offset:0.1 quantity:1 visibility:100
    - playeffect at:<[val2]> effect:lava offset:0.3 visibility:100 quantity:15
    - define hittarg <[val2].find.living_entities.within[1.25].exclude[<[swinger]>]>
    - foreach <[hittarg]>:
      - hurt <[value]> 8 source:<[swinger]> cause:ENTITY_SWEEP_ATTACK
      - burn <[value]> duration:8s
      - playeffect at:<[value].eye_location.sub[0,1,0]> effect:lava offset:0.7 visibility:100 quantity:60
      - playsound at:<[value].eye_location> sound:entity_blaze_shoot pitch:0 volume:2
      - playsound at:<[value].eye_location> sound:block_glass_break pitch:0 volume:2
    - wait 2t