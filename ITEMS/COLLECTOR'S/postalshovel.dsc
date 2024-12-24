postalshovel:
  type: item
  material: iron_shovel
  display name: <element[Parcel Gardener].color_gradient[from=#808060;to=#C04040]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374285
    attribute_modifiers:
      GENERIC_ATTACK_SPEED:
        1:
          operation: add_scalar
          amount: -0.5
          slot: hand
  lore:
  - <element[I think we found this one in a parcel center?].color_gradient[from=#404030;to=#602020]>
  - <element[Not sure what it was doing there...].color_gradient[from=#404030;to=#602020]>
  - <&7> 
  - <element[COLLECTOR'S].color[#800000].bold>

postalshoveltriggers:
  type: world
  debug: false
  events:
    on player left clicks block with:postalshovel:
    - determine cancelled passively
    - if <player.attack_cooldown_percent> < 100:
      - stop
    - if <context.location.block.material.name||0> != 0:
      - playsound at:<player.eye_location> sound:<list[custom.shovelbash1|custom.shovelbash2].random> volume:2 pitch:<list[0.8|0.9|1|1.1|1.2].random> custom
      - playeffect at:<context.location.add[0.5,0.5,0.5]> effect:block_crack special_data:<context.location.block.material.name> offset:0.4 quantity:60
    - else:
      - playsound at:<player.location> volume:2 sound:entity_player_attack_weak pitch:1
    - define lookpos <player.eye_location.forward[4]>
    - define lookray <player.eye_location.points_between[<[lookpos]>].distance[0.75]>
    - foreach <[lookray]>:
      - foreach <[value].find_entities.within[1.75].filter_tag[<[filter_value].is_projectile.and[<[filter_value].has_flag[parried2].not>]>]> as:deflected:
        - playsound at:<[deflected].location> volume:2 sound:custom.shoveldeflect pitch:<list[0.8|0.9|1|1.1|1.2].random> custom
        - playeffect at:<[deflected].location> effect:crit offset:1 quantity:20 visibility:100
        - adjust <[deflected]> velocity:<location[0,0,0].random_offset[1].normalize>
        - narrate <element[+ ].italicize.bold.color[#FFFFFF]><element[DEFLECTED].italicize.bold.color[#00FFFF]> targets:<player>
        - flag <player> stylestatus:<player.flag[stylestatus].add[75]>
        - flag <[deflected]> parried2
    on player damages entity with:postalshovel:
    - determine cancelled passively
    - if <context.damager.fall_distance> > 25:
      - narrate <element[+ ].italicize.bold.color[#FFFFFF]><element[SCREAMING EAGLES].italicize.bold.color[#80FF80]> targets:<context.damager>
      - run achievementgive def:<context.damager>|marketgarden
      - flag <context.damager> stylestatus:<context.damager.flag[stylestatus].add[<context.damager.fall_distance.mul[20]>]>
    - define fallpower <context.damager.fall_distance.max[0].add[0.5]>
    - if <context.entity.health> > <[fallpower].add[3]>:
      - playsound at:<player.eye_location> sound:<list[custom.shovelbash1|custom.shovelbash2].random> volume:2 pitch:<list[0.8|0.9|1|1.1|1.2].random> custom
    - else:
      - playsound at:<player.eye_location> sound:custom.shovelkill volume:2 pitch:<list[0.8|0.9|1|1.1|1.2].random> custom
    - hurt <context.entity> <[fallpower].add[3]>
    - adjust <context.entity> velocity:<context.damager.eye_location.direction.vector.normalize.mul[<[fallpower]>].add[0,<[fallpower].div[2]>,0]>
    - if <player.attack_cooldown_percent> < 100:
      - stop
    - if <player.has_flag[shovelcooldown]>:
      - stop
    - flag <player> shovelcooldown expires:6s
    - itemcooldown iron_shovel duration:6s
    - playeffect at:<context.entity.eye_location> effect:block_crack special_data:redstone_wire offset:0.25 quantity:30
    - playeffect at:<context.entity.eye_location> effect:item_crack special_data:redstone offset:0.25 quantity:30
    - playeffect at:<context.entity.eye_location> effect:item_crack special_data:red_dye offset:0.25 quantity:30
    - playeffect at:<context.entity.eye_location> effect:block_crack special_data:redstone_block offset:0.25 quantity:30
    - adjust <context.damager> fall_distance:0
    - if <context.entity.is_player>:
      - cast <context.entity> blindness duration:80t amplifier:2 no_icon hide_particles no_ambient
      - cast <context.entity> slow duration:80t amplifier:2 no_icon hide_particles no_ambient
      - cast <context.entity> slow_digging duration:80t amplifier:2 no_icon hide_particles no_ambient
      - cast <context.entity> weakness duration:80t amplifier:2 no_icon hide_particles no_ambient
      - cast <context.entity> confusion duration:120t amplifier:20 no_icon hide_particles no_ambient
    - else:
      - if <context.entity.is_aware>:
        - define awre <context.entity.is_aware>
        - adjust <context.entity> is_aware:false
        - repeat 4:
          - look <context.entity> <context.entity.eye_location.random_offset[1,0,1]>
          - wait 20t
        - adjust <context.entity> is_aware:<[awre]>
    on player walks:
    - if <player.item_in_hand.script||0> == <script[postalshovel]>:
      - if <player.fall_distance> > 25:
        - if !<player.has_flag[screamingeagles]>:
          - flag <player> screamingeagles
          - playsound at:<player.location> sound:custom.eaglecry pitch:1 volume:10 custom
          - waituntil <player.fall_distance> == 0
          - flag <player> screamingeagles:!