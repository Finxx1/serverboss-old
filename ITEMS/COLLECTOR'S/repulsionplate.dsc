repulsionplate:
  type: item
  material: diamond_chestplate
  display name: <element[Chestplate of Repulsion].color_gradient[from=#200040;to=#20C0FF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374200
  lore:
  - <element[Theoretically infinite spatial distance magnifier].color_gradient[from=#100020;to=#106080]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

repulsiontriggers:
  type: world
  debug: false
  events:
    on player damaged by entity:
    - if <context.entity.has_equipped[repulsionplate]>:
      - playsound sound:custom.psychichit at:<context.entity.eye_location> pitch:1 volume:2 custom
      - playeffect effect:redstone special_data:1|<color[#20C0FF]> quantity:8 offset:0.6 visibility:100 at:<context.entity.eye_location>
      - playeffect effect:redstone special_data:1|<color[#20FFFF]> quantity:8 offset:0.6 visibility:100 at:<context.entity.eye_location>
      - playeffect effect:redstone special_data:1|<color[#2040FF]> quantity:8 offset:0.6 visibility:100 at:<context.entity.eye_location>
      - adjust <context.damager> velocity:<context.damager.velocity.add[<context.damager.eye_location.sub[<context.entity.location>].normalize.mul[0.75]>]>
    on projectile damages player:
    - if <context.entity.has_equipped[repulsionplate]>:
      - define woulddmg <context.damage>
      - determine cancelled passively
      - hurt <player> <[woulddmg].mul[0.5]>