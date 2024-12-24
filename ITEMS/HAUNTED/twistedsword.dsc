twistedsword:
  type: item
  material: diamond_sword
  display name: <element[Twisted Sword].color_gradient[from=#C04040;to=#404040]>
  mechanisms:
    unbreakable: true
    #hides: all
    custom_model_data: 13374219
    attribute_modifiers:
      GENERIC_ATTACK_DAMAGE:
        1:
          operation: add_number
          amount: 16
          slot: hand
          id: 10000000-1000-1000-1000-100000000000
  lore:
  - <element[Something's deeply wrong with it].color_gradient[from=#602020;to=#202020]>
  - <element[<&l>↓<&r> Trance].color_gradient[from=#602020;to=#202020]>
  - <&7>
  - <element[HAUNTED].color[#38F0A8].bold>

twistedswordhits:
  type: world
  debug: false
  events:
    on player damages entity with:twistedsword:
    - if <context.entity.location.yaw> < <context.damager.location.yaw.add[20]> && <context.entity.location.yaw> > <context.damager.location.yaw.sub[20]>:
      - title title:<element[BACKSTAB!].bold.color_gradient[from=#C04040;to=#404040]> fade_in:0t stay:0t fade_out:20t targets:<context.damager>
      - playeffect effect:block_crack quantity:32 special_data:redstone_wire at:<context.entity.eye_location> offset:0.25
      - playeffect effect:redstone quantity:32 special_data:1.2|red at:<context.entity.eye_location> offset:0.25
      - playsound at:<context.entity.eye_location> sound:block_slime_block_break pitch:0 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_salmon_flop pitch:0 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_arrow_hit_player pitch:0 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_arrow_hit_player pitch:1 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_arrow_hit_player pitch:2 volume:2
      - determine <context.damage.mul[3]> CLEAR_MODIFIERS
    - if <context.entity.is_spawned> && ( <context.entity.health_max> > <context.damager.health_max.mul[2.5]> || <context.damager.health> < <context.damager.health_max.div[3]> ):
      - repeat 10:
        - playeffect effect:block_crack quantity:16 special_data:redstone_wire at:<context.entity.eye_location> offset:0.1
        - playeffect effect:redstone quantity:16 special_data:1.2|red at:<context.entity.eye_location> offset:0.1
        - playsound at:<context.entity.eye_location> sound:block_slime_block_break pitch:0 volume:2
        - playsound at:<context.entity.eye_location> sound:entity_salmon_flop pitch:0 volume:2
        - hurt <context.entity> 2 SUICIDE
        - wait 10t
#love being needlessly edgy