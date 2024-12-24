dlrrubberband:
  type: item
  material: gray_concrete
  display name: <element[ゴ ゴ DIALUP REQUIEM : RUBBERBAND ゴ ゴ].color[#C0C0C0]>
  lore:
  - <element[Marks a waypoint for return in 6 seconds,].color[#808080]>
  - <element[then undoes it another 6 seconds later].color[#808080]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

dlrbadmodem:
  type: item
  material: gray_concrete
  display name: <element[ゴ ゴ DIALUP REQUIEM : BAD MODEM ゴ ゴ].color[#C0C0C0]>
  lore:
  - <element[Makes the user near impossible to hit].color[#808080]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

dlrtimeout:
  type: item
  material: gray_concrete
  display name: <element[ゴ ゴ DIALUP REQUIEM : TIMEOUT ゴ ゴ].color[#C0C0C0]>
  lore:
  - <element[Disconnects the user from reality for 10 seconds].color[#808080]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

dlrfreezeframe:
  type: item
  material: gray_concrete
  display name: <element[ゴ ゴ DIALUP REQUIEM : FREEZEFRAME ゴ ゴ].color[#C0C0C0]>
  lore:
  - <element[Locks the target's hitbox and model].color[#808080]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

dlrlagspike:
  type: item
  material: gray_concrete
  display name: <element[ゴ ゴ DIALUP REQUIEM : LAGSPIKE ゴ ゴ].color[#C0C0C0]>
  lore:
  - <element[].color[#808080]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

dlrpunch:
  type: item
  material: gray_concrete
  display name: <element[ゴ ゴ DIALUP REQUIEM : PUNCH ゴ ゴ].color[#C0C0C0]>
  lore:
  - <element[Punches].color[#808080]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

dlrbarrage:
  type: item
  material: gray_concrete
  display name: <element[ゴ ゴ DIALUP REQUIEM : BARRAGE ゴ ゴ].color[#C0C0C0]>
  lore:
  - <element[Barrages].color[#808080]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

dlrcommand:
  debug: false
  type: world
  events:
    on player left clicks block with:dlrbadmodem:
    - if <player> == <server.match_player[IceTheo]> && !<player.has_flag[dlrcooldown]>:
      - determine cancelled passively
      - run dialuprequiembadmodem
    on player left clicks block with:dlrrubberband:
    - if <player> == <server.match_player[IceTheo]> && !<player.has_flag[dlrcooldown]>:
      - determine cancelled passively
      - run dialuprequiemrubberband
    on player left clicks block with:dlrtimeout:
    - if <player> == <server.match_player[IceTheo]> && !<player.has_flag[dlrcooldown]>:
      - determine cancelled passively
      - run dialuprequiemtimeout
    on player left clicks block with:dlrfreezeframe:
    - if <player> == <server.match_player[IceTheo]> && !<player.has_flag[dlrcooldown]>:
      - determine cancelled passively
      - run dialuprequiemfreezeframe
    on player left clicks block with:dlrlagspike:
    - if <player> == <server.match_player[IceTheo]> && !<player.has_flag[dlrcooldown]>:
      - determine cancelled passively
      - run dialuprequiemlagspike
    on player damages entity:
    - if <context.damager.item_in_hand.script||0> == <script[dlrpunch]> && <context.damager> == <server.match_player[IceTheo]> && !<player.has_flag[dlrcooldown]>:
      - flag <context.damager> dlrcooldown expire:3s
      - itemcooldown gray_concrete duration:3s
      - determine cancelled passively
      - hurt <context.entity> 8 source:<context.damager>
      - define lookvec <context.damager.eye_location.direction.vector>
      - playeffect effect:crit_magic quantity:25 at:<context.damager.eye_location> offset:0.6 velocity:<[lookvec].mul[3]>
    - else if <context.damager.item_in_hand.script||0> == <script[dlrbarrage]> && <context.damager> == <server.match_player[IceTheo]> && !<player.has_flag[dlrcooldown]>:
      - flag <context.damager> dlrcooldown expire:5s
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
    - attach <server.match_player[IceTheo]> to:<context.entity>
    - wait 17t
    - attach <server.match_player[IceTheo]> cancel
    - remove <context.entity>

dialuprequiemfreezeframelag:
  debug: false
  type: task
  definitions: laggypoint|lagtarget
  script:
  - attach <[lagtarget]> to:<[laggypoint]>
  - wait 120t
  - attach <[lagtarget]> cancel
  - remove <[laggypoint]>

lagpoint2:
  type: entity
  entity_type: armor_stand
  mechanisms:
    gravity: false
    visible: false
    marker: true

lagpoint3:
  type: entity
  entity_type: armor_stand
  mechanisms:
    gravity: false
    visible: false
    marker: true

dialuprequiemrubberband:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[IceTheo]>
  - flag <[standuser]> dlrcooldown expire:14s
  - itemcooldown gray_concrete duration:14s
  #- playsound <[standuser].location> sound:custom.dialuprequiem_stand_summon pitch:0 volume:4 custom
  - playsound <[standuser].location> sound:block_stone_button_click_on pitch:0 volume:4
  - define loc1 <[standuser].location>
  - wait 12s
  - playsound <[standuser].location> sound:custom.dialup_rubberband pitch:0 volume:4 custom
  #- playeffect effect:smoke at:<[loc1].points_between[<[standuser].location>].distance[3]> offset:0 quantity:1
  - define loc2 <[standuser].location>
  - teleport <[standuser]> <[loc1]>
  - wait 12s
  #- playeffect effect:smoke at:<[loc2].points_between[<[standuser].location>].distance[3]> offset:0 quantity:1
  - teleport <[standuser]> <[loc2]>

dialuprequiembadmodem:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[IceTheo]>
  - flag <[standuser]> dlrcooldown expire:14s
  - itemcooldown gray_concrete duration:14s
  - playsound <[standuser].location> sound:custom.dialup_badmodem pitch:0 volume:4 custom
  - repeat 20:
    - spawn lagpoint2 <[standuser].location.random_offset[2]>
    - wait 1s
  - attach <[standuser]> cancel
  - playsound <[standuser].location> sound:block_stone_button_click_off pitch:0 volume:4

dialuprequiemtimeout:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[IceTheo]>
  - flag <[standuser]> dlrcooldown expire:25s
  - itemcooldown gray_concrete duration:25s
  - define gm <player.gamemode>
  - adjust <player> gamemode:spectator
  - announce <element[IceTheo left the game].color_gradient[from=#FFC000;to=#FFFF80]>
  - playsound <[standuser].location> sound:custom.dialup_timeout pitch:0 volume:10 custom
  - flag <[standuser]> drtimedout expire:9.9s
  - wait 2s
  - define loc3 <[standuser].location>
  - wait 18s
  - announce <element[IceTheo joined the game].color_gradient[from=#FFC000;to=#FFFF80]>
  - adjust <player> gamemode:<[gm]>
  - cast <player> invisibility duration:1t amplifier:0 no_icon hide_particles no_ambient
  - teleport <[standuser]> <[loc3]>

dialuprequiemfreezeframe:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[IceTheo]>
  - define demtarget <[standuser].precise_target[6]||0>
  - if <[demtarget]> != 0:
    - flag <[standuser]> dlrcooldown expire:14s
    - itemcooldown gray_concrete duration:14s
    - playsound <[standuser].location> sound:custom.dialuprequiem_lagspike pitch:1 volume:4 custom
    - spawn lagpoint3 <[demtarget].location> save:dlrsv
    - define laggy <entry[dlrsv].spawned_entity>
    - run dialuprequiemfreezeframelag def:<[laggy]>|<[demtarget]>
    - attach <[standuser]> cancel
    - playsound <[standuser].location> sound:block_stone_button_click_off pitch:0 volume:4
  - else: 
    - playsound <[standuser].location> sound:block_note_block_bass pitch:0 volume:4

dialuprequiemlagspikescript:
  debug: false
  type: task
  definitions: affected
  script:
  - flag <[affected]> dialloc:<[affected].location>
  - wait 1.5s
  - teleport <[affected]> <[affected].flag[dialloc]>
  - flag <[affected]> dialloc:!

dialuprequiemlagspike:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[IceTheo]>
  - flag <[standuser]> dlrcooldown expire:5s
  - itemcooldown gray_concrete duration:5s
  - foreach <[standuser].location.find_entities.within[100].exclude[<[standuser]>]>:
    - run dialuprequiemlagspikescript def:<[value]>
  - wait 1.5s
  - playsound <[standuser].location> sound:custom.dialuprequiem_freezeframe pitch:1 volume:4 custom