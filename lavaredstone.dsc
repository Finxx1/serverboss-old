betalava:
  type: world
  debug: false
  events:
    on liquid spreads:
    - if <context.destination.block.material.name> == redstone_wire:
      - determine cancelled passively
      - playsound sound:block_lava_extinguish volume:2 pitch:1 at:<context.destination.add[0.5,0.5,0.5]>
      - playeffect effect:large_smoke visibility:100 quantity:16 offset:0.25 at:<context.destination.add[0.5,0.5,0.5]>
      - playeffect effect:redstone special_data:2|<color[#FF0000]> visibility:100 quantity:8 offset:0.25 at:<context.destination.add[0.5,0.5,0.5]>
      - playeffect effect:lava visibility:100 quantity:2 offset:0.25 at:<context.destination.add[0.5,0.5,0.5]>
      - playsound sound:block_respawn_anchor_set_spawn volume:2 pitch:2 at:<context.destination.add[0.5,0.5,0.5]>
      - modifyblock <context.destination> obsidian