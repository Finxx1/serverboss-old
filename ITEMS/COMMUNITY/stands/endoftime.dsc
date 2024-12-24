eotswap:
  type: item
  material: black_concrete
  display name: <element[ゴ ゴ End of Time : Swap ゴ ゴ].color[#606060]>
  lore:
  - <element[Swap's the user's position with the target].color[#404040]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

eotblink:
  type: item
  material: black_concrete
  display name: <element[ゴ ゴ End of Time : Blink ゴ ゴ].color[#606060]>
  lore:
  - <element[Teleports the user forwards by a few meters].color[#404040]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

eotdementia:
  type: item
  material: black_concrete
  display name: <element[ゴ ゴ End of Time : Dementia ゴ ゴ].color[#606060]>
  lore:
  - <element[Locks higher brain functions away from the target for a short period].color[#404040]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

eotpunch:
  type: item
  material: black_concrete
  display name: <element[ゴ ゴ End of Time : Punch ゴ ゴ].color[#606060]>
  lore:
  - <element[Punch].color[#404040]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>


eotbarrage:
  type: item
  material: black_concrete
  display name: <element[ゴ ゴ End of Time : Barrage ゴ ゴ].color[#606060]>
  lore:
  - <element[Barrages].color[#404040]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

eotcommand:
  debug: false
  type: world
  events:
    on player chats:
    - if <player> == <server.match_player[rika55]||0>:
      - if <context.message> == "END OF TIME BLINK" || <context.message> == "ETB":
        - run endoftimeblink
        - determine cancelled passively
      - if <context.message> == "END OF TIME SWAP" || <context.message> == "ETS":
        - run endoftimeswap
        - determine cancelled passively
      - if <context.message> == "END OF TIME DEMENTIA" || <context.message> == "ETD":
        - run endoftimedementia
        - determine cancelled passively
      - if <context.message> == "END OF TIME":
        - playsound <player.location> sound:custom.endoftime_stand_summon pitch:1 volume:4 custom
        - give <player> eotblink|eotswap|eotdementia|eotpunch|eotbarrage
    on player left clicks block with:eotswap:
    - if <player> == <server.match_player[rika55]> && !<player.has_flag[eotcooldown]>:
      - run endoftimeswap
      - determine cancelled passively
    on player left clicks block with:eotblink:
    - if <player> == <server.match_player[rika55]> && !<player.has_flag[eotcooldown]>:
      - run endoftimeblink
      - determine cancelled passively
    on player left clicks block with:eotdementia:
    - if <player> == <server.match_player[rika55]> && !<player.has_flag[eotcooldown]>:
      - run endoftimedementia
      - determine cancelled passively
    on player damages entity:
    - if <context.damager.item_in_hand.script||0> == <script[eotpunch]> && <context.damager> == <server.match_player[rika55]||0> && !<player.has_flag[eotcooldown]>:
      - flag <context.damager> eotcooldown expire:4s
      - itemcooldown gray_concrete duration:4s
      - determine cancelled passively
      - hurt <context.entity> 5 source:<context.damager>
      - define lookvec <context.damager.eye_location.direction.vector>
      - playeffect effect:crit_magic quantity:25 at:<context.damager.eye_location> offset:0.6 velocity:<[lookvec].mul[3]>
    - else if <context.damager.item_in_hand.script||0> == <script[eotbarrage]> && <context.damager> == <server.match_player[rika55]> && !<player.has_flag[eotcooldown]>:
      - flag <context.damager> eotcooldown expire:6s
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

endoftimeswap:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[rika55]>
  - define demtarget <[standuser].precise_target[11]||0>
  - if <[demtarget]> != 0:
    - flag <[standuser]> eotcooldown expire:5s
    - itemcooldown black_concrete duration:5s
    - playsound <[standuser].location> sound:custom.endoftime_swap pitch:1 volume:1 custom
    - wait 2s
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
    - teleport <[demtarget]> <[standuser].location>
    - teleport <[standuser]> <[blinkloc]>


endoftimeblink:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[rika55]>
  - cast <[standuser]> invisibility duration:6t amplifier:0 no_ambient hide_particles no_icon
  - define blinkloc <[standuser].eye_location.forward[7].sub[0,0.75,0]>
  - playeffect effect:large_smoke at:<[standuser].location> offset:0.75 quantity:60
  - cast <[standuser]> blindness duration:20t amplifier:0 no_ambient hide_particles no_icon
  - teleport <[standuser]> <[blinkloc]>
  - playsound <[standuser].location> sound:custom.endoftime_blink pitch:0 volume:1 custom
  - playeffect effect:large_smoke at:<[blinkloc]> offset:0.75 quantity:60
  - flag <[standuser]> eotcooldown expire:3.5s
  - itemcooldown black_concrete duration:3.5s

endoftimedementia:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[rika55]>
  - define demtarget <[standuser].precise_target[11]||0>
  - if <[demtarget]> != 0:
    - playsound <[demtarget].eye_location> sound:custom.endoftime_dementia pitch:1 volume:1 custom
    - playeffect effect:large_smoke at:<[demtarget].eye_location> offset:0.75 quantity:120
    - cast <[demtarget]> blindness duration:10s amplifier:0 no_ambient hide_particles no_icon
    - cast <[demtarget]> confusion duration:10s amplifier:0 no_ambient hide_particles no_icon
    - cast <[demtarget]> slow duration:10s amplifier:2 no_ambient hide_particles no_icon
    - cast <[demtarget]> slow_digging duration:10s amplifier:2 no_ambient hide_particles no_icon
    - cast <[demtarget]> weakness duration:10s amplifier:2 no_ambient hide_particles no_icon
    - flag <[standuser]> eotcooldown expire:12s
    - itemcooldown black_concrete duration:12s