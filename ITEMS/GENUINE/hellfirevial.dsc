hellfirevial:
  type: item
  material: golden_hoe
  display name: <element[Vial of Hellfire].color[#FFC040]>
  mechanisms:
    custom_model_data: 13374204
  lore:
  - <element[Unknown flammable substance inside?].color[#806020]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

hellfiretriggers:
  debug: false
  type: world
  events:
    on player left clicks block with:hellfirevial:
    - if <player.has_flag[vialcoold]>:
      - stop
    - flag <player> vialcoold expire:7s
    #- itemcooldown golden_hoe duration:7s
    - inventory adjust slot:<player.held_item_slot> custom_model_data:13374205
    - playsound <player.location> sound:block_fire_ambient pitch:0 volume:1
    - define lookvec <player.eye_location.direction.vector>
    - playsound <player.location> sound:block_fire_ambient pitch:1 volume:1
    - playsound <player.location> sound:block_fire_ambient pitch:0 volume:1
    - playsound <player.location> sound:entity_blaze_shoot pitch:0 volume:1
    - playeffect effect:splash quantity:3 at:<player.eye_location.add[<[lookvec].div[3]>]> offset:0 velocity:<[lookvec].div[3].random_offset[0.15].div[1]>
    - define aimtarg <player.eye_location.ray_trace[range=8;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.5]>
    - foreach <player.eye_location.points_between[<[aimtarg]>].distance[0.5]>:
      - hurt <[value].find_entities.within[1].exclude[<player>]> 12 cause:fire
      - burn <[value].find_entities.within[1].exclude[<player>]> 25s
      - playeffect effect:lava quantity:1 at:<[value]> offset:0 velocity:<[lookvec].div[6].random_offset[0.15].div[5]>
      - playeffect effect:flame quantity:2 at:<[value]> offset:0 velocity:<[lookvec].div[3].random_offset[0.3].div[5]>
      - playeffect effect:smoke quantity:2 at:<[value]> offset:0 velocity:<[lookvec].random_offset[0.6].div[5]>
      - if <[loop_index].mod[2]> == 0:
        - wait 1t
    - wait 1s
    - take item:hellfirevial from:<player.inventory> quantity:1
    - playsound <player.location> sound:block_glass_break pitch:2 volume:1
    - repeat 15:
      - playeffect effect:item_crack at:<player.eye_location> offset:0.3,0.3,0.3 special_data:glass quantity:1 velocity:<player.eye_location.direction.vector.div[2].random_offset[0.3]>