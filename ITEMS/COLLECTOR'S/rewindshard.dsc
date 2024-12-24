rewindshard:
  type: item
  material: diamond
  display name: <element[Rewind Shard].unescaped.color_gradient[from=#40FF80;to=#40FF40]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375242
  lore:
  - <element[Outta time!].color_gradient[from=#208040;to=#208020]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

rewindshardtriggers:
  type: world
  debug: false
  events:
    on tick:
    - foreach <server.online_players||0>:
      - if <[value].inventory.contains_any[rewindshard]> && !<[value].has_flag[rewinding]>:
        - flag <[value]> rewindpath:->:<[value].location>
        - if <[value].flag[rewindpath].size> > 100:
          - flag <[value]> rewindpath:<-:<[value].flag[rewindpath].first>
    on player right clicks block with:rewindshard:
    - if <player.has_flag[rewindcooldown]>:
      - stop
    - flag <player> rewindcooldown expire:20t
    - itemcooldown diamond duration:20t
    - if <player.has_flag[rewinding]>:
      - flag <player> rewinding:!
      - stop
    - flag <player> rewinding
    - playsound at:<player.eye_location> sound:block_respawn_anchor_deplete pitch:1 volume:2
    - playsound at:<player.eye_location> sound:block_respawn_anchor_deplete pitch:0 volume:2
    - define rquip <list[It's Rewind Time!|Outta Time!|Freeze-Frame, Record Scratch!|CTRL+Z].random>
    - foreach <player.flag[rewindpath].reverse>:
      - playeffect at:<[value].add[0,1,0]> effect:redstone special_data:2|<color[#40FF80]> offset:0.125 quantity:16 visibility:100
      - teleport <player> <[value]>
      - title title:<element[&lt&lt&lt].unescaped.bold.italicize.color_gradient[from=#40FF80;to=#40FF40]> subtitle:<element[<[rquip]>].bold.italicize.color_gradient[from=#40FF80;to=#40FF40]> targets:<player>  fade_in:0t stay:5t fade_out:5t
      - flag <player> rewindpath:<-:<[value]>
      - if !<player.has_flag[rewinding]>:
        - flag <player> rewindpath:!
        - stop
      - wait 1t
    - flag <player> rewinding:!

replayshard:
  type: item
  material: diamond
  display name: <element[Replay Shard].unescaped.color_gradient[from=#C060FF;to=#6060FF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375246
  lore:
  - <element[It's like my iPod's stuck on replay!].color_gradient[from=#603080;to=#303080]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

replayshardtriggers:
  type: world
  debug: false
  events:
    on tick:
    - foreach <server.online_players||0>:
      - if <[value].inventory.contains_any[replayshard]> && !<[value].has_flag[replaying]>:
        - flag <[value]> replaypath:->:<[value].location>
        - if <[value].flag[replaypath].size> > 100:
          - flag <[value]> replaypath:<-:<[value].flag[replaypath].first>
    on player right clicks block with:replayshard:
    - if <player.has_flag[rewindcooldown]>:
      - stop
    - flag <player> rewindcooldown expire:20t
    - itemcooldown diamond duration:20t
    - if <player.has_flag[replaying]>:
      - flag <player> replaying:!
      - stop
    - flag <player> replaying
    - playsound at:<player.eye_location> sound:block_respawn_anchor_set_spawn pitch:1 volume:2
    - playsound at:<player.eye_location> sound:block_respawn_anchor_set_spawn pitch:0 volume:2
    - define offset <player.location.sub[<player.flag[replaypath].first>]>
    - define rquip <list[It's like my iPod's stuck on replay!|One more time! I'm back with a new rhyme!|P o l y r y t h m i c].random>
    - foreach <player.flag[replaypath]>:
      - if <[value].add[<[offset]>].block.material.is_solid>:
        - playsound at:<[value].add[0,1,0].add[<[offset]>]> sound:custom.classic_explode pitch:2 volume:2 custom
        - playeffect at:<[value].add[0,1,0].add[<[offset]>]> effect:flash offset:0 quantity:1 visibility:100
        - flag <player> replaypath:!
        - flag <player> replaying:!
        - stop
      - playeffect at:<[value].add[0,1,0].add[<[offset]>]> effect:redstone special_data:2|<color[#8060FF]> offset:0.125 quantity:16 visibility:100
      - teleport <player> <[value].add[<[offset]>]>
      - title title:<element[⟳].unescaped.bold.italicize.color_gradient[from=#C060FF;to=#6060FF]> subtitle:<element[<[rquip]>].bold.italicize.color_gradient[from=#C060FF;to=#6060FF]> targets:<player>  fade_in:0t stay:5t fade_out:5t
      - flag <player> replaypath:<-:<[value]>
      - if !<player.has_flag[replaying]>:
        - flag <player> replaypath:!
        - stop
      - wait 1t
    - flag <player> replaying:!