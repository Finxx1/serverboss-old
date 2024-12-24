eotrswap:
  type: item
  material: black_concrete
  display name: <element[ゴ ゴ END OF TIME REQUIEM : LIBET'S DELAY ゴ ゴ].color[#606060]>
  lore:
  - <element[Swaps the user with the target entirely].color[#404040]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

eotrblink:
  type: item
  material: black_concrete
  display name: <element[ゴ ゴ END OF TIME REQUIEM : BLINK ゴ ゴ].color[#606060]>
  lore:
  - <element[Teleports the user forwards by a few meters].color[#404040]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

eotrdementia:
  type: item
  material: black_concrete
  display name: <element[ゴ ゴ END OF TIME REQUIEM : DEMENTIA ゴ ゴ].color[#606060]>
  lore:
  - <element[Locks higher brain functions away from the target for a short period].color[#404040]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

eotrtemporaryblissstate:
  type: item
  material: black_concrete
  display name: <element[ゴ ゴ END OF TIME REQUIEM : TEMPORARY BLISS STATE ゴ ゴ].color[#606060]>
  lore:
  - <element[Keeps the user in a deathloop].color[#404040]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

eotrterminallucidity:
  type: item
  material: black_concrete
  display name: <element[ゴ ゴ END OF TIME REQUIEM : TERMINAL LUCIDITY ゴ ゴ].color[#606060]>
  lore:
  - <element[Reveals what has to be].color[#404040]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

eotrpunch:
  type: item
  material: black_concrete
  display name: <element[ゴ ゴ END OF TIME REQUIEM : PUNCH ゴ ゴ].color[#606060]>
  lore:
  - <element[Punch].color[#404040]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

eotrbarrage:
  type: item
  material: black_concrete
  display name: <element[ゴ ゴ END OF TIME REQUIEM : BARRAGE ゴ ゴ].color[#606060]>
  lore:
  - <element[Barrages].color[#404040]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

eotrcommand:
  debug: false
  type: world
  events:
    on player left clicks block with:eotrswap:
    - if <player> == <server.match_player[rika55]> && !<player.has_flag[eotrcooldown]> && !<player.has_flag[loopstate]>:
      - determine cancelled passively
      - run endoftimerequiemswap
    on player left clicks block with:eotrblink:
    - if <player> == <server.match_player[rika55]> && !<player.has_flag[eotrcooldown]> && !<player.has_flag[loopstate]>:
      - determine cancelled passively
      - run endoftimerequiemblink
    on player left clicks block with:eotrdementia:
    - if <player> == <server.match_player[rika55]> && !<player.has_flag[eotrcooldown]> && !<player.has_flag[loopstate]>:
      - determine cancelled passively
      - run endoftimerequiemdementia
    on player left clicks block with:eotrtemporaryblissstate:
    - if <player> == <server.match_player[rika55]> && !<player.has_flag[eotrcooldown]> && !<player.has_flag[loopstate]>:
      - determine cancelled passively
      - run endoftimerequiemtemporaryblissstate
    on player left clicks block with:eotrterminallucidity:
    - if <player> == <server.match_player[rika55]> && !<player.has_flag[eotrcooldown]> && !<player.has_flag[loopstate]>:
      - determine cancelled passively
      - run endoftimerequiemterminallucidity
    on player right clicks block with:eotrtemporaryblissstate:
    - if <player> == <server.match_player[rika55]> && !<player.has_flag[eotrcooldown]> && <player.has_flag[loopstate]>:
      - determine cancelled passively
      - run endoftimerequiemtemporaryblissstateremove
    on player dies:
    - if <player.has_flag[loopstate]>:
      - determine passively cancelled
      - announce <element[The events leading up to rika55's death have been eradicated]>
      - define standuser <server.match_player[rika55]||0>
      - wait 1t
      - teleport <[standuser]> <location[0,67,0,deathplane]>
      - cast <[standuser]> blindness duration:5s amplifier:0
      - wait 5s
      - teleport <[standuser]> <[standuser].flag[looploc]>
      - adjust <[standuser]> velocity:<[standuser].flag[loopvel]>
      - adjust <[standuser]> health:<[standuser].flag[loophealth]>
      - adjust <[standuser]> inventory:<[standuser].flag[loopinv]>
      - adjust <[standuser]> equipment:<[standuser].flag[loopequip]>
      - adjust <[standuser]> gamemode:<[standuser].flag[loopgm]>
    on player damages entity:
    - if <context.damager.item_in_hand.script||0> == <script[eotrpunch]> && <context.damager> == <server.match_player[rika55]> && !<player.has_flag[eotrcooldown]>:
      - flag <context.damager> eotrcooldown expire:3s
      - itemcooldown gray_concrete duration:3s
      - determine cancelled passively
      - hurt <context.entity> 8 source:<context.damager>
      - define lookvec <context.damager.eye_location.direction.vector>
      - playeffect effect:crit_magic quantity:25 at:<context.damager.eye_location> offset:0.6 velocity:<[lookvec].mul[3]>
    - else if <context.damager.item_in_hand.script||0> == <script[eotrbarrage]> && <context.damager> == <server.match_player[rika55]> && !<player.has_flag[eotrcooldown]>:
      - flag <context.damager> eotrcooldown expire:5s
      - itemcooldown gray_concrete duration:5s
      - determine cancelled passively
      - define lookvec <context.damager.eye_location.direction.vector>
      - adjust <context.entity> max_no_damage_duration:1t
      - repeat 77:
        - cast <context.damager> slow duration:2t amplifier:4 no_icon no_ambient hide_particles
        - cast <context.entity> slow duration:2t amplifier:8 no_icon no_ambient hide_particles
        - hurt <context.entity> 0.15
        - playeffect effect:crit_magic quantity:2 at:<context.damager.eye_location> offset:1 velocity:<[lookvec].mul[3]>
        - wait 1t
      - hurt <context.entity> 1 source:<context.damager>
      - wait 1t
      - hurt <context.entity> 1 source:<context.damager>
      - wait 1t
      - hurt <context.entity> 1 source:<context.damager>
      - adjust <context.entity> max_no_damage_duration:20t
    on lagpoint2 spawns:
    - attach <server.match_player[rika55]> to:<context.entity>
    - wait 17t
    - attach <server.match_player[rika55]> cancel
    - remove <context.entity>
    on player damaged by suffocation:
    - if <player.has_flag[tluc]>:
      - determine cancelled passively

endoftimerequiemswap:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[rika55]>
  - define demtarget <[standuser].precise_target[100]||0>
  - if <[demtarget]> != 0:
    - flag <[standuser]> eotrcooldown expire:10s
    - itemcooldown black_concrete duration:10s
    - playsound <[standuser].location> sound:custom.endoftime_swap pitch:0 volume:1 custom
    - wait 4s
    - define demtargetarmor <[demtarget].equipment>
    - define standuserarmor <[standuser].equipment>
    - cast <[demtarget]> invisibility duration:6t amplifier:0 no_ambient hide_particles no_icon
    - cast <[standuser]> invisibility duration:6t amplifier:0 no_ambient hide_particles no_icon
    - define blinkloc <[demtarget].location>
    - cast <[standuser]> blindness duration:20t amplifier:0 no_ambient hide_particles no_icon
    - cast <[demtarget]> blindness duration:40t amplifier:0 no_ambient hide_particles no_icon
    - playeffect effect:large_smoke at:<[standuser].location> offset:0.75 quantity:60
    - playeffect effect:large_smoke at:<[blinkloc]> offset:0.75 quantity:60
    - adjust <[standuser]> equipment:<[demtargetarmor]>
    - adjust <[demtarget]> equipment:<[standuserarmor]>
    - if <[demtarget].is_player>:
      - define demname <[demtarget].display_name>
      - define demskin <[detmarget].skin_blob>
      #- inventory swap o:<[demtarget].inventory>
      - adjust <[demtarget]> display_name:<[standuser].display_name>
      - adjust <[standuser]> display_name:<[demname]>
      - adjust <[demtarget]> skin_blob:<[standuser].skin_blob>
      - adjust <[standuser]> skin_blob:<[demskin]>
    - teleport <[demtarget]> <[standuser].location>
    - teleport <[standuser]> <[blinkloc]>


endoftimerequiemblink:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[rika55]>
  - cast <[standuser]> invisibility duration:6t amplifier:0 no_ambient hide_particles no_icon
  - define blinkloc <[standuser].eye_location.forward[13].sub[0,0.75,0]>
  - playeffect effect:large_smoke at:<[standuser].location> offset:0.75 quantity:60
  - cast <[standuser]> blindness duration:20t amplifier:0 no_ambient hide_particles no_icon
  - teleport <[standuser]> <[blinkloc]>
  - playsound <[standuser].location> sound:custom.endoftime_blink pitch:0 volume:1 custom
  - playeffect effect:large_smoke at:<[blinkloc]> offset:0.75 quantity:60
  - flag <[standuser]> eotrcooldown expire:3s
  - itemcooldown black_concrete duration:3s

endoftimerequiemdementia:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[rika55]>
  - define demtarget <[standuser].precise_target[11]||0>
  - if <[demtarget]> != 0:
    - playsound <[demtarget].eye_location> sound:custom.endoftime_dementia pitch:0 volume:1 custom
    - playeffect effect:large_smoke at:<[demtarget].eye_location> offset:1 quantity:160
    - cast <[demtarget]> blindness duration:10s amplifier:0 no_ambient hide_particles no_icon
    - cast <[demtarget]> confusion duration:10s amplifier:0 no_ambient hide_particles no_icon
    - cast <[demtarget]> slow duration:10s amplifier:2 no_ambient hide_particles no_icon
    - cast <[demtarget]> slow_digging duration:10s amplifier:2 no_ambient hide_particles no_icon
    - cast <[demtarget]> weakness duration:10s amplifier:2 no_ambient hide_particles no_icon
    - flag <[standuser]> eotrcooldown expire:12s
    - itemcooldown black_concrete duration:12s

endoftimerequiemtemporaryblissstate:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[rika55]>
  - playsound <[standuser.location]> sound:custom.endoftimerequiem_temporaryblissstate pitch:0 volume:1 custom
  #- playsound sound:custom.endoftime_blink pitch:0 volume:1 custom
  - flag <[standuser]> eotrcooldown expire:25s
  - itemcooldown black_concrete duration:25s
  - flag <[standuser]> loopstate
  - flag <[standuser]> looploc:<[standuser].location>
  - flag <[standuser]> loophealth:<[standuser].health>
  - flag <[standuser]> loopequip:<[standuser].equipment_map>
  - flag <[standuser]> loopvel:<[standuser].velocity>
  - flag <[standuser]> loopinv:<[standuser].inventory>
  - flag <[standuser]> loopgm:<[standuser].gamemode>
  #- flag <[standuser]> loopflags:<[standuser].flag_map>

endoftimerequiemtemporaryblissstateremove:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[rika55]>
  - flag <[standuser]> eotrcooldown expire:5s
  - itemcooldown black_concrete duration:5s
  - wait 5s
  - flag <[standuser]> loopstate:!
  - flag <[standuser]> looploc:!
  - flag <[standuser]> loophealth:!
  - flag <[standuser]> loopequip:!
  - flag <[standuser]> loopvel:!
  - flag <[standuser]> loopinv:!
  - flag <[standuser]> loopgm:!

endoftimerequiemterminallucidity:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[rika55]>
  - flag <[standuser]> eotrcooldown expire:15s
  - itemcooldown black_concrete duration:15s
  - flag <[standuser]> tluc
  - adjust <[standuser]> noclip:true
  #- adjust <[standuser]> visible:false
  #- fakeequip <[standuser]> head:air chest:air legs:air boots:air offhand:air hand:air for:<server.online_players.exclude[<[standuser]>]>
  - repeat 100:
    - playeffect effect:large_smoke at:<[standuser].eye_location> offset:1 quantity:8
    - foreach <[standuser].eye_location.add[0,1,0].find_blocks.within[3]>:
      - showfake air <[value]> players:<[standuser]> duration:5t
      #- if [value].material
      #- playeffect effect:large_smoke at:<[value]> offset:0.3 quantity:6
    - wait 2t
  #- fakeequip <[standuser]> reset for:<server.online_players.exclude[<[standuser]>]>
  - adjust <[standuser]> noclip:false
  #- adjust <[standuser]> visible:true
  - flag <[standuser]> tluc:!