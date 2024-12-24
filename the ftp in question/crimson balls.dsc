kccommand:
  debug: false
  type: world
  events:
    on player chats:
    - if <context.message> = "TIME SKIP" || <context.message> = "KC":
      # SHUT THE FUCK UP
      - determine cancelled passively
      - announce <context.full_text>
      - run kingcrimsontimeskip

kingcrimsontimeskip:
  debug: false
  type: task
  script:
  # check for the cooldown
  - ratelimit <player> 1t
  - if <player.has_flag[timestop]> || <player.has_flag[timeskipcooldownearly]>:
    - stop
  - if <player.has_flag[kctimeskipcooldown]>:
    - playsound sound:BLOCK_NOTE_BLOCK_BASS <player> pitch:0
    - title subtitle:<&d><&l><player.flag_expiration[kctimeskipcooldown].duration_since[<util.time_now>].in_seconds.round>s fade_in:0 fade_out:10t stay:1t
    - stop
  # give cooldown
  - flag <player> kctimeskipcooldown duration:20s
  - flag <player> timeskipcooldownearly duration:5s

  # define entities in 100 block range
  - define entities <player.location.find.living_entities.within[100]>
  - define players <player.location.find_players_within[100]>
  # filter alive
  - define entities <[entities].filter[is_spawned]>
  - define players <[players].filter[is_spawned]>
  # filter time stoppers
  - define entities <[entities].filter[has_flag[timestop].not]>
  # remove player & user
  - define entities <[entities].exclude[<player>]>

  # speed no, dio is dumbass!
  - cast <player> speed amplifier:5 duration:1s
  # visuals
  - foreach <[entities]>:
    - flag <[value]> prevloc:<[value].location> expire:2s
    - playsound sound:BLOCK_NOTE_BLOCK_BASS <player> pitch:0.5
    - playsound sound:BLOCK_NOTE_BLOCK_BASS <player> pitch:0.6
    - playsound sound:BLOCK_NOTE_BLOCK_BASS <player> pitch:0.7
    - playsound sound:BLOCK_NOTE_BLOCK_BASS <player> pitch:0.8
    - playsound sound:BLOCK_NOTE_BLOCK_BASS <player> pitch:0.9
    #- teleport <[value]> <[value].location.add[<[value].velocity.mul[10]>]>
    - playeffect at:<[value].location> effect:REDSTONE special_data:1|red quantity:15 offset:0.1,0.5,0.1
  - wait 20t
  - foreach <[entities]>:
    - define tpto <[value].location>.sub[<[value].flag[prevloc]>]>]
    - teleport <[value]> <[tpto].mul[10].add[<[value].location>]>