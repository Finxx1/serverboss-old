glasssword:
  type: item
  material: diamond_sword
  display name: <element[Glass Sword].color_gradient[from=#80FFFF;to=#FFFFFF]>
  mechanisms:
    unbreakable: true
    #hides: all
    custom_model_data: 13374208
    attribute_modifiers:
      GENERIC_ATTACK_DAMAGE:
        1:
          operation: add_number
          amount: 10
          slot: hand
          id: 10000000-1000-1000-1000-100000000000
  lore:
  - <element[Fragile yet sharp!].color_gradient[from=#408080;to=#808080]>
  - <&7>
  - <element[UNIQUE].color[#FFEF10].bold>

glassswordshatter:
  type: world
  debug: false
  events:
    on player damages entity with:glasssword:
    - if <util.random_chance[1]>:
      - playsound <player.eye_location> sound:block_glass_break pitch:1 volume:1
      - repeat 30:
        - playeffect at:<player.eye_location> effect:item_crack special_data:glasssword visibility:100 velocity:<location[0,0,0].random_offset[0.25]> quantity:1 offset:0.2
      - take iteminhand quantity:1 from:<player.inventory>
      - hurt <player.eye_location.find.living_entities.within[4]> 2
    on player damaged:
    - if <player.item_in_hand.script> == <script[glasssword]> && <util.random_chance[15]>:
      - playsound <player.eye_location> sound:block_glass_break pitch:1 volume:1
      - repeat 30:
        - playeffect at:<player.eye_location> effect:item_crack special_data:glasssword visibility:100 velocity:<location[0,0,0].random_offset[0.25]> quantity:1 offset:0.2
      - take iteminhand quantity:1 from:<player.inventory>
      - hurt <player.eye_location.find.living_entities.within[3]> 6
     