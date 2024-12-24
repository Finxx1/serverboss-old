treasures:
  debug: false
  type: world
  events:
    on player damaged by player:
    - if <context.damager.gamemode> == ADVENTURE:
      - determine cancelled passively
#    on player pushes player:
#    - determine cancelled passively
    on player dies:
    - flag <player> gennedchests:!
    on !player enters vkill_*:
    - kill <context.entity>
    on !player changes air level:
    - determine cancelled passively
    on player right clicks chest:
    - if <player.gamemode> == CREATIVE:
      - stop
    - define aimtarg <player.eye_location.ray_trace[range=10;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.5]>
    - if <[aimtarg].material.name> == chest && !<player.is_sneaking>:
      - choose <[aimtarg].sub[0,1,0].material.name>:
        - case GLOWSTONE:
          - if !<player.flag[gennedchests].contains_any[<[aimtarg].block>]||false>:
            - determine cancelled passively
            - flag <player> gennedchests:->:<[aimtarg].block>
            - animatechest <[aimtarg].block> open sound:true <server.online_players>
            - wait 1s
            - repeat <list[5|10|15].random>:
              - run dolarspawn def:1|0.35|<[aimtarg].block.add[0.5,1.2,0.5]>
              - wait 2t
            - wait 1s
            - animatechest <[aimtarg].block> close sound:true <server.online_players>
          - else:
            - title "title:" "subtitle:<element[Already opened!].color_gradient[from=#FFFF00;to=#FFFF80]>" stay:0t targets:<player> fade_in:0t fade_out:10t
            - determine cancelled passively
            - playsound sound:BLOCK_CHEST_LOCKED pitch:1 volume:1 at:<[aimtarg].block>
        - case OBSIDIAN:
  #        - announce !<player.flag[gennedchests].contains_any[<[aimtarg].block>]||false>
          - if !<player.flag[gennedchests].contains_any[<[aimtarg].block>]||false>:
            - determine cancelled passively
            - if <[aimtarg].block.inventory.list_contents.contains_any[*key]>:
              - foreach <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>]||0>:
                - flag <[value]> gennedchests:->:<[aimtarg].block>
            - else:
              - flag <player> gennedchests:->:<[aimtarg].block>
            - animatechest <[aimtarg].block> open sound:true <server.online_players>
            - wait 1s
            - foreach <[aimtarg].block.inventory.list_contents>:
              - drop <[value]> <[aimtarg].block.add[0.5,1.2,0.5]> speed:0.02
            - wait 1s
            - animatechest <[aimtarg].block> close sound:true <server.online_players>
          - else:
            - title "title:" "subtitle:<element[Already opened!].color_gradient[from=#FFFF00;to=#FFFF80]>" stay:0t targets:<player> fade_in:0t fade_out:10t
            - determine cancelled passively
            - playsound sound:BLOCK_CHEST_LOCKED pitch:1 volume:1 at:<[aimtarg].block>
        - case NETHER_WART_BLOCK:
          - define sacrifice <list[2|4|6].random>
          - if !<player.flag[gennedchests].contains_any[<[aimtarg].block>]||false> && <player.health> > <[sacrifice]>:
            - determine cancelled passively
            - flag <[aimtarg].block> generated
            - animatechest <[aimtarg].block> open sound:true <server.online_players>
            - wait 2t
            - hurt <player> <[sacrifice]>
            - adjust <player> max_health:<player.health_max.sub[<[sacrifice]>]>
            - run goreburstatloc def:<player.location.add[0,0.5,0]>
            - give to:<player.inventory> <list[hauntedgift|collectorsgift|collectorsgift|hauntedgift|collectorsgift|collectorsgift|hauntedgift|collectorsgift|collectorsgift|unusualgift|strangegift|strangegift].random> quantity:1
            - wait 1s
            - animatechest <[aimtarg].block> close sound:true <server.online_players>
          - else:
            - if <player.health> <= <[sacrifice]>:
              - title "title:" "subtitle:<element[YOU DONT HAVE ENOUGH BLOOD IN YOU].italicize.color_gradient[from=#FF0000;to=#800000]>" stay:5t targets:<player> fade_in:0t fade_out:15t
            - else:
              - title "title:" "subtitle:<element[Already opened!].color_gradient[from=#FF0000;to=#800000]>" stay:0t targets:<player> fade_in:0t fade_out:10t
            - determine cancelled passively
            - playsound sound:BLOCK_CHEST_LOCKED pitch:1 volume:1 at:<[aimtarg].block>
        - default:
          - flag <player> shopping:!
    - else:
      - determine cancelled passively

sacrificialrewards:
  debug: false
  type: task
  definitions: cultist
  script:
  - flag <[cultist]> itemgiven:voidednull
  - announce <[cultist].inventory.contains_item[<[cultist].flag[itemgiven]>].not>
  - announce <[cultist].flag[itemgiven].equals[voidednull].not>
  - while <[cultist].inventory.contains_item[<[cultist].flag[itemgiven]>]> || <[cultist].flag[itemgiven]> == voidednull:
    - flag <[cultist]> itemgiven:<list[haunted_gift|collectors_gift|collectors_gift|haunted_gift|collectors_gift|collectors_gift|haunted_gift|collectors_gift|collectors_gift|unusual_gift|strange_gift|strange_gift]>
    - if <[loop_index]> > 10:
      - title "title:" "subtitle:<element[YOUR GREED IS PUNISHED WITH DISAPPOINTMENT].italicize.bold.color_gradient[from=#FF0000;to=#800000]>" stay:10t targets:<[cultist]> fade_in:0t fade_out:3s
      - stop
  - give <[cultist].inventory> <[cultist].flag[itemgiven]>
  - cast <[cultist]> <list[speed|damage_resistance|fire_resistance|fast_digging|night_vision].random> duration:<list[30s|60s|120s|240s|480s|960s].random> amplifier:<list[0|1|2].random>