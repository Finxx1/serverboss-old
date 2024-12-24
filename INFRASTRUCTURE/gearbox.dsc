devtriggers2:
  type: world
  debug: false
  events:
    on yellow_glazed_terracotta physics adjacent:redstone_wire:
    - ratelimit <context.location.block> 1t
    - if <context.location.find_blocks[redstone_wire].within[1].filter_tag[<[filter_value].level.is_more_than[0]>]>:
      - wait 1t