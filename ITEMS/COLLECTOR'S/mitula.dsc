captivators:
  type: item
  material: golden_helmet
  display name: <element[The Captivators].color[#A0A000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 1228422
  lore:
  - <element[priimary fiire for red la2er.].color_gradient[from=#800000;to=#505000]>
  - <element[53CND4RYY FL1R3 F0H 8L0UR3 L424R].color_gradient[from=#505000;to=#000080]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

captivatortriggers:
  type: world
  debug: false
  events:
    on player left clicks block with:air:
    - if <player.has_equipped[captivators]||0> && <player.item_in_hand.material.name> == air:
      - if <player.is_sneaking>:
        - choose <player.flag[captormode]||red>:
          - case red:
            - flag <player> captormode:blue
            - title targets:<player> "title:<element[8LUGH M03D 53L3C73DD].color[#0000FF]>" "subtitle:" stay:10t fade_out:5t fade_in:0t
          - case blue:
            - flag <player> captormode:red
            - title targets:<player> "title:<element[red mode 2elected].color[#FF0000]>" "subtitle:" stay:10t fade_out:5t fade_in:0t
        - playsound <player.eye_location> sound:custom.psychichit volume:2 pitch:2 custom
      - else:
        - if <player.has_flag[captorcooldown]>:
          - stop
        - choose <player.flag[captormode]||red>:
          - case red:
            - flag <player> captorcooldown expire:10t
            - playsound <player.eye_location> sound:custom.psychichit volume:2 pitch:1 custom
            - playsound <player.eye_location> sound:block_beacon_activate volume:2 pitch:1
            - define aimtarg <player.eye_location.left[0.1].ray_trace[range=50;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.5]>
            - define posline <player.eye_location.left[0.1].points_between[<[aimtarg]>].distance[0.5]>
            - foreach <[posline]> as:pointloc:
              - playeffect effect:redstone special_data:0.5|<color[#FF0000]> quantity:3 at:<[pointloc]> offset:0.01 visibility:100
              - define aroundme <[pointloc].find_entities.within[1].exclude[<player>]>
              - if !<[aroundme].is_empty>:
                - foreach <[aroundme]>:
                  - hurt <[value]> amount:4 source:<player>
          - case blue:
            - flag <player> captorcooldown expire:40t
            - playsound <player.eye_location> sound:custom.psychichit volume:2 pitch:0 custom
            - playsound <player.eye_location> sound:custom.psychicfire volume:2 pitch:1 custom
            - playsound <player.eye_location> sound:block_beacon_activate volume:2 pitch:0
            - define aimtarg <player.eye_location.left[-0.1].ray_trace[range=50;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.5]>
            - define posline <player.eye_location.left[-0.1].points_between[<[aimtarg]>].distance[0.5]>
            - foreach <[posline]> as:pointloc:
              - playeffect effect:redstone special_data:2|<color[#0000FF]> quantity:3 at:<[pointloc]> offset:0.01 visibility:100
              - define aroundme <[pointloc].find_entities.within[1].exclude[<player>]>
              - if !<[aroundme].is_empty>:
                - foreach <[aroundme]>:
                  - hurt <[value]> amount:12 source:<player>
                  - adjust <[value]> velocity:<[value].velocity.add[<[value].eye_location.sub[<[pointloc]>].normalize.mul[2]>]>
                - playsound <[pointloc]> sound:custom.psychichit volume:2 pitch:0 custom
                - playsound <[pointloc]> sound:entity_evoker_cast_spell volume:2 pitch:1
                - playsound <[pointloc]> sound:entity_generic_explode volume:2 pitch:0
                - playeffect effect:redstone special_data:2|<color[#0000FF]> quantity:30 at:<[pointloc]> offset:0.5 visibility:100
                - stop
              - wait 1t
            - playeffect effect:redstone special_data:2|<color[#0000FF]> quantity:30 at:<[aimtarg]> offset:0.5 visibility:100
            - playsound <[aimtarg]> sound:custom.psychichit volume:2 pitch:0 custom
            - playsound <[aimtarg]> sound:entity_evoker_cast_spell volume:2 pitch:1
            - playsound <[aimtarg]> sound:entity_generic_explode volume:2 pitch:0

redglare:
  type: item
  material: golden_helmet
  display name: <element[The Red Glare].color[#008080]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 1314314
  lore:
  - <element[1f you c4nt k33p up th3n ch3ck 1n to h3ll!!!! &gt8&rb].unescaped.color[#004040]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

redglaretriggers:
  type: world
  debug: false
  events:
    on tick every:5:
    - foreach <server.online_players> as:playrs:
      - if <[playrs].has_equipped[redglare]||0>:
        - cast <[playrs]> blindness duration:70t amplifier:1 no_icon hide_particles no_ambient 
        - cast <[playrs]> speed duration:40t amplifier:1 no_icon hide_particles no_ambient 
        - cast <[playrs]> increase_damage duration:40t amplifier:0 no_icon hide_particles no_ambient 
        - foreach <[playrs].eye_location.find_entities.within[50].exclude[<[playrs]>]||0>:
          - if !<[value].glowing>:
            - adjust <[value]> glowing:true
            - waituntil <[value].distance[<[playrs].eye_location>]> > 50 || !<[playrs].has_equipped[redglare]> max:3600t rate:5t
            - adjust <[value]> glowing:false

dealmaker:
  type: item
  material: golden_helmet
  display name: <element[The Deal Maker].color_gradient[from=#FFFF00;to=#FF80A0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 1997197
  lore:
  - <element[EVERY  BUDDY'S   FAVORITE &lbFavorite Number 1 Rated Salesman1997&rb].unescaped.color_gradient[from=#808000;to=#804050]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

dealmakertriggers:
  type: world
  debug: false
  events:
    on player kills entity:
    - if <context.damager.has_equipped[dealmaker]>:
      - run dolarspawn def:<context.entity.health_max.mul[0.2].min[25]>|0.25|<context.entity.location>
    on player damaged:
    - if <context.entity.has_equipped[dealmaker]>:
      - if <context.entity.flag[money]||0> > 0:
        - determine <context.damage.mul[0.497]> passively
        - define moneyused <context.damage.mul[2].add[<list[4|8|3|7].random>].mul[<list[1.1|1.02|0.8|1|0.5|1.6].random>].round_down>
        - flag <context.entity> money:<context.entity.flag[money].sub[<[moneyused]>].max[0]>
        - title targets:<context.entity> "subtitle:<element[-¤<[moneyused].sub[1]>.99].bold.color[#FF2020]>" "title:" fade_in:0t fade_out:5t stay:10t