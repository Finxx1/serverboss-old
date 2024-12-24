leavesfake:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375404

zombtrace:
  type: task
  debug: false
  definitions: zombbase|zombnew
  script:
  - flag <[zombnew]> pillarbase:<[zombbase]>
  - 

zombbuff:
  type: world
  debug: false
  events:
    on delta time secondly every:1:
    - foreach <server.online_players>:
      - foreach <[value].location.find_entities[ZOMBIE].within[50]> as:creeps:
        - if <[creeps].target||0> != 0:
          - if <[creeps].location.with_y[0].distance[<[creeps].target.location.with_y[0]>]> < 2 && <[creeps].location.y.sub[<[creeps].target.location.y>]> > 4:
            - if !<[creeps].has_flag[pillaring]>:
              - define foundbase <[creeps].location.find_entities[ZOMBIE].within[5].exclude[<[creeps]>].filter_tag[<[filter_value].has_flag[pillaring].not>].get[1]||0>
 #             - if <[foundbase]> != 0:
 #               - run
                

creepbuff:
  type: world
  debug: false
  events:
    on entity knocks back creeper:
    - determine <context.acceleration.mul[2]>
    on creeper explosion primes:
    - determine cancelled
    after creeper spawns:
    - adjust <context.entity> max_fuse_ticks:9999
    on delta time secondly every:1:
    - foreach <server.online_players>:
      - foreach <[value].location.find_entities[CREEPER].within[50]> as:creeps:
        - if <[creeps].target||0> != 0:
          - if <[creeps].location.distance[<[creeps].target.location>]> < 2:
            - hurt <[creeps].target> amount:5
            - if <[creeps].powered>:
              - run mgk_chainlightning def:<[creeps]>|<[creeps].target>|<element[4]>
            - playsound <[creeps].eye_location> sound:entity_creeper_hurt pitch:0 volume:2
            - adjust <[creeps].target> velocity:<[creeps].target.velocity.add[<[creeps].target.eye_location.sub[<[creeps].location>].normalize.mul[0.35]>]>
    on tick every:4:
    - foreach <server.online_players>:
      - foreach <[value].location.find_entities[CREEPER].within[50]> as:creeps:
        - if <[creeps].target||0> != 0:
          - if <[creeps].location.distance[<[creeps].target.location>]> > 2 && <[creeps].is_on_ground>:
            - walk <[creeps]> <[creeps].target.location> lookat:<[creeps].target.eye_location> speed:0.16
            - adjust <[creeps]> velocity:<[creeps].target.location.sub[<[creeps].location>].normalize.mul[0.3].add[0,<list[0.4|0.3|0.35|0.45].random>,0]>
            - look <[creeps]> <[creeps].target>
    on creeper damaged by FALL:
    - determine cancelled passively
    on creeper damages entity:
    - if <context.cause> == ENTITY_EXPLOSION:
      - determine cancelled passively
    on creeper dies:
    - define powerStat <context.entity.powered>
    - define creeploc <context.entity.location>
    - define creeploc2 <context.entity.eye_location>
    - playeffect at:<[creeploc].add[0,1,0]> effect:explode_large quantity:1 offset:0 velocity:0 visibility:100
    - playeffect at:<[creeploc].add[0,1,0]> effect:flash quantity:1 offset:0 velocity:0 visibility:100
    - repeat 64:
      - playeffect at:<[creeploc].add[0,0.5,0]> effect:item_crack special_data:leavesfake quantity:4 offset:0.2 velocity:<location[0,0,0].random_offset[0.85]> visibility:100
    - repeat 64:
      - playeffect at:<[creeploc2]> effect:item_crack special_data:leavesfake quantity:4 offset:0.2 velocity:<location[0,0,0].random_offset[0.85]> visibility:100
    - playsound at:<[creeploc].add[0,0.5,0]> sound:entity_generic_explode volume:2 pitch:0
    - playsound at:<[creeploc].add[0,0.5,0]> sound:custom.classic_explode volume:2 pitch:0 custom
    - playsound at:<[creeploc].add[0,0.5,0]> sound:block_grass_break volume:2 pitch:0
    - playsound at:<[creeploc].add[0,0.5,0]> sound:block_grass_break volume:2 pitch:1
    - foreach <context.entity.location.find_entities.within[5]>:
      - adjust <[value]> velocity:<[value].velocity.add[<[value].eye_location.sub[<context.entity.location>].normalize.mul[1.25]>]>
      - if <[powerStat]>:
        - run mgk_chainlightning def:<context.entity>|<[value]>|<element[20]>
      - hurt <[value]> 10
    - remove <context.entity>
    on creeper explodes:
    - define creeploc <context.entity.location>
    - define creeploc2 <context.entity.eye_location>
    - determine cancelled passively
    - repeat 64:
      - playeffect at:<[creeploc].add[0,0.5,0]> effect:item_crack special_data:leavesfake quantity:4 offset:0.2 velocity:<location[0,0,0].random_offset[0.85]> visibility:100
    - repeat 64:
      - playeffect at:<[creeploc2]> effect:item_crack special_data:leavesfake quantity:4 offset:0.2 velocity:<location[0,0,0].random_offset[0.85]> visibility:100
    - playsound at:<[creeploc].add[0,0.5,0]> sound:entity_generic_explode volume:2 pitch:0
    - playsound at:<[creeploc].add[0,0.5,0]> sound:custom.classic_explode volume:2 pitch:0 custom
    - playsound at:<[creeploc].add[0,0.5,0]> sound:block_grass_break volume:2 pitch:0
    - playsound at:<[creeploc].add[0,0.5,0]> sound:block_grass_break volume:2 pitch:1
#    - explode <context.entity> power:4