quiver:
  type: item
  material: paper
  display name: <element[Quiver].color_gradient[from=#C06000;to=#808080]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375520
  lore:
  - <element[GET YOUR FREE TVS!].color_gradient[from=#603000;to=#404040]>
  - <&7>
  - <element[UNIQUE].color[#FFEF10].bold>

quiverevents:
  type: world
  debug: false
  events:
    on player right clicks block with:quiver:
    - if <player.has_flag[quivercooldown]>:
      - stop
    - flag <player> quivercooldown expire:600t
    - itemcooldown paper duration:600t
    - playsound sound:entity_ender_dragon_flap pitch:2 volume:1 at:<player.eye_location>
    - repeat 8:
      - give arrow to:<player.inventory> quantity:4
      - playsound sound:entity_item_pickup pitch:0 volume:1 at:<player.eye_location>
      - wait 3t