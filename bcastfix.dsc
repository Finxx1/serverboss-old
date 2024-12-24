discordfix:
  type: world
  debug: false
  events:
    on player chats:
    - if <context.message> != <element[roll for persuasion].unescaped> && <context.message> != <element[random].unescaped>:
      - execute as_server "discord bcast **<player.name>** ≫ <context.message>" silent

nya:
  type: world
  debug: false
  events:
    on player chats:
    - if <context.message> == <element[&co3].unescaped>:
      - foreach <server.list_online_players>:
        - playsound <[value].eye_location> <[value]> sound:entity_cat_ambient volume:2 pitch:1
    - if <context.message> == <element[uwu].unescaped> || <context.message> == <element[UwU].unescaped>:
      - foreach <server.list_online_players>:
        - playsound <[value].eye_location> <[value]> sound:entity_cat_purr volume:2 pitch:1
    - if <context.message> == <element[owo].unescaped> || <context.message> == <element[OwO].unescaped>:
      - foreach <server.list_online_players>:
        - playsound <[value].eye_location> <[value]> sound:entity_cat_purreow volume:2 pitch:1
    - if <context.message> == <element[ncrp].unescaped> || <context.message> == <element[ncrp].unescaped>:
      - strike <player.location>
    - if <context.message> == <element[oops].unescaped> || <context.message> == <element[fuck].unescaped> || <context.message> == <element[oh fuck].unescaped> || <context.message> == <element[shit].unescaped> || <context.message> == <element[oh shit].unescaped>:
      - foreach <server.list_online_players>:
        - playsound <[value].eye_location> <[value]> sound:custom.reload_error volume:2 pitch:1 custom
    - if <context.message> == <element[tadaa].unescaped> || <context.message> == <element[yay].unescaped> || <context.message> == <element[yippee].unescaped>:
      - foreach <server.list_online_players>:
        - playsound <[value].eye_location> <[value]> sound:custom.reload_correct volume:2 pitch:1 custom
    - if <context.message> == <element[roll for persuasion].unescaped> || <context.message> == <element[random].unescaped>:
      - define rnd <server.flag[LAST_CHAT].random>
      - determine cancelled passively
      - define dice <list[⚀|⚁|⚂|⚃|⚄|⚅].random>
      - announce "<player.display_name> §x§F§F§3§8§2§0<[dice]>§r <element[<[rnd]>]>"
      - execute as_server "discord bcast **<player.name>** :game_die: <[rnd]> " silent