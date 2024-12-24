swordknightzombiesummon:
  type: item
  material: iron_sword
  display name: <&3>Sword Knight Zombie Summoner

axeknightzombiesummon:
  type: item
  material: iron_axe
  display name: <&3>Axe Knight Zombie Summoner

zombieknightsummons:
  type: world
  debug: false
  events:
    on player right clicks block:
    - choose <context.item.script.name||null>:
      - case axeknightzombiesummon:
        - spawn knightzombie[item_in_hand=knightaxe]
      - case swordknightzombiesummon:
          - spawn knightzombie[item_in_hand=knightsword]

axekzalwaysshield:
  type: world
  debug: false
  events:
    after knightzombie spawns:
    - if <context.entity.item_in_hand.contains_any_text[axe]> && <context.entity.item_in_offhand.script.name> != knightzombieshield:
      - if <util.random.int[1].to[2]> == 1:
        - equip <context.entity> offhand:knightzombieshield

knightzombie:
  type: entity
  entity_type: zombie
  mechanisms:
    equipment: <map[helmet=<item[iron_helmet]>;chestplate=<item[iron_chestplate]>;leggings=<item[iron_leggings]>;boots=<item[iron_boots]>]>
    item_in_hand: <list[knightsword|knightsword|knightaxe].random>
    item_in_offhand: <list[knightzombieshield|knightzombieshield|knightzombieshield|air|air|air].random>
    #item_in_hand: iron_axe
    #item_in_offhand: knightzombieshield
    age: adult
    max_health: 30
    health: 30

knightzombieshield:
  type: item
  material: shield
  display name: <&2>Zombie Shield
  mechanisms:
    base_color: blue
    patterns: <list[purple/gradient|green/gradient_up|white/skull]>

knightzombieshield2:
  type: item
  material: shield
  display name: <&2>Zombie Shield
  mechanisms:
    base_color: blue
    patterns: <list[purple/gradient|green/gradient_up|red/skull]>

knightzombiechargecounter:
  type: world
  debug: false
  events:
    on entity damages knightzombie:
    - if <context.entity.has_flag[kzshieldmidair]>:
      - playsound at:<context.entity.location> sound:entity_ender_dragon_growl volume:1.5 pitch:1.3
      - playsound at:<context.entity.location> sound:entity_generic_explode volume:1.5
      - playsound at:<context.entity.location> sound:entity_wither_break_block volume:0.8
      - playeffect at:<context.entity.location> effect:explosion_large quantity:8 offset:0.4
      - playeffect at:<context.entity.location> effect:explosion_normal quantity:24 offset:0.4
      - playeffect at:<context.entity.location.above[1.5]> effect:flash offset:0
      - adjust <context.entity> velocity:<context.entity.location.sub[<context.damager.location>].normalize.mul[1.8].with_y[0.8]>
      - determine <context.damage.mul[5].add[10]>

knightzombiehandler:
  type: world
  debug: false
  events:
    on knightzombie dies:
    - repeat 2:
      - playsound <context.entity.location> sound:item_shield_break pitch:0.7
    on entity damages knightzombie:
    - playsound <context.entity.location> sound:entity_zombie_attack_iron_door volume:0.3
    on entity knocks back knightzombie:
    - if <context.entity.has_flag[kzgrabinterrupted].not>:
      - determine <context.acceleration.mul[0.5]>
    - else:
      - determine <context.acceleration.mul[2.5].with_y[<context.acceleration.y.mul[1.2]>]>
    on knightzombie damages entity:
    - if <context.damager.item_in_hand.contains_any_text[axe]>:
      - run knightzombiearmordamage def:<context.damager>|<context.entity>
    on knightzombie spawns:
    - run knightzombiespawn def:<context.entity>

