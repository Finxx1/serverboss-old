gaussstick:
  type: item
  material: stick
  display name: <element[Gauss Stick].color_gradient[from=#FFFFFF;to=#008080]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374400
  lore:
  - <element[Most importantly, under no circumstances should you <&k>fdspojg j DSFIu].color_gradient[from=#808080;to=#004040]>
  - 
  - <element[HAUNTED].color[#38F0A8].bold>

gausstriggers:
  type: world
  debug: false
  events:
    on player left clicks block with:gaussstick:
    - determine cancelled passively
    - if <player.has_flag[teslacooldown]>:
      - stop
    - flag <player> teslacooldown expire:5s
    - itemcooldown stick duration:5s
    - define aimtarg <player.eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.5]>
    - define posline <player.eye_location.points_between[<[aimtarg]>].distance[0.5]>
    - define lookvec <player.eye_location.direction.vector>
    - define hittarg <[aimtarg].find_entities.within[3].exclude[<player>].get[1]||0>
    - playsound <player.location> sound:entity_lightning_bolt_thunder pitch:2 volume:2
    - playsound <player.location> sound:entity_generic.explode pitch:2 volume:2
    - playsound <player.location> sound:custom.lightning_discharge pitch:0 volume:2 custom
    - playsound <player.location> sound:custom.lightning_charge pitch:0 volume:2 custom
    - playsound <player.location> sound:custom.lightning_discharge pitch:1 volume:2 custom
    - playsound <player.location> sound:custom.lightning_charge pitch:1 volume:2 custom
    - playsound <player.location> sound:custom.lightning_charge pitch:1 volume:2 custom
    - foreach <[posline]>:
      - playeffect effect:redstone special_data:1.5|<color[#FFFFFF]> quantity:2 at:<[value]> offset:0.02 visibility:100
      - playeffect effect:redstone special_data:0.75|<color[#80FFFF]> quantity:6 at:<[value]> offset:0.1 visibility:100
      - playeffect effect:magic_crit quantity:2 at:<[value]> offset:0.5 visibility:100
      - define hittemp <[value].find_entities.within[3].exclude[<player>].get[1]||0>
      - if <[hittemp]> != 0:
        - define hittarg <[hittemp]>
        - foreach stop
    - if <[hittemp]||0> != 0:
      - hurt <[hittemp]> 10
      - run mgk_chainlightning def:<player>|<[hittemp]>|<element[20]>
    - else:
      - explode <[aimtarg]> power:2
    - adjust <player> velocity:<player.velocity.sub[<[lookvec].normalize.mul[1]>]>