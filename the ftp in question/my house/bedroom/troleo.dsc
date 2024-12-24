troleotrollitem:
  type: item
  material: player_head
  mechanisms:
    skull_skin: trollface
  display name: <&f>troleo

troleotrollitemhandler:
  type: world
  debug: false
  events:
    on tick every:10:
    - if <server.match_player[soup].item_in_hand.script.name||fail> != troleotrollitem:
      - stop
    - run 10ticktroleo def:<server.match_player[soup]>
    #on player damages entity:
    #- if <context.damager.has_flag[troleo]>:
    #  - if <util.random.int[1].to[6]> == 1:
    #    - determine cancelled passively
    #    - run randomtroleo def:<context.damager>
    #on entity damaged by player:
    #- if <context.entity.has_flag[troleo]>:
    #  - if <util.random.int[1].to[3]> == 1:
    #    - run randomtroleo def:<context.entity>
    #    #- narrate targets:<context.damager> "trole"
    #    - if <util.random.int[1].to[25]> == 25:
    #      - run troleospawn def:<context.entity>
    on player damages player:
    - if <context.damager.has_flag[troleo]>:
      - if <util.random.int[1].to[3]> == 1:
        - determine cancelled passively
        - run randomtroleo def:<context.damager>
    - if <context.entity.has_flag[troleo]>:
      - if <util.random.int[1].to[3]> == 1:
        - determine cancelled passively
        - run randomtroleo def:<context.entity>

10ticktroleo:
  type: task
  debug: false
  definitions: soup
  script:
  #- define trolled <[soup].location.find_players_within[20].exclude[<[soup]>]>
  #- define trolled <[soup]>
  - if <[trolled].is_empty>:
    - stop
  - flag <[trolled]> troleo expire:10s
  - if <util.random.int[1].to[5]> == 1:
    - ratelimit <[soup]> 30t
    - run randomtroleo def:<[trolled]>|<[soup]>

randomtroleo:
  type: task
  definitions: trolled|soup
  script:
  - repeat 3:
    - random:
      - run troleoattackcooldown def:<[trolled]>
      - run troleofakedrop def:<[trolled]>
      - run troleoswitchhotbar def:<[trolled]>
      - run troleoturn def:<[trolled]>
      - run troleoglass def:<[trolled]>
      - run troleofling def:<[trolled]>
      - run troleobuyminecraft def:<[trolled]>
      - run troleotrollbook def:<[trolled]>
      - run troleospeed def:<[trolled]>
      - run troleoteleport def:<[trolled]>|<[soup]>
      #- run troleosoupclones def:<[trolled]>|<[soup]>
      - run troleosand def:<[trolled]>|<[soup]>
      - run troleofov def:<[trolled]>
      - run troleospectate def:<[trolled]>
      - run troleovision def:<[trolled]>
      - run troleoattach def:<[trolled]>|<[soup]>
      - run troleogravity def:<[trolled]>
      - run troleohurtself def:<[trolled]>
      - run troleoridesilverfish def:<[trolled]>
      #- run troleospawn def:<[trolled]>|<[soup]>

troleoridesilverfish:
  type: task
  definitions: trolled
  script:
  - mount <[trolled]> silverfish

troleohurtself:
  type: task
  definitions: trolled
  script:
  - adjust <[trolled]> melee_attack:<[trolled]>

troleogravity:
  type: task
  definitions: trolled
  script:
  - adjust <[trolled]> gravity:false
  - wait 4s
  - adjust <[trolled]> gravity:true

troleoattach:
  type: task
  definitions: trolled|soup
  script:
  - attach for:<[trolled]> <[soup]> to:<[soup]> offset:<util.random.int[3].to[-3]>,1,<util.random.int[3].to[-3]>
  - wait 4s
  - attach for:<[trolled]> <[soup]> cancel

troleovision:
  type: task
  definitions: trolled
  script:
  - adjust <[trolled]> vision:cave_spider

troleospectate:
  type: task
  definitions: trolled
  script:
  - spawn pig <[trolled].location.random_offset[10,10,10].find_spawnable_blocks_within[10].first> save:pig
  - wait 1t
  - adjust <[trolled]> spectate:<entry[pig].spawned_entity>
  - wait 2s
  - adjust <[trolled]> spectate:<[trolled]>
  - remove <entry[pig].spawned_entity>

troleofov:
  type: task
  definitions: trolled
  script:
  - random:
    - adjust <[trolled]> fov_multiplier:-5
    - adjust <[trolled]> fov_multiplier:5
  - wait 1s
  - adjust <[trolled]> fov_multiplier

