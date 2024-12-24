angelwings:
  type: item
  material: elytra
  display name: <element[「「「Angel].color_gradient[from=#C0FFFF;to=#FFFFC0]><element[ Wings」」」].color_gradient[from=#C0FFFF;to=#FFFFC0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374777
  enchantments:
  - infinity:1
  lore:
  - <element[The biblically accurate ones].color_gradient[from=#608080;to=#808080]>
  - <element[are in the back aisles].color_gradient[from=#608080;to=#808080]>
  - 
  - <element[CRACKED].color[#700050].bold>


angelwingstriggers:
  type: world
  debug: false
  events:
    on player starts gliding:
    - if <player.has_equipped[angelwings]||0>:
      - if !<player.has_flag[djmp]>:
        - determine cancelled passively
        - playsound <player.location> sound:entity_ender_dragon_flap pitch:2 volume:2
        - playeffect effect:cloud quantity:20 at:<player.location.add[0,0.2,0]> offset:0.5,0,0.5
        - if <player.is_sneaking>:
          - adjust <player> velocity:<player.velocity.x>,2,<player.velocity.z>
          - cast <player> slow_falling duration:1.5s amplifier:0 no_icon hide_particles no_ambient
        - else:
          - define lookvec <player.eye_location.direction.vector.mul[1]>
          - adjust <player> velocity:<player.velocity.x.add[<[lookvec].x>]>,<element[0.6].add[<[lookvec].y.div[2]>]>,<player.velocity.z.add[<[lookvec].z>]>
          - cast <player> slow_falling duration:0.625s amplifier:0 no_icon hide_particles no_ambient
        - flag <player> djmp
        - waituntil !<player.is_on_ground> max:1s
        - waituntil <player.is_on_ground> max:3s
        - flag <player> djmp:!
      - else:
        - determine cancelled passively
        - cast <player> slow_falling duration:2t amplifier:0 no_icon hide_particles no_ambient
    on delta time secondly every:5:
    - foreach <server.online_players>:
      - if <[value].has_equipped[angelwings]||0>:
        - cast <[value]> speed duration:6s amplifier:2 no_icon hide_particles no_ambient
        - cast <[value]> fast_digging duration:6s amplifier:0 no_icon hide_particles no_ambient
        - cast <[value]> damage_resistance duration:6s amplifier:0 no_icon hide_particles no_ambient
    on player damaged by FALL:
    - if <player.has_equipped[angelwings]||0>:
      - determine cancelled passively