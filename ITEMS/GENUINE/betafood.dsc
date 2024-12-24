betasteak:
  type: item
  material: cooked_beef
  mechanisms:
    custom_model_data: 13374202
  display name: <element[Beta Steak].color_gradient[from=#783810;to=#581800]>
  lore:
  - <element[What an awesome familiar taste!].color_gradient[from=#581800;to=#380800]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>
  - <&7><element[Manufactured in factory <util.random_uuid>]>

betachop:
  type: item
  material: porkchop
  display name: <element[Beta Porkchop].color_gradient[from=#FFD8D8;to=#D8A0A0]>
  mechanisms:
    custom_model_data: 13374203
  lore:
  - <element[What a familiar taste!].color_gradient[from=#D8A0A0;to=#A08080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>
  - <&7><element[Manufactured in factory <util.random_uuid>]>

betasteakeat:
  debug: false
  type: world
  events:
    on player right clicks block with:betasteak:
    - determine cancelled passively
    - if <player.health> < <player.health_max>:
      - define lookvec <player.eye_location.direction.vector.mul[1]>
      - heal <player> 8
      - feed <player> amount:8
      - repeat 10:
        - playeffect effect:item_crack at:<player.eye_location.below[0.1]> offset:0.1,0.1,0.1 special_data:cooked_beef quantity:1 velocity:<[lookvec].div[10].random_offset[0.1]>
      - playsound sound:entity_generic_eat at:<player.location> pitch:1
      - take iteminhand quantity:1 from:<player>
    on player right clicks block with:betachop:
    - determine cancelled passively
    - if <player.health> < <player.health_max>:
      - define lookvec <player.eye_location.direction.vector.mul[1]>
      - heal <player> 3
      - feed <player> amount:3
      - repeat 10:
        - playeffect effect:item_crack at:<player.eye_location.below[0.25].forward[0.1]> offset:0.1,0.1,0.1 special_data:porkchop quantity:1 velocity:<[lookvec].div[5].random_offset[0.1]>
      - playsound sound:entity_generic_eat at:<player.location> pitch:1
      - take iteminhand quantity:1 from:<player>