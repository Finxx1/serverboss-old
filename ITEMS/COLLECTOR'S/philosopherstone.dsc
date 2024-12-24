philosopherstone:
  type: item
  material: diamond
  display name: <element[Philosopher's Stone].color_gradient[from=#FF40C0;to=#FFC020]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375237
  lore:
  - <element[Great minds think alike].color_gradient[from=#802060;to=#806010]>
  - <element[Greater minds think worse].color_gradient[from=#802060;to=#806010]>
  -
  - <element[COLLECTOR'S].color[#800000].bold>

philoprojs:
  type: item
  material: clay_ball
  display name: <element[Philosopher's Projectile].color_gradient[from=#FF40C0;to=#FFC020;style=hsb]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374326
  lore:
  - <element[ur not suposed to have this].color_gradient[from=#800000;to=#003060]>
  -
  - <element[COLLECTOR'S].color[#800000].bold>

philoprojp:
  type: entity
  entity_type: snowball
  mechanisms:
    item: philoprojs
    gravity: false

philotriggers:
  type: world
  events:
    on player right clicks block with:philosopherstone:
    - if <player.has_flag[philocooldown]>:
      - stop
    - flag <player> philocooldown expire:5t
    - itemcooldown diamond duration:5t
    - playsound sound:custom.psychicfire pitch:2 volume:2 at:<player.eye_location> custom
    - playsound sound:entity_arrow_hit_player pitch:0 volume:2 at:<player.eye_location>
    - shoot philoprojp origin:<player.eye_location.right[0.4].below[0.4]> speed:1.5 shooter:<player> spread:1
    after philoprojp spawns:
    - wait 80t
    - if <context.entity.is_spawned>:
      - remove <context.entity>
    on philoprojp hits entity:
    - random:
      - attack <context.hit_entity> target:<context.hit_entity>
      - explode <context.hit_entity.eye_location> power:2
      - cast <context.hit_entity> levitation duration:60t amplifier:1 no_icon hide_particles no_ambient
      - burn <context.hit_entity> duration:80t
      - repeat 1:
        - define temploc <context.hit_entity.location>
        - teleport <context.hit_entity> <context.projectile.shooter>
        - teleport <context.projectile.shooter> <[temploc]>