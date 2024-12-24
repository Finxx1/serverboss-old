gloryhammer:
  type: item
  material: netherite_axe
  display name: <element[「GLORYHAMMER」].color_gradient[from=#606060;to=#FF40FF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374239
  enchantments:
  - smite: 2
  lore:
#  - <list[<element[-= LASER POWERED =-].color_gradient[from=#303030;to=#802080]>|<element[-= THUNDER STRIKING =-].color_gradient[from=#303030;to=#802080]>|<element[-= HEAVY METAL =-].color_gradient[from=#303030;to=#802080]>].random>
#  - <list[<element[-= GOBLIN SMASHER =-].color_gradient[from=#303030;to=#802080]>|<element[-= WIZARD THRASHER =-].color_gradient[from=#303030;to=#802080]>|<element[-= DARKLORD CRASHER =-].color_gradient[from=#303030;to=#802080]>|].random>
  - <element[-= LASER POWERED =-].color_gradient[from=#303030;to=#802080]>
  - <element[-= GOBLIN SMASHER =-].color_gradient[from=#303030;to=#802080]>
  - 
  - <element[UNUSUAL].color[#9040C0].bold>


gloryhammertriggers:
  type: world
  debug: false
  events:
    on player damages entity with:gloryhammer:
    - if <player.has_flag[gloryhammercooldown]>:
      - stop
    - flag <player> gloryhammercooldown expire:5s
    - itemcooldown netherite_axe duration:5s
    - determine cancelled passively
    - if <context.entity.location.block.material.name> == air:
      - teleport <context.entity> <context.entity.location.sub[0,1,0]>
    - playeffect at:<context.entity.eye_location> quantity:5 offset:0.2 effect:explosion_large
    - playsound at:<context.entity.eye_location> sound:entity_generic_explode pitch:1 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_generic_explode pitch:1 volume:2
    - define entloc <context.entity.eye_location>
    - hurt <context.entity> 10
    - define <[awareness]> <context.entity.is_aware>
    - adjust <context.entity> is_aware:false
    - repeat 20:
      - foreach <proc[particle_ring].context[<[entloc]>|8|<[value]>]> as:ringloc:
        - explode <[ringloc]> power:1 source:<player>
      - wait 1t
    - wait 5s
    - adjust <context.entity> is_aware:<[awareness]>