swordknightzombieshield:
  type: world
  debug: false
  events:
    on entity damages knightzombie:
    - if <context.entity.item_in_hand.contains_any_text[sword]> && <context.entity.eye_location.facing[<context.damager.location>].degrees[90]>:
      - if <context.entity.has_flag[knightzombieshieldcd].not>:
        - if <context.entity.item_in_offhand.contains_any_text[shield]||false>:
          - define hasshield true
        - else:
          - define hasshield false
        - if <[hasshield]>:
          - if <util.random.int[1].to[4]> == 1:
            - define good true
        - if <[hasshield].not>:
          - if <util.random.int[1].to[8]> == 1:
            - define good true
        #- define good true
        - if <[good]>:
          - if <context.final_damage> < <context.entity.health.mul[1.5]>:
            - playeffect effect:flash at:<context.entity.location.above[1.5]> offset:0.1 quantity:3
            - playsound <context.entity.location> sound:entity_ender_dragon_hurt pitch:1.4
            - playsound <context.entity.location> sound:entity_zombie_attack_iron_door pitch:0.9
            - cast <context.entity> slow amplifier:2 duration:1s
            - cast <context.entity> damage_resistance amplifier:2 duration:1s
            - playeffect effect:flash at:<context.entity.location.above[1.5]> offset:0.1 quantity:3
            - if <[hasshield]>:
              - flag <context.entity> knightzombieshieldcd expire:<duration[4s]>
              - playeffect effect:block_crack special_data:iron_block at:<context.entity.location.above[1.5].forward_flat[0.5]> offset:0.2 quantity:20
              - if <context.damager.location.distance[<context.entity.location>]> < 4:
                - cast <context.damager> slow amplifier:2 duration:1s
                - adjust <context.damager> velocity:<context.damager.location.sub[<context.entity.location>].normalize.mul[1.2]>
              - if <context.projectile||null> != null:
                - run kzprojectileparry def:<context.entity>|<context.damager>|<context.projectile>
              - determine cancelled
            - if <[hasshield].not>:
              - flag <context.entity> knightzombieshieldcd expire:<duration[6s]>
              - playeffect effect:sweep_attack at:<context.entity.location.above[1.5].forward_flat[0.5]> offset:0 quantity:1
              - if <context.damager.location.distance[<context.entity.location>]> < 4:
                - adjust <context.damager> velocity:<context.damager.location.sub[<context.entity.location>].normalize.mul[1.2]>
                - hurt <context.damager> <context.damage.mul[0.5]> source:<context.entity>
              - if <context.projectile||null> != null:
                - run kzprojectileparry def:<context.entity>|<context.damager>|<context.projectile>
              - determine <context.damage.mul[0.5]>

kzprojectileparry:
  type: task
  debug: false
  definitions: knight|shooter|oldprojectile
  script:
  #- teleport <[projectile]> <[knight].location.forward[1]>
  #- playeffect soul_fire_flame at:<[shooter].eye_location> quantity:10 offset:0.2
  - remove <[oldprojectile]>
  - define projectile <[oldprojectile].describe>
  - shoot <[projectile]> shooter:<[knight]> origin:<[knight].eye_location.forward[0.3]> destination:<[shooter].location.above[1.7]> save:proj speed:2
  - define projectilenew <entry[proj].shot_entity>
  - wait 1t
  - while <[projectilenew].is_on_ground.not>:
    - playeffect flame at:<[projectilenew].location> offset:0.1 quantity:3
    - wait 1t

shieldtest:
  type: world
  debug: false
  events:
    on player damaged:
    - stop
    - announce <context.damage_type_map>

swordknightzombiearmorbypass:
  type: world
  debug: false
  events:
    on knightzombie damages entity:
    - if <context.damage_type_map.get[blocking]> != 0 || <context.damage_type> != entity_attack:
      - stop
    - if <context.damager.item_in_hand.contains_any_text[sword]>:
      - if <context.damage> > <context.final_damage>:
        - define difference <context.damage.sub[<context.final_damage>]>
        - define differencehalf <[difference].mul[0.3]>
        - define determinedfinal <context.final_damage.add[<[differencehalf]>]>
        #- announce <&c>---------
        #- announce "<&a>INITIAL: <context.final_damage>"
        #- announce "<&7><&o>(Could've been: <context.damage>)"
        #- announce "<&c>ABSORBED <&9>(HALF)<&c>: <[difference]> <&9>(<[differencehalf]>)"
        #- announce "<&6>TOTAL: <[determinedfinal]>"
        - determine CLEAR_MODIFIERS passively
        - determine <[determinedfinal]>
        #- define damagecutout <context.damage.sub[<context.final_damage>].abs>
        #- define damageadded <[damagecutout].mul[0.4]>
        #- announce "<context.final_damage> + <[damageadded]>"
        #- determine <context.final_damage.add[<[damageadded]>]>

