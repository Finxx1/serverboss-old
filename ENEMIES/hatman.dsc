hatman:
  type: entity
  entity_type: husk
  mechanisms:
    equipment: <map[helmet=<item[hat]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    age: adult
    max_health: 50
    health: 50
    speed: 0.195

hatmanhandle:
  type: world
  events:
    after hatman spawns:
    - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:0 volume:2
    - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:1 volume:2
    - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:2 volume:2
    - libsdisguise player target:<context.entity> name:IamSisyphus hide_name
    - while <context.entity.is_spawned>:
      - attack <context.entity> target:<context.entity.find.living_entities.exclude[<context.entity>].get[1]||0>
      - if <context.entity.eye_location.with_y[0].distance[<context.entity.target.eye_location.with_y[0]>].add[1]||0> < <context.entity.eye_location.with_y[0].distance[<context.entity.target.eye_location.forward[2].with_y[0]>]||0>:
        - cast <context.entity> slow amplifier:8 duration:5t no_icon hide_particles no_ambient
        - adjust <context.entity> visible:false
      - else:
        - playeffect effect:large_smoke at:<context.entity.location.add[0,1,0]> offset:0.5 quantity:4 visibility:100
        - adjust <context.entity> visible:true
      - define fearfactorenm <context.entity.eye_location.find.living_entities.within[75].exclude[<context.entity>].filter_tag[<[filter_value].is_player.not>]>
      - define fearfactorval 1
#      - announce <[fearfactorenm]>
      - foreach <[fearfactorenm]>:
        - define fearfactorval <[fearfactorval].add[<[value].health_max.div[5].round_down.sub[1]>]>
      - if <[fearfactorval]> != <context.entity.health_max>:
        - adjust <context.entity> max_health:<[fearfactorval]>
#      - announce <[fearfactorval]>
      - if <util.random_chance[1]>:
        - playsound at:<context.entity.eye_location> sound:entity_blaze_ambient pitch:0 volume:2
      - heal <context.entity> 1
      - wait 2t
    on hatman damaged:
    - if <context.entity.health_max> <= <context.damage>:
      - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:0 volume:2
      - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:1 volume:2
      - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:2 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_blaze_death pitch:0 volume:2
      - playeffect effect:large_smoke at:<context.entity.location.add[0,1,0]> offset:0.65 quantity:44 visibility:100
    - if <context.cause> != FIRE && <context.cause> != FIRE_TICK:
      - playeffect effect:large_smoke at:<context.entity.location.add[0,1,0]> offset:0.65 quantity:64 visibility:100
      - adjust <context.entity> visible:false
      - spawn <element[shadowman].repeat_as_list[<list[1|2|3].random>]> <context.entity.location>
      - wait 3t
      - define smokeloc <context.damager.eye_location.backward_flat[6].find.surface_blocks.within[3].filter_tag[<context.damager.eye_location.line_of_sight[<[filter_value].add[0,1,0]>]>].get[1].add[0,1,0]>
      - teleport <context.entity> <[smokeloc]>
      - wait 5t
      - adjust <context.entity> visible:true
    on hatman damaged by FIRE_TICK:
    - determine cancelled passively
    - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:0 volume:2
    - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:1 volume:2
    - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:2 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_ghast_hurt pitch:2 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_ghast_hurt pitch:1 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_ghast_hurt pitch:0 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_blaze_death pitch:1 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_blaze_death pitch:0 volume:2
    - remove <context.entity>
    on hatman damaged by FIRE:
    - determine cancelled passively
    - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:0 volume:2
    - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:1 volume:2
    - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:2 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_ghast_hurt pitch:2 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_ghast_hurt pitch:1 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_ghast_hurt pitch:0 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_blaze_death pitch:1 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_blaze_death pitch:0 volume:2
    - remove <context.entity>
    on hatman damaged by FALL:
    - determine cancelled
    on hatman dies:
    - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:0 volume:2
    - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:1 volume:2
    - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:2 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_blaze_death pitch:0 volume:2
    - playeffect effect:large_smoke at:<context.entity.location.add[0,1,0]> offset:0.65 quantity:44 visibility:100
    - wait 1t
    - remove <context.entity>
    on hatman damages player:
    - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:0 volume:2
    - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:1 volume:2
    - playsound at:<context.entity.eye_location> sound:ambient_cave pitch:2 volume:2
    - cast <player> blindness amplifier:1 duration:80t no_icon hide_particles no_ambient
    - cast <player> confusion amplifier:90 duration:120t no_icon hide_particles no_ambient
    - cast <player> slow amplifier:1 duration:80t no_icon hide_particles no_ambient
    - cast <player> weak amplifier:0 duration:80t no_icon hide_particles no_ambient
