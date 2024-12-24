hecker:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 1000
    health: 1000
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: scythe
    speed: 0.35

darkhecker:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 2500
    health: 2500
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: icesword
    item_in_offhand: firesword
    speed: 0.365


heckerhandler:
  type: world
  events:
    after hecker spawns:
    - libsdisguise player target:<context.entity> name:heckermann1337 display_name:Hecker
    - adjust <context.entity.location.find_players_within[100]> stopsound
    - rename <element[Hecker].color[#FFFFFF]> t:<context.entity>
    - bossbar create heckerID players:<context.entity.location.find_players_within[100]> title:<element[hecker].color[#FFFFFF]> progress:1 color:white options:create_fog,darken_sky
    - wait 0.8s
    - attack <context.entity> target:<context.entity.location.find_players_within[20].get[1]>
    - wait 2.0s
#    - run fighttheme def:<context.entity>
    - wait 0.2s
    - repeat 60:
      - playeffect at:<context.entity.location.add[0,1,0]> effect:soul_fire_flame offset:1.1,1.5,1.1 quantity:1 velocity:<location[0,0,0].random_offset[1]>
    - explode <context.entity.location> power:4 source:<context.entity>
    - stop
    - while <context.entity.is_spawned>:
      - random:
        - run heckerkick def:<context.entity>|<context.entity.target>
        - run hecker300cps def:<context.entity>|<context.entity.target>
        - run heckerjudge def:<context.entity>|<context.entity.target>
        - repeat 1:
          - if <context.entity.health> < 500:
            - run heckerslice def:<context.entity>|<context.entity.target>
      - wait 4s
    - wait 2s
    - bossbar remove heckerID
    on hecker spawns:
    - wait 5t
    - flag <context.entity> saidweak:!
    - while <context.entity.is_spawned>:
      - look <context.entity> <context.entity.target.eye_location>
      - if <context.entity.health> < 500:
        - if !<context.entity.has_flag[saidweak]>:
          - announce <element[Hecker &gt&gt ].unescaped><element[WEAK!].bold.color_gradient[from=#C000C0;to=#804080]>
          - flag <context.entity> saidweak
        - cast <context.entity> speed amplifier:1 duration:3t no_icon hide_particles no_ambient
        - cast <context.entity> strength amplifier:1 duration:3t no_icon hide_particles no_ambient
        - playeffect at:<context.entity.location.add[0,1,0]> effect:soul_fire_flame offset:1.1,1.5,1.1 quantity:5 velocity:<location[0,0.075,0]>
        - heal <context.entity> 0.05
      - bossbar update heckerID progress:<context.entity.health.div[1000]>
      - wait 2t
    on hecker dies:
    - adjust <context.entity.location.find_players_within[100]> stop_sound
    - playsound <context.entity.location> sound:entity_blaze_death
    - wait 2s
    - bossbar remove heckerID
    on hecker damaged:
    - if <context.entity.has_flag[parriable]>:
      - heal <context.damager> <context.damage.mul[3]>
      - determine <context.damage.mul[3]> passively
      - playsound at:<context.entity.location> volume:2 sound:entity_arrow_hit_player pitch:0
      - playsound at:<context.entity.location> volume:2 sound:entity_wither_break_block pitch:2
      - playeffect at:<context.entity.location.add[0,1,0]> effect:crit offset:0.5 quantity:30 visibility:100
      - playeffect at:<context.entity.location.add[0,1,0]> effect:explosion_large offset:0 quantity:1 visibility:100
      - flag <context.entity> parriable:!
      - cast <context.damager> night_vision duration:5t amplifier:3 no_icon hide_particles no_ambient
     # - adjust <context.damager> vision:enderman
      - wait 1t
      #- adjust <context.damager> vision
    on player damaged by hecker:
    - if <context.cause> == entity_attack && <context.damager.has_flag[motherfucker]>:
      - determine cancelled passively


darkheckerhandler:
  type: world
  events:
    after darkhecker spawns:
    - libsdisguise player target:<context.entity> name:YaBoyhecker display_name:hecker
    - adjust <context.entity.location.find_players_within[100]> stopsound
    - rename <element[darkhecker].color[#FFFFFF]> t:<context.entity>
    - bossbar create darkheckerID players:<context.entity.location.find_players_within[100]> title:<element[hecker].color[#FFFFFF]> progress:1 color:white options:create_fog,darken_sky
    - wait 0.8s
    - attack <context.entity> target:<context.entity.location.find_players_within[20].get[1]>
    - wait 2.0s
#    - run fighttheme def:<context.entity>
    - wait 0.2s
    - repeat 60:
      - playeffect at:<context.entity.location.add[0,1,0]> effect:soul_fire_flame offset:1.1,1.5,1.1 quantity:1 velocity:<location[0,0,0].random_offset[1]>
    - explode <context.entity.location> power:4 source:<context.entity>
    - while <context.entity.is_spawned>:
      - random:
        - run heckerkick def:<context.entity>|<context.entity.target>
        - run hecker300cps def:<context.entity>|<context.entity.target>
        - run heckerjudge def:<context.entity>|<context.entity.target>
        - run heckerslice def:<context.entity>|<context.entity.target>
        - run heckerprojectile def:<context.entity>|<context.entity.target>
        - run heckericeslice def:<context.entity>|<context.entity.target>
        - repeat 1:
          - if <context.entity.health> < 1250:
            - run heckerhoming def:<context.entity>|<context.entity.target>
        - repeat 1:
          - if <context.entity.health> < 1250:
            - run heckerfireslice def:<context.entity>|<context.entity.target>
      - wait 3s
    - wait 2s
    - bossbar remove darkheckerID
    on darkhecker spawns:
    - wait 5t
    - flag <context.entity> saidweak:!
    - while <context.entity.is_spawned>:
      - look <context.entity> <context.entity.target.eye_location>
      - if <context.entity.health> < 1250:
        - if !<context.entity.has_flag[saidweak]>:
          - announce <element[hecker &gt&gt ].unescaped><element[WEAK!].bold.color_gradient[from=#C000C0;to=#804080]>
          - flag <context.entity> saidweak
        - cast <context.entity> speed amplifier:1 duration:3t no_icon hide_particles no_ambient
        - cast <context.entity> strength amplifier:1 duration:3t no_icon hide_particles no_ambient
        - playeffect at:<context.entity.location.add[0,1,0]> effect:soul_fire_flame offset:1.1,1.5,1.1 quantity:5 velocity:<location[0,0.075,0]>
        - heal <context.entity> 0.05
      - bossbar update darkheckerID progress:<context.entity.health.div[2500]>
      - wait 2t
    on darkhecker dies:
    - adjust <context.entity.location.find_players_within[100]> stop_sound
    - playsound <context.entity.location> sound:entity_blaze_death
    - wait 2s
    - bossbar remove darkheckerID
    on darkhecker damaged:
    - if <context.entity.has_flag[parriable]>:
      - heal <context.damager> <context.damage.mul[3]>
      - determine <context.damage.mul[3]> passively
      - playsound at:<context.entity.location> volume:2 sound:entity_arrow_hit_player pitch:0
      - playsound at:<context.entity.location> volume:2 sound:entity_wither_break_block pitch:2
      - playeffect at:<context.entity.location.add[0,1,0]> effect:crit offset:0.5 quantity:30 visibility:100
      - playeffect at:<context.entity.location.add[0,1,0]> effect:explosion_large offset:0 quantity:1 visibility:100
      - cast <context.damager> night_vision duration:5t amplifier:3 no_icon hide_particles no_ambient
     # - adjust <context.damager> vision:enderman
      - wait 1t
      #- adjust <context.damager> vision
      - adjust <context.damager> vision
    on player damaged by darkhecker:
    - if <context.cause> == entity_attack && <context.damager.has_flag[motherfucker]>:
      - determine cancelled passively

heckerfireslice:
  type: task
  definitions: heckermob2|target
  script:
  - flag <[heckermob2]> motherfucker
  - announce <element[hecker &gt&gt ].unescaped><element[YOU DENY YOUR WEAPON ITS PURPOSE!].bold.color_gradient[from=#C000C0;to=#804080]>
  - repeat 4:
    - playsound at:<[heckermob2].location> volume:1 pitch:1 sound:block_note_block_bit
    - playsound at:<[heckermob2].location> volume:1 pitch:0 sound:block_note_block_bit
    - wait 3t
  - flag <[heckermob2]> parriable
  - playsound at:<[heckermob2].location> volume:1 sound:entity_arrow_hit_player pitch:2
  - playeffect at:<[heckermob2].location.add[0,1,0]> effect:magic_crit offset:0.5 quantity:30 visibility:100
  - wait 10t
  - if !<[heckermob2].has_flag[parriable]>:
    - stop
  - flag <[heckermob2]> parriable:!
  - cast <[heckermob2]> speed duration:2s amplifier:2 no_icon hide_particles no_ambient
  - playsound at:<[heckermob2].location> volume:2 sound:item_trident_throw pitch:0
  - define lookinplace <[heckermob2].eye_location>
  - foreach <list[<[lookinplace].forward[1.5].above[1.5].left[-1.5]>|<[lookinplace].forward[2].above[0.75].left[-0.75]>|<[lookinplace].forward[2].above[-0.75].left[0.75]>|<[lookinplace].forward[1.5].above[-1.5].left[1.5]>]> as:val2:
    #- look <[heckermob2]> <[val2]> duration:2t
    - playeffect at:<[val2]> effect:sweep_attack offset:0.1 quantity:1 visibility:100
    - playeffect at:<[val2]> effect:lava offset:0.3 visibility:100 quantity:15
    - define hittarg <[val2].find.living_entities.within[1.25].exclude[<[heckermob2]>]>
    - foreach <[hittarg]>:
      - hurt <[value]> 8 source:<[heckermob2]> cause:ENTITY_SWEEP_ATTACK
      - burn <[value]> duration:8s
      - playeffect at:<[value].eye_location.sub[0,1,0]> effect:lava offset:0.7 visibility:100 quantity:60
      - playsound at:<[value].eye_location> sound:entity_blaze_shoot pitch:0 volume:2
      - playsound at:<[value].eye_location> sound:block_glass_break pitch:0 volume:2
    - wait 2t
  - flag <[heckermob2]> motherfucker:!