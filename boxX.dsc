boxevents:
  type: world
  debug: false
  events:
    on player exits box_*:
    - if <player.has_flag[boxdup]>:
      - determine cancelled passively
    - if !<player.has_flag[boxdup]>:
      - announce <player.display_name><element[ has been unboxed].color[#606060]>
    on command in:box_*:
    - if <player||0> == 0:
      - stop
    - if <player.has_flag[boxdup]>:
      - determine cancelled passively
    on player places block in:box_*:
    - if <player.has_flag[boxdup]>:
      - determine cancelled passively
    on player breaks block in:box_*:
    - if <player.has_flag[boxdup]>:
      - determine cancelled passively
    on delta time secondly:
    - foreach <cuboid[box_bossfight].players>:
      - if !<[value].has_flag[boxdup]>:
        - teleport <[value]> <[value].flag[boxpreloc]>
        - flag <[value]> boxpreloc:!

boxcmd:
  debug: false
  type: command
  name: box
  description: "Box someone in for a specific duration"
  aliases:
  - bx
  - xbox
  usage: /box [player] [duration](in seconds)
  script:
    - if <context.args.get[1]||0> == 0 || <context.args.get[2]||0> == 0:
      - announce <element[Command is not in format: /box &lbplayer&rb &lbduration&rb].unescaped.color[#FF0000]>
      - playsound at:<player.eye_location> sound:custom.reload_error volume:2 pitch:1 custom
      - stop
    - define boxed <server.match_player[<context.args.get[1]>]||0>
    - define sentence <context.args.get[2]||0>
    - if <server.match_player[<context.args.get[1]>]||0> == 0:
      - announce <element[Invalid player!].unescaped.color[#FF0000]>
      - playsound at:<player.eye_location> sound:custom.reload_error volume:2 pitch:1 custom
      - stop
    - announce <element[Boxed ].color[#606060]><[boxed].display_name><element[ for ].color[#606060]><element[<[sentence]>].color[#804040]><element[ seconds ].color[#804040]>
    - flag <[boxed]> boxpreloc:<[boxed].location>
    - flag <[boxed]> boxdup expire:<[sentence].mul[20]>t
    - wait 1t
    - teleport <[boxed]> node_box