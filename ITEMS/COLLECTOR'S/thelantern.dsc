thelantern:
  type: item
  material: soul_lantern
  display name: <element[The Lantern].color_gradient[from=#80FFFF;to=#FFFFFF]>
 # enchantments:
 # - looting:100
  mechanisms:
    unbreakable: true
    custom_model_data: 13374200
    hides: all
  lore:
  - <element[Your path shall be clear].color_gradient[from=#408080;to=#808080]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

thelanterntriggers:
  type: world
  debug: false
  events:
    on delta time secondly every:1:
    - foreach <server.online_players> as:fuck:
      - if <[fuck].item_in_hand.script||0> == <script[thelantern]>:
        - repeat 10:
          - foreach <[fuck].location.find_entities.within[16].exclude[<[fuck]>]> as:fuck2:
            - adjust <[fuck2]> velocity:<[fuck2].velocity.div[1.5]>
            - playeffect effect:end_rod quantity:1 at:<[fuck2].eye_location> offset:0.1
          - playeffect effect:end_rod quantity:6 at:<[fuck].eye_location> offset:16
          - wait 2t
    on player right clicks block with:thelantern:
    - determine cancelled passively