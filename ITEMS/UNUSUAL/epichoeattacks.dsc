epichoepoison:
  type: task
  debug: false
  definitions: target|damager
  script:
  # 1:
  # particles, sound
  - playeffect effect:redstone special_data:1.6|green quantity:20 at:<[target].eye_location> offset:0.8
  - playeffect effect:redstone special_data:1|lime quantity:50 at:<[target].eye_location> offset:1
  - playsound sound:entity_generic_extinguish_fire pitch:1.2 at:<[target].location>
  # 2:
  # the poison
  # 2.1
  # check if already got poison, just stack
  - if <[target].has_effect[poison]> && <[target].has_flag[epichoepoisoned]>:
    - cast <[target]> poison duration:120t amplifier:2
    - cast <[target]> slow duration:20t amplifier:2
    - stop
  # 2.2
  # poison mechanic
  - cast <[target]> poison duration:120t amplifier:2
  - cast <[target]> slow duration:20t amplifier:2
  - flag <[target]> epichoepoisoned
  - while <[target].has_effect[poison]>:
    - if <[target].is_spawned.not>:
      - stop
    - wait 20t
    - if <[target].health> > 2:
      - hurt <[target]> 2 cause:poison
    - else:
      - playsound sound:entity_generic_extinguish_fire pitch:2 volume:0.05 at:<[target].location>
      - playeffect effect:redstone special_data:0.7|lime quantity:25 at:<[target].eye_location> offset:0.6
      - playeffect effect:redstone special_data:2|lime quantity:15 at:<[target].eye_location> offset:0.6
      - cast <[target]> slow duration:20t amplifier:3
  - flag <[target]> epichoepoisoned:!
  - if <[target].entity_type> == zombie || <[target].entity_type> == zombie_villager || <[target].entity_type> == husk || <[target].entity_type> == skeleton <[target].entity_type> == stray:
    - adjust <[target]> no_damage_duration:<duration[1t]>
    - wait 1t
    - playeffect effect:redstone special_data:4|black quantity:10 at:<[target].eye_location> offset:0.6
    - playsound at:<[target].location> sound:entity_elder_guardian_curse
    - cast wither amplifier:2 duration:3s <[target]>
    - cast slow amplifier:2 duration:3s <[target]>
    - hurt <[target]> 8 cause:poison

epichoepoisonworld:
  type: world
  debug: false
  events:
    on entity damaged:
    - if <context.entity.has_flag[epichoepoisoned]>:
      - if <context.cause> == poison || <context.damager.item_in_hand.script.name||no> == epichoe:
        - playeffect effect:redstone special_data:0.9|lime quantity:30 at:<context.entity.eye_location> offset:1
        - playsound sound:entity_generic_extinguish_fire pitch:1.6 at:<context.entity.location> volume:0.4
        - cast <context.entity> slow duration:15t amplifier:3

epichoewind:
  type: task
  definitions: target|damager
  script:
  # 1
  #
  # one time vel 
  - adjust <[target]> velocity:<[target].velocity.add[<util.random.decimal[1].to[-1]>,<util.random.decimal[0.3].to[0.05]>,<util.random.decimal[1].to[-1]>]>
  # 2
  # particles, sound
  - playsound at:<[target].location> pitch:2 sound:entity_bat_takeoff
  - repeat 17:
    - wait 2t
    - playsound at:<[target].location> pitch:<util.random.decimal[0.3].to[0.9]> volume:1 sound:entity_ender_dragon_flap
    - playeffect at:<[target].location> effect:cloud data:0.085 offset:0.5 quantity:15 visibility:50
    - playeffect at:<[target].location.below[0.15]> effect:cloud data:0.085 offset:0.35 quantity:20 visibility:50
    - playeffect at:<[target].location.below[0.30]> effect:cloud data:0.085 offset:0.20 quantity:8 visibility:50
    # 3
    # velocity2
    - adjust <[target]> velocity:<[target].velocity.add[<util.random.decimal[0.17].to[-0.17]>,<util.random.decimal[0.16].to[0.1]>,<util.random.decimal[0.17].to[-0.17]>]>
  - repeat 2:
    - wait 2t
    - playsound at:<[target].location> pitch:<util.random.decimal[1.3].to[2]> volume:0.7 sound:entity_ender_dragon_flap
    - playeffect at:<[target].location> effect:cloud data:0.085 offset:0.5 quantity:15 visibility:50
    - playeffect at:<[target].location.below[0.15]> effect:cloud data:0.085 offset:0.35 quantity:20 visibility:50
    - playeffect at:<[target].location.below[0.30]> effect:cloud data:0.085 offset:0.20 quantity:8 visibility:50
  - wait 2t
  - playsound sound:entity_generic_explode at:<[target].location> volume:1 pitch:1.5
  - playsound sound:entity_lightning_bolt_thunder at:<[target].location> volume:0.8 pitch:2
  - repeat 3:
    - playsound at:<[target].location> pitch:<util.random.decimal[0.2].to[0.4]> volume:1 sound:entity_ender_dragon_flap
  - playeffect at:<[target].location> effect:flash quantity:3 visibility:50
  - playeffect at:<[target].location.above[6]> effect:cloud data:0.1 offset:4.0,0.2,4.0 quantity:50 visibility:50
  - playeffect at:<[target].location.above[6]> effect:cloud data:0.07 offset:4.0,0.2,4.0 quantity:50 visibility:50
  - playeffect at:<[target].location.above[5]> effect:cloud data:0.05 offset:2.0,0.5,2.0 quantity:50 visibility:50
  - playeffect at:<[target].location.above[5.5]> effect:villager_angry data:0.05 offset:2.0,0.5,2.0 quantity:50 visibility:50
  - adjust <[target]> velocity:<location[0.0,-1.7,0.0,<[target].location.world>]>
  - adjust <[target]> fall_distance:<[target].fall_distance.add[7]>
  - flag <[target]> epichoefalldamage

