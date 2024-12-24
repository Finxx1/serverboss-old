shadowman:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 20
    health: 20
    speed: 0.3125

shadowmanhandle:
  type: world
  debug: false
  events:
    after shadowman spawns:
    - libsdisguise player target:<context.entity> name:IamSisyphus hide_name
    - while <context.entity.is_spawned>:
      - attack <context.entity> target:<context.entity.find.living_entities.exclude[<context.entity>].get[1]||0>
      - if <context.entity.eye_location.with_y[0].distance[<context.entity.target.eye_location.with_y[0]>].add[1]||0> < <context.entity.eye_location.with_y[0].distance[<context.entity.target.eye_location.forward[2].with_y[0]>]||0>:
        - cast <context.entity> slow amplifier:8 duration:5t no_icon hide_particles no_ambient
        - adjust <context.entity> visible:false
        - adjust <context.entity> has_ai:false
      - else:
        - playeffect effect:large_smoke at:<context.entity.location.add[0,1,0]> offset:0.35 quantity:8 visibility:100
        - adjust <context.entity> visible:true
        - adjust <context.entity> has_ai:true
      - wait 2t
    on shadowman damaged:
    - determine cancelled passively
    - playeffect effect:large_smoke at:<context.entity.location.add[0,1,0]> offset:0.65 quantity:64 visibility:100
    - remove <context.entity>
    on shadowman damaged by FALL:
    - determine cancelled
    on shadowman dies:
    - determine cancelled passively
    - playeffect effect:large_smoke at:<context.entity.location.add[0,1,0]> offset:0.65 quantity:44 visibility:100
    - remove <context.entity>
    on shadowman damages player:
    - cast <player> blindness amplifier:1 duration:80t no_icon hide_particles no_ambient
    - cast <player> confusion amplifier:90 duration:120t no_icon hide_particles no_ambient
    - cast <player> slow amplifier:1 duration:80t no_icon hide_particles no_ambient
    - cast <player> weak amplifier:0 duration:80t no_icon hide_particles no_ambient

statue:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 15
    health: 15
    speed: 0.3

statuehandle:
  type: world
  debug: false
  events:
    on statue spawns:
    - wait 1t
    - while <context.entity.is_spawned>:
      - while <context.entity.has_flag[karmicretribution]>:
        - wait 1t
        - if !<context.entity.is_spawned>:
          - stop
      - playsound at:<context.entity.eye_location> sound:entity_zombie_attack_iron_door pitch:2 volume:0.25
      - while !<context.entity.has_flag[karmicretribution]>:
        - wait 1t
        - if !<context.entity.is_spawned>:
          - stop
      - playsound at:<context.entity.eye_location> sound:block_stone_break pitch:2 volume:0.25
    after statue spawns:
    - libsdisguise player target:<context.entity> name:ThyMagic hide_name
    - while <context.entity.is_spawned>:
      - attack <context.entity> target:<context.entity.find.living_entities.exclude[<context.entity>].get[1]||0>
      - if <context.entity.eye_location.with_y[0].distance[<context.entity.target.eye_location.with_y[0]>].add[1.8]||0> > <context.entity.eye_location.with_y[0].distance[<context.entity.target.eye_location.forward[2].with_y[0]>]||0> || <list[creative|spectator].contains_any.context.entity.target.gamemode>:
        - cast <context.entity> slow amplifier:8 duration:5t no_icon hide_particles no_ambient
        - walk <context.entity> stop
        - teleport <context.entity> <context.entity.location>
        - wait 1t
        - adjust <context.entity> has_ai:false
        - teleport <context.entity> <context.entity.location>
      - else:
        - adjust <context.entity> has_ai:true
        - if !<context.entity.has_flag[homingprimed]>:
          - flag <context.entity> homingprimed expire:40t
          - if <context.entity.location.find_path[<context.entity.target.location>].is_empty>:
            - cast <context.entity> slow amplifier:8 duration:30t no_icon hide_particles no_ambient
            - playsound at:<context.entity.eye_location> sound:block_beacon_activate pitch:1 volume:2
            - wait 15t
            - shoot homingorb origin:<context.entity.eye_location> speed:0.05 script:hominghit shooter:<context.entity> spread:5 save:susvented5
            - define homeorb <entry[susvented5].shot_entities.get[1]>
            - run homingtask3 def:<[homeorb]>|<context.entity>|<context.entity.target>
            - playsound at:<context.entity.eye_location> sound:custom.psychichit pitch:1 volume:2 custom
            - playsound at:<context.entity.eye_location> sound:block_beacon_power_select pitch:1 volume:2
        - flag <context.entity> karmicretribution expire:20t
      - wait 2t
    on projectile hits statue:
    - if <context.projectile.script.name||0> == homingorb:
      - explode <context.hit_entity.location.add[1]>
      - kill <context.hit_entity>
    - else:
      - determine cancelled passively
      - define projspeed <context.projectile.velocity.vector_length>
      - define projloc <context.projectile.location>
      - playsound at:<context.hit_entity.eye_location> sound:custom.shoveldeflect pitch:2 volume:2 custom
      - adjust <context.projectile> velocity:<[projloc].sub[<context.hit_entity.location.add[0,1,0]>].normalize.mul[<[projspeed].mul[0.35]>]>
    on statue damaged:
    - if !<context.entity.has_flag[karmicretribution]>:
      - determine cancelled passively
      - repeat 32:
        - playeffect effect:crit at:<context.entity.location.add[0,1,0]> offset:0 quantity:1 velocity:<location[0,0,0].random_offset[1]>
      - playsound at:<context.entity.eye_location> sound:custom.shoveldeflect pitch:2 volume:2 custom
    on statue dies:
    - playsound at:<context.entity.eye_location> sound:entity_wither_break_block pitch:1 volume:3
    - playsound at:<context.entity.eye_location> sound:block_glass_break pitch:0 volume:3
    - playsound at:<context.entity.eye_location> sound:custom.gib pitch:1 volume:3 custom
    - run GOREBURSTPRO def:<context.entity.location.above[1]>|0.25
    - remove <context.entity>

gore1:
  type: item
  material: clay_ball
  display name: <element[gore].color[#FFFF80]>
  mechanisms:
    custom_model_data: 13374346
  lore:
  - <element[stop    die].color[#808040]>

gore2:
  type: item
  material: clay_ball
  display name: <element[gore].color[#FFFF80]>
  mechanisms:
    custom_model_data: 13374347
  lore:
  - <element[stop    die].color[#808040]>

gore3:
  type: item
  material: clay_ball
  display name: <element[gore].color[#FFFF80]>
  mechanisms:
    custom_model_data: 13374348
  lore:
  - <element[stop    die].color[#808040]>

gorebone:
  type: item
  material: clay_ball
  display name: <element[gore].color[#FFFF80]>
  mechanisms:
    custom_model_data: 13374349
  lore:
  - <element[stop    die].color[#808040]>