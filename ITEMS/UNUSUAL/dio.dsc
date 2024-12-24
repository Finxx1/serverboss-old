#twcommand:
#  debug: false
#  type: world
#  events:
#    on player chats:
#    - if <context.message> = "TIME STOP" || <context.message> = "TS":
#      # SHUT THE FUCK UP
#      - determine cancelled passively
#      - run theworldtimestop
#
theworlditem:
  type: item
  display name: <element[「The World」].color_gradient[from=#ffaa00;to=#aaaa20]>
  material: gold_ingot
  enchantments:
  - knockback:1
  mechanisms:
    custom_model_data: 13371867
    hides:
    - ALL
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: deadringer|aries
  lore:
  - <element[-= Can halt the power of time itself =-].color_gradient[from=#805500;to=#555510]>
  - 
  - <element[UNUSUAL].color[#9040C0].bold>

theworlditemtrigger:
  type: world
  debug: false
  events:
    on player damages entity priority:-1:
      - if <context.cause> == entity_attack && <player.item_in_hand.script.name||null> == theworlditem && <context.entity.has_flag[ded].not>:
        - determine cancelled passively
    on player right clicks block with:theworlditem:
      - if <context.click_type> == PHYSICAL:
        - stop
      - determine cancelled passively
      - run theworldtimestop
    after delta time secondly every:6:
    - foreach <server.online_players>:
      - if <[value].item_in_hand.script||0> == <script[theworlditem]>:
        - playsound sound:BLOCK_PORTAL_AMBIENT <[value].location> pitch:0 volume:0.5

theworldtimestop:
  debug: false
  type: task
  script:
  # check for the cooldown
  - ratelimit <player> 1t
  - if <player.has_flag[timestop]> || <player.has_flag[timestopcooldownearly]>:
    - stop
  - if <player.has_flag[twtimestopcooldown]>:
    - playsound sound:BLOCK_NOTE_BLOCK_BASS <player> pitch:0
    - title subtitle:<&d><&l><player.flag_expiration[twtimestopcooldown].duration_since[<util.time_now>].in_seconds.round>s fade_in:0 fade_out:10t stay:1t
    - stop
  # give cooldown
  - flag <player> twtimestopcooldown duration:33s
  - itemcooldown gold_ingot duration:33s
  - flag <player> timestopcooldownearly duration:5s

  # define standnpc
  - define standnpc <player>

  # forward float
  - flag <player> standfloattype:front duration:1s

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
  #- cast <player> speed amplifier:2 duration:9.9s
  # visuals
  - run timestopvisuals2 def:<list_single[<[players]>]>
  - playsound sound:BLOCK_NOTE_BLOCK_BASS <player> pitch:0.5
  - playsound sound:BLOCK_NOTE_BLOCK_BASS <player> pitch:0.6
  - playsound sound:BLOCK_NOTE_BLOCK_BASS <player> pitch:0.7
  - playsound sound:BLOCK_NOTE_BLOCK_BASS <player> pitch:0.8
  - playsound sound:BLOCK_NOTE_BLOCK_BASS <player> pitch:0.9
  # 25t duration of saying za warudo
  - wait 25t
  # give flag
  - flag <player> timestop duration:12.9s
  #- flag <[standnpc]> timestop duration:12.9s
  # check if someone else had it
  - if <player.location.find.living_entities.within[100].filter[has_flag[timestop]].size> > 1:
    - define othertimestop:true
  - else:
    - define othertimestop:false

  - if <[othertimestop]>:
    # give me gravity back
    - adjust <player> gravity:<player.flag[tsgravity]||true>
    - flag <player> tsgravity:!

  # stop entities
  - foreach <[entities].filter[has_flag[timestop].not].filter[is_spawned]>:
    # Velocity ################
    - if <[value].is_player>:
      - adjust <[value]> vision:enderman

    # if not player store their velocity
    - if <[value].is_player.not> && <[value].has_flag[tsvelocity].not>:
      - flag <[value]> tsvelocity:<[value].velocity>
    # velocity no
    - teleport <[value]> <[value].location>

    # AI ######################

    # check ai
    - if <[value].has_ai> && <[value].has_flag[tsai].not>:
      - flag <[value]> tsai:true
    - else:
      - flag <[value]> tsai:false
    # no ai
    - adjust <[value]> has_ai:false

    # Gravity #################
    - if <[value].is_player>:
      # check gravity
      - if <[value].gravity> && <[value].has_flag[tsgravity].not>:
        - flag <[value]> tsgravity:true
      - else:
        - flag <[value]> tsgravity:false
      # no gravity
      - adjust <[value]> gravity:false

    # STOP FUCKING MOVING
    - if <[value].is_player>:
      # store speed
      - flag <[value]> tsws:<[value].walk_speed>
      - flag <[value]> tsfs:<[value].fly_speed>
      - adjust <[value]> max_damage_duration:1t
      # no more speed
      - cast <[value]> slow duration:13s amplifier:8 no_ambient hide_particles no_icon
      - cast <[value]> jump duration:13s amplifier:255 no_ambient hide_particles no_icon
      #- adjust <[value]> gravity:false
      - adjust <[value]> walk_speed:0
      - adjust <[value]> fly_speed:0

  # resume
  - waituntil <player.location.find.living_entities.within[100].filter[has_flag[timestop]].is_empty>
  - foreach <[entities].filter[is_spawned]>:
    # Velocity ################

    # if not player give back their velocity
    - if <[value].is_player.not>:
      - flag <[value]> velocity:<[value].flag[tsvelocity]||true>
      - flag <[value]> tsvelocity:!
    # velocity no
    - teleport <[value]> <[value].location>

    # AI ######################

    # check ai
    - adjust <[value]> has_ai:<[value].flag[tsai]||false>
    - flag <[value]> tsai:!

    # Gravity #################
    - adjust <[value]> gravity:<[value].flag[tsgravity]||true>
    - flag <[value]> tsgravity:!
    - if <[value].is_player>:
      - adjust <[value]> vision


    # Speed
    - if <[value].is_player>:
      # put back speed
      - adjust <[value]> walk_speed:<[value].flag[tsws]||0.2>
      - adjust <[value]> fly_speed:<[value].flag[tsfs]||0.2>
      - adjust <[value]> gravity:true
      - adjust <[value]> max_damage_duration:20t
      # no more store speed
      - flag <[value]> tsws:!
      - flag <[value]> tsfs:!

    # damage
    - run timestopfinishdamage def:<[value]>
