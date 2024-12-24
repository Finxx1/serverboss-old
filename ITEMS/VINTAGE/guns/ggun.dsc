ggun:
  type: item
  material: golden_horse_armor
  display name: <element[Gravity Gun].color[#FF8000]>
  lore:
  - <element[mmmm soup].color[#804000]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

ggunevents:
  type: world
  events:
    on player left clicks block with:ggun:
    - determine cancelled passively
    - run ggunfire def:<player>
    on player right clicks block with:ggun:
    - if !<player.has_flag[gguncooldown]>:
      - determine cancelled passively
      - run ggungrab def:<player>|<context.location.material.name||air>|<context.location.block>
      #- wait 20t
      - modifyblock <context.location.block> air
    on block falls:
    - if <context.entity.has_flag[unfalling2]>:
      - spawn <context.entity.fallingblock_material>
      - determine cancelled passively

ggungrab:
  debug: false
  definitions: mgk_player|mat|loc
  type: task
  script:
    - define aimtarg <[mgk_player].eye_location.ray_trace[range=3;return=precise;default=air;nonsolids=false]>
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - if <[mat]> == air:
      - flag <[mgk_player]> gguncooldown expire:1s
      - itemcooldown golden_horse_armor duration:1s
      - playsound <[mgk_player].location> sound:block_note_block_bass pitch:0 volume:1
      - stop
    - if <[mgk_player].has_flag[held_ggun]>:
      - stop
    - itemcooldown golden_horse_armor duration:0.8s
    - playsound <[mgk_player].location> sound:custom.lightning_discharge pitch:0 volume:2 custom
    - playsound <[mgk_player].location> sound:block_dirt_break pitch:0 volume:1
    - playsound <[mgk_player].location> sound:block_sand_break pitch:0 volume:1
    - playsound <[mgk_player].location> sound:block_stone_break pitch:0 volume:1
    - flag <[mgk_player]> held_ggun
    - playeffect effect:block_crack quantity:128 special_data:<[mat]> at:<[aimtarg]> offset:0.7 velocity:<random_offset[1,1,1]>
    - playsound at:<[aimtarg]> sound:block_gravel_break pitch:0 volume:2
    - playsound at:<[aimtarg]> sound:block_stone_break pitch:0 volume:2
    - playsound at:<[aimtarg]> sound:block_sand_break pitch:0 volume:2
    - playsound at:<[aimtarg]> sound:entity_zombie_attack_wooden_door pitch:0 volume:2
    - spawn falling_block[fallingblock_type=<[mat]>;gravity=false] <[aimtarg]> save:balzacsave2
    - define grabbed <entry[balzacsave2].spawned_entity>
    - flag <[grabbed]> unfalling2
    - while !<player.has_flag[mgk_justshotggun]>:
      - define aimtarg <[mgk_player].eye_location.ray_trace[range=3;return=precise;default=air;nonsolids=false].forward[1].sub[0,0.5,0]>
      - adjust <[grabbed]> velocity:<[aimtarg].sub[<[grabbed].location>]>
      #- remove <[grabbed]>
      #- showfake cancel <[aimtarg].backward[1]> <server.online_players>
      - if <[loop_index]> > 120:
        - while stop
      - if !<[grabbed].is_spawned>:
        - spawn falling_block[fallingblock_type=<[mat]>;gravity=false] <[aimtarg]> save:balzacsave2
        - define grabbed <entry[balzacsave2].spawned_entity>
        - flag <[grabbed]> unfalling2
      - playeffect effect:block_crack quantity:4 special_data:<[mat]> at:<[aimtarg].add[0,0.5,0]> offset:0.3 velocity:<random_offset[1,1,1]>
      - if <util.random_chance[3]>:
        - playsound <[mgk_player].location> sound:block_sand_hit pitch:0 volume:1
        - playsound <[mgk_player].location> sound:block_gravel_hit pitch:0 volume:1
        - playsound <[mgk_player].location> sound:block_stone_hit pitch:0 volume:1
      - flag <[mgk_player]> materialheld:<[mat]>
      - wait 1t
    - remove grabbed
    - flag <[mgk_player]> earthcharge:!
    - flag <[mgk_player]> held_ggun:!
    - if !<[mgk_player].has_flag[justfiredggun]>:
      - flag <[mgk_player]> mgk_earthcooldown expire:7s
      - itemcooldown brown_concrete duration:7s
      - spawn falling_block[fallingblock_type=<[mat]>] <[mgk_player].eye_location.ray_trace[range=3;return=precise;default=air;nonsolids=false].sub[0,0.5,0]> save:balzacsave2
      - define earthball <entry[balzacsave2].spawned_entity>
      #- flag <[earthball]> unfalling

ggunscript:
  type: task
  debug: false
  definitions: grabbedproj|mgkplayer|charge
  script:
  - while <[grabbedproj].is_spawned||0>:
    - playeffect effect:block_crack quantity:2 special_data:<[grabbedproj].fallingblock_material.name> at:<[grabbedproj].location> offset:0.4 velocity:<random_offset[0.2,0.2,0.2]>  visibility:64
    - define entities_hit <[grabbedproj].location.find.living_entities.within[1.85].exclude[<[grabbedproj]>].exclude[<[mgkplayer]>]||0>
    - if !<[entities_hit].is_empty>:
      - foreach <[entities_hit]>:
        - playeffect effect:block_crack quantity:2 special_data:<[grabbedproj].fallingblock_material.name> at:<[grabbedproj].location> offset:1 velocity:<random_offset[1,1,1]>
        - hurt <[entities_hit]> <[charge].div[3.33].round_down_to_precision[1]> source:<[mgkplayer]>
        - adjust <[value]> velocity:<[value].velocity.add[<[grabbedproj].velocity.add[0,0.25,0].mul[2]>]>
        - if <[value].health> > <[charge].div[3.33].round_down_to_precision[1]>:
          - playsound at:<[grabbedproj].location> sound:entity_generic_explode pitch:0 volume:5
          - playeffect effect:block_crack quantity:16 special_data:<[grabbedproj].fallingblock_material.name> at:<[grabbedproj].location> offset:0.7 velocity:<random_offset[1,1,1]> visibility:100
          - while stop
        - else:
          - playsound at:<context.location> sound:block_gravel_break pitch:0.75 volume:3
          - playsound at:<context.location> sound:block_stone_break pitch:0.75 volume:3
          - playsound at:<context.location> sound:block_sand_break pitch:0.75 volume:3
          - playsound at:<context.location> sound:entity_zombie_attack_wooden_door pitch:0.75 volume:3
      - adjust <[grabbedproj]> velocity:<[grabbedproj].velocity.div[1.5]>
    #- announce <element[<[charge].div[3.33].round_down_to_precision[1]>]>
    - wait 2t
  - remove <[grabbedproj]>


ggunfire:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if !<[mgk_player].has_flag[held_ggun]>:
      - flag <[mgk_player]> gguncooldown expire:1s
      - playsound <[mgk_player].location> sound:block_note_block_bass pitch:0 volume:1
      - itemcooldown golden_horse_armor duration:1s
      - stop
    - if <[mgk_player].has_flag[gguncooldown]>:
      - stop
    - define mat <[mgk_player].flag[materialheld]>
    - flag <[mgk_player]> gguncooldown expire:4s
    - flag <[mgk_player]> justfiredggun expire:1s
    - itemcooldown golden_horse_armor duration:4s
    - define charge <[mgk_player].flag[earthcharge]>
    - define aimtarg <[mgk_player].eye_location.ray_trace[range=3;return=precise;default=air;nonsolids=false]>
    - spawn falling_block[fallingblock_type=<[mat]>;gravity=false;visible=false] <[aimtarg].sub[0,0.5,0]> save:dirtsave
    - define earthball <entry[dirtsave].spawned_entity>
    #- flag <[earthball]> unfalling
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - playsound <[mgk_player].location> sound:entity_wither_break_block pitch:0 volume:1
    - flag <[mgk_player]> mgk_justshotggun expire:2t
    - adjust <[earthball]> gravity:true
    - adjust <[earthball]> velocity:<[lookvec].mul[2.15].add[0,0.25,0]>
    - playeffect effect:block_crack quantity:128 special_data:<[mat]> at:<[earthball].location> offset:0.7 velocity:<random_offset[1,1,1]>
    - playsound at:<[earthball].location> sound:block_gravel_break pitch:0 volume:2
    - playsound at:<[earthball].location> sound:block_stone_break pitch:0 volume:2
    - playsound at:<[earthball].location> sound:block_sand_break pitch:0 volume:2
    - playsound at:<[earthball].location> sound:entity_zombie_attack_wooden_door pitch:0 volume:2
    - playsound <[mgk_player].location> sound:custom.lightning_charge pitch:0 volume:2 custom
    - run ggunscript def:<[earthball]>|<[mgk_player]>|75