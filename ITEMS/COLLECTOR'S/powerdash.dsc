powerdash:
  type: item
  material: feather
  display name: <element[Powerdash].color_gradient[from=#FFC0FF;to=#C0FFC0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374200
  lore:
  - <element[Flings you].color_gradient[from=#806080;to=#608060]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

powerdashtriggers:
  type: world
  events:
    on player right clicks block with:powerdash:
    - determine cancelled passively
    - if !<player.has_flag[powerdashcooldown]>:
      - define lookvec <player.velocity.mul[4]>
      - adjust <player> velocity:<[lookvec]>
      - flag <player> powerdashcooldown expire:60t
      - itemcooldown feather duration:60t
      - playeffect effect:redstone special_data:1|<color[#FFFF00]> at:<player.eye_location> offset:0.75 quantity:64 visibility:100
      - playsound sound:entity_wither_shoot at:<player.eye_location> pitch:2 volume:2
      - playsound sound:entity_player_levelup at:<player.eye_location> pitch:2 volume:2
    on player left clicks block with:powerdash:
    - determine cancelled passively
    - if !<player.has_flag[powerdashcooldown]>:
      - define lookvec <player.velocity.mul[-3]>
      - adjust <player> velocity:<[lookvec]>
      - flag <player> powerdashcooldown expire:60t
      - itemcooldown feather duration:60t
      - playeffect effect:redstone special_data:1|<color[#FFFF00]> at:<player.eye_location> offset:0.75 quantity:64 visibility:100
      - playsound sound:entity_wither_shoot at:<player.eye_location> pitch:1 volume:2
      - playsound sound:entity_player_levelup at:<player.eye_location> pitch:1 volume:2