btdcommand:
  debug: false
  type: world
  events:
    on player chats:
    - if <context.message> = "BITES THE DUST" || <context.message> = "BTD":
      # SHUT THE FUCK UP
      - determine cancelled passively
      - run bitezadusto

bitezadusto:
  debug: false
  type: task
  script:
  - title targets:<server.online_players> "title:<&d><&l>KILLER" fade_in:0t stay:5s
  - wait 5t
  - title targets:<server.online_players> "title:<&d><&l>KILLER QUEEN" fade_in:0t stay:5s
  - wait 15t
  - title targets:<server.online_players> "title:<&5><&l>DAISAN" fade_in:0t fade_out:5t stay:0.6s
  - wait 5t
  - title targets:<server.online_players> "title:<&5><&l>DAISAN NO BAKUDAN" fade_in:0t fade_out:5t stay:0.6s
  - wait 10t
  - title targets:<server.online_players> "title:<&5><&l>DAISAN NO BAKUDAN" "subtitle:<&f><&o>BITE ZA DUSTO!" fade_in:0t fade_out:2t stay:1.5s
  - foreach <server.online_players>:
    - adjust <[value]> gamemode:survival
    - explode power:8 <[value].location> source:<player>
  - wait 10t
  - execute as_op "co rb u:#global t:1m radius:100" silent