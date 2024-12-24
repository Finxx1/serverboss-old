airstrike:
  type: item
  material: iron_horse_armor
  display name: <element[Remote].color[#FF0000]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374334
    hides: all
  lore:
  - <element[Houston, we may have a problem here].color[#800000]>
  - 
  - <element[VINTAGE].color[#404878].bold>

shellsprite:
  type: item
  material: clay_ball
  mechanisms:
    custom_model_data: 13374365

shell:
  type: entity
  entity_type: snowball
  mechanisms:
    item: shellsprite

airstriketriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:airstrike:
    - determine cancelled passively
    - if <player.has_flag[airstrikecooldown]>:
      - stop
    - define aimtarg <player.eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.1]>
    - playeffect at:<[aimtarg]> effect:redstone special_data:2|<color[#FF0000]> quantity:24 offset:0.05 visibility:120
    - if !<[aimtarg].line_of_sight[<[aimtarg].add[0,250,0]>]>:
      - flag <player> airstrikecooldown expire:20t
      - itemcooldown iron_horse_armor duration:20t
      - playsound at:<[aimtarg]> sound:custom.reload_error pitch:2 volume:2 custom
      - stop
    - playsound at:<[aimtarg]> sound:block_lever_click pitch:0 volume:4
    - playsound at:<[aimtarg]> sound:entity_sheep_shear pitch:0 volume:4
    - playsound at:<[aimtarg]> sound:custom.fall2 pitch:1 volume:4 custom
    - flag <player> airstrikecooldown expire:600t
    - itemcooldown iron_horse_armor duration:600t
    - repeat 100:
      - define offset <[aimtarg].random_offset[16,0,16].block.center>
      - define shellskybox <[offset].with_pitch[-90].ray_trace[range=81;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.1]>
      - if !<[offset].line_of_sight[<[offset].add[0,250,0]>]>:
        - repeat next
      - spawn shell <[shellskybox].sub[0,1,0]>
      - wait <list[1|2|3|5].random>t
    on shell spawns:
    - wait 1t
    - while <context.entity.is_spawned||0>:
      - playeffect effect:smoke quantity:1 at:<context.entity.location> offset:0.1 visibility:120
      - playeffect effect:large_smoke quantity:1 at:<context.entity.location> offset:0.1 visibility:120
      - wait 1t
    on shell hits block:
    - explode <context.location> power:3
    - playsound at:<context.location> sound:custom.classic_explode pitch:1 volume:2 custom
    - repeat 2:
      - playeffect effect:smoke quantity:64 at:<context.location> offset:4 visibility:120
    on shell hits entity:
    - explode <context.hit_entity.location> power:3
    - playsound at:<context.hit_entity.location> sound:custom.classic_explode pitch:1 volume:2 custom
    - repeat 2:
      - playeffect effect:smoke quantity:64 at:<context.hit_entity.location> offset:4 visibility:120