knightzombieinterruptionhandler:
  type: world
  debug: false
  events:
    on entity damaged by entity priority:-1:
    - if <context.entity.has_flag[knightzombiegrabbed]>:
      - determine cancelled
    - if <context.entity.has_flag[knightzombiegrab]>:
      - if <context.damager.has_flag[knightzombiegrabbed]>:
        - flag <context.entity> kzgrabinterrupted expire:<duration[1s]>
        - run knightzombieinterruptbash def:<context.entity>|<context.damager>|<context.entity.location>
        - define flingloc <context.damager.location.sub[<context.entity.location>]>
        - adjust <context.entity> velocity:<[flingloc].normalize.mul[1.5].add[0,0.3,0]>
        - determine <context.damage.mul[3]>
      - else:
        - determine cancelled
    on knightzombie damaged:
    - playsound sound:ITEM_ARMOR_EQUIP_iron pitch:0 at:<context.entity.eye_location> volume:2
    - playsound sound:block_chain_break pitch:0 at:<context.entity.eye_location> volume:2

knightzombiearmordamage:
  type: task
  debug: false
  definitions: knightzombie|target
  script:
  # cooldown
  - if <[knightzombie].has_flag[knightzombiearmordamagecd]>:
    - stop
  - flag <[knightzombie].find_entities[knightzombie].within[10].filter[has_flag[knightzombiearmordamagecd].not]> knightzombiearmordamagecd expire:<duration[6s]>
  # we do with flags because better
  - run kzarmorbroken def:<[target]>
  # cool effects after because theres a delay aaaugh
  - define loc <[target].location>
  - repeat 3:
    - playeffect at:<[loc].above> crit data:0.7 quantity:30 offset:0.8
    - playsound <[loc]> sound:item_armor_equip_chain
  - if <[target].is_player>:
    - title targets:<[target]> "subtitle:<&c>-5 ARMOR" fade_in:0t
  - playsound <[loc]> sound:entity_zombie_attack_iron_door pitch:1.2
  - wait 6t
  - playsound <[loc]> sound:entity_zombie_attack_iron_door pitch:1.2
  - if <[target].is_player>:
    - title targets:<[target]> "subtitle:<&7>-5 ARMOR" stay:0.4s fade_in:0t fade_out:0.6s

kzarmorbroken:
  type: task
  debug: false
  definitions: target
  script:
  - define HADALREADY false
  - if <[target].has_flag[kzarmorbroken]>:
    - define HADALREADY true
  - flag <[target]> kzarmorbroken expire:<duration[8s]>
  - adjust <[target]> armor_bonus:-5
  - if !<[HADALREADY]>:
    - wait 1t
    - while <[target].has_flag[kzarmorbroken]> && <[target].is_spawned>:
      - playeffect at:<[target].location.above[1.5]> crit quantity:10
      - if <[target].is_player>:
        - actionbar targets:<[target]> "<&c>ARMOR BROKEN"
      - wait 1s
    - adjust <[target]> armor_bonus:0
    - if <[target].is_spawned>:
      - playeffect at:<[target].location.above[1.5]> totem quantity:20 offset:0.8
      - if <[target].is_player>:
        - playsound <[target]> sound:entity_player_levelup
        - actionbar targets:<[target]> "<&a>ARMOR <&m>BROKEN"
    - if <[target].is_spawned.not>:
      - if <[target].is_player>:
        - flag <[target]> kzarmorbroken:!

knightzombiespawn:
  type: task
  debug: false
  definitions: knightzombie
  script:
  - wait 1t
  - if <[knightzombie].item_in_hand.contains_any_text[sword]>:
    - cast <[knightzombie]> speed amplifier:0 duration:100000000s
    - libsdisguise player target:<[knightzombie]> name:Shark_Duck hide_name
  - else:
    - libsdisguise player target:<[knightzombie]> name:Northgar hide_name
  - while <[knightzombie].is_spawned>:
    - if <[knightzombie].target||null> != null
    - if !<[knightzombie].has_flag[knightzombieabilitycd]>:
      - if <[knightzombie].item_in_hand.contains_any_text[axe]> && <[knightzombie].item_in_offhand.material.name> == shield:
        #axe+shield shit
        - run kzaxecharge def:<[knightzombie]>
      - if <[knightzombie].item_in_hand.contains_any_text[sword]> && <[knightzombie].item_in_offhand.material.name> == shield:
        #sword+shield shit
        - run kzswordbash def:<[knightzombie]>
    - wait 1s

kzaxecharge:
  type: task
  debug: false
  definitions: knightzombie
  script:
  # conditions
  - if <[knightzombie].target||null> == null || !<[knightzombie].target.location.line_of_sight[<[knightzombie].location>]>:
    - stop
  # very good if it got here
  - flag <[knightzombie]> knightzombieabilitycd expire:<duration[10s]>
  - define target <[knightzombie].target>
  - adjust <[knightzombie]> location:<[knightzombie].location.face[<[target].location>].above[0.75]>
  - wait 1t
  - define flingloc <[target].location.sub[<[knightzombie].location>]>
  - adjust <[knightzombie]> velocity:<[flingloc].normalize.mul[1.2].with_y[0.7]>
  #- shoot <[knightzombie]> origin:<[knightzombie].location> destination:<[target].location.above[1.5]> speed:2 no_rotate
  - playsound sound:entity_ravager_roar volume:2.5 <[knightzombie].location>
  - playsound sound:entity_ravager_roar volume:2.5 <[knightzombie].location> pitch:1.5
  - playsound sound:entity_zombie_infect <[knightzombie].location>
  - flag <[knightzombie]> kzshieldmidair expire:<duration[2s]>
  - wait 1t
  - equip <[knightzombie]> offhand:knightzombieshield2
  - while <[knightzombie].has_flag[kzshieldmidair]> && <[knightzombie].is_on_ground.not> && <[knightzombie].is_spawned>:
    - playeffect at:<[knightzombie].location> offset:0.5,0.1,0.5 flame quantity:15
    - playeffect at:<[knightzombie].location.left[0.1]> offset:0.1,0,0.1 flame quantity:6
    - playeffect at:<[knightzombie].location.right[0.1]> offset:0.1,0,0.1 flame quantity:6
    - wait 2t
  - if <[knightzombie].has_flag[kzshieldmidair]>:
    - flag <[knightzombie]> kzshieldmidair:!
  - if <[knightzombie].is_spawned>:
    - cast <[knightzombie]> speed amplifier:2 duration:2s
    - repeat 20:
      - if <[knightzombie].is_spawned>:
        - playeffect at:<[knightzombie].location.left[0.1]> offset:0.1,0,0.1 flame quantity:6
        - playeffect at:<[knightzombie].location.right[0.1]> offset:0.1,0,0.1 flame quantity:6
        - wait 2t
  - if <[knightzombie].is_spawned>:
    - equip <[knightzombie]> offhand:knightzombieshield

