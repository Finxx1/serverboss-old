clone:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 20
    health: 20
    speed: 0.325

clonehandler:
  type: world
  events:
    after clone spawns:
    - libsdisguise player target:<context.entity> name:<context.entity.flag[playcopy]>
    - while <context.entity.is_spawned>:
      - attack <context.entity> target:<context.entity.find.living_entities.exclude[<context.entity.flag[playcopy]>].exclude[<context.entity>].get[1]||0>
      - if <[loop_index]> > 600:
        - hurt <context.entity> amount:2 cause:MAGIC
      - wait 2t
    on clone targets player:
    - determine cancelled passively
    on clone dies:
    - determine NO_DROPS passively