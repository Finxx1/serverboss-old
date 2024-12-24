milf:
  type: item
  material: golden_horse_armor
  display name: <element[Massive Igneous Loss Firearm].color[#D05000]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374316
    hides: all
  lore:
  - <element[i like em big].color[#702800]>
  - 
  - <element[VINTAGE].color[#404878].bold>

missilesprite:
  type: item
  material: clay_ball
  mechanisms:
    custom_model_data: 13374365

missile:
  type: entity
  entity_type: snowball
  mechanisms:
    item: missilesprite

milftriggers:
  type: world
  events:
    on player right clicks block with:milf:
    - if !<player.has_flag[nukecooldown]>:
      - playsound at:<player.eye_location> sound:custom.fall1 pitch:0 volume:2 custom
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:0 volume:2
      - playsound <player.location> sound:entity_generic_extinguish_fire pitch:0 volume:2
      - playsound <player.location> sound:entity_skeleton_hurt pitch:0 volume:2
      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:0 volume:2
      - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:0 volume:2
      - flag <player> nukecooldown expire:500t
      - itemcooldown golden_horse_armor duration:500t
      - shoot missile origin:<player.eye_location.right[0.4].below[0.4]> speed:2 shooter:<player> spread:0 gravity:0
      - wait 10t
      - playsound at:<player.eye_location> sound:custom.fall2 pitch:1 volume:4 custom
    on missile hits block:
    - run nuclearblast2 def:<context.location.add[0,0.5,0]>
    on missile hits entity:
    - run nuclearblast2 def:<context.hit_entity.location>
    after missile spawns:
    - while <context.entity.is_spawned||0>:
      - repeat 5:
        - playeffect effect:flame quantity:1 at:<context.entity.location> offset:0.1 visibility:120 velocity:<context.entity.velocity.random_offset[0.25].mul[-0.2].mul[<list[0.5|1|2].random>]>
        - playeffect effect:smoke quantity:1 at:<context.entity.location> offset:0.1 visibility:120
        - playeffect effect:large_smoke quantity:1 at:<context.entity.location> offset:0.1 visibility:120
      - wait 1t
    - adjust <server.online_players> stop_sound:minecraft:custom.fall2

shockwave:
  type: task
  debug: false
  definitions: entdam|falldam
  script:
  - repeat <[falldam].mul[0.4].round_down>:
    - foreach <[entdam].points_around_y[points=<[value].mul[2].round_down.add[4]>;radius=<[value]>]> as:pre_ringloc:
      - define ringloc <[pre_ringloc].with_pitch[90].ray_trace[range=16;return=block;default=air;ignore=*;nonsolids=false;fluids=true]||0>
      - if <[ringloc].material.name> != air:
        - if <[ringloc].block.material.name> == water:
          - playsound at:<[ringloc].above[2]> sound:entity_generic_splash pitch:1 volume:1
          - playsound at:<[ringloc].above[2]> sound:weather_rain pitch:1 volume:1
          - playsound at:<[ringloc].above[2]> sound:weather_rain pitch:2 volume:1
          - playeffect at:<[ringloc].add[0.5,0,0.5]> effect:water_bubble quantity:12 offset:2,1,2 visibility:100 velocity:<location[0,-1,0]>
          - repeat 4:
            - playeffect at:<[ringloc].add[0.5,2,0.5]> effect:water_splash quantity:48 offset:0.5,1,0.5 visibility:100
          - playeffect at:<[ringloc].add[0.5,1,0.5]> effect:water_wake quantity:20 offset:0.35,0.2,0.35 visibility:100
          - foreach <[ringloc].find_entities.within[7]> as:hurter:
            - adjust <[hurter]> velocity:<[hurter].velocity.add[<[hurter].eye_location.sub[<[entdam]>].normalize.mul[1]>].add[0,0.5,0]>
            - hurt <[hurter]> <[falldam]>
        - else:
          - playsound at:<[ringloc]> sound:entity_generic_explode pitch:1 volume:1
          - playeffect at:<[ringloc].add[0.5,1,0.5]> effect:block_crack special_data:<[ringloc].block.material.name> quantity:48 offset:0.35,0,0.35 visibility:100
          - playeffect at:<[ringloc].add[0.5,1,0.5]> effect:cloud quantity:4 offset:2 visibility:100 velocity:<location[0,0.4,0].add[<[ringloc].sub[<[entdam]>].normalize.mul[0.3].with_y[0]>]>
          - foreach <[ringloc].find_entities.within[4].exclude[<context.entity>]> as:hurter:
            - adjust <[hurter]> velocity:<[hurter].velocity.add[<[hurter].eye_location.sub[<[entdam]>].normalize.mul[2]>].add[0,0.5,0]>
            - hurt <[hurter]> <[falldam]> cause:ENTITY_EXPLOSION
    - wait 2t

nuclearblast2:
  type: task
  debug: false
  definitions: exploc
  script:
  - run shockwave def:<[exploc]>|<element[150]>
  - wait 1t
  - playeffect at:<[exploc]> effect:flash quantity:3 offset:0 visibility:130
  - run explsilent def:<[exploc].add[0,0.5,0]>|<element[8]>
  - playsound at:<[exploc]> sound:custom.nuke pitch:1 volume:10 custom
  - playsound at:<[exploc]> sound:custom.nuke pitch:2 volume:10 custom
  - playsound at:<[exploc]> sound:custom.nuke pitch:0 volume:10 custom
  - repeat 40:
    - foreach <proc[particle_ring].context[<[exploc]>|15|<[value]>]> as:place:
      - run explsilent def:<[place]>|<element[1]>
      - playeffect effect:flame quantity:15 offset:0.5 visibility:100 at:<[place]>
      - playeffect effect:smoke_large quantity:15 offset:0.5 visibility:100 at:<[place]>
    - run explsilent def:<[exploc].add[0,<[value]>,0]>|<element[3]>
    - playeffect effect:flame quantity:120 offset:3 visibility:100 at:<[exploc].add[0,<[value]>,0]>
    - playeffect effect:smoke_large quantity:120 offset:3 visibility:100 at:<[exploc].add[0,<[value]>,0]>
    - playeffect effect:redstone quantity:25 special_data:2|<color[#208040]> at:<[exploc]> offset:5,0,5  visibility:100
    - if <[value].mod[2]> == 0:
      - wait 1t
    - if <[value]> == 20:
      - foreach <proc[particle_ring].context[<[exploc].add[0,20,0]>|26|14]> as:place:
        - run explsilent def:<[place]>|<element[1]>
        - playeffect effect:flame quantity:15 offset:0.5 visibility:100 at:<[place]>
        - playeffect effect:smoke_large quantity:15 offset:0.5 visibility:100 at:<[place]>
  - foreach <proc[particle_ring].context[<[exploc].add[0,40,0]>|8|7]> as:place:
    - run explsilent def:<[place]>|<element[5]>
    - playeffect effect:flame quantity:96 offset:3.5 visibility:100 at:<[place]>
    - playeffect effect:smoke_large quantity:96 offset:3.5 visibility:100 at:<[place]>
  - repeat 4:
    - playeffect effect:flame quantity:120 offset:3 visibility:100 at:<[exploc]>
    - playeffect effect:smoke_large quantity:120 offset:3 visibility:100 at:<[exploc]>
  - define cuboidhurty <[exploc].add[7,1,7].to_cuboid[<[exploc].sub[7,0.25,7]>]>
  - run geigersfx def:<[exploc]>
  - repeat 100:
    - wait 3t
    - playeffect effect:redstone quantity:35 special_data:2|<color[#208040]> at:<[exploc]> offset:7,1,7  visibility:100
    - if <[cuboidhurty].entities||0> != 0:
      - foreach <[cuboidhurty].entities>:
        - hurt <[value]> amount:2
        - cast <[value]> poison duration:4t amplifier:0 no_icon hide_particles no_ambient
        - cast <[value]> slow duration:4t amplifier:2 no_icon hide_particles no_ambient
        - cast <[value]> slow_digging duration:4t amplifier:2 no_icon hide_particles no_ambient
        - cast <[value]> confusion duration:5s amplifier:20 no_icon hide_particles no_ambient
        - if <[value].is_player>:
          - playeffect effect:redstone quantity:100 special_data:0.1|<color[#208040]> at:<[value].eye_location> offset:0.6 visibility:10 targets:<[value]>