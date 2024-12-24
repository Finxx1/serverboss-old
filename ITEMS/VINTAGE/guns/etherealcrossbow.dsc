etherealcrossbow:
  type: item
  material: golden_hoe
  display name: <element[Ethereal Crossbow].color[#909858]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374286
  lore:
  - <element[Kpshwoommmmfffffwowomp].color[#484C2C]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

etherealcrossbowtriggers:
  type: world
  events:
    on player right clicks block with:etherealcrossbow:
    - if <player.has_flag[crossbowcooldown]>:
      - stop
    - flag <player> crossbowcooldown expire:15t
    - determine cancelled passively
    - playsound <player.location> sound:item_crossbow_shoot pitch:0 volume:1
    - playsound <player.location> sound:item_crossbow_shoot pitch:1 volume:1
    - playsound <player.location> sound:item_crossbow_shoot pitch:2 volume:1
    - define lookvec <player.eye_location.direction.vector>
    - adjust <player> velocity:<player.velocity.sub[<[lookvec].div[2]>]>
    - foreach <player.eye_location.points_between[<player.eye_location.forward[70]>].distance[0.7]>:
      - playeffect at:<[value]> effect:redstone quantity:2 offset:0.01 special_data:0.5|<color[#80FF80]> visibility:200
      - foreach <[value].find.living_entities.within[1].exclude[<player>]>:
        - hurt <[value]> 3 source:<player>
      - if <[loop_index].mod[5]> == 0:
        - wait 1t