troleosand:
  type: task
  definitions: trolled|soup
  script:
  - repeat 20:
    - shoot falling_block origin:<[soup].eye_location> destination:<[trolled].above[1.5]> speed:1 spread:20 save:sand
    - run troleosandtask def:<entry[sand].shot_entity>|<[soup]>

troleosandtask:
  type: task
  definitions: sand|soup
  script:
  - while <[sand].is_spawned||no>:
    - define targets <[sand].location.find_players_within[1.8].exclude[<[soup]>]>
    - if <[targets].is_empty.not>:
      - hurt <[targets]> 2 source:<[soup]>
    - wait 1t

troleosoupclone:
  type: entity
  entity_type: silverfish
  mechanisms:
    #invulnerable: true
    speed: 0.7
    #visible: false
    silent: true
    item_in_hand: troleotrollitem

troleosoupclones:
  type: task
  definitions: player|soup
  script:
  - teleport <[player]> <[player].location.face[<[player].location.below[10]>]>
  - wait 3t
  - repeat 10:
    - spawn troleosoupclone <[soup].location.random_offset[15,0,15].find_spawnable_blocks_within[10].first> save:troe
    - flag <entry[troe].spawned_entity> target:<[player]>

troleosoupcloneshandler:
  type: world
  events:
    on troleosoupclone spawns:
    - libsdisguise player target:<context.entity> name:soup__can display_name:soup__can
    - wait 1t
    #- adjust <context.entity> visible:true
    - repeat 60:
      - define target <context.entity.flag[target].as[entity]>
      - if <[target]||no> != no:
        - attack <context.entity> target:<[target]>
      - wait 2t
    - remove <context.entity>

troleospeed:
  type: task
  definitions: player
  script:
  - adjust <[player]> speed:<[player].speed.mul[5]>
  - wait 15t
  - adjust <[player]> speed:<[player].speed.div[5]>

troleoteleport:
  type: task
  definitions: player|soup
  script:
  - teleport <[player]> <[player].location.random_offset[10,1,10].find_spawnable_blocks_within[10].first> relative
  - teleport <[soup]> <[player].location.backward_flat[3].find_spawnable_blocks_within[10].first.face[<[player].location>]>

troleofling:
  type: task
  definitions: player
  script:
  - adjust <[player]> velocity:<util.random.decimal[-1.5].to[1.5]>,<util.random.decimal[0.7].to[1]>,<util.random.decimal[-1.5].to[1.5]>
  - playsound sound:entity_firework_rocket_shoot <[player].location>
  - wait 1t
  - adjust <[player]> fall_distance:8

troleobuyminecraft:
  type: task
  definitions: player
  script:
  - adjust <[player]> show_demo

troleotrollbook:
  type: task
  definitions: player
  script:
  - adjust <[player]> show_book:<item[troleotrollbookitem]>

