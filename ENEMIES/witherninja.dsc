witherninja:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 50
    health: 50
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: katana
    item_in_offhand: air
    speed: 0.33

witherninjahandler:
  type: world
  events:
    on witherninja damages entity:
    - cast <context.entity> wither duration:120t amplifier:1 no_icon hide_particles no_ambient
    after witherninja spawns:
    - libsdisguise player target:<context.entity> name:Rusheliny32 hide_name
    - while <context.entity.is_spawned>:
      - if <context.entity.target.eye_location.line_of_sight[<context.entity.eye_location>]> && <context.entity.target||0> != 0 && <context.entity.target.eye_location.distance[<context.entity.eye_location>]> > 8:
        - run withershit def:<context.entity>|<context.entity.target>
      - wait 20t
    on witherninja damaged:
    - playsound at:<context.entity.eye_location> sound:entity_wither_skeleton_hurt pitch:1 volume:5
    - playsound at:<context.entity.eye_location> sound:entity_zombie_attack_iron_door pitch:2 volume:5
    - if <context.damager||0> == 0:
      - stop
    - if <util.random_chance[50]>:
      - wait 17t
      - if !<context.entity.is_spawned>:
        - stop
      - define awareness <context.entity.is_aware>
      - adjust <context.entity> is_aware:false
      - playeffect <context.entity.eye_location.sub[0,1,0]> effect:smoke_large quantity:64 offset:0.5 visibility:100
      - cast <context.entity> invisibility duration:5t amplifier:1 no_icon hide_particles no_ambient
      - cast <context.entity> weakness duration:5t amplifier:1 no_icon hide_particles no_ambient
      - equip <context.entity> hand:air
      - wait 3t
      - define smokeloc <context.damager.eye_location.backward_flat[6].find.surface_blocks.within[3].filter_tag[<context.damager.eye_location.line_of_sight[<[filter_value].add[0,1,0]>]>].get[1].add[0,1,0]>
      - teleport <context.entity> <[smokeloc]>
      - playeffect <[smokeloc].add[0,0.85,0]> effect:smoke_large quantity:64 offset:0.5 visibility:100
      - wait 2t
      - equip <context.entity> hand:katana
      - adjust <context.entity> is_aware:<[awareness]>
    on axemachine damaged by FALL:
    - determine cancelled passively
    on entity knocks back axemachine:
    - determine <context.acceleration.mul[2.5]> passively
    on witherninja dies:
    - playsound at:<context.entity.eye_location> sound:entity_wither_skeleton_death pitch:1 volume:5
    - playsound at:<context.entity.eye_location> sound:entity_wither_skeleton_death pitch:0 volume:5
    - playsound at:<context.entity.eye_location> sound:entity_zombie_attack_iron_door pitch:1 volume:5

withershit:
  type: task
  definitions: soviet|target
  script:
  - cast <[soviet]> speed duration:4s amplifier:1 no_icon hide_particles no_ambient
  - playsound <[soviet].eye_location> sound:item_snowball_throw pitch:0 volume:2
  - look <[soviet]> <[target].eye_location>
  - adjust <[soviet]> velocity:<[soviet].location.sub[<[target].eye_location>].normalize.mul[-2]>