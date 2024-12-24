## Configuration ##

instruments_config:
  type: data
  # Can players use instruments to craft items? [default=false]
  can_craft: false
  # Can players hurt entities using instruments? [default=true]
  can_damage: true
  # Can players break blocks using instruments? [default=true]
  can_break: true

## Configuration End ##

instrument_handler:
  type: world
  debug: false
  events:
    on player breaks block:
    - if <context.item.has_flag[sound]||false> && !<script[instruments_config].data_key[can_break]>:
      - determine passively cancelled
    on item recipe formed:
    - if <script[instruments_config].data_key[can_craft]>:
      - stop
    after player right clicks entity:
    - run instrument_task def:<context.item>|right
    after player left clicks block:
    - run instrument_task def:<context.item>|left
    after player right clicks block:
    - run instrument_task def:<context.item>|right
    after player damages entity:
    - if <player.item_in_hand.has_flag[sound]> && !<script[instruments_config].data_key[can_damage]>:
      - determine passively cancelled
    - run instrument_task def:<player.item_in_hand>|left
    after player scrolls their hotbar:
    - while <player.item_in_hand.has_flag[sound]>:
      - run display_pitch_task
      - wait 10t
    - stop
display_pitch_task:
  type: task
  debug: false
  script:
  - define pitch <player.location.pitch.sub[90].mul[-1].mul[<element[12].div[180]>].round.add_int[1]>
  #- define names <list[F#|G|G#|A|A#|B|B#|C|C#|D|D#|E|F|F#|G|G#|A|A#|C|C#|D|D#|F|F|F#]>
  - define names <list[F#|G|G#|A|A#|B|C|C#|D|D#|E|F|F#]>
  #- title "subtitle:<[names].get[<[pitch]>]> / <[names].get[<[pitch].add[12]>]>" stay:1s fade_in:0 fade_out:0
  - title subtitle:<[names].get[<[pitch]>]> stay:1s fade_in:0 fade_out:0

# ♪ ♫ Source: https://docs.google.com/spreadsheets/d/1DkJoTy4-oJKPDha14fLnLF62yWzFIjOerxNW35yhuNU
note_color:
  type: procedure
  debug: false
  definitions: note
  script:
  - define pitch <element[2].power[<[note].div[24]>]>
  - define red <element[<element[<[pitch].add[<element[0].div[3]>]>].mul[2].mul[<util.pi>].sin.mul[0.65].add[0.35]>].max[0].mul[255].before[.]>
  - define green <element[<element[<[pitch].add[<element[1].div[3]>]>].mul[2].mul[<util.pi>].sin.mul[0.65].add[0.35]>].max[0].mul[255].before[.]>
  - define blue <element[<element[<[pitch].add[<element[2].div[3]>]>].mul[2].mul[<util.pi>].sin.mul[0.65].add[0.35]>].max[0].mul[255].before[.]>
  - determine <color[<[red]>,<[green]>,<[blue]>]>

instrument_task:
  type: task
  debug: false
  definitions: item|click
  script:
  - if !<[item].has_flag[sound]||false> || <player.open_inventory.inventory_type> != CRAFTING || <player.has_flag[instrument_cooldown]||false>:
    - stop
  - flag player instrument_cooldown expire:1t
  - define pitch <player.location.pitch.sub[90].mul[-1].mul[<element[12].div[180]>].round>
  - if <[click]> == right:
    - define pitch:+:12
  - run play_note_task def:<[pitch]>|2|<[item].flag[sound]>|<[item].flag[custom]>|<player.location.above[2]>|0.5
  - determine passively cancelled

play_note_task:
  type: task
  debug: false
  definitions: note|volume|sound|custom|location|offset
  script:
    - define pitch <element[2].power[<element[<[note].sub_int[12]>].div[12]>]>
    - if <[custom]||false>:
      - playsound <[location]> sound:<[sound]> volume:<[volume]> pitch:<[pitch]> sound_category:records custom
    - else:
      - playsound <[location]> sound:<[sound]> volume:<[volume]> pitch:<[pitch]> sound_category:records
    - if <[offset]||0> != 0:
      - define location <[location].add[<util.random.decimal[<[offset].mul[-1]>].to[<[offset]>]>,0,<util.random.decimal[<[offset].mul[-1]>].to[<[offset]>]>]>
    - playeffect effect:NOTE at:<[location]> offset:<[pitch]> quantity:0 data:1