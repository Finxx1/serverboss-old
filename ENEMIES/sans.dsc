sans:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 1
    health: 1
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: air
    item_in_offhand: air
    speed: 0.2


bluebone:
  type: item
  material: bone
  display name: <&b><element[Blue Attack]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 666

textEntity:
  type: entity
  entity_type: armor_stand
  mechanisms:
    gravity: false
    marker: true
    visible: false
    custom_name_visible: true

blasterskull:
  type: item
  material: player_head
  display name: <element[Skeleton].color_gradient[from=#E0D0C0;to=#C0C0C0]><element[ ]><element[King's].color_gradient[from=#FFC020;to=#800000]><element[ Skull].color[#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    skull_skin: macunzen
  lore:
  - <element[It's a trophy].color_gradient[from=#707860;to=#606060]><element[ ]><element[fit for a king].color_gradient[from=#806010;to=#400000]>
  - 
  - <element[HAUNTED].color[#38F0A8].bold>

gasterblaster:
  type: entity
  entity_type: armor_stand
  mechanisms:
    equipment: <map[helmet=<item[blasterskull]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    gravity: true
    visible: false

sanshandler:
  type: world
  events:
    on textEntity spawns:
    - wait <context.entity.health>t
    - remove <context.entity>
    after sans spawns:
    - flag <context.entity> dodges:20
    - libsdisguise player target:<context.entity> name:M7MDGAMES hide_name
    - while <context.entity.is_spawned>:
      - if <context.entity.target.eye_location.line_of_sight[<context.entity.eye_location>]> && <context.entity.target||0> != 0:
        - adjust <context.entity> fire_time:0
      - wait 1t
    on sans spawns:
    - wait 1t
    - while <context.entity.is_spawned>:
      - if <context.entity.target.eye_location.line_of_sight[<context.entity.eye_location>]> && <context.entity.target||0> != 0:
        - random:
          - wait 1t
          - ~run allbones def:<context.entity>
          - ~run gasterblasters def:<context.entity>
      - wait <list[5|8|9|7].random>s
    on sans damaged:
    - if <context.entity.has_flag[hittable]>:
      - determine cancelled
    - else if <context.entity.flag[dodges]> > 0:
      - determine cancelled passively
      - flag <context.entity> hittable expires:1s
      - flag <context.entity> dodges:<context.entity.flag[dodges].sub[1]>
      - playsound <context.entity.location> sound:entity_ender_dragon_wings_flap pitch:2 volume:2
      - adjust <context.entity> velocity:<context.entity.velocity.add[<context.damager.eye_location.rotate_yaw[<list[-90|90].random>].direction.vector.normalize.mul[1.25].add[0,0.5,0]>]>
      - spawn at:<context.entity.eye_location.sub[0,1,0]> textEntity[custom_name=<&7><&l><&o>MISS!;health=15]
    - else:
      - kill <context.entity>
    on gasterblaster spawns:
    - define postobein <context.entity.location>
    - repeat 50:
      - teleport <context.entity> <[postobein]>
      - wait 1t
    after gasterblaster spawns:
    - look <context.entity> <context.entity.flag[gblasttarget].eye_location> duration:25t
    - playsound at:<context.entity.eye_location> sound:custom.psychicfire pitch:0 volume:2 custom
    - playsound at:<context.entity.eye_location> sound:entity_enderman_teleport pitch:0 volume:2
    - wait 25t
    - look <context.entity> <context.entity.flag[gblasttarget].eye_location> duration:45t
#    - announce <context.entity.flag[gblasttarget]>
    - wait 25t
    - playsound at:<context.entity.eye_location> sound:custom.hand pitch:0 volume:2 custom
    - playsound at:<context.entity.eye_location> sound:custom.psychichit pitch:1 volume:2 custom
    - playsound at:<context.entity.eye_location> sound:entity_generic_explode pitch:1 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_ender_dragon_hurt pitch:1 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_skeleton_horse_death pitch:1 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_skeleton_horse_death pitch:0 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_skeleton_horse_death pitch:2 volume:2
    - define aimtarg <context.entity.eye_location.ray_trace[range=50;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.5]>
    - define pointlist <context.entity.eye_location.forward[1].points_between[<[aimtarg]>].distance[1]>
    - foreach <[pointlist]>:
      - playeffect effect:redstone special_data:6|<color[#FFFFFF]> visibility:100 offset:0.7 quantity:32 at:<[value]>
    - flag <context.entity> movableblaster
    - repeat 10:
      - adjust <context.entity> velocity:<context.entity.location.direction.vector.mul[-1].mul[<[value].div[2]>]>
      - foreach <[pointlist]> as:selectedfirst:
        - foreach <[selectedfirst].find.living_entities.within[1.5]||0> as:selectedfinal:
          - hurt <[selectedfinal]> amount:1
          - adjust <[selectedfinal]> no_damage_duration:1t
      - wait 1t
    - remove <context.entity>

allbones:
  type: task
  definitions: thecomic
  script:
  - repeat 4:
    - define comloc <[thecomic].location>
    - playsound sound:entity_arrow_hit_player pitch:2 volume:2 at:<[comloc]>
    - foreach <[comloc].points_around_y[radius=1;points=8]>:
      - spawn boneattack[velocity=<[comloc].sub[<[value]>].mul[-1].normalize.with_y[0]>] at:<[thecomic].eye_location.sub[0,0.5,0]>
      - wait 3t
    - wait 1s
    - playsound sound:block_note_block_pling pitch:2 volume:2 at:<[comloc]>
    - foreach <[thecomic].target.location.points_around_y[radius=1;points=8]>:
      - spawn blueattack[velocity=<[comloc].sub[<[value]>].mul[-1].normalize.with_y[0]>] at:<[thecomic].eye_location.sub[0,0.5,0]>
      - wait 1t
    - wait 1s

bonefire:
  type: task
  definitions: thecomic
  script:
  - repeat 5:
    - define comloc <[thecomic].location>
    - define target <[thecomic].target>
    - spawn boneattack[velocity=<[comloc].sub[<[value]>].mul[-1].normalize.with_y[0]>] at:<[thecomic].eye_location.sub[0,0.5,0]>
    - wait 10t

gasterblasters:
  type: task
  definitions: thecomic
  script:
  - define comloc <[thecomic].location>
  - repeat 3:
    - define target <[thecomic].target>
    - define spawnloc <[comloc].random_offset[3].add[0,4,0]>
    - spawn gasterblaster <[spawnloc]> save:gblast
    - define blastar <entry[gblast].spawned_entity>
    - flag <[blastar]> gblasttarget:<[target]>
    - wait 20t
  - wait 20t