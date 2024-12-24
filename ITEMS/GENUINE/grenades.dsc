fraggrenade:
  type: item
  material: clay_ball
  display name: <element[Fragmentation Grenade].color_gradient[from=#305010;to=#303030]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374353
  lore:
  - <element[GRENADE!].color_gradient[from=#182808;to=#181818]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

fragproj:
  type: entity
  entity_type: snowball
  mechanisms:
    item: fraggrenade

incendiarygrenade:
  type: item
  material: clay_ball
  display name: <element[Incendiary Grenade].color_gradient[from=#802020;to=#303030]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374354
  lore:
  - <element[FIRE IN THE HOLE!].color_gradient[from=#401010;to=#181818]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

incendiaryproj:
  type: entity
  entity_type: snowball
  mechanisms:
    item: incendiarygrenade

smokegrenade:
  type: item
  material: clay_ball
  display name: <element[Smoke Grenade].color_gradient[from=#606060;to=#202020]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374355
  lore:
  - <element[Wanna see a magic trick?].color_gradient[from=#303030;to=#101010]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

smokeproj:
  type: entity
  entity_type: snowball
  mechanisms:
    item: smokegrenade

fraggrenadestriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:fraggrenade:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot fragproj speed:1 spread:1 shooter:<player> origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:1
    after fragproj spawns:
    - if !<context.entity.has_flag[grenadetimer]>:
      - flag <context.entity> grenadetimer:70
    - while <context.entity.is_spawned>:
      - if <context.entity.flag[grenadetimer]> < 1:
        - explode <context.entity.location> power:5
        - remove <context.entity>
        - stop
      - playeffect effect:smoke at:<context.entity.location> offset:0.05 quantity:1 visibility:100
      - flag <context.entity> grenadetimer:<context.entity.flag[grenadetimer].sub[1]>
      - wait 1t
    on fragproj collides with entity:
    - explode <context.entity.location> power:5
    on fragproj hits block:
    - define timerleft <context.projectile.flag[grenadetimer]>
    - define projvel <context.projectile.velocity>
    - define projbnc <context.projectile.flag[bounces]>
    - define shootercont <context.shooter>
    - define hitface <context.hit_face>
    - define pvel2 <location[<[projvel].x.mul[<[hitface].x.abs.mul[-2].add[1]>]>,<[projvel].y.mul[<[hitface].y.abs.mul[-2].add[1]>]>,<[projvel].z.mul[<[hitface].z.abs.mul[-2].add[1]>]>].mul[0.75]>
    - define bounceloc <context.location.add[0.5,0.5,0.5].add[<[hitface].mul[0.8]>]>
    - playsound <[bounceloc]> sound:item_armor_equip_iron pitch:<list[0.7|0.8|0.9|1].random> volume:1
    - playsound <[bounceloc]> sound:entity_iron_golem_step pitch:<list[0.7|0.8|0.9|1].random> volume:1
    - playsound <[bounceloc]> sound:entity_iron_golem_step pitch:<list[1.7|1.8|1.9|2].random> volume:1
    - playeffect at:<[bounceloc]> effect:flash offset:0 visibility:100
    - spawn fragproj[velocity=<[pvel2]>;shooter=<[shootercont]>] <[bounceloc]> save:grenadeBnc
    - define grnd <entry[grenadeBnc].spawned_entity>
    - flag <[grnd]> grenadetimer:<[timerleft]>

incendiarygrenadestriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:incendiarygrenade:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot incendiaryproj speed:1 spread:1 shooter:<player> origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:1
    after incendiaryproj spawns:
    - if !<context.entity.has_flag[grenadetimer]>:
      - flag <context.entity> grenadetimer:70
    - while <context.entity.is_spawned>:
      - if <context.entity.flag[grenadetimer]> < 1:
        - foreach <context.entity.location.find.living_entities.within[5].exclude[<context.entity>]||0>:
          - burn <[value]> duration:120t
        - repeat 64:
          - define ofset <location[0,0,0].random_offset[1].normalize.mul[<list[0.25|0.5|0.75|1].random>]>
          - playeffect effect:flame at:<context.entity.location.add[<[ofset].mul[2.5]>]> quantity:1 visibility:100 offset:0.1 velocity:<[ofset].mul[0.4]>
        - explode <context.entity.location> power:5
        - remove <context.entity>
        - stop
      - playeffect effect:smoke at:<context.entity.location> offset:0.05 quantity:1 visibility:100
      - flag <context.entity> grenadetimer:<context.entity.flag[grenadetimer].sub[1]>
      - wait 1t
    on incendiaryproj collides with entity:
    - burn <context.entity> duration:600t
    - foreach <context.entity.eye_location.find.living_entities.within[5].exclude[<context.entity>]||0>:
      - burn <[value]> duration:120t
    - repeat 64:
      - define ofset <location[0,0,0].random_offset[1].normalize.mul[<list[0.25|0.5|0.75|1].random>]>
      - playeffect effect:flame at:<context.entity.eye_location.add[<[ofset].mul[2.5]>]> quantity:1 visibility:100 offset:0.1 velocity:<[ofset].mul[0.4]>
    - explode <context.entity.location> power:5
    on incendiaryproj hits block:
    - define timerleft <context.projectile.flag[grenadetimer]>
    - define projvel <context.projectile.velocity>
    - define projbnc <context.projectile.flag[bounces]>
    - define shootercont <context.shooter>
    - define hitface <context.hit_face>
    - define pvel2 <location[<[projvel].x.mul[<[hitface].x.abs.mul[-2].add[1]>]>,<[projvel].y.mul[<[hitface].y.abs.mul[-2].add[1]>]>,<[projvel].z.mul[<[hitface].z.abs.mul[-2].add[1]>]>].mul[0.75]>
    - define bounceloc <context.location.add[0.5,0.5,0.5].add[<[hitface].mul[0.8]>]>
    - playsound <[bounceloc]> sound:item_armor_equip_iron pitch:<list[0.7|0.8|0.9|1].random> volume:1
    - playsound <[bounceloc]> sound:entity_iron_golem_step pitch:<list[0.7|0.8|0.9|1].random> volume:1
    - playsound <[bounceloc]> sound:entity_iron_golem_step pitch:<list[1.7|1.8|1.9|2].random> volume:1
    - playeffect at:<[bounceloc]> effect:flash offset:0 visibility:100
    - spawn incendiaryproj[velocity=<[pvel2]>;shooter=<[shootercont]>] <[bounceloc]> save:grenadeBnc
    - define grnd <entry[grenadeBnc].spawned_entity>
    - flag <[grnd]> grenadetimer:<[timerleft]>

smokegrenadestriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:smokegrenade:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot smokeproj speed:1 spread:1 shooter:<player> origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:2
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:1
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:0
    after smokeproj spawns:
    - if !<context.entity.has_flag[grenadetimer]>:
      - flag <context.entity> grenadetimer:50
    - while <context.entity.is_spawned>:
      - if <context.entity.flag[grenadetimer]> < 1:
        - repeat 64:
          - define ofset <location[0,0,0].random_offset[1].normalize.mul[<list[0.25|0.5|0.75|1].random>]>
          - playeffect effect:campfire_signal_smoke at:<context.entity.location> quantity:4 visibility:100 offset:0.3 velocity:<[ofset].mul[0.2]>
          - define ofset <location[0,0,0].random_offset[1].normalize.mul[<list[0.25|0.5|0.75|1].random>]>
          - playeffect effect:campfire_signal_smoke at:<context.entity.location> quantity:4 visibility:100 offset:0.3 velocity:<[ofset].mul[0.2]>
          - define ofset <location[0,0,0].random_offset[1].normalize.mul[<list[0.25|0.5|0.75|1].random>]>
          - playeffect effect:campfire_signal_smoke at:<context.entity.location> quantity:4 visibility:100 offset:0.3 velocity:<[ofset].mul[0.2]>
          - define ofset <location[0,0,0].random_offset[1].normalize.mul[<list[0.25|0.5|0.75|1].random>]>
          - playeffect effect:campfire_signal_smoke at:<context.entity.location> quantity:4 visibility:100 offset:0.3 velocity:<[ofset].mul[0.2]>
        - repeat 64:
          - repeat 5:
            - playeffect effect:campfire_signal_smoke at:<context.entity.location> quantity:4 visibility:100 offset:3
            - playeffect effect:campfire_signal_smoke at:<context.entity.location> quantity:4 visibility:100 offset:3
            - playeffect effect:campfire_signal_smoke at:<context.entity.location> quantity:4 visibility:100 offset:3
            - playeffect effect:redstone special_data:16|<color[#808080]> at:<context.entity.location> quantity:4 visibility:100 offset:3
        - explode <context.entity.location> power:1
        - define entloc <context.entity.location>
        - remove <context.entity> 
        - foreach <[entloc].find.living_entities.within[6]||0>:
          - cast <[value]> blindness duration:500 amplifier:2 no_icon hide_particles no_ambient
        - repeat 100:
          - foreach <[entloc].find.living_entities.within[6]||0>:
            - attack <[value]> cancel
          - wait 5t
      - playeffect effect:smoke_large at:<context.entity.location> offset:0.05 quantity:1 visibility:100
      - flag <context.entity> grenadetimer:<context.entity.flag[grenadetimer].sub[1]>
      - wait 1t
    on smokeproj collides with entity:
    - define entloc <context.entity.eye_location>
    - repeat 64:
      - define ofset <location[0,0,0].random_offset[1].normalize.mul[<list[0.25|0.5|0.75|1].random>]>
      - playeffect effect:campfire_signal_smoke at:<context.entity.location> quantity:4 visibility:100 offset:0.3 velocity:<[ofset].mul[0.2]>
      - define ofset <location[0,0,0].random_offset[1].normalize.mul[<list[0.25|0.5|0.75|1].random>]>
      - playeffect effect:campfire_signal_smoke at:<context.entity.location> quantity:4 visibility:100 offset:0.3 velocity:<[ofset].mul[0.2]>
      - define ofset <location[0,0,0].random_offset[1].normalize.mul[<list[0.25|0.5|0.75|1].random>]>
      - playeffect effect:campfire_signal_smoke at:<context.entity.location> quantity:4 visibility:100 offset:0.3 velocity:<[ofset].mul[0.2]>
      - define ofset <location[0,0,0].random_offset[1].normalize.mul[<list[0.25|0.5|0.75|1].random>]>
      - playeffect effect:campfire_signal_smoke at:<context.entity.location> quantity:4 visibility:100 offset:0.3 velocity:<[ofset].mul[0.2]>
    - repeat 64:
      - repeat 5:
        - playeffect effect:campfire_signal_smoke at:<context.entity.location> quantity:4 visibility:100 offset:3
        - playeffect effect:campfire_signal_smoke at:<context.entity.location> quantity:4 visibility:100 offset:3
        - playeffect effect:campfire_signal_smoke at:<context.entity.location> quantity:4 visibility:100 offset:3
        - playeffect effect:redstone special_data:16|<color[#808080]> at:<context.entity.location> quantity:4 visibility:100 offset:3
    - explode <context.entity.location> power:1
    - foreach <[entloc].find.living_entities.within[6]||0>:
      - cast <[value]> blindness duration:500 amplifier:2 no_icon hide_particles no_ambient
    - repeat 100:
      - foreach <[entloc].find.living_entities.within[6]||0>:
        - attack <[value]> cancel
      - wait 5t
    on smokeproj hits block:
    - define timerleft <context.projectile.flag[grenadetimer]>
    - define projvel <context.projectile.velocity>
    - define projbnc <context.projectile.flag[bounces]>
    - define shootercont <context.shooter>
    - define hitface <context.hit_face>
    - define pvel2 <location[<[projvel].x.mul[<[hitface].x.abs.mul[-2].add[1]>]>,<[projvel].y.mul[<[hitface].y.abs.mul[-2].add[1]>]>,<[projvel].z.mul[<[hitface].z.abs.mul[-2].add[1]>]>].mul[0.75]>
    - define bounceloc <context.location.add[0.5,0.5,0.5].add[<[hitface].mul[0.8]>]>
    - playsound <[bounceloc]> sound:item_armor_equip_iron pitch:<list[0.7|0.8|0.9|1].random> volume:1
    - playsound <[bounceloc]> sound:entity_iron_golem_step pitch:<list[0.7|0.8|0.9|1].random> volume:1
    - playsound <[bounceloc]> sound:entity_iron_golem_step pitch:<list[1.7|1.8|1.9|2].random> volume:1
    - playeffect at:<[bounceloc]> effect:flash offset:0 visibility:100
    - spawn smokeproj[velocity=<[pvel2]>;shooter=<[shootercont]>] <[bounceloc]> save:grenadeBnc
    - define grnd <entry[grenadeBnc].spawned_entity>
    - flag <[grnd]> grenadetimer:<[timerleft]>