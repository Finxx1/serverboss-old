riftaxe:
  type: item
  material: netherite_axe
  display name: <element[Sharpened].color_gradient[from=#FF0000;to=#FFC040]> <element[Volcano].color_gradient[from=#FFC040;to=#FF0000]><element[ Fragment].color_gradient[from=#FF0000;to=#402020]>
  mechanisms:
    unbreakable: true
    #hides: all
    custom_model_data: 13374292
  lore:
  - <element[God ].color_gradient[from=#800000;to=#806020]><element[fucking].color_gradient[from=#806020;to=#800000]><element[ damnit].color_gradient[from=#800000;to=#201010]>
  - <&7>
  - <element[UNIQUE].color[#FFEF10].bold>

riftmace:
  type: item
  material: netherite_shovel
  display name: <element[The ].color_gradient[from=#FF0000;to=#FFC040]><element[Sun].color_gradient[from=#FFC040;to=#FF0000]><element[ on a Stick].color_gradient[from=#FF0000;to=#402020]>
  mechanisms:
    unbreakable: true
    #hides: all
    custom_model_data: 13374291
    attribute_modifiers:
      generic_attack_speed:
        1:
          operation: add_scalar
          amount: 8
          slot: hand
          id: 10000000-1000-1000-1000-100000000000
  lore:
  - <element[Jesus ].color_gradient[from=#800000;to=#806020]><element[fucking].color_gradient[from=#806020;to=#800000]><element[ christ].color_gradient[from=#800000;to=#201010]>
  - <&7>
  - <element[UNIQUE].color[#FFEF10].bold>


riftweaponz:
  type: world
  debug: false
  events:
    on player damages entity with:riftaxe:
    - burn <context.entity> duration:120t
    on player damages entity with:riftmace:
    - if <context.entity.on_fire>:
      - title targets:<context.damager> "title:<element[CRITICAL HIT!].bold.italicize.color_gradient[from=#00FF00;to=#FF0000;style=HSB]>" "subtitle:" fade_in:0 stay:5t fade_out:10t
      - adjust <context.entity> velocity:<context.entity.velocity.add[<context.damager.eye_location.direction.vector.mul[1].random_offset[0.5]>]>
      - playsound <context.entity.eye_location> sound:entity_arrow_hit_player volume:1 pitch:2
      - playsound <context.entity.eye_location> sound:entity_player_levelup volume:1 pitch:1
      - determine <context.damage.mul[4]> passively