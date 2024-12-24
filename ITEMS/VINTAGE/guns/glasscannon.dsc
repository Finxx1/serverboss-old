glasscannon:
  type: item
  material: iron_horse_armor
  display name: <element[Glass Cannon].color[#C0FFFF]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374341
    hides: all
  lore:
  - <element[Crackle!].color[#608080]>
  - 
  - <element[VINTAGE].color[#404878].bold>

glasscannontriggers:
  type: world
  events:
    on player right clicks block with:glasscannon:
    - ratelimit <player> 1t
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:1.5 volume:1
#      - playsound <player.location> sound:entity_skeleton_hurt pitch:0.75 volume:1
      - playsound <player.location> sound:entity_generic_explode pitch:1 volume:1
      - playsound <player.location> sound:block_glass_break pitch:1 volume:1
      - playsound <player.location> sound:block_glass_break pitch:0 volume:1
#      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:0.75 volume:1
      - flag <player> riflecooldown expire:25t
      - itemcooldown iron_horse_armor duration:25t
      - repeat 50:
        - shoot glasspellet origin:<player.eye_location.right[0.4].below[0.4]> speed:<list[1.8|1.9|2].random> shooter:<player> spread:30
      - repeat 20:
        - wait 1t
        - playeffect effect:smoke_large at:<player.eye_location.right[0.4].below[0.4]> offset:0 visibility:100
    on player damaged:
    - if <player.item_in_hand.script> == <script[glasscannon]>:
      - playsound <player.eye_location> sound:block_glass_break pitch:1 volume:1
      - repeat 30:
        - playeffect at:<player.eye_location> effect:item_crack special_data:glasscannon visibility:100 velocity:<location[0,0,0].random_offset[0.25]> quantity:1 offset:0.2
      - take iteminhand quantity:1 from:<player.inventory>
      - hurt <player.eye_location.find.living_entities.within[4]> 2
     