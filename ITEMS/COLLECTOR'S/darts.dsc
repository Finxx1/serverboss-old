dartbag:
  type: item
  material: paper
  display name: <element[Dartbag].color_gradient[from=#C06000;to=#808080]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375521
  lore:
  - <element[Happy birthday ;)].color_gradient[from=#603000;to=#404040]>
  - <&7>
  - <element[COLLECTOR'S].color[#808080].bold>

dart:
  type: item
  material: paper
  display name: <element[Dart].color_gradient[from=#808080;to=#C06000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375522
  lore:
  - <element[Pew].color_gradient[from=#404040;to=#603000]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

dartevents:
  type: world
  debug: false
  events:
    on player right clicks block with:dartbag:
    - if <player.has_flag[quivercooldown]>:
      - stop
    - flag <player> dartbagcooldown expire:600t
    - itemcooldown paper duration:600t
    - playsound sound:entity_ender_dragon_flap pitch:2 volume:1 at:<player.eye_location>
    - repeat 8:
      - give dart to:<player.inventory> quantity:4
      - playsound sound:entity_item_pickup pitch:0 volume:1 at:<player.eye_location>
      - wait 3t
    on player right clicks block with:dart:
    - take iteminhand quantity:1
    - if <player.has_equipped[skelekingskull]||0>:
      - shoot arrow[pickup_status=disallowed] origin:<player.eye_location> speed:1.45 spread:1 shooter:<player>
    - else:
      - shoot arrow[pickup_status=disallowed] origin:<player.eye_location> speed:1.45 spread:1 shooter:<player>
    - playsound sound:custom.classic_bow_shoot pitch:2 volume:1 at:<player.eye_location> custom
    - playsound sound:entity_arrow_shoot pitch:2 volume:1 at:<player.eye_location>