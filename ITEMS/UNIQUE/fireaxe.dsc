fireaxe:
  type: item
  material: netherite_axe
  display name: <element[Fire Axe].color_gradient[from=#C00000;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    #hides: all
    custom_model_data: 13374290
    attribute_modifiers:
      GENERIC_ATTACK_DAMAGE:
        1:
          operation: add_number
          amount: 7
          slot: hand
  lore:
  - <element[Note: Fire sold separately].color_gradient[from=#600000;to=#606060]>
  - <&7>
  - <element[UNIQUE].color[#FFEF10].bold>

fireaxeaxtinguish:
  type: world
  debug: false
  events:
    on player damages entity with:fireaxe:
    - if <context.entity.on_fire>:
      - determine <context.damage.mul[1.35].add[<context.entity.fire_time.mul[0.2]>]> passively
      - playsound at:<context.entity.location> volume:2 sound:entity_arrow_hit_player pitch:1
      - playsound at:<context.entity.location> volume:2 sound:entity_wither_break_block pitch:2
      - playsound at:<context.entity.location> volume:2 sound:entity_generic_extinguish_fire pitch:1
      - adjust <context.entity> fire_time:0t
      - repeat 32:
        - playeffect at:<context.entity.location.add[<context.entity.eye_location>].mul[0.5].add[0,0.25,0]> effect:flame velocity:<location[0,0,0].random_offset[<list[0.05|0.1|0.15].random>]> quantity:1 offset:0.02