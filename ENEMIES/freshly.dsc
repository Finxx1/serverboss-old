freshly:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 1000
    health: 1000
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: iron_sword
    speed: 0.35

darkfreshly:
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


freshlyhandler:
  type: world
  events:
    after freshly spawns:
    - libsdisguise player target:<context.entity> name:YaBoyFreshly display_name:Freshly
    - adjust <context.entity.location.find_players_within[100]> stopsound
    - rename <element[Freshly].color[#FFFFFF]> t:<context.entity>
    - bossbar create freshlyID players:<context.entity.location.find_players_within[100]> title:<element[Freshly].color[#FFFFFF]> progress:1 color:white options:create_fog,darken_sky
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
        - run freshlykick def:<context.entity>|<context.entity.target>
        - run freshly300cps def:<context.entity>|<context.entity.target>
        - run freshlyjudge def:<context.entity>|<context.entity.target>
        - repeat 1:
          - if <context.entity.health> < 500:
            - run freshlyslice def:<context.entity>|<context.entity.target>
      - wait 4s
    - wait 2s
    - bossbar remove freshlyID
    on freshly spawns:
    - wait 5t
    - flag <context.entity> saidweak:!
    - while <context.entity.is_spawned>:
      - look <context.entity> <context.entity.target.eye_location>
      - if <context.entity.health> < 500:
        - if !<context.entity.has_flag[saidweak]>:
          - announce <element[Freshly &gt&gt ].unescaped><element[WEAK!].bold.color_gradient[from=#C000C0;to=#804080]>
          - flag <context.entity> saidweak
        - cast <context.entity> speed amplifier:1 duration:3t no_icon hide_particles no_ambient
        - cast <context.entity> strength amplifier:1 duration:3t no_icon hide_particles no_ambient
        - playeffect at:<context.entity.location.add[0,1,0]> effect:soul_fire_flame offset:1.1,1.5,1.1 quantity:5 velocity:<location[0,0.075,0]>
        - heal <context.entity> 0.05
      - bossbar update freshlyID progress:<context.entity.health.div[1000]>
      - wait 2t
    on freshly dies:
    - adjust <context.entity.location.find_players_within[100]> stop_sound
    - playsound <context.entity.location> sound:entity_blaze_death
    - wait 2s
    - bossbar remove freshlyID
    on freshly damaged:
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
    on player damaged by freshly:
    - if <context.cause> == entity_attack && <context.damager.has_flag[motherfucker]>:
      - determine cancelled passively


darkfreshlyhandler:
  type: world
  events:
    after darkfreshly spawns:
    - libsdisguise player target:<context.entity> name:YaBoyFreshly display_name:Freshly
    - adjust <context.entity.location.find_players_within[100]> stopsound
    - rename <element[darkfreshly].color[#FFFFFF]> t:<context.entity>
    - bossbar create darkfreshlyID players:<context.entity.location.find_players_within[100]> title:<element[Freshly].color[#FFFFFF]> progress:1 color:white options:create_fog,darken_sky
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
        - run freshlykick def:<context.entity>|<context.entity.target>
        - run freshly300cps def:<context.entity>|<context.entity.target>
        - run freshlyjudge def:<context.entity>|<context.entity.target>
        - run freshlyslice def:<context.entity>|<context.entity.target>
        - run freshlyprojectile def:<context.entity>|<context.entity.target>
        - run freshlyiceslice def:<context.entity>|<context.entity.target>
        - repeat 1:
          - if <context.entity.health> < 1250:
            - run freshlyhoming def:<context.entity>|<context.entity.target>
        - repeat 1:
          - if <context.entity.health> < 1250:
            - run freshlyfireslice def:<context.entity>|<context.entity.target>
      - wait 3s
    - wait 2s
    - bossbar remove darkfreshlyID
    on darkfreshly spawns:
    - wait 5t
    - flag <context.entity> saidweak:!
    - while <context.entity.is_spawned>:
      - look <context.entity> <context.entity.target.eye_location>
      - if <context.entity.health> < 1250:
        - if !<context.entity.has_flag[saidweak]>:
          - announce <element[Freshly &gt&gt ].unescaped><element[WEAK!].bold.color_gradient[from=#C000C0;to=#804080]>
          - flag <context.entity> saidweak
        - cast <context.entity> speed amplifier:1 duration:3t no_icon hide_particles no_ambient
        - cast <context.entity> strength amplifier:1 duration:3t no_icon hide_particles no_ambient
        - playeffect at:<context.entity.location.add[0,1,0]> effect:soul_fire_flame offset:1.1,1.5,1.1 quantity:5 velocity:<location[0,0.075,0]>
        - heal <context.entity> 0.05
      - bossbar update darkfreshlyID progress:<context.entity.health.div[2500]>
      - wait 2t
    on darkfreshly dies:
    - adjust <context.entity.location.find_players_within[100]> stop_sound
    - playsound <context.entity.location> sound:entity_blaze_death
    - wait 2s
    - bossbar remove darkfreshlyID
    on darkfreshly damaged:
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
    on player damaged by darkfreshly:
    - if <context.cause> == entity_attack && <context.damager.has_flag[motherfucker]>:
      - determine cancelled passively

#fightthemeheroin:
#  type: task
#  definitions: bossentity
#  script:
#  - while <[bossentity].is_spawned>:
#    - playsound <[bossentity].location> sound:custom.freshlyfight volume:16 pitch:1 custom
#    - wait 3323t

freshly300cps:
  type: task
  definitions: freshlymob2|target
  script:
  - flag <[freshlymob2]> motherfucker
  - announce <element[Freshly &gt&gt ].unescaped><element[PREPARE THYSELF!].bold.color_gradient[from=#C000C0;to=#804080]>
  - repeat 8:
    - playsound at:<[freshlymob2].location> volume:1 pitch:2 sound:block_note_block_didgeridoo
    - wait 3t
  - cast <[freshlymob2]> speed duration:2s amplifier:2 no_icon hide_particles no_ambient
  - repeat 5:
    - foreach <proc[particle_ring].context[<[freshlymob2].location.add[0,1,0]>|8|2.25]> as:val2:
      - look <[freshlymob2]> <[val2]> duration:2t
      - adjust <[freshlymob2]> velocity:<[freshlymob2].velocity.mul[0.9].add[<[target].eye_location.sub[<[freshlymob2].location>].normalize.mul[0.02]>]>
      - playsound at:<[val2]> volume:2 sound:item_trident_throw pitch:2
      - playeffect at:<[val2]> effect:sweep_attack offset:0.2 quantity:1 visibility:100
      - define hittarg <[val2].find.living_entities.within[1.25].exclude[<[freshlymob2]>]>
      - animate <[freshlymob2]> animation:arm_swing for:<server.online_players>
      - foreach <[hittarg]>:
        - adjust <[value]> max_no_damage_duration:2t
        - hurt <[value]> 5 source:<[freshlymob2]> cause:ENTITY_SWEEP_ATTACK
      - wait 1t
      - foreach <[hittarg]>:
        - adjust <[value]> max_no_damage_duration:20t
  - flag <[freshlymob2]> motherfucker:!

freshlykick:
  type: task
  definitions: freshlymob2|target
  script: 
  - flag <[freshlymob2]> motherfucker
  - announce <element[Freshly &gt&gt ].unescaped><element[JUDGEMENT!].bold.color_gradient[from=#C000C0;to=#804080]>
  - repeat 5:
    - playsound at:<[freshlymob2].location> volume:1 sound:block_note_block_didgeridoo
    - wait 5t
  - adjust <[freshlymob2]> gravity:false
  - define aimtarg <[target].eye_location.ray_trace[range=2;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.5].with_y[<[target].location.y.add[0.25]>]>
  - foreach <[freshlymob2].location.add[0,1,0].points_between[<[aimtarg]>].distance[1]>:
    - playeffect at:<[value]> effect:soul_fire_flame offset:0.35 quantity:20 visibility:100
  - teleport <[freshlymob2]> <[aimtarg]>
  - wait 1t
  - look <[freshlymob2]> <[target].eye_location> duration:7t
  - flag <[freshlymob2]> parriable
  - playsound at:<[freshlymob2].location> volume:1 sound:entity_arrow_hit_player pitch:2
  - playeffect at:<[freshlymob2].location.add[0,1,0]> effect:magic_crit offset:0.5 quantity:30 visibility:100
  - wait 6t
  - if <[freshlymob2].has_flag[parriable]>:
    - explode <[freshlymob2].eye_location.forward[1]> power:3 source:<[freshlymob2]>
    - playeffect at:<[freshlymob2].location.add[0,1,0]> effect:soul_fire_flame offset:0.35 quantity:20 visibility:100
    - flag <[freshlymob2]> parriable:!
  - adjust <[freshlymob2]> gravity:true
  - flag <[freshlymob2]> motherfucker:!

freshlyslice:
  type: task
  definitions: freshlymob2|target
  script: 
  - flag <[freshlymob2]> motherfucker
  - announce <element[Freshly &gt&gt ].unescaped><element[THY END IS NOW!].bold.color_gradient[from=#C000C0;to=#804080]>
  - repeat 2:
    - playsound at:<[freshlymob2].location> volume:2 pitch:2 sound:block_note_block_didgeridoo
    - wait 2t
    - playsound at:<[freshlymob2].location> volume:2 pitch:0 sound:block_note_block_didgeridoo
    - wait 2t
  - repeat 6:
    - adjust <[freshlymob2]> velocity:<[freshlymob2].velocity.mul[1].add[<[target].location.sub[<[freshlymob2].location>].normalize.mul[2]>]>
    - look <[freshlymob2]> <[target].eye_location> duration:1s
    - waituntil <[target].location.distance[<[freshlymob2].location>]> < 2 max:1s
    - if <[target].location.distance[<[freshlymob2].location>]> < 2:
      - define targloc <[target].location.add[0,1,0]>
      - wait 6t
      - playeffect at:<[targloc]> effect:sweep_attack offset:0.2 quantity:1 visibility:100
      - playsound at:<[targloc]> volume:2 sound:item_trident_throw pitch:2
      - wait 2t
      - hurt <[targloc].find.living_entities.within[1].exclude[<[freshlymob2]>]> source:<[freshlymob2]> cause:ENTITY_SWEEP_ATTACK
    #- wait 1t
  - flag <[freshlymob2]> motherfucker:!

freshlyjudge:
  type: task
  definitions: freshlymob2|target
  script:
  - flag <[freshlymob2]> motherfucker
  - announce <element[Freshly &gt&gt ].unescaped><element[CRUSH!].bold.color_gradient[from=#C000C0;to=#804080]>
  - repeat 3:
    - playsound at:<[freshlymob2].location> volume:3 pitch:0 sound:block_note_block_didgeridoo
    - wait 8t
  - adjust <[freshlymob2]> gravity:false
  - define aimtarg <[target].location>
  - foreach <[freshlymob2].location.add[0,1,0].points_between[<[aimtarg].add[0,10,0]>].distance[1]>:
    - playeffect at:<[value]> effect:soul_fire_flame offset:0.35 quantity:20 visibility:100
  - teleport <[freshlymob2]> <[aimtarg].add[0,9,0]>
  - wait 1t
  - look <[freshlymob2]> <[target].eye_location> duration:7t
  - flag <[freshlymob2]> parriable
  - playsound at:<[freshlymob2].location> volume:1 sound:entity_arrow_hit_player pitch:2
  - playeffect at:<[freshlymob2].location.add[0,1,0]> effect:magic_crit offset:0.5 quantity:30 visibility:100
  - wait 1s
  - if <[freshlymob2].has_flag[parriable]>:
    - teleport <[freshlymob2]> <[aimtarg]>
    - explode <[aimtarg].add[0,1,0]> power:3 source:<[freshlymob2]>
    - playeffect at:<[aimtarg].add[0,9,0].points_between[<[aimtarg]>].distance[1]> effect:soul_fire_flame offset:0.35 quantity:20 visibility:100
    - flag <[freshlymob2]> parriable:!
  - adjust <[freshlymob2]> gravity:true
  - flag <[freshlymob2]> motherfucker:!

freshlyprojectile:
  type: task
  definitions: freshlymob2|target
  script:
  - flag <[freshlymob2]> motherfucker
  - announce <element[Freshly &gt&gt ].unescaped><element[BLOODSHED!].bold.color_gradient[from=#C000C0;to=#804080]>
  - repeat 3:
    - playsound at:<[freshlymob2].location> volume:3 pitch:0 sound:block_note_block_bit
    - wait 2t
  - repeat 6:
    - cast <[freshlymob2]> slow duration:18t amplifier:6 no_icon hide_particles no_ambient
    - define aimtarg <[target].eye_location.sub[0,0.3,0]>
    - wait 5t
    - playeffect at:<[freshlymob2].eye_location.sub[0,1,0]> effect:soul_fire_flame offset:0.35 quantity:20 visibility:100
    - playsound at:<[freshlymob2].location> volume:2 sound:item_trident_throw pitch:1
    - look <[freshlymob2]> <[target].eye_location> duration:7t
    - shoot thrownsword origin:<[freshlymob2].eye_location.below[1].right[0.6]> destination:<[aimtarg]> speed:3 spread:0 shooter:<[freshlymob2]> save:iceswords
    - define thrownicesword <entry[iceswords].shot_entities.get[1]>
    - run icetrail def:<[thrownicesword]>|<[freshlymob2]>
    - wait 8t
  - wait 0.2s
  - flag <[freshlymob2]> motherfucker:!

freshlyhoming:
  type: task
  definitions: freshlymob2|target
  script:
  - flag <[freshlymob2]> motherfucker
  - announce <element[Freshly &gt&gt ].unescaped><element[ONLY ONE LEFT!].bold.color_gradient[from=#C000C0;to=#804080]>
  - repeat 5:
    - playsound at:<[freshlymob2].location> volume:3 pitch:1 sound:block_note_block_bit
    - wait 5t
  - playeffect at:<[freshlymob2].location.add[0,1,0]> effect:magic_crit offset:0.5 quantity:30 visibility:100
  - flag <[freshlymob2]> parriable
  - playsound at:<[freshlymob2].location> volume:1 sound:entity_arrow_hit_player pitch:2
  - playeffect at:<[freshlymob2].location.add[0,1,0]> effect:magic_crit offset:0.5 quantity:30 visibility:100
  - cast <[freshlymob2]> slow duration:18t amplifier:6 no_icon hide_particles no_ambient
  - define aimtarg <[target].eye_location.sub[0,0.3,0]>
  - wait 10t
  - if !<[freshlymob2].has_flag[parriable]>:
    - stop
  - flag <[freshlymob2]> parriable:!
  - playeffect at:<[freshlymob2].eye_location.sub[0,1,0]> effect:flame offset:0.35 quantity:20 visibility:100
  - playsound at:<[freshlymob2].location> volume:2 sound:item_trident_throw pitch:1
  - playsound at:<[freshlymob2].location> volume:0.4 sound:item_trident_throw pitch:0
  - look <[freshlymob2]> <[target].eye_location> duration:7t
  - shoot thrownswordhoming origin:<[freshlymob2].eye_location.below[1].left[0.6]> destination:<[aimtarg]> speed:0.5 spread:0 shooter:<[freshlymob2]> save:fireswords
  - define thrownfiresword <entry[fireswords].shot_entities.get[1]>
  - run homingtask2 def:<[thrownfiresword]>|<[freshlymob2]>
  - wait 0.2s
  - flag <[freshlymob2]> motherfucker:!

freshlyiceslice:
  type: task
  definitions: freshlymob2|target
  script:
  - flag <[freshlymob2]> motherfucker
  - announce <element[Freshly &gt&gt ].unescaped><element[SHOW ME A GOOD TIME, JACK!].bold.color_gradient[from=#C000C0;to=#804080]>
  - repeat 8:
    - playsound at:<[freshlymob2].location> volume:1 pitch:2 sound:block_note_block_bit
    - playsound at:<[freshlymob2].location> volume:1 pitch:1 sound:block_note_block_bit
    - wait 3t
  - repeat 3:
    - cast <[freshlymob2]> speed duration:2s amplifier:2 no_icon hide_particles no_ambient
    - playsound at:<[freshlymob2].location> volume:2 sound:item_trident_throw pitch:0
    - define lookinplace <[freshlymob2].eye_location>
    - foreach <list[<[lookinplace].forward[1.5].above[1.5].left[1.5]>|<[lookinplace].forward[2].above[0.75].left[0.75]>|<[lookinplace].forward[2].above[-0.75].left[-0.75]>|<[lookinplace].forward[1.5].above[-1.5].left[-1.5]>]> as:val2:
      #- look <[freshlymob2]> <[val2]> duration:2t
      - playeffect at:<[val2]> effect:sweep_attack offset:0.1 quantity:1 visibility:100
      - playeffect at:<[val2]> effect:block_crack special_data:ice offset:0.3 visibility:100 quantity:15
      - define hittarg <[val2].find.living_entities.within[1.25].exclude[<[freshlymob2]>]>
      - foreach <[hittarg]>:
        - hurt <[value]> 5 source:<[freshlymob2]> cause:ENTITY_SWEEP_ATTACK
        - cast <[value]> slow duration:1s amplifier:3 no_icon hide_particles no_ambient
        - cast <[value]> weakness duration:1s amplifier:3 no_icon hide_particles no_ambient
        - cast <[value]> slow_digging duration:1s amplifier:3 no_icon hide_particles no_ambient
        - playeffect at:<[value].eye_location.sub[0,1,0]> effect:block_crack special_data:ice offset:0.7 visibility:100 quantity:60
        - playsound at:<[value].eye_location> sound:entity_zombie_villager_cure pitch:2 volume:2
        - playsound at:<[value].eye_location> sound:block_glass_break pitch:1 volume:2
        - playsound at:<[value].eye_location> sound:block_glass_break pitch:0 volume:2
      - wait 1t
    - wait 10t
  - flag <[freshlymob2]> motherfucker:!

freshlyfireslice:
  type: task
  definitions: freshlymob2|target
  script:
  - flag <[freshlymob2]> motherfucker
  - announce <element[Freshly &gt&gt ].unescaped><element[YOU DENY YOUR WEAPON ITS PURPOSE!].bold.color_gradient[from=#C000C0;to=#804080]>
  - repeat 4:
    - playsound at:<[freshlymob2].location> volume:1 pitch:1 sound:block_note_block_bit
    - playsound at:<[freshlymob2].location> volume:1 pitch:0 sound:block_note_block_bit
    - wait 3t
  - flag <[freshlymob2]> parriable
  - playsound at:<[freshlymob2].location> volume:1 sound:entity_arrow_hit_player pitch:2
  - playeffect at:<[freshlymob2].location.add[0,1,0]> effect:magic_crit offset:0.5 quantity:30 visibility:100
  - wait 10t
  - if !<[freshlymob2].has_flag[parriable]>:
    - stop
  - flag <[freshlymob2]> parriable:!
  - cast <[freshlymob2]> speed duration:2s amplifier:2 no_icon hide_particles no_ambient
  - playsound at:<[freshlymob2].location> volume:2 sound:item_trident_throw pitch:0
  - define lookinplace <[freshlymob2].eye_location>
  - foreach <list[<[lookinplace].forward[1.5].above[1.5].left[-1.5]>|<[lookinplace].forward[2].above[0.75].left[-0.75]>|<[lookinplace].forward[2].above[-0.75].left[0.75]>|<[lookinplace].forward[1.5].above[-1.5].left[1.5]>]> as:val2:
    #- look <[freshlymob2]> <[val2]> duration:2t
    - playeffect at:<[val2]> effect:sweep_attack offset:0.1 quantity:1 visibility:100
    - playeffect at:<[val2]> effect:lava offset:0.3 visibility:100 quantity:15
    - define hittarg <[val2].find.living_entities.within[1.25].exclude[<[freshlymob2]>]>
    - foreach <[hittarg]>:
      - hurt <[value]> 8 source:<[freshlymob2]> cause:ENTITY_SWEEP_ATTACK
      - burn <[value]> duration:8s
      - playeffect at:<[value].eye_location.sub[0,1,0]> effect:lava offset:0.7 visibility:100 quantity:60
      - playsound at:<[value].eye_location> sound:entity_blaze_shoot pitch:0 volume:2
      - playsound at:<[value].eye_location> sound:block_glass_break pitch:0 volume:2
    - wait 2t
  - flag <[freshlymob2]> motherfucker:!