bloodbucket:
  type: item
  material: diamond
  display name: <element[Blood Bucket].color_gradient[from=#FF0000;to=#A00000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375244
  lore:
  - <element[1) blood floats on blood].color_gradient[from=#800000;to=#500000]>
  - <&7>
  - <element[STRANGE].color[#D87840].bold>

bloodbuckettriggers:
  type: world
  events:
    on player right clicks block with:bloodbucket:
    - ratelimit <player> 1t
    - if <player.has_flag[bloodcooldown]>:
      - stop
    - if <player.flag[killmana]||0> < 5:
      - stop
    - flag <player> killmana:<player.flag[killmana].sub[5]||0>
    - flag <player> bloodcooldown expire:5t
    - playsound at:<player.eye_location> sound:entity_generic_splash pitch:0 volume:2
    - playsound at:<player.eye_location> sound:entity_generic_splash pitch:1 volume:2
    - playeffect at:<player.eye_location> quantity:16 effect:redstone special_data:2|<color[#<list[FF|A0].random>0000]> visibility:100 offset:0.5
    - heal <player> amount:2