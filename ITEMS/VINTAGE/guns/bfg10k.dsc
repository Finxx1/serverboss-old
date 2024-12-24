bfg10k:
  type: item
  material: diamond_horse_armor
  display name: <element[BFG-10000].color_gradient[from=#2060FF;to=#6020FF]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374209
    hides: all
  lore:
  - <element[poof].color_gradient[from=#308010;to=#108040]>
  - 
  - <element[VINTAGE].color[#404878].bold>

bfg10kprojs:
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

bfg10kprojp:
  type: entity
  entity_type: snowball
  mechanisms:
    gravity: false
    item: bfg10kprojs

bfg10ktriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:bfg10k:
    - if <player.has_flag[bfgcooldown]>:
      - stop
    - flag <player> bfgcooldown expire:400t
    - itemcooldown diamond_horse_armor duration:400t
    - playsound sound:custom.bfg at:<player.eye_location> pitch:1 volume:2 custom
    - wait 17t
    - shoot bfg10kprojp origin:<player.eye_location> shooter:<player> speed:0.8 spread:0
    after bfg10kprojp spawns:
    - while <context.entity.is_spawned>:
      - adjust <context.entity> velocity:<context.entity.velocity.mul[1.01]>
      - if <[loop_index]> > 200:
        - while stop
      - wait 1t
    - if <context.entity.is_spawned>:
      - explode <context.entity.location> power:6
      - remove <context.entity>
    on bfg10kprojp hits entity:
    - playeffect at:<context.projectile.location> effect:redstone special_data:2|<color[#0060FF]> quantity:64 offset:1.5 visibility:100
    - playeffect at:<context.projectile.location> effect:redstone special_data:2|<color[#40C0FF]> quantity:32 offset:0.75 visibility:100
    - define shoota <context.shooter>
    - playsound at:<context.projectile.location> sound:custom.psychichit pitch:0 volume:2 custom
    - playsound at:<context.projectile.location> sound:entity_generic_explode pitch:0 volume:2
    - playsound at:<context.projectile.location> sound:entity_generic_explode pitch:1 volume:2
    - playsound at:<context.projectile.location> sound:entity_generic_explode pitch:2 volume:2
    - playsound at:<context.projectile.location> sound:entity_lightning_bolt_thunder pitch:1 volume:2
    - playsound at:<context.projectile.location> sound:entity_lightning_bolt_thunder pitch:2 volume:2
    - playsound at:<context.projectile.location> sound:entity_lightning_bolt_thunder pitch:0 volume:2
    - explode <context.projectile.location> power:4
    on bfg10kprojp hits block:
    - playeffect at:<context.projectile.location> effect:redstone special_data:2|<color[#0060FF]> quantity:64 offset:1.5 visibility:100
    - playeffect at:<context.projectile.location> effect:redstone special_data:2|<color[#40C0FF]> quantity:32 offset:0.75 visibility:100
    - define shoota <context.shooter>
    - playsound at:<context.projectile.location> sound:custom.psychichit pitch:0 volume:2 custom
    - playsound at:<context.projectile.location> sound:entity_generic_explode pitch:0 volume:2
    - playsound at:<context.projectile.location> sound:entity_generic_explode pitch:1 volume:2
    - playsound at:<context.projectile.location> sound:entity_generic_explode pitch:2 volume:2
    - playsound at:<context.projectile.location> sound:entity_lightning_bolt_thunder pitch:1 volume:2
    - playsound at:<context.projectile.location> sound:entity_lightning_bolt_thunder pitch:2 volume:2
    - playsound at:<context.projectile.location> sound:entity_lightning_bolt_thunder pitch:0 volume:2
    - explode <context.projectile.location> power:4