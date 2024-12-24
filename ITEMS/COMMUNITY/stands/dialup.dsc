dlrubberband:
  type: item
  material: gray_concrete
  display name: <element[ゴ ゴ Dialup : Rubberband ゴ ゴ].color[#C0C0C0]>
  lore:
  - <element[Marks a waypoint for return in 6 seconds,].color[#808080]>
  - <element[then undoes it another 6 seconds later].color[#808080]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

dlbadmodem:
  type: item
  material: gray_concrete
  display name: <element[ゴ ゴ Dialup : Bad Modem ゴ ゴ].color[#C0C0C0]>
  lore:
  - <element[Makes the user near impossible to hit].color[#808080]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

dltimeout:
  type: item
  material: gray_concrete
  display name: <element[ゴ ゴ Dialup : Timeout ゴ ゴ].color[#C0C0C0]>
  lore:
  - <element[Disconnects the user from reality for 10 seconds].color[#808080]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

dlpunch:
  type: item
  material: gray_concrete
  display name: <element[ゴ ゴ Dialup : Punch ゴ ゴ].color[#C0C0C0]>
  lore:
  - <element[Punches].color[#808080]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

dlbarrage:
  type: item
  material: gray_concrete
  display name: <element[ゴ ゴ Dialup : Barrage ゴ ゴ].color[#C0C0C0]>
  lore:
  - <element[Barrages].color[#808080]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

drcommand:
  debug: false
  type: world
  events:
    on player chats:
    - if <player> == <server.match_player[IceTheo]||0>:
      - if <context.message> == "DIALUP":
        - playsound <player.location> sound:custom.dialup_stand_summon pitch:1 volume:4 custom
        - give <player> dlbadmodem|dlrubberband|dltimeout|dlpunch|dlbarrage
      - if <context.message> == "DIALUP BAD MODEM" || <context.message> == "DBM":
        - run dialupbadmodem
        - determine cancelled passively
      - if <context.message> == "DIALUP TIMEOUT" || <context.message> == "DT":
        - run dialuptimeout
        - determine cancelled passively
    on player changes gamemode:
    - if <player.has_flag[drtimedout]>:
      - determine cancelled passively
    on player dies:
    - if <player.has_flag[drtimedout]>:
      - determine cancelled passively
    on lagpoint spawns:
    - attach <server.match_player[IceTheo]> to:<context.entity>
    - wait 15t
    - attach <server.match_player[IceTheo]> cancel
    - remove <context.entity>
    on player left clicks block with:dlbadmodem:
    - if <player> == <server.match_player[IceTheo]> && !<player.has_flag[dlcooldown]>:
      - run dialupbadmodem
      - determine cancelled passively
    on player left clicks block with:dlrubberband:
    - if <player> == <server.match_player[IceTheo]> && !<player.has_flag[dlcooldown]>:
      - run dialuprubberband
      - determine cancelled passively
    on player left clicks block with:dltimeout:
    - if <player> == <server.match_player[IceTheo]> && !<player.has_flag[dlcooldown]>:
      - run dialuptimeout
      - determine cancelled passively
    on player damages entity:
    - if <context.damager.item_in_hand.script||0> == <script[dlpunch]> && <context.damager> == <server.match_player[IceTheo]||0> && !<player.has_flag[dlcooldown]>:
      - flag <context.damager> dlcooldown expire:4s
      - itemcooldown gray_concrete duration:4s
      - determine cancelled passively
      - hurt <context.entity> 5 source:<context.damager>
      - define lookvec <context.damager.eye_location.direction.vector>
      - playeffect effect:crit_magic quantity:25 at:<context.damager.eye_location> offset:0.6 velocity:<[lookvec].mul[3]>
    - else if <context.damager.item_in_hand.script||0> == <script[dlbarrage]> && <context.damager> == <server.match_player[IceTheo]> && !<player.has_flag[dlcooldown]>:
      - flag <context.damager> dlcooldown expire:6s
      - itemcooldown gray_concrete duration:6s
      - determine cancelled passively
      - define lookvec <context.damager.eye_location.direction.vector>
      - adjust <context.entity> max_no_damage_duration:1t
      - repeat 47:
        - cast <context.damager> slow duration:2t amplifier:4 no_icon no_ambient hide_particles
        - cast <context.entity> slow duration:2t amplifier:5 no_icon no_ambient hide_particles
        - hurt <context.entity> 0.15
        - playeffect effect:crit_magic quantity:2 at:<context.damager.eye_location> offset:1 velocity:<[lookvec].mul[3]>
        - wait 1t
      - hurt <context.entity> 1 source:<context.damager>
      - wait 1t
      - hurt <context.entity> 1 source:<context.damager>
      - wait 1t
      - hurt <context.entity> 1 source:<context.damager>
      - adjust <context.entity> max_no_damage_duration:20t

lagpoint:
  type: entity
  entity_type: armor_stand
  mechanisms:
    gravity: false
    visible: false
    marker: true

dialuprubberband:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[IceTheo]>
  - flag <[standuser]> dlcooldown expire:16s
  - itemcooldown gray_concrete duration:16s
  #- playsound <[standuser].location> sound:custom.dialup_stand_summon pitch:1 volume:4 custom
  - playsound <[standuser].location> sound:block_stone_button_click_on pitch:0 volume:4
  - define loc1 <[standuser].location>
  - wait 6s
  - playsound <[standuser].location> sound:custom.dialup_rubberband pitch:1 volume:4 custom
  #- playeffect effect:smoke at:<[loc1].points_between[<[standuser].location>].distance[3]> offset:0 quantity:1
  - define loc2 <[standuser].location>
  - teleport <[standuser]> <[loc1]>
  - wait 6s
  #- playeffect effect:smoke at:<[loc2].points_between[<[standuser].location>].distance[3]> offset:0 quantity:1
  - teleport <[standuser]> <[loc2]>

dialupbadmodem:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[IceTheo]>
  - flag <[standuser]> dlcooldown expire:14s
  - itemcooldown gray_concrete duration:14s
  - playsound <[standuser].location> sound:custom.dialup_badmodem pitch:1 volume:4 custom
  - repeat 10:
    - spawn lagpoint
    - wait 1s
  - attach <[standuser]> cancel
  - playsound <[standuser].location> sound:block_stone_button_click_off pitch:0 volume:4

dialuptimeout:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[IceTheo]>
  - flag <[standuser]> dlcooldown expire:25s
  - itemcooldown gray_concrete duration:25s
  - define loc3 <[standuser].location>
  - define gm <player.gamemode>
  - adjust <player> gamemode:spectator
  - announce <element[IceTheo left the game].color_gradient[from=#FFC000;to=#FFFF80]>
  - playsound <[standuser].location> sound:custom.dialup_timeout pitch:1 volume:10 custom
  - flag <[standuser]> drtimedout expire:9.9s
  - wait 10s
  - announce <element[IceTheo joined the game].color_gradient[from=#FFC000;to=#FFFF80]>
  - define loc2 <[standuser].location>
  - adjust <player> gamemode:<[gm]>
  - cast <player> invisibility duration:1t amplifier:0 no_icon hide_particles no_ambient
  - teleport <[standuser]> <[loc3]>