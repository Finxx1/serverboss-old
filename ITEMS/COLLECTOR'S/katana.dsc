katana:
  type: item
  material: iron_sword
  display name: <element[Katana].color_gradient[from=#FFA000;to=#E00808]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374200
    attribute_modifiers:
      GENERIC_ATTACK_SPEED:
        1:
          operation: add_scalar
          amount: 0.15
          slot: hand
          id: 10000000-1000-1000-1000-100000000000
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: lightblade|sickle[attribute_modifiers=map@[GENERIC_ATTACK_SPEED=li@map@[name=GENERIC_ATTACK_SPEED;amount=0.15;operation=ADD_SCALAR;slot=HAND;id=10000000-1000-1000-1000-100000000000]|]]
  lore:
  - <element[Can't abscond, bro.].color_gradient[from=#805000;to=#780404]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>



katanatriggers:
  type: world
  events:
    on player left clicks block with:katana:
    - determine cancelled passively
    - if <player.attack_cooldown_percent> < 100:
      - stop
    - playsound at:<player.location> volume:2 sound:item_trident_throw pitch:2
    - flag <player> melee_parrying duration:5t
    on player damages entity with:katana:
    - if <context.entity.has_flag[melee_parrying]>:
      - determine cancelled passively
      - narrate <element[+ ].italicize.bold.color[#FFFFFF]><element[CLASH].italicize.bold.color[#FFA000]> targets:<context.entity>
      - narrate <element[+ ].italicize.bold.color[#FFFFFF]><element[CLASH].italicize.bold.color[#FFA000]> targets:<context.damager>
      - playeffect at:<context.damager.eye_location.add[<context.entity.eye_location>].mul[0.5]> effect:flash offset:0 quantity:1 visibility:100
      - playsound at:<context.damager.eye_location> volume:2 sound:entity_zombie_attack_iron_door pitch:0
      - flag <context.entity> stylestatus:<context.entity.flag[stylestatus].add[250]>
      - flag <context.damager> stylestatus:<context.damager.flag[stylestatus].add[250]>
      - adjust <context.entity> velocity:<context.entity.velocity.add[<context.entity.location.sub[<context.damager.location>].normalize.mul[1]>].add[0,0.5,0]>
      - adjust <context.damager> velocity:<context.damager.velocity.add[<context.damager.location.sub[<context.entity.location>].normalize.mul[1]>].add[0,0.5,0]>
      - flag <context.entity> melee_parrying:!
      - flag <context.damager> melee_parrying:!
    on player damaged:
    - if <context.entity.has_flag[melee_parrying]>:
      - define dmggot <context.damage.mul[2]>
      - determine cancelled passively
      - playsound at:<context.damager.eye_location> volume:2 sound:entity_arrow_hit_player pitch:1
      - playsound at:<context.damager.eye_location> volume:2 sound:entity_wither_break_block pitch:2
      - if <context.damager||0> == 0:
        - flag <context.entity> melee_parrying:!
        - stop
      - if <context.damager> == <context.entity>:
        - flag <context.entity> melee_parrying:!
        - stop
      - if <context.damager.has_flag[melee_parrying]>:
        - wait 1t
      - else:
        - narrate <element[+ ].italicize.bold.color[#FFFFFF]><element[PARRY].italicize.bold.color[#80FF80]> targets:<context.entity>
        - flag <context.entity> stylestatus:<context.entity.flag[stylestatus].add[150]>
        - playeffect at:<context.damager.eye_location> effect:crit offset:0.5 quantity:10 visibility:100
        - playeffect at:<context.damager.eye_location> effect:explosion_large offset:0 quantity:1 visibility:100
        - hurt <context.damager> <[dmggot]>
      - flag <context.entity> melee_parrying:!
    on player right clicks block with:katana:
    - if <player.has_flag[katanacooldown]>:
      - stop
    - flag <player> katanacooldown expire:15t
    - itemcooldown iron_sword duration:15t
    - cast <player> invisibility duration:6t amplifier:0 no_ambient hide_particles no_icon
    - define blinkloc <player.eye_location.ray_trace[range=7;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.5].forward[1].with_y[<player.location.y>].with_pitch[<player.eye_location.pitch>].with_yaw[<player.eye_location.yaw>]>
    - define playvel <player.location.sub[<[blinkloc]>].normalize.mul[-0.35]>
    - playeffect effect:large_smoke at:<player.location> offset:0.5 quantity:30
    - cast <player> blindness duration:20t amplifier:0 no_ambient hide_particles no_icon
    - teleport <player> <[blinkloc]>
    - playsound <player.location> sound:custom.endoftime_blink pitch:1 volume:1 custom
    - playeffect effect:large_smoke at:<[blinkloc]> offset:0.5 quantity:30
    - wait 1t
    - adjust <player> velocity:<[playvel]>