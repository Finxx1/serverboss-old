tntboots:
  type: item
  material: golden_boots
  display name: <element[TNT Boots].color_gradient[from=#C0C0C0;to=#C00000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374200
  lore:
  - <element[Kapow!].color_gradient[from=#606060;to=#600000]>
  -
  - <element[COLLECTOR'S].color[#800000].bold>


tntbootstriggers:
  type: world
  debug: false
  events:
    on player jumps:
    - if <player.has_equipped[tntboots]||0>:
      - explode <player.location> power:1
      - wait 2t
      - while !<player.is_on_ground>:
        - playeffect effect:flame quantity:2 at:<player.location.sub[0,0.1,0]> offset:0
        - wait 1t
    on player damaged by BLOCK_EXPLOSION:
    - if <player.has_equipped[tntboots]||0>:
      - determine <element[1]> passively
    on player damaged by ENTITY_EXPLOSION:
    - if <player.has_equipped[tntboots]||0>:
      - determine <element[1]> passively