therock:
  type: item
  material: polished_andesite
  display name: <element[The Rock?].color_gradient[from=#808080;to=#C0C0C0]>
 # enchantments:
 # - looting:100
  mechanisms:
    unbreakable: true
    hides: all
  lore:
  - <element[Powers: UNKNOWN].color_gradient[from=#404040;to=#606060]>
  - <element[Danger: UNKNOWN].color_gradient[from=#404040;to=#606060]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

therocktriggers:
  type: world
  debug: false
  events:
    after delta time secondly every:75:
    - foreach <server.online_players>:
      - if <[value].inventory.contains_item[therock]||0>:
        - define fuck <[value]>
        - random:
          - repeat 1:
            - cast <list[speed|regeneration|damage_resistance|fire_resistance|blindness|increase_damage|fast_digging|slow|levitation|poison].random> duration:<list[60t|120t|180t].random> amplifier:<list[0|1].random> <[fuck]> no_ambient hide_particles no_icon
            - playsound <[fuck].location> <[fuck]> sound:block_enchantment_table_use pitch:0.75
            - playsound <[fuck].location> <[fuck]> sound:block_enchantment_table_use pitch:0
          - repeat 1:
            - define entities <[fuck].location.find.living_entities.within[14].exclude[<[fuck].location.find.living_entities.within[7]>]>
            - narrate <[entities]>
            - strike <[entities].random.location||<location[0,0,0,world]>>
          - repeat 1:
            - time <util.random.int[<0>].to[<23999>]> <[fuck].location.world>
          - repeat 1:
            - flag <[fuck]> 
        - playsound <[fuck].location> <[fuck]> sound:block_enchantment_table_use pitch:0.75
        - playsound <[fuck].location> <[fuck]> sound:block_enchantment_table_use pitch:0
    on player starts swimming:
    - if <player.item_in_hand.script||0> == <script[therock]>:
      - explode <player.location.sub[0,1,0]> power:1
    on player picks up *gift:
    - if <player.inventory.contains_item[therock]||0>:
      - determine ITEM:fuckedgift