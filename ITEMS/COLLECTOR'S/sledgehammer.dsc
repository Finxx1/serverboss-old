sledgehammer:
  type: item
  material: iron_axe
  display name: <element[Sledgehammer].color_gradient[from=#000000;to=#808080]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374200
  lore:
  - <element[lost this one in your mom yesterday].color_gradient[from=#000000;to=#404040]>
  - <&7>
  - <element[COLLECTOR'S].color[#800000].bold>

sledgehammerspinning:
  type: item
  material: iron_axe
  display name: <element[Sledgehammer].color_gradient[from=#000000;to=#808080]><element[ ]><element[(Spinning)].color[#FFFFFF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374201
  lore:
  - <element[how did she even survive].color_gradient[from=#000000;to=#404040]>
  - <&7>
  - <element[COLLECTOR'S].color[#800000].bold>

spinnysledge:
  type: entity
  entity_type: snowball
  mechanisms:
    item: sledgehammerspinning

sledgehammertriggers:
  type: world
  debug: false
  events:
    on player damages entity with:sledgehammer:
    - if !<context.entity.is_spawned>:
      - stop
    - if <context.damager.has_flag[sledgecooldown]>:
      - stop
    - flag <context.damager> sledgecooldown expire:6s
    - itemcooldown iron_axe duration:6s
    - playeffect at:<context.entity.eye_location> offset:0 quantity:1 visibility:100 effect:FLASH
    - playsound at:<context.entity.eye_location> sound:entity_generic_explode volume:2 pitch:2
    - if <context.entity.is_player>:
      - cast <context.entity> blindness duration:80t amplifier:1 no_icon hide_particles no_ambient
      - cast <context.entity> slow duration:60t amplifier:1 no_icon hide_particles no_ambient
      - cast <context.entity> weak duration:60t amplifier:0 no_icon hide_particles no_ambient
      - cast <context.entity> slow_digging duration:60t amplifier:1 no_icon hide_particles no_ambient
      - cast <context.entity> confusion duration:100t amplifier:2 no_icon hide_particles no_ambient
    - else:
      - define awareness <context.entity.is_aware>
      - adjust <context.entity> is_aware:false
      - repeat 3:
        - look <context.entity> <context.entity.eye_location.random_offset[1,0,1]>
        - wait 20t
      - adjust <context.entity> is_aware:<[awareness]>
    on player right clicks block with:sledgehammer:
    - determine cancelled passively
    - ratelimit <player> 1t
    - if <player.has_flag[sledgecooldown]>:
      - stop
    - flag <player> sledgecooldown expire:6t
    - itemcooldown iron_axe duration:6t
    - shoot spinnysledge origin:<player.eye_location.right[0.4].below[0.4]> height:1 spread:10 gravity:0.025 script:sledgehit def:<player>

sledgehit:
  debug: false
  definitions: thecoolguy
  type: task
  script:
  - determine cancelled passively
  - define sh_hitent <[hit_entities].get[1]||0>
  - if <[sh_hitent]> == 0:
    - playeffect at:<[location]> offset:0 quantity:1 visibility:100 effect:FLASH
    - playsound at:<[location]> sound:entity_generic_explode volume:2 pitch:2
    - stop
  - playeffect at:<[sh_hitent].eye_location> offset:0 quantity:1 visibility:100 effect:FLASH
  - playsound at:<[sh_hitent].eye_location> sound:entity_generic_explode volume:2 pitch:2
  - if <[sh_hitent].has_flag[ikeaframe]>:
    - stop
  - if <[sh_hitent].is_player>:
    - cast <[sh_hitent]> blindness duration:40t amplifier:1 no_icon hide_particles no_ambient
    - cast <[sh_hitent]> slow duration:20t amplifier:1 no_icon hide_particles no_ambient
    - cast <[sh_hitent]> weak duration:20t amplifier:0 no_icon hide_particles no_ambient
    - cast <[sh_hitent]> slow_digging duration:20t amplifier:1 no_icon hide_particles no_ambient
    - cast <[sh_hitent]> confusion duration:60t amplifier:2 no_icon hide_particles no_ambient
  - else:
    - define awareness <[sh_hitent].is_aware>
    - adjust <[sh_hitent]> is_aware:false
    - look <[sh_hitent]> <[sh_hitent].eye_location.random_offset[1,0,1]>
    - wait 20t
    - adjust <[sh_hitent]> is_aware:<[awareness]>
  - adjust <[sh_hitent]> velocity:<[sh_hitent].velocity.add[<[sh_hitent].eye_location.sub[<[thecoolguy].location>].mul[0.25]>]>
  - hurt <[sh_hitent]> 5