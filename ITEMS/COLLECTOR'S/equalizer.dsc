equalizer:
  type: item
  material: iron_pickaxe
  display name: <element[The Equalizer].color_gradient[from=#C0C0C0;to=#C00000]>
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
  lore:
  - <element[Come here, cupcake].color_gradient[from=#606060;to=#600000]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

equalizertriggers:
  type: world
  debug: false
  events:
    on entity damages entity with:equalizer:
    - determine <context.damager.health_max.sub[<player.health>].mul[0.75].add[4]> passively
    - playsound sound:entity_zombie_attack_iron_door pitch:1 volume:2 at:<context.damager.eye_location>
    - playsound sound:entity_zombie_attack_iron_door pitch:0 volume:2 at:<context.damager.eye_location>
    on entity kills entity:
    - if <util.random_chance[5]> && <context.damager.item_in_hand.script.name||0> == equalizer:
      - drop fraggrenade <context.entity.location.add[0,0.2,0]> quantity:1 speed:0.1 delay:10t