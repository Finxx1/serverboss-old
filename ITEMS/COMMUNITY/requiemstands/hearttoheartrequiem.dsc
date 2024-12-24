h2hrubercharge:
  type: item
  material: red_concrete
  display name: <element[ゴ ゴ HEART TO HEART REQUIEM : ÜBERCHARGE ゴ ゴ].color[#FF0000]>
  lore:
  - <element[Turns people into Gods].color[#800000]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

h2hrleap:
  type: item
  material: red_concrete
  display name: <element[ゴ ゴ HEART TO HEART REQUIEM : LEAP ゴ ゴ].color[#FF0000]>
  lore:
  - <element[Allows the user to leap into the air].color[#800000]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

h2hrqf:
  type: item
  material: red_concrete
  display name: <element[ゴ ゴ HEART TO HEART REQUIEM : QUICKFIX ゴ ゴ].color[#FF0000]>
  lore:
  - <element[Seeps health away from the target and into the user].color[#800000]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

h2hrpunch:
  type: item
  material: red_concrete
  display name: <element[ゴ ゴ HEART TO HEART REQUIEM : PUNCH ゴ ゴ].color[#FF0000]>
  lore:
  - <element[Punch].color[#800000]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

h2hrbarrage:
  type: item
  material: red_concrete
  display name: <element[ゴ ゴ HEART TO HEART REQUIEM : BARRAGE ゴ ゴ].color[#FF0000]>
  lore:
  - <element[Barrages].color[#800000]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

h2hrcommand:
  debug: false
  type: world
  events:
    on player left clicks block with:h2hrubercharge:
    - if <player> == <server.match_player[AGooseWithAPhone]> && !<player.has_flag[h2hcooldown]>:
      - determine cancelled passively
      - run hearttoheartrequiemubercharge
    on player left clicks block with:h2hrleap:
    - if <player> == <server.match_player[AGooseWithAPhone]> && !<player.has_flag[h2hcooldown]>:
      - determine cancelled passively
      - run hearttoheartrequiemleap
    on player left clicks block with:h2hrqf:
    - if <player> == <server.match_player[AGooseWithAPhone]> && !<player.has_flag[h2hcooldown]>:
      - determine cancelled passively
      - run hearttoheartrequiemquickfix
    on player damaged:
    - if <context.cause> == fall && <context.entity.has_flag[nofalldmg]>:
      - determine cancelled passively
    on delta time secondly every:1:
    - define standuser <server.match_player[AGooseWithAPhone]||0>
    - if <[standuser]> != 0:
      - if !<[standuser].has_flag[h2hrcooldown]||false>:
        - if <[standuser].flag[h2hrcooldown2]> < 97.5:
          - flag <[standuser]> h2hrcooldown2:<[standuser].flag[h2hrcooldown2].add[2.5]>
          - title "title:" "subtitle:<element[<[standuser].flag[h2hrcooldown2].round_up>%].color[#FF0000].bold>" fade_in:0 stay:2s targets:<[standuser]>
        - else if <[standuser].flag[h2hrcooldown2]> < 100:
          - flag <[standuser]> h2hrcooldown2:100
          - title "title:" "subtitle:<element[100%].color[#FF0000].bold>" fade_in:0 stay:2s targets:<[standuser]>
    on player damages entity:
    - if <context.damager.item_in_hand.script||0> == <script[h2hrpunch]> && <context.damager> == <server.match_player[AGooseWithAPhone]> && !<player.has_flag[h2hrcooldown]>:
      - flag <context.damager> h2hrcooldown expire:5s
      - itemcooldown red_concrete duration:5s
      - determine cancelled passively
      - hurt <context.entity> 15 source:<context.damager>
      - define lookvec <context.damager.eye_location.direction.vector>
      - playeffect effect:crit_magic quantity:25 at:<context.damager.eye_location> offset:0.6 velocity:<[lookvec].mul[3]>
    - else if <context.damager.item_in_hand.script||0> == <script[h2hrbarrage]> && <context.damager> == <server.match_player[AGooseWithAPhone]> && !<player.has_flag[h2hrcooldown]>:
      - flag <context.damager> h2hrcooldown expire:7s
      - itemcooldown red_concrete duration:7s
      - determine cancelled passively
      - define lookvec <context.damager.eye_location.direction.vector>
      - adjust <context.entity> max_no_damage_duration:1t
      - repeat 20:
        - cast <context.damager> slow duration:2t amplifier:4 no_icon no_ambient hide_particles
        - cast <context.entity> slow duration:2t amplifier:5 no_icon no_ambient hide_particles
        - hurt <context.entity> 0.5
        - playeffect effect:crit_magic quantity:2 at:<context.damager.eye_location> offset:1 velocity:<[lookvec].mul[3]>
        - wait 2t
      - hurt <context.entity> 2 source:<context.damager>
      - wait 2t
      - hurt <context.entity> 2 source:<context.damager>
      - wait 1t
      - hurt <context.entity> 2 source:<context.damager>
      - adjust <context.entity> max_no_damage_duration:20t


hearttoheartrequiemubercharge:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[AGooseWithAPhone]>
  - if <[standuser].flag[h2hrcooldown2]> == 100:
    - flag <[standuser]> h2hcooldown expire:8s
    - itemcooldown red_concrete duration:8s
    - playsound <[standuser].location> sound:custom.h2h_ubercharge pitch:0 volume:10 custom
    #- adjust <[standuser]> invincible:true
    - foreach <list[absorption|blindness|confusion|damage_resistance|fast_digging|fire_resistance|health_boost|hunger|increase_damage|invisibility|jump|levitation|luck|night_vision|poison|regeneration|saturation|slow|slow_digging|slow_falling|speed|unluck|water_breathing|weakness|wither]>:
      - cast <[standuser]> <[value]> remove
    - cast <[standuser]> increase_damage duration:10s amplifier:127 no_ambient hide_particles no_icon
    - cast <[standuser]> glowing duration:10s amplifier:1 no_ambient hide_particles no_icon
    - cast <[standuser]> speed duration:10s amplifier:1 no_ambient hide_particles no_icon
    - cast <[standuser]> regeneration duration:10s amplifier:2 no_ambient hide_particles no_icon
    - repeat 200:
      - playeffect effect:redstone special_data:0.9|<color[#FF0000]> quantity:7 at:<[standuser].location.add[0,0.75,0]> offset:0.4,0.6,0.4
      - adjust <[standuser]> invulnerable:true
      - flag <[standuser]> h2hcooldown2:<[standuser].flag[h2hcooldown2].sub[0.5]>
      - title "title:<element[<[standuser].flag[h2hrcooldown2].round_up>%].color[#FF0000].bold>" "subtitle:" fade_in:0 stay:2s targets:<[standuser]>
      - wait 1t
    - adjust <[standuser]> invulnerable:false
  - else:
    - title "title:" "subtitle:<element[<[standuser].flag[h2hrcooldown2].round_up>%].color[#FF0000].bold>" fade_in:0 stay:2s targets:<[standuser]>

hearttoheartrequiemleap:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[AGooseWithAPhone]>
  - flag <[standuser]> h2hcooldown expire:5s
  - itemcooldown red_concrete duration:5s
  - playsound <[standuser].location> sound:custom.h2h_leap pitch:0 volume:10 custom
  - define lookvec <[standuser].eye_location.direction.vector.mul[4.5]>
  - adjust <[standuser]> velocity:<[lookvec]>
  - flag <[standuser]> nofalldmg
  - waituntil !<[standuser].is_on_ground>
  - waituntil <[standuser].is_on_ground>
  - flag <[standuser]> nofalldmg:!
  - explode at:<[standuser].location> power:3 source:<[standuser]>

hearttoheartrequiemquickfix:
  debug: false
  type: task
  script:
  - define standuser <server.match_player[AGooseWithAPhone]>
  - define demtarget <[standuser].precise_target[12]||0>
  - if <[demtarget]> != 0:
    - flag <[standuser]> h2hcooldown expire:12s
    - itemcooldown red_concrete duration:12s
    - playsound <[standuser].location> sound:custom.h2hrequiem_quickfix pitch:1 volume:10 custom
    - while <[standuser].location.distance[<[demtarget].location>]> < 12:
      - foreach <[standuser].location.add[0,1,0].points_between[<[demtarget].location.add[0,1,0]>].distance[0.2]>:
        - playeffect effect:redstone quantity:2 special_data:1|red at:<[value]> offset:0.05
      - if <[demtarget].health> > 1 && <[standuser].health> < <[standuser].health_max>:
        - hurt <[demtarget]> 1
        - heal <[standuser]> 1
      - wait 2t
  - else:
    - playsound <[standuser].location> sound:block_note_block_bass pitch:0 volume:4