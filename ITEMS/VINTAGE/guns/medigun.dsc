medigun:
  type: item
  material: iron_horse_armor
  display name: <element[Medigun].color[#C04040]>
  mechanisms:
    unbreakable: true
    hides: all
  lore:
  - <element[Vwoooooooom... :)].color[#602020]>
  - 
  - <element[VINTAGE].color[#404878].bold>

mediguntriggers:
  type: world
  events:
    on player right clicks block with:medigun:
    - if !<player.has_flag[mediusing]>:
      - determine cancelled passively
      - define demtarget <player.precise_target[7]||0>
      - if <[demtarget]> != 0:
        - flag <player> mediusing
        - playsound <player.location> sound:custom.h2h_ubercharge pitch:1 volume:10 custom
        - adjust <player> speed:<[demtarget].speed>
        - while <player.location.distance[<[demtarget].location>]> < 7 && !<player.has_flag[stopheal]>:
          - foreach <player.eye_location.right[0.4].below[0.4].points_between[<[demtarget].location.add[0,1,0]>].distance[0.2]>:
            - playeffect effect:redstone quantity:2 special_data:0.8|red at:<[value]> offset:0.05
          - if <[demtarget].health> < <[demtarget].health_max>:
            - heal <[demtarget]> 0.15
          - else if <[demtarget].absorption_health> < 9:
            - adjust <[demtarget]> absorption_health:<[demtarget].absorption_health.add[0.1]>
          - wait 1t
        - flag <player> mediusing:!
    - else:
      - playsound <player.location> sound:block_note_block_bass pitch:0 volume:4
      - flag <player> stopheal expire:1t
      - flag <player> mediusing:!