epichoefalldamage:
  type: world
  events:
    on entity damaged by fall:
    - if <context.entity.has_flag[epichoefalldamage]>:
      - flag <context.entity> epichoefalldamage:!
      - playeffect at:<context.entity.location.above> effect:explosion_normal offset:0.2 quantity:30 data:1
      - playeffect at:<context.entity.location.above> effect:explosion_huge quantity:1
      - playsound at:<context.entity.location> sound:entity_generic_explode volume:0.2 pitch:1.5
      - wait 1t
      - if <context.entity.is_spawned.not>:
        - stop
      - cast <context.entity> slow duration:30t amplifier:2
      - repeat 9:
        - wait 3t
        - if <context.entity.is_spawned.not>:
          - stop
        - playeffect at:<context.entity.eye_location.above> effect:smoke data:0.1 offset:0.2 quantity:45
        - playeffect at:<context.entity.eye_location> effect:smoke data:0.2 offset:0.2 quantity:45

epichoeearthhit:
  type: task
  definitions: target|damager
  script:
  # 1
  # particles,sounds
  - repeat 3:
    - playeffect at:<[target].location.above> effect:block_crack special_data:dirt offset:1 quantity:70
    - playeffect at:<[target].location.above> effect:block_crack special_data:dirt offset:0.6 quantity:70
    - playeffect at:<[target].location.above> effect:block_crack special_data:dirt offset:0.8 quantity:70
    - playsound at:<[target].location.above> sound:block_grass_break volume:1.2
  - foreach <[damager].location.above.points_between[<[damager].location.above.forward[3]>].distance[0.5]>:
    - playeffect at:<[value]> effect:block_crack special_data:dirt offset:0.5 quantity:50
  - playsound at:<[target].location> sound:entity_zombie_break_wooden_door volume:0.8
  - playsound at:<[target].location> sound:entity_zombie_attack_iron_door volume:1
  - playsound at:<[target].location> sound:entity_zombie_attack_iron_door volume:1 pitch:1.2
  # 2
  # reset and damage again
  - adjust <[target]> no_damage_duration:<duration[1t]>
  - wait 1t
  - flag <[target]> earthhit
  - hurt <[target]> 16 source:<[damager]>

epichoeearthhitworld:
  type: world
  events:
    on entity knocks back entity:
    - if <context.entity.has_flag[earthhit]>:
      - flag <context.entity> earthhit:!
      - define velocidad <context.acceleration.mul[3.5].with_y[<context.acceleration.y.mul[1.2]>]>
      - determine <[velocidad].add[0.0,0.5,0.0]> passively
      - repeat 3:
        - wait 1t
        - if <context.entity.is_spawned.not>:
          - stop
        - adjust <context.entity> velocity:<[velocidad].add[<context.entity.velocity>]>
        - playeffect at:<context.entity.location> effect:cloud offset:1 data:0.3 quantity:25 visibility:200
        - playsound at:<context.entity.location> sound:entity_generic_extinguish_fire volume:0.61 pitch:2
        - playsound at:<context.entity.location> sound:block_grass_break volume:0.5
      - wait 2t
      - adjust <context.entity> fall_distance:<context.entity.fall_distance.add[5]>
      - while <context.entity.is_on_ground.not>:
          - wait 1t
          - if <context.entity.is_spawned.not>:
            - stop
          - playeffect at:<context.entity.location> effect:cloud offset:0.5 data:0.1 quantity:7 visibility:200
          - playsound at:<context.entity.location> sound:entity_generic_extinguish_fire volume:0.41 pitch:2
          - playsound at:<context.entity.location> sound:block_grass_break volume:0.5
      - playsound at:<context.entity.location> sound:entity_zombie_attack_iron_door pitch:0
      - playsound at:<context.entity.location> sound:entity_zombie_attack_iron_door pitch:0.3
      - playeffect at:<context.entity.location.above> effect:block_crack special_data:dirt offset:1 quantity:70 visibility:200
      - playeffect at:<context.entity.location.above> effect:block_crack special_data:dirt offset:1.6 quantity:70 visibility:200
      - playeffect at:<context.entity.location.above> effect:block_crack special_data:dirt offset:0.8 quantity:70 visibility:200
      - if <context.entity.is_spawned>:
        - cast <context.entity> slow amplifier:5 duration:30t