troleotrollbookitem:
  type: book
  title: trolled
  author: trolled
  signed: true
  # Each -line in the text section represents an entire page.
  # To create a newline, use the tag <n>. To create a paragraph, use <p>.
  # | All book scripts MUST have this key!
  text:
  #-  ⠀⠀⠀⠀⠀⠀⠀⣠⣴⠾⠟⠛⠛⠛⠛⠛⢛⣛⡛⠻⠟⠛⠛⠟⠛⠛⠛⠷⠶⢶⣶⣶⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀<n>⠀⠀⠀⠀⠀⠀⢀⣼⠟⠁⠀⠀⢀⣠⠴⢚⣉⡥⠤⠔⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠤⠭⠭⠭⢭⠛⠿⣶⣄⡀⠀⠀⠀⠀<n>⠀⠀⠀⠀⠀⢠⣿⠃⠀⠀⣠⠔⢉⡴⣚⡭⠖⠒⠛⠉⠉⠙⢯⠀⠀⠀⠀⠀⠀⠤⠤⠶⠒⠒⠦⣄⠀⠀⠀⠙⢿⡄⠀⠀⠀<n>⠀⠀⠀⠀⢠⣿⠃⠀⠀⠈⠁⠞⢡⠞⠁⢀⣀⣀⣀⣀⣀⠀⠀⠇⠀⠀⠀⠀⠀⡼⠁⠀⠀⠀⠀⠈⢳⠀⠀⠀⠸⣿⠀⠀⠀<n>⠀⠀⢀⣴⣿⣁⡀⠀⠀⠀⣀⣀⢀⣴⣿⣿⣿⣿⣿⡉⠛⠿⣶⣄⠀⠀⠀⠀⠀⢃⣠⣴⣶⣶⣶⣤⣀⠀⠀⠀⠀⠻⣷⣄⠀<n>⠀⣴⣿⡿⠋⣉⣭⣥⣤⣄⣙⠳⠘⠛⠛⠋⢉⣿⠛⠛⠿⣶⣼⡿⠀⠀⠀⠶⣶⣿⡿⠿⠛⠛⠛⠋⠁⠉⠉⠉⢉⡳⢌⢻⣦<n>⣾⠏⡟⠀⣼⠟⠉⢈⣏⠉⠛⠿⠶⣶⣶⠾⠛⠁⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠸⣿⠀⠀⠀⢀⣤⣀⣤⡶⡿⠿⣶⠹⡄⢻⣿<n>⣿⠀⡇⢸⡏⢀⣠⣾⡿⢿⣦⣄⡀⠀⠀⠀⢀⣀⣀⣀⣤⣤⣶⠄⠀⠀⠀⠀⠀⠛⢷⣦⡀⠀⠉⠛⠋⠁⣿⠀⠀⢠⠇⣸⣿<n>⢿⡆⢳⡈⣿⠈⠉⢹⣷⣀⠈⠙⢻⣿⣶⣤⣬⣀⡀⠀⢸⣧⠠⡶⠶⠶⠀⠀⠀⢀⣼⡿⠟⠓⠤⡀⠀⣸⣿⣧⢀⡡⠖⣿⠏<n>⠈⢿⣦⣙⠲⠄⠀⠈⢻⣿⣷⣦⣼⣿⣄⠈⠉⠛⠻⢿⣶⣯⣤⣄⣀⣀⠀⠘⠷⠟⠋⠀⠀⣀⣠⣴⣿⡿⣿⣿⠀⠀⣼⡏⠀<n>⠀⠀⠙⢿⣅⠀⠀⠀⠀⠙⣷⡌⠹⣿⣿⣷⣶⣤⣀⣾⡇⠀⠉⠉⠛⣿⠟⠛⠻⣿⡿⠛⠛⠻⣿⠁⢸⣇⣿⣿⠀⠀⣿⠀⠀<n>⠀⠀⠀⠀⢻⣆⠀⠀⠀⠀⠈⢻⣶⡿⠀⠈⠉⠛⢿⣿⣿⣷⣶⣶⣶⣿⣷⣴⣶⣾⣷⣶⣶⣾⣿⣶⣿⣿⣿⣿⠀⠀⣿⠀⠀<n>⠀⠀⠀⠀⠀⢻⣦⡀⠀⠀⠀⠀⠙⠻⣶⣄⠀⠀⣼⡇⠀⠉⠙⠛⣿⡿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⣿⠀⠀<n>⠀⠀⠀⠀⠀⠀⠙⢿⣦⡀⢤⡀⠠⣄⡈⠙⠻⣾⣿⣀⣀⠀⠀⠀⣿⠁⠀⠀⢨⡿⠁⢀⣿⠏⣸⡟⣸⣿⡿⠁⠀⠀⣿⠀⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣶⣌⡓⠦⣍⡓⠦⣄⡈⠉⠛⠛⠳⠾⠿⠷⠶⠶⠾⠷⠶⠾⠿⠾⠟⠛⠛⠉⠀⠀⠀⠀⣿⠀⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⢷⣦⣍⡓⠲⠬⣝⣒⣤⣤⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⢀⣀⠴⠚⠀⢀⡆⠀⢿⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⢷⣦⣄⡀⠉⠉⠛⠓⠲⠤⠤⠬⢭⣭⣭⣭⣉⣁⣀⣀⡤⠞⠉⠀⠀⣼⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠷⣦⣤⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣼⠟⠀⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠛⠛⠷⠶⣶⣤⣤⣤⣤⣤⣤⣤⣶⠾⠛⠉⠀⠀⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
  - <n>⠀⠀⠀⢀⡴⠋⠉⢉⠍⣉⡉⠉⠉⠉⠓⠲⠶⠤⣄⠀⠀⠀<n>⠀⠀⢀⠎⠀⠪⠾⢊⣁⣀⡀⠄⠀⠀⡌⠉⠁⠄⠀⢳⠀⠀<n>⠀⣰⠟⣢⣤⣐⠘⠛⣻⠻⠭⠇⠀⢤⡶⠟⠛⠂⠀⢌⢷⡀<n>⢸⢈⢸⠠⡶⠬⣉⡉⠁⠀⣠⢄⡀⠀⠳⣄⠑⠚⣏⠁⣪⠇<n>⠀⢯⡊⠀⠹⡦⣼⣍⠛⢲⠯⢭⣁⣲⣚⣁⣬⢾⢿⠈⡜⠀<n>⠀⠀⠙⡄⠀⠘⢾⡉⠙⡟⠶⢶⣿⣶⣿⣶⣿⣾⣿⠀⡇⠀<n>⠀⠀⠀⠙⢦⣤⡠⡙⠲⠧⠀⣠⣇⣨⣏⣽⡹⠽⠏⠀⡇⠀<n>⠀⠀⠀⠀⠀⠈⠙⠦⢕⡋⠶⠄⣤⠤⠤⠤⠤⠂⡠⠀⡇⠀<n>⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⠦⠤⣄⣀⣀⣀⣠⠔⠁⠀
