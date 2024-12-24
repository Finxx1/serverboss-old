bfg9k:
  type: item
  material: diamond_horse_armor
  display name: <element[BFG-9000].color_gradient[from=#60FF20;to=#20FF60]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374205
    hides: all
  lore:
  - <element[poof].color_gradient[from=#308010;to=#108040]>
  - 
  - <element[VINTAGE].color[#404878].bold>

bfgprojs:
  type: item
  material: clay_ball
  display name: <element[bfg ball].color[#00FF00]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374329
    hides: all
  lore:
  - <element[bang].color[#4000ff]>
#  - 
#  - <element[VINTAGE].color[#404878].bold>

bfgprojp:
  type: entity
  entity_type: snowball
  mechanisms:
    gravity: false
    item: bfgprojs

bfgtriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:bfg9k:
    - if <player.has_flag[bfgcooldown]>:
      - stop
    - flag <player> bfgcooldown expire:400t
    - itemcooldown diamond_horse_armor duration:400t
    - playsound sound:custom.bfg at:<player.eye_location> pitch:1 volume:2 custom
    - wait 17t
    - shoot bfgprojp origin:<player.eye_location> shooter:<player> speed:0.8 spread:0
    after bfgprojp spawns:
    - while <context.entity.is_spawned>:
      - adjust <context.entity> velocity:<context.entity.velocity.mul[1.01]>
      - if <[loop_index]> > 200:
        - while stop
      - wait 1t
    - if <context.entity.is_spawned>:
      - explode <context.entity.location> power:6
      - remove <context.entity>
    on bfgprojp hits entity:
    - playeffect at:<context.projectile.location> effect:redstone special_data:2|<color[#60FF00]> quantity:64 offset:1.5 visibility:100
    - playeffect at:<context.projectile.location> effect:redstone special_data:2|<color[#C0FF40]> quantity:32 offset:0.75 visibility:100
    - define shoota <context.shooter>
    - playsound at:<context.projectile.location> sound:custom.psychichit pitch:0 volume:2
    - playsound at:<context.projectile.location> sound:entity_generic_explode pitch:0 volume:2
    - playsound at:<context.projectile.location> sound:entity_generic_explode pitch:1 volume:2
    - playsound at:<context.projectile.location> sound:entity_generic_explode pitch:2 volume:2
    - playsound at:<context.projectile.location> sound:entity_lightning_bolt_thunder pitch:1 volume:2
    - playsound at:<context.projectile.location> sound:entity_lightning_bolt_thunder pitch:2 volume:2
    - playsound at:<context.projectile.location> sound:entity_lightning_bolt_thunder pitch:0 volume:2
    - explode <context.projectile.location> power:4
    - repeat 40 as:bfgdegrees:
      - define aimtarg <[shoota].eye_location.sub[0,0.5.0].with_yaw[<[shoota].eye_location.yaw.add[<[bfgdegrees].mul[4].add[-80]>]>].with_pitch[0].ray_trace[range=70;return=precise;default=air;nonsolids=false;entities=*;ignore=<[shoota]>;raysize=0.25]>
      - foreach <[aimtarg].find.living_entities.within[2].exclude[<[shoota]>].get[1]||0>:
        - playeffect at:<[value].location.above[1]> effect:redstone special_data:2|<color[#60FF00]> quantity:16 offset:0.5 visibility:100
        - playeffect at:<[value].location.above[1]> effect:redstone special_data:2|<color[#C0FF40]> quantity:8 offset:0.25 visibility:100
        - hurt <[value]> amount:25 cause:fire
#      - playeffect at:<[aimtarg]> effect:redstone special_data:2|<color[#60FF00]> quantity:4 offset:0.25 visibility:100
#      - playeffect at:<[aimtarg]> effect:redstone special_data:2|<color[#C0FF40]> quantity:2 offset:0.125 visibility:100
    on bfgprojp hits block:
    - playeffect at:<context.projectile.location> effect:redstone special_data:2|<color[#60FF00]> quantity:64 offset:1.5 visibility:100
    - playeffect at:<context.projectile.location> effect:redstone special_data:2|<color[#C0FF40]> quantity:32 offset:0.75 visibility:100
    - define shoota <context.shooter>
    - playsound at:<context.projectile.location> sound:custom.psychichit pitch:0 volume:2
    - playsound at:<context.projectile.location> sound:entity_generic_explode pitch:0 volume:2
    - playsound at:<context.projectile.location> sound:entity_generic_explode pitch:1 volume:2
    - playsound at:<context.projectile.location> sound:entity_generic_explode pitch:2 volume:2
    - playsound at:<context.projectile.location> sound:entity_lightning_bolt_thunder pitch:1 volume:2
    - playsound at:<context.projectile.location> sound:entity_lightning_bolt_thunder pitch:2 volume:2
    - playsound at:<context.projectile.location> sound:entity_lightning_bolt_thunder pitch:0 volume:2
    - explode <context.projectile.location> power:4
    - repeat 40 as:bfgdegrees:
      - define aimtarg <[shoota].eye_location.with_yaw[<[shoota].eye_location.yaw.add[<[bfgdegrees].mul[4].add[-80]>]>].with_pitch[0].ray_trace[range=70;return=precise;default=air;nonsolids=false;entities=*;ignore=<[shoota]>;raysize=0.25]>
      - foreach <[aimtarg].find.living_entities.within[2].exclude[<[shoota]>].get[1]||0>:
        - playeffect at:<[value].location.above[1]> effect:redstone special_data:2|<color[#60FF00]> quantity:16 offset:0.5 visibility:100
        - playeffect at:<[value].location.above[1]> effect:redstone special_data:2|<color[#C0FF40]> quantity:8 offset:0.25 visibility:100
        - hurt <[value]> amount:25 cause:fire
#      - playeffect at:<[aimtarg]> effect:redstone special_data:2|<color[#60FF00]> quantity:4 offset:0.25 visibility:100
#      - playeffect at:<[aimtarg]> effect:redstone special_data:2|<color[#C0FF40]> quantity:2 offset:0.125 visibility:100