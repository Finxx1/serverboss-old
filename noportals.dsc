noportal:
  type: world
  debug: false
  events:
    on player uses portal:
    - if <entity.location.world> != world:
      - determine cancelled passively