troleoattackcooldown:
  type: task
  definitions: player
  script:
  - cast <[player]> slow_digging duration:1s amplifier:10
  - random:
    - playsound <[player].location.left[3]> <[player]> sound:entity_villager_work_weaponsmith volume:2
    - playsound <[player].location.right[3]> <[player]> sound:entity_villager_work_weaponsmith volume:2

troleofakedrop:
  type: task
  definitions: player
  script:
  - ratelimit <[player]> 5s
  - if <[player].item_in_hand.material.name> == air:
    - stop
  - playsound <[player]> sound:entity_item_pickup
  - fakeitem players:<[player]> slot:<[player].held_item_slot> air duration:2s
  - drop <[player].item_in_hand> quantity:<[player].item_in_hand.quantity> delay:1000 save:fakeitem <[player].eye_location>
  - wait 1t
  - shoot <entry[fakeitem].dropped_entity> origin:<[player].eye_location> destination:<[player].eye_location.forward[2].above[0.5]> speed:0.6
  - wait 2s
  - remove <entry[fakeitem].dropped_entity>

troleoswitchhotbar:
  type: task
  definitions: player
  script:
  - mark lol
  - define slot <util.random.int[1].to[9]>
  - define oldslot <[player].held_item_slot>
  - define olditem <[player].item_in_hand>
  - if <[slot]> == <[player].held_item_slot>:
    - goto lol
  - adjust <[player]> item_slot:<[slot]>
  - playsound <[player]> sound:block_stone_break <[player].location>
  - fakeitem players:<[player]> slot:<[slot]> <[olditem]> duration:1s
  - fakeitem players:<[player]> slot:<[oldslot]> <item[trollfacehead]> duration:1s

troleoglass:
  type: task
  definitions: player
  script:
  #- showfake glass <[player].location.find.surface_blocks.within[5].filter[material.name.is[!=].to[air]].include[<[player].location.find_blocks[air].within[4]>]> duration:2s players:<[player]>
  - repeat 46:
    - fakeitem players:<[player]> slot:<[value]> glass duration:3s
    - playsound <[player]> <[player].location> sound:block_glass_break volume:10
    - playsound <[player]> <[player].location> sound:block_glass_break volume:10
  - wait 2s
  - inventory update destination:<[player].inventory>

trollfacehead:
  type: item
  material: player_head
  mechanisms:
    skull_skin: trollface
  display name: <&f><list[troll|tr|troe|trolled|t|roled|erode|popbob|po,bob|troled|trollface|trolle|problem?].random>

troleoturn:
  type: task
  definitions: player
  script:
  - adjust <[player]> location:<[player].location.face[<[player].location.backward[2]>].with_pitch[<[player].location.pitch>]>
  - playsound <[player]> <[player].location> sound:block_grass_place

troleospawn:
  type: task
  definitions: player
  script:
  - repeat 10:
    - wait <util.random.int[0].to[1]>t
    - shoot troleotrolls[target=<[player]>] destination:<[player].location> origin:<[player].location.above[10].random_offset[10,0,10]> speed:1 spread:10
    - playsound <[player].location> sound:entity_tnt_primed

troleotrolls:
  type: entity
  entity_type: silverfish
  mechanisms:
    custom_name: <&f><list[troll|tr|troe|trolled|t|roled|erode|popbob|po,bob|troled|trollface|trolle|problem?].random>
    invulnerable: true
    speed: 0.7
    #visible: false
    silent: true

troleotrollshandler:
  type: world
  events:
    on troleotrolls spawns:
    #- wait 1t
    - libsdisguise player target:<context.entity> name:trollface hide_name
    #- adjust <context.entity> visible:true
    - repeat 60:
      - define target <context.entity.location.find.living_entities.within[20].filter[script.name.is[!=].to[troleotrolls]||true].filter[name.is[!=].to[soup__can]||true].first>
      - if <[target]||no> != no:
        - attack <context.entity> target:<[target]>
        - if <context.entity.location.distance[<[target].location>]> <= 2:
          - adjust <context.entity> melee_attack:<[target]>
          - adjust <[target]> no_damage_duration:0t
      - wait 2t
    - remove <context.entity>
    on troleotrolls knocks back entity:
    - determine <context.acceleration.mul[4].with_y[<context.acceleration.y.mul[1.5]>]>
    on troleotrolls damages entity:
    - determine 0.5 passively
