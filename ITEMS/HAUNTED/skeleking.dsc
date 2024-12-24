skelekingskull:
  type: item
  material: player_head
  display name: <element[Skeleton].color_gradient[from=#E0D0C0;to=#C0C0C0]><element[ ]><element[King's].color_gradient[from=#FFC020;to=#800000]><element[ Skull].color[#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    skull_skin: _nomor_
  lore:
  - <element[It's a trophy].color_gradient[from=#707860;to=#606060]><element[ ]><element[fit for a king].color_gradient[from=#806010;to=#400000]>
  - 
  - <element[HAUNTED].color[#38F0A8].bold>

skelekingskulltrig:
  type: world
  debug: false
  events:
    on player damaged by entity:
    - if <context.entity.has_equipped[skelekingskull]||0>:
      - if <context.damager.target> != <context.entity>:
        - determine cancelled passively
      - if <context.projectile||0> != 0:
        - determine <context.damage.mul[0.35]>
      - foreach <context.entity.location.find_entities[skeleton|wither_skeleton].within[32]||0>:
        - attack <[value]> target:<context.damager>
    on entity targets player:
    - if <context.target.has_equipped[skelekingskull]>:
      - if <list[skeleton|wither_skeleton].contains_any[<context.entity.entity_type>]>:
        - determine cancelled passively
    on player right clicks block with:arrow:
    - if <player.has_equipped[skelekingskull]||0>:
      - take iteminhand quantity:1
      - shoot arrow origin:<player.eye_location> speed:1.25 spread:5 shooter:<player>
      - playsound sound:custom.classic_bow_shoot pitch:2 volume:1 at:<player.eye_location> custom
    on projectile spawns:
    - if <context.entity.shooter.has_equipped[skelekingskull]>:
      - adjust <context.entity> velocity:<context.entity.velocity.mul[1.25]>
      - define proj <context.entity>
      - wait 1t
      - while <[proj].is_spawned>:
        - playeffect at:<[proj].location> offset:0 effect:crit quantity:1 visibility:100
        - wait 1t
    on projectile damages entity:
    - if <context.damager.has_equipped[skelekingskull]>:
      - determine <context.damage.add[2].mul[1.5]>
    on player right clicks block with:bow:
    - wait 1t