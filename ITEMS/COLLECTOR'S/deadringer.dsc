deadringer:
  type: item
  material: gold_ingot
  display name: <element[The Dead Ringer].color_gradient[from=#808080;to=#00FFD0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374220
  lore:
  - <element[Did you forget about me?].color_gradient[from=#404040;to=#008068]>
  -
  - <element[COLLECTOR'S].color[#800000].bold>

deadringertriggers:
  type: world
  debug: false
  events:
    on player dies priority:999:
    - if ( <player.item_in_hand.script.name> == deadringer || <player.item_in_offhand.script.name> == deadringer ) && !<player.has_flag[deathringcooldown]>:
      - determine cancelled passively
      - adjust <player> health:1
      - flag <player> deathringcooldown expire:280t
      - itemcooldown gold_ingot duration:280t
      - cast <player> invisibility duration:100t amplifier:1 no_icon hide_particles no_ambient
      - cast <player> speed duration:100t amplifier:2 no_icon hide_particles no_ambient
      - cast <player> weakness duration:100t amplifier:6 no_icon hide_particles no_ambient
      - cast <player> slow_digging duration:100t amplifier:6 no_icon hide_particles no_ambient
      - cast <player> damage_resistance duration:20t amplifier:3 no_icon hide_particles no_ambient
      - cast <player> fire_resistance duration:40t amplifier:0 no_icon hide_particles no_ambient
      - foreach <player.eye_location.find.living_entities.within[32].exclude[<player>]>:
        - if <[value].target> == <player>:
          - attack <[value]> cancel
      - wait 20t
      - cast <player> damage_resistance duration:60t amplifier:1 no_icon hide_particles no_ambient
      - wait 80t
      - foreach <player.eye_location.find.living_entities.within[16].exclude[<player>]>:
        - attack <[value]> target:<player>
      - playsound at:<player.eye_location> sound:custom.lightning_charge pitch:2 volume:9 custom
      - playsound at:<player.eye_location> sound:custom.lightning_charge pitch:1 volume:9 custom
      - playsound at:<player.eye_location> sound:custom.lightning_charge pitch:0 volume:9 custom
      - wait 1t
      - playsound at:<player.eye_location> sound:custom.lightning_discharge pitch:2 volume:9 custom
      - playsound at:<player.eye_location> sound:custom.lightning_discharge pitch:1 volume:9 custom
      - playsound at:<player.eye_location> sound:custom.lightning_discharge pitch:0 volume:9 custom
      - wait 1t
      - playsound at:<player.eye_location> sound:block_portal_travel pitch:2 volume:9
      - playsound at:<player.eye_location> sound:block_endportal_spawn pitch:2 volume:9