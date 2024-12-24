## Items
note_w:
  type: item
  material: white_concrete
  debug: false
note_b:
  type: item
  material: black_concrete
  debug: false
## Handlers
piano_command:
  type: command
  name: piano
  description: Opens a Piano GUI to play your held instrument.
  usage: /piano
  tab complete:
  - determine <empty>
  debug: false
  script:
    - define item <player.item_in_hand>
    - if !<[item].has_flag[sound]>:
      - narrate "<red>You need to hold an instrument to use this command"
      - stop
    - inventory open d:instrument_menu
    - wait 1t
    - if <player.item_in_hand> != <[item]>:
      - inventory close
instrument_menu_handler:
  type: world
  debug: false
  events:
    on player clicks note_b|note_w in instrument_menu:
    - run play_note_task def:<context.item.flag[pitch]>|1|<player.item_in_hand.flag[sound]>|<player.item_in_hand.flag[custom]>|<player.location>|0.5

instrument_menu:
  type: inventory
  inventory: CHEST
  title: <player.item_in_hand.display>
  size: 45
  gui: true
  slots:
    - [] [] [] [air] [] [] [air] [] [air]
    - [] [] [] [] [] [] [] [] [air]
    - [air] [air] [air] [air] [air] [air] [air] [air] [air]
    - [] [] [] [air] [] [] [air] [] []
    - [air] [] [] [] [] [] [] [] []
  procedural items:
    - define list <list>
    - define notes <list[B|B|B|B|B|B|W|W|W|W|W|W|W|W|B|B|B|B|B|B|B|W|W|W|W|W|W|W|W]>
    #- define names <list[F#↓|G↓|G#↓|A↓|Bb↓|B↓|C|C#|D|Eb|E|F|F#|G|G#|A|Bb|B|C↑|C#↑|D↑|Eb↑|E↑|F↑|F#↑|a|a|a|a]>
    - define names <list[F#|G#|A#|C#|D#|F#|F|G|A|B|C|D|E|F|F#|G#|A#|C#|D#|F#|G#|G|A|B|C|D|E|F|G]>
    - define table <list[12|14|16|19|21|24|11|13|15|17|18|20|22|23|0|2|4|7|9|12|14|1|3|5|6|8|10|11|13]>
    - foreach <util.list_numbers_to[29]> as:slot:
      - define note <[notes].get[<[slot]>]>
      - define name <[names].get[<[slot]>]>
      - define pitch <[table].get[<[slot]>]>
      - define list:->:<item[note_<[note]>].with[display_name=<&r><[name]>;lore=<&7><[pitch]>;flag_map=<map.with[pitch].as[<[pitch]>]>]>
    - determine <[list]>