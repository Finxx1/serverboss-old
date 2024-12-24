vampscythe:
  type: item
  material: golden_hoe
  display name: <element[Vampiric Scythe].color_gradient[from=#FF8080;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374215
#    attribute_modifiers:
#      GENERIC_ATTACK_SPEED:
#        1:
#          operation: add_scalar
#          amount: -0.90
#          slot: hand
  lore:
  - <element[Your lust for blood has driven you].color_gradient[from=#804040;to=#606060]>
  - <element[in endless crop circles].color_gradient[from=#804040;to=#606060]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

vampscythetriggers:
  type: world
  events:
    on player left clicks block with:vampscythe:
    - determine cancelled passively
    - if <player.attack_cooldown_percent> < 80:
      - stop
    - playsound at:<player.location> volume:2 sound:item_trident_throw pitch:0
    - foreach <list[<player.eye_location.forward[2].left[-2.65].below[0.75]>|<player.eye_location.forward[2.75].left[-1.75].below[0.75]>|<player.eye_location.forward[3.25].below[0.75]>|<player.eye_location.forward[2.75].left[1.75].below[0.75]>|<player.eye_location.forward[2].left[2.65].below[0.75]>]>:
      - playeffect effect:sweep_attack quantity:1 offset:0.1 at:<[value]> visibility:100
      - foreach <[value].find.living_entities.within[2].exclude[<player>]> as:hurtguys:
        - hurt <[hurtguys]> 9 source:<player> cause:ENTITY_SWEEP_ATTACK
        - heal <player> 2
      - wait 1t
    on player damages entity with:vampscythe:
    - if <player.attack_cooldown_percent> < 80 || <context.cause> == ENTITY_SWEEP_ATTACK:
      - stop
    - playsound at:<player.location> volume:2 sound:item_trident_throw pitch:0
    - foreach <list[<player.eye_location.forward[2].left[-2.65].below[0.75]>|<player.eye_location.forward[2.75].left[-1.75].below[0.75]>|<player.eye_location.forward[3.25].below[0.75]>|<player.eye_location.forward[2.75].left[1.75].below[0.75]>|<player.eye_location.forward[2].left[2.65].below[0.75]>]>:
      - playeffect effect:sweep_attack quantity:1 offset:0.1 at:<[value]> visibility:100
      - foreach <[value].find.living_entities.within[2].exclude[<player>]> as:hurtguys:
        - hurt <[hurtguys]> 9 source:<player> cause:ENTITY_SWEEP_ATTACK
        - heal <player> 2
      - wait 1t