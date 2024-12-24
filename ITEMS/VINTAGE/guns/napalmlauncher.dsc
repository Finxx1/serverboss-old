napalmcannon:
  type: item
  material: iron_horse_armor
  display name: <element[Napalm Cannon].color[#C0A080]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374317
    hides: all
  lore:
  - <element[Kfwooooosh crackle crackle, BLAKOOMfff].color[#504040]>
  - 
  - <element[VINTAGE].color[#404878].bold>

napalmball:
  type: entity
  entity_type: snowball
  mechanisms:
    gravity: true
    item: napalmballsprite

napalmcannontriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:napalmcannon:
    - if !<player.has_flag[napalmcooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:0 volume:1
      - playsound <player.location> sound:entity_skeleton_hurt pitch:0 volume:1
      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:0 volume:1
      - playsound <player.location> sound:entity_generic_extinguish_fire pitch:0 volume:1
      - playsound <player.location> sound:block_respawn_anchor_deplete pitch:0 volume:1
      - flag <player> napalmcooldown expire:140t
      - itemcooldown iron_horse_armor duration:140t
      - shoot napalmball origin:<player.eye_location.right[0.4].below[0.4]> speed:1.65 shooter:<player> spread:0
    after napalmball spawns:
    - wait 2t
    - while <context.entity.is_spawned>:
      - if <[loop_index]> > 80:
        - while stop
#      - announce balls
      - define surfland <context.entity.location.with_pitch[90].ray_trace[range=25;return=precise;default=air;ignore=*;nonsolids=false]>
      - foreach <context.entity.location.points_between[<[surfland]>].distance[1]||0>:
        - playeffect at:<[value]> effect:flame offset:0.3,0.5,0.3 quantity:5 velocity:<location[0,-0.10,0]> visibility:100
      - if <[surfland].below[1].block.material.name> != air && <[surfland].y> > 1:
        - run burnspot def:<[surfland]>
      - playeffect at:<[value]> effect:flame offset:0.1,0.1,0.1 quantity:1 velocity:<context.entity.velocity.mul[0.1].random_offset[0.2]> visibility:100
      - wait 1t
    - if <context.entity.is_spawned>:
      - explode <context.entity.location> power:3
      - remove <context.entity>
    on napalmball hits block:
    - explode <context.projectile.location> power:3

burnspot:
  type: task
  debug: false
  definitions: surfspot
  script:
  - repeat 55:
    - repeat 7:
      - playeffect at:<[surfspot]> effect:flame offset:1.65,0,1.65 quantity:1 velocity:<location[0,0.2,0].random_offset[0.1,0.1,0.1]> visibility:100
      - playeffect at:<[surfspot]> effect:flame offset:1.65,0,1.65 quantity:5 velocity:<location[0,0.015,0].random_offset[0.05,0,0.05]> visibility:100
    - playeffect at:<[surfspot]> effect:smoke offset:1.65,0.2,1.65 quantity:1 velocity:<location[0,0.5,0].random_offset[0.1,0.2,0.1]> visibility:100
    - playeffect at:<[surfspot]> effect:lava offset:1.65,0.2,1.65 quantity:1 velocity:<location[0,0.5,0].random_offset[0.1,0.2,0.1]> visibility:100
    - foreach <[surfspot].find_entities.within[1.5]||0>:
      - burn <[value]> duration:120t
      - hurt <[value]> amount:2 cause:FIRE
    - wait <list[1|2|3|4|5].random>t