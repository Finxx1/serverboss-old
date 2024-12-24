axemachine:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 100
    health: 100
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: netherite_axe
    item_in_offhand: bow
    speed: 0.325

axemachinehandler:
  type: world
  events:
    after axemachine spawns:
    - libsdisguise player target:<context.entity> name:PryBoiGaming hide_name
# display_name:Axemachine 
    - while <context.entity.is_spawned>:
      - if <context.entity.target.eye_location.line_of_sight[<context.entity.eye_location>]> && <context.entity.target||0> != 0 && <context.entity.target.eye_location.distance[<context.entity.eye_location>]> < 14 && <context.entity.target.eye_location.distance[<context.entity.eye_location>]> > 3:
        - run shootingshit2 def:<context.entity>|<context.entity.target>
      - wait <list[5s|6s|7s|8s].random>
    on axemachine damaged:
    - attack <context.entity> <context.damager>
    on axemachine damaged by BLOCK_EXPLOSION:
    - determine 2 passively
    - playsound at:<context.entity.eye_location> sound:entity_zombie_attack_iron_door pitch:1 volume:5
    - playsound at:<context.entity.eye_location> sound:entity_zombie_attack_iron_door pitch:0 volume:5
    - playsound at:<context.entity.eye_location> sound:entity_experience_orb_pickup pitch:0 volume:5
    - playsound at:<context.entity.eye_location> sound:entity_experience_orb_pickup pitch:1 volume:5
    - playsound at:<context.entity.eye_location> sound:block_bell_use pitch:2 volume:5
    - playsound at:<context.entity.eye_location> sound:entity_experience_orb_pickup pitch:2 volume:5
    - cast <context.entity> slow duration:2s amplifier:7 no_icon hide_particles no_ambient
    on axemachine damaged:
    - playsound at:<context.entity.eye_location> sound:entity_zombie_attack_iron_door pitch:2 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_zombie_attack_iron_door pitch:1 volume:2
    - if ( !<context.damager.fall_distance> > 0 or <context.cause> == LIGHTNING ) and <context.entity.is_aware>:
      - adjust <context.entity> is_aware:false
      - cast <context.entity> slow duration:1s amplifier:7 no_icon hide_particles no_ambient
      - cast <context.entity> weakness duration:1s amplifier:7 no_icon hide_particles no_ambient
      - playsound at:<context.entity.eye_location> sound:entity_iron_golem_repair pitch:1 volume:5
      - playsound at:<context.entity.eye_location> sound:block_bell_resonate pitch:2 volume:5
      - wait 1s
      - adjust <context.entity> is_aware:true
    on axemachine damaged by ENTITY_EXPLOSION:
    - determine 2 passively
    - playsound at:<context.entity.eye_location> sound:entity_zombie_attack_iron_door pitch:1 volume:5
    - playsound at:<context.entity.eye_location> sound:entity_zombie_attack_iron_door pitch:0 volume:5
    - playsound at:<context.entity.eye_location> sound:entity_player_levelup pitch:0 volume:5
    - playsound at:<context.entity.eye_location> sound:block_bell_use pitch:2 volume:5
    - cast <context.entity> slow duration:2s amplifier:7 no_icon hide_particles no_ambient
    on entity knocks back axemachine:
    - determine cancelled
    on axemachine dies:
    - playsound at:<context.entity.eye_location> sound:block_anvil_place pitch:0 volume:5
    - playsound at:<context.entity.eye_location> sound:entity_zombie_attack_iron_door pitch:0 volume:5
    - determine 36 passively
    - determine NO_DROPS passively
    - if <util.random_chance[5]>:
      - drop betabow <context.entity.location> 
    - if <util.random_chance[5]>:
      - drop netherite_axe <context.entity.location>
    - repeat 30:
      - if <util.random_chance[90]>:
        - drop netherite_ingot <context.entity.location>

shootingshit2:
  type: task
  definitions: soviet|target
  script:
  - cast <[soviet]> slow duration:5s amplifier:7 no_icon hide_particles no_ambient
  - playsound at:<[soviet].eye_location> sound:block_anvil_destroy pitch:2 volume:5
  - wait 1s
  - repeat 16:
    - wait 3t
    - playsound <[soviet].eye_location> sound:custom.classic_bow_shoot pitch:1 volume:2 custom
    - look <[soviet]> <[target].eye_location.add[0,1,0]>
    - shoot arrow origin:<[soviet].eye_location.left[0.4].below[0.8]> speed:1.5 def:<[soviet]> shooter:<[soviet]> spread:5