converter:
  type: item
  material: heart_of_the_sea
  display name: <element[The Converter].color_gradient[from=#FF0000;to=#0060C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375252
  lore:
  - <element[Will you give your soul in exchange for mine?].color_gradient[from=#800000;to=#003060]>
  -
  - <element[COLLECTOR'S].color[#800000].bold>

convertertriggers:
  type: world
  events:
    on player right clicks block with:converter:
    - if <player.health_max> > 2 && !<player.has_flag[convertercooldown]>:
      - adjust <player> absorption_health:<player.absorption_health.add[6]>
      - adjust <player> max_health:<player.health_max.sub[2]>
      - flag <player> convertercooldown expire:5t
      - itemcooldown heart_of_the_sea duration:5t
      - playsound at:<player.eye_location> sound:entity_wither_ambient pitch:1
      - playsound at:<player.eye_location> sound:entity_generic_hurt pitch:0