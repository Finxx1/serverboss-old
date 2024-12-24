addmana:
  type: world
  debug: false
  events:
    on entity killed by player:
    - if <context.damager.inventory.contains_item[celestialclaw|bloodbucket]>:
      - flag <context.damager> killmana:<context.damager.flag[killmana].add[<context.entity.health_max>]||0>