kunai:
  type: item
  material: golden_sword
  display name: <element[Kunai].color_gradient[from=#404040;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374325
  lore:
  - <element[You are SUCH].color_gradient[from=#202020;to=#606060]>
  - <element[A BAD].color_gradient[from=#202020;to=#606060]>
  - <element[DOCTOR!].color_gradient[from=#202020;to=#606060]>
  - <element[HAHAHAHHAHAHAHHAAHA].color_gradient[from=#202020;to=#606060]>
  -
  - <element[HAUNTED].color[#38F0A8].bold>

kunaitriggers:
  type: world
  debug: false
  events:
    on player damages entity with:kunai:
    #- if <context.entity.location.direction> == <context.damager.eye_location.direction>:
    - if <context.entity.location.yaw> < <context.damager.location.yaw.add[20]> && <context.entity.location.yaw> > <context.damager.location.yaw.sub[20]>:
      - title title:<element[BACKSTAB!].bold.color_gradient[from=#C04040;to=#404040]> fade_in:0t stay:0t fade_out:5t targets:<context.damager>
      - playeffect effect:block_crack quantity:16 special_data:redstone_wire at:<context.entity.eye_location> offset:0.25
      - playeffect effect:redstone quantity:16 special_data:1.2|red at:<context.entity.eye_location> offset:0.25
      - playsound at:<context.entity.eye_location> sound:block_slime_block_break pitch:0 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_salmon_flop pitch:0 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_arrow_hit_player pitch:0 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_arrow_hit_player pitch:1 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_arrow_hit_player pitch:2 volume:2
      - if <context.damage.mul[16]> >= <context.entity.health>:
        - heal <context.damager> <context.damager.health_max>
        - adjust <context.damager> absorption_health:<context.entity.health_max.max[<context.damager.absorption_health>].min[100]>
        - playsound at:<context.entity.eye_location> sound:entity_wither_ambient pitch:2 volume:2
      - determine <context.damage.mul[16]> CLEAR_MODIFIERS
