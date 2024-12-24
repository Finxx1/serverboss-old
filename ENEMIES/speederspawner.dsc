speederspawner:
  type: item
  material: written_book
  mechanisms:
    display: <&a>speeder spawner

speederspawnerhandler:
  type: world
  events:
    on player right clicks block with:speederspawner:
    - determine cancelled passively
    - ratelimit <player> 3t
    - if <player.is_sneaking>:
      - spawn speeder <context.relative>
    - else:
      - spawn speederboss <context.relative>