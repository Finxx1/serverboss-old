h2hubercharge:
  type: item
  material: red_concrete
  display name: <element[ゴ ゴ Heart to Heart : Übercharge ゴ ゴ].color[#FF0000]>
  lore:
  - <element[Turns people into Gods].color[#800000]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

h2hleap:
  type: item
  material: red_concrete
  display name: <element[ゴ ゴ Heart to Heart : Leap ゴ ゴ].color[#FF0000]>
  lore:
  - <element[Allows the user to leap into the air].color[#800000]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>


h2hpunch:
  type: item
  material: red_concrete
  display name: <element[ゴ ゴ Heart to Heart : Punch ゴ ゴ].color[#FF0000]>
  lore:
  - <element[Punch].color[#800000]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>


h2hbarrage:
  type: item
  material: red_concrete
  display name: <element[ゴ ゴ Heart to Heart : Barrage ゴ ゴ].color[#FF0000]>
  lore:
  - <element[Barrages].color[#800000]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>


h2hcommand:
  debug: false
  type: world
  events:
    on player chats:
    - if <player> == <server.match_player[AGooseWithAPhone]||0>:
      - if <context.message> == "HEART TO HEART":
        - playsound <player.location> sound:custom.h2h_stand_summon pitch:1 volume:4 custom
        - give <player> h2hubercharge
        - give <player> h2hleap
        - give <player> h2hpunch
        - give <player> h2hbarrage
      - if <context.message> == "HEART TO HEART UBERCHARGE" || <context.message> == "H2HU":
        - run hearttoheartubercharge
        - determine cancelled passively
    on player left clicks block with:h2hubercharge:
    - if <player> == <server.match_player[AGooseWithAPhone]> && !<player.has_flag[h2hcooldown]>:
      - run hearttoheartubercharge
      - determine cancelled passively
    on player left clicks block with:h2hleap:
    - if <player> == <server.match_player[AGooseWithAPhone]> && !<player.has_flag[h2hcooldown]>:
      - run hearttoheartleap
      - determine cancelled passively
    on delta time secondly every:1:
    - define standuser <server.match_player[AGooseWithAPhone]||0>
    - if <[standuser]> != 0:
      - if !<[standuser].has_flag[h2hrcooldown]||false>:
        - if <[standuser].flag[h2hcooldown2]> < 97.5:
          - flag <[standuser]> h2hcooldown2:<[standuser].flag[h2hcooldown2].add[2.5]>
          - title "title:" "subtitle:<element[<[standuser].flag[h2hcooldown2].round_up>%].color[#FF0000].bold>" fade_in:0 stay:2s targets:<[standuser]>
        - else if <[standuser].flag[h2hcooldown2]> < 100:
          - flag <[standuser]> h2hcooldown2:100
          - title "title:" "subtitle:<element[100%].color[#FF0000].bold>" fade_in:0 stay:2s targets:<[standuser]>
    on player damages entity:
    - if <context.damager.item_in_hand.script||0> == <script[h2hpunch]> && <context.damager> == <server.match_player[AGooseWithAPhone]||0> && !<player.has_flag[h2hcooldown]>:
      - flag <context.damager> h2hcooldown expire:6s
      - itemcooldown red_concrete duration:6s
      - determine cancelled passively
      - hurt <context.entity> 10 source:<context.damager>
      - define lookvec <context.damager.eye_location.direction.vector>
      - playeffect effect:crit_magic quantity:25 at:<context.damager.eye_location> offset:0.6 velocity:<[lookvec].mul[3]>
    - else if <context.damager.item_in_hand.script||0> == <script[h2hbarrage]> && <context.damager> == <server.match_player[AGooseWithAPhone]> && !<player.has_flag[h2hcooldown]>:
      - flag <context.damager> h2hcooldown expire:8s
      - itemcooldown red_concrete duration:8s
      - determine cancelled passively
      - define lookvec <context.damager.eye_location.direction.vector>
      - adjust <context.entity> max_no_damage_duration:1t
      - repeat 30:
        - cast <context.damager> slow duration:2t amplifier:4 no_icon no_ambient hide_particles
        - cast <context.entity> slow duration:2t amplifier:5 no_icon no_ambient hide_particles
        - hurt <context.entity> 0.3
        - playeffect effect:crit_magic quantity:2 at:<context.damager.eye_location> offset:1 velocity:<[lookvec].mul[3]>
        - wait 3t
      - hurt <context.entity> 2 source:<context.damager>
      - wait 1t
      - hurt <context.entity> 2 source:<context.damager>
      - wait 1t
      - hurt <context.entity> 2 source:<context.damager>
      - adjust <context.entity> max_no_damage_duration:20t

hearttoheartubercharge:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[AGooseWithAPhone]>
  - if <[standuser].flag[h2hcooldown2]> == 100:
    - flag <[standuser]> h2hcooldown expire:12s
    - itemcooldown red_concrete duration:12s
    - playsound <[standuser].location> sound:custom.h2h_ubercharge pitch:1 volume:10 custom
    #- adjust <[standuser]> invincible:true
    - foreach <list[absorption|blindness|confusion|damage_resistance|fast_digging|fire_resistance|health_boost|hunger|increase_damage|invisibility|jump|levitation|luck|night_vision|poison|regeneration|saturation|slow|slow_digging|slow_falling|speed|unluck|water_breathing|weakness|wither]>:
      - cast <[standuser]> <[value]> remove
    - cast <[standuser]> increase_damage duration:8s amplifier:127 no_ambient hide_particles no_icon
    - cast <[standuser]> glowing duration:8s amplifier:1 no_ambient hide_particles no_icon
    - cast <[standuser]> speed duration:8s amplifier:0 no_ambient hide_particles no_icon
    - cast <[standuser]> regeneration duration:8s amplifier:1 no_ambient hide_particles no_icon
    - repeat 160:
      - playeffect effect:redstone special_data:0.9|<color[#FF0000]> quantity:7 at:<[standuser].location.add[0,0.75,0]> offset:0.4,0.6,0.4
      - adjust <[standuser]> invulnerable:true
      - flag <[standuser]> h2hcooldown2:<[standuser].flag[h2hcooldown2].sub[0.625]>
      - title "title:<element[<[standuser].flag[h2hcooldown2].round_up>%].color[#FF0000].bold>" "subtitle:" fade_in:0 stay:2s targets:<[standuser]>
      - wait 1t
    - adjust <[standuser]> invulnerable:false
  - else:
    - title "title:" "subtitle:<element[<[standuser].flag[h2hcooldown2].round_up>%].color[#FF0000].bold>" fade_in:0 stay:2s targets:<[standuser]>

hearttoheartleap:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[AGooseWithAPhone]>
  - flag <[standuser]> h2hcooldown expire:6s
  - itemcooldown red_concrete duration:6s
  - playsound <[standuser].location> sound:custom.h2h_leap pitch:1 volume:10 custom
  - define lookvec <[standuser].eye_location.direction.vector.mul[3]>
  - adjust <[standuser]> velocity:<[lookvec]>