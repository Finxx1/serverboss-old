speedermeleestage:
  type: task
  debug: false
  definitions: boss
  script:
  # first time? no effects.
  - if <[boss].has_flag[stage]>:
    - define effects true
  - else:
    - define effects false
  # flag
  - flag <[boss]> stage:melee
  # visual effects if it's not the first time (switch from a previous stage)
  # if effects is false, its the first time.
  - if <[effects]>:
    - run speedermeleestagefx def:<[boss]>
  # speed/invul
  - run speederinvul def:<[boss]>|5s
  - cast speed <context.entity> duration:5s amplifier:2
  # attacks
  - run speedermeleeattacksfast def:<[boss]>

speedermeleestagefx:
  type: task
  debug: false
  definitions: boss
  script:
  - actionbar targets:<[boss].location.find_players_within[60]> "<&3>-MELEE INBOUND.-"
  - playsound sound:entity_zombie_attack_iron_door <[boss].location> <[boss].location.find_players_within[60]> volume:1 pitch:1.3
  - wait 4t
  - playsound sound:entity_zombie_attack_iron_door <[boss].location> <[boss].location.find_players_within[60]> volume:1 pitch:1.3
  - playsound sound:item_shield_break <[boss].location> <[boss].location.find_players_within[60]> volume:1 pitch:0.8

speedermeleeattacksfast:
  type: task
  debug: false
  definitions: boss
  script:
  # fast attacks:
  # - teleports frequently, following with a thunder attack or lunging towards the player.
  - while <[boss].flag[stage]||none> == melee && <[boss].is_spawned||false>:
    - wait 5t
    - if <[boss].has_flag[invul].not> && <[boss].has_flag[cooldown].not> && <util.random.int[1].to[5]> == 5:
      - stop
      # placeholder, will continue