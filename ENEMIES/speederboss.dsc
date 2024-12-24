speeder:
  type: entity
  entity_type: armor_stand
  mechanisms:
    marker: true
    gravity: false
    invulnerable: true

speederboss:
  type: entity
  entity_type: skeleton
  mechanisms:
    custom_name: <&3>Speeder323
    custom_name_visible: true
    equipment: <map[helmet=stone_button]>
    item_in_hand: <item[air]>
    item_in_offhand: <item[air]>
    silent: true

speederspawnworld:
  type: world
  events:
    on speeder spawns:
    #- announce "SPEEDER SPAWNED"
    - define location <context.entity.location>
    - remove <context.entity>
    - playsound <[location]> sound:entity_wither_spawn pitch:0.5
    - wait 5s
    - run speederspawnthunder def:<[location]>
    - wait 5s
    - strike <[location]>
    - playeffect effect:flash at:<[location].above> offset:0.1 quantity:5
    - spawn <entity[speederboss].with_map[invulnerable=true]> <[location]>
    on block ignites:
    - if <context.location.find_entities[speeder].within[40].size> != 0:
      - if <context.cause> == LIGHTNING:
        - determine cancelled

speederspawnthunder:
  type: task
  definitions: centerlocation
  script:
  - foreach <proc[particle_ring].context[<[centerlocation]>|8|6]>:
    - strike <[value]>
    - foreach <proc[particle_ring].context[<[value]>|6|1]> as:value2:
      - playeffect effect:soul_fire_flame at:<[value2].above[0.2]> offset:0.1 quantity:2 data:0.5
    - wait 0.4s

speederbossspawnworld:
  type: world
  events:
    on speederboss spawns:
    - run speederdisguise def:<context.entity>
    - wait 1t
    - define target <context.entity.location.find_players_within[30].first>
    - teleport <context.entity> <context.entity.location.face[<[target].eye_location>]>
    - adjust <context.entity> velocity:<context.entity.location.sub[<[target].location.above[1.5]>].normalize.mul[-1.7]>
    - run speedermeleestage def:<context.entity>
    - repeat 10:
      - wait 1t
      - look <context.entity> <[target].eye_location> duration:1t
      - attack <context.entity> target:<[target]>

speederinvul:
  type: task
  debug: false
  definitions: boss|duration
  script:
  - cast fire_resistance <[boss]> hide_particles duration:<[duration]>
  - flag <[boss]> invul expire:<duration[<[duration]>]>
  - adjust <[boss]> invulnerable:true
  - while <[boss].has_flag[invul]> && <[boss].is_spawned||false>:
    - wait 2t
    - burn <[boss]> duration:0
    - run speederinvulparticles def:<[boss]>
  - adjust <[boss]> invulnerable:false

speederinvulparticles:
  type: task
  debug: false
  definitions: boss
  script:
  - repeat 3:
    - if <[boss].is_spawned||false>:
      - playeffect effect:crit_magic at:<[boss].location.forward_flat[1].above[1.2]> offset:1.4,1.8,1.4 quantity:10 velocity:<[boss].location.backward_flat.sub[<[boss].location.forward_flat>].random_offset[0.3].mul[1.3]>

speederdisguise:
  type: task
  definitions: boss
  script:
  - libsdisguise player target:<[boss]> name:speeder323 display_name:Speeder323
  - waituntil <[boss].is_spawned>
  - libsdisguise player target:<[boss]> name:speeder323 display_name:Speeder323