kzswordbash:
  type: task
  debug: false
  definitions: knightzombie
  script:
  - define target <[knightzombie].target||null>
  # conditions
  - if <[knightzombie].target||null> == null || !<[knightzombie].target.location.line_of_sight[<[knightzombie].location>]> || <[knightzombie].target.location.distance[<[knightzombie].location>]> > 2.3:
    - stop
  - if <[knightzombie].has_flag[knightzombiegrab]> || <[target].has_flag[knightzombiegrabbed]>:
    - stop
  # very good if it got here
  # flag
  - flag <[knightzombie]> knightzombiegrab expire:<duration[0.9s]>
  - flag <[target]> knightzombiegrabbed expire:<duration[0.9s]>
  - flag <[knightzombie]> knightzombieabilitycd expire:<duration[12s]>
  - flag <[knightzombie].location.find_entities[knightzombie].within[6].exclude[<[knightzombie]>].filter[has_flag[knightzombieabilitycd].not]> knightzombieabilitycd expire:<duration[6s]>
  - teleport <[knightzombie]> <[knightzombie].location.forward_flat[0.5]>
  - teleport <[target]> <[knightzombie].location.forward_flat[<[target].location.distance[<[knightzombie].location>]>].with_yaw[<[target].location.yaw>].with_pitch[<[target].location.pitch>]>
  #- teleport <[knightzombie]> location:<[knightzombie].location.points_between[<[target].location>].distance[0.8].reverse.get[3].backward_flat[0.3]>
  - cast <[target]> blindness duration:2.2s
  - cast <[target]> slow amplifier:5 duration:1s
  - cast <[knightzombie]> glowing duration:1s
  #- announce <[knightzombie].location.find_entities.within[8].filter[target.is[==].to[<[knightzombie].target>]||false].size>
  #- cast <[knightzombie].location.find_entities.within[8].filter[target.is[==].to[<[knightzombie].target>]||false]> slow amplifier:10 duration:3s
  - cast <[knightzombie]> slow amplifier:10 duration:4s
  - define loc <[knightzombie].location>
  - playsound <[loc]> sound:entity_zombie_villager_converted pitch:0.5
  - repeat 3:
    - if <[knightzombie].has_flag[kzgrabinterrupted]>:
      - stop
    - playeffect flame <[loc].above[1]> offset:0.5 quantity:40
    - playsound <[loc]> sound:entity_blaze_shoot pitch:0.9
    - wait 5t
  - if <[knightzombie].has_flag[kzgrabinterrupted]>:
    - stop
  - playsound <[target].location> sound:entity_zombie_attack_iron_door pitch:0.9
  - playeffect soul_fire_flame <[loc].above[1]> offset:0.5 quantity:40
  - playsound <[loc]> sound:entity_blaze_shoot pitch:0.9
  - wait 5t
  - if <[knightzombie].has_flag[kzgrabinterrupted]>:
    - stop
  - playsound <[target].location> sound:entity_vex_death pitch:0
  - playsound <[target].location> sound:entity_zombie_attack_iron_door pitch:1.1
  - flag <[target]> knightzombiegrabbed:!
  - hurt <[target]> 5 source:<[knightzombie]> cause:magic
  - define flingloc <[target].location.sub[<[loc]>]>
  - adjust <[knightzombie]> velocity:<[flingloc].normalize.mul[1.3].add[0,0.4,0].mul[-1]>
  - adjust <[target]> velocity:<[flingloc].normalize.mul[1.5].add[0,0.3,0]>

knightzombieinterruptbash:
  type: task
  debug: false
  definitions: knightzombie|target|loc
  script:
  - playeffect effect:explosion_huge at:<[loc].above> offset:0
  - playeffect effect:flash at:<[loc].above[1.5]> offset:0
  - playsound sound:entity_generic_explode volume:1.5 <[loc]>
  - playsound sound:entity_wither_hurt volume:1.5 <[loc]>
  - playsound sound:entity_wither_hurt volume:1.5 <[loc]> pitch:0.5
  - flag <[target]> knightzombiegrabbed:!
  - wait 1t
  - if <[knightzombie].is_spawned.not>:
    - stop
  - flag <[knightzombie]> knightzombiegrab:!
  - teleport <[knightzombie]> <[loc].face[<[loc].below.forward>]>
  - if <[target].is_player>:
    - title targets:<[target]> subtitle:<&a><&o>COUNTERED! fade_in:0t fade_out:10t stay:5t
    - cast <[target]> speed amplifier:2 duration:2s
    - adjust <[target]> velocity:<[target].location.sub[<[loc]>].normalize.mul[1.5]>
    - cast <[target]> slow remove
  - flag <[knightzombie]> knightzombieabilitycd expire:<duration[25s]>