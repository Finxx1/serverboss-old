displacercannon:
  type: item
  material: diamond_horse_armor
  display name: <element[XV-11382].color[#80FF00]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374206
  lore:
  - <element[Speedy thing goes in,].color[#408000]>
  - <element[Speedy thing comes out].color[#408000]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

displacetriggers:
  debug: false
  type: world
  events:
    on player left clicks block with:displacercannon:
    - determine cancelled passively
    - if <player.has_flag[l_place_f]>:
      - playsound <player.eye_location> sound:custom.reload_error pitch:2 volume:2 custom
      - stop
    - flag <player> cannonfire:left
    - run displace_l def:<player>
    on player right clicks block with:displacercannon:
    - determine cancelled passively
    - if <player.has_flag[r_place_f]>:
      - playsound <player.eye_location> sound:custom.reload_error pitch:2 volume:2 custom
      - stop
    - flag <player> cannonfire:right
    - run displace_r def:<player>

portal_l:
  debug: false
  definitions: p_shooter|l_place
  type: task
  script:
  - repeat 370:
    - playeffect effect:redstone special_data:5|<color[#FFFF00]> quantity:8 at:<[l_place]> offset:0.03 visibility:100
    - playeffect effect:redstone special_data:3|<color[#80FF00]> quantity:16 at:<[l_place]> offset:0.75 visibility:100
    - playeffect effect:redstone special_data:1|<color[#00FF00]> quantity:16 at:<[l_place]> offset:1.5 visibility:100
    - define aroundme <[l_place].find_entities.within[2]||0>
    - if <[aroundme]> != 0:
      - if <[p_shooter].has_flag[r_place_f]>:
        - foreach <[aroundme]>:
          - if <[value].has_flag[r_tele]> || <[value].entity_type> == item_frame:
            - flag <[value]> r_tele expire:5t
          - else:
            - flag <[value]> l_tele expire:5t
            - define entityvel <[value].velocity>
            - define telepitch <[value].eye_location.pitch>
            - define teleyaw <[value].eye_location.yaw>
            - define heightmogging <[value].eye_location.y.sub[<[value].location.y>]>
            - teleport <[value]> <[p_shooter].flag[r_place_f].with_yaw[<[teleyaw]>].with_pitch[<[telepitch]>].sub[0,<[heightmogging]>,0]>
            - adjust <[value]> velocity:<[entityvel]>
            - playsound <[p_shooter].flag[r_place_f]> sound:entity_lightning_bolt_thunder pitch:2 volume:2
            - playsound <[p_shooter].flag[r_place_f]> sound:custom.hand_short pitch:0 volume:2 custom
            - playsound <[p_shooter].flag[r_place_f]> sound:entity_enderman_teleport pitch:1 volume:2
            - playsound <[p_shooter].flag[r_place_f]> sound:block_portal_travel pitch:2 volume:2
    - wait 1t
  - playsound <[p_shooter].eye_location> sound:custom.lightning_discharge pitch:1 volume:2 custom
  - playsound <[p_shooter].eye_location> sound:custom.lightning_discharge pitch:0 volume:2 custom
  - playsound <[p_shooter].eye_location> sound:entity_lightning_bolt_impact pitch:0 volume:2
  - playsound <[p_shooter].eye_location> sound:custom.hand_short pitch:2 volume:2 custom
  - playsound <[p_shooter].eye_location> sound:block_piston_extend pitch:0 volume:1
  - playsound <[p_shooter].eye_location> sound:block_piston_extend pitch:0 volume:2
  - flag <[p_shooter]> l_place_f:!
  - flag <[p_shooter]> cannonfire:!

portal_r:
  debug: false
  definitions: p_shooter|r_place
  type: task
  script:
  - repeat 380:
    - playeffect effect:redstone special_data:5|<color[#00FF00]> quantity:8 at:<[r_place]> offset:0.03 visibility:100
    - playeffect effect:redstone special_data:3|<color[#80FF00]> quantity:16 at:<[r_place]> offset:0.75 visibility:100
    - playeffect effect:redstone special_data:1|<color[#FFFF00]> quantity:16 at:<[r_place]> offset:1.5 visibility:100
    - define aroundme <[r_place].find_entities.within[2]||0>
    - if <[aroundme]> != 0:
      - if <[p_shooter].has_flag[l_place_f]>:
        - foreach <[aroundme]>:
          - if <[value].has_flag[l_tele]> || <[value].entity_type> == item_frame:
            - flag <[value]> l_tele expire:5t
          - else:
            - flag <[value]> r_tele expire:5t
            - define entityvel <[value].velocity>
            - define telepitch <[value].eye_location.pitch>
            - define teleyaw <[value].eye_location.yaw>
            - define heightmogging <[value].eye_location.y.sub[<[value].location.y>]>
            - teleport <[value]> <[p_shooter].flag[l_place_f].with_yaw[<[teleyaw]>].with_pitch[<[telepitch]>].sub[0,<[heightmogging]>,0]>
            - adjust <[value]> velocity:<[entityvel]>
            - playsound <[p_shooter].flag[l_place_f]> sound:entity_lightning_bolt_thunder pitch:2 volume:2
            - playsound <[p_shooter].flag[l_place_f]> sound:custom.hand_short pitch:0 volume:2 custom
            - playsound <[p_shooter].flag[l_place_f]> sound:entity_enderman_teleport pitch:1 volume:2
            - playsound <[p_shooter].flag[l_place_f]> sound:block_portal_travel pitch:2 volume:2
    - wait 1t
  - playsound <[p_shooter].eye_location> sound:custom.lightning_discharge pitch:1 volume:2 custom
  - playsound <[p_shooter].eye_location> sound:custom.lightning_discharge pitch:0 volume:2 custom
  - playsound <[p_shooter].eye_location> sound:entity_lightning_bolt_impact pitch:0 volume:2
  - playsound <[p_shooter].eye_location> sound:custom.hand_short pitch:2 volume:2 custom
  - playsound <[p_shooter].eye_location> sound:block_piston_extend pitch:0 volume:1
  - playsound <[p_shooter].eye_location> sound:block_piston_extend pitch:0 volume:2
  - flag <[p_shooter]> r_place_f:!
  - flag <[p_shooter]> cannonfire:!

displace_l:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[displacercooldown]>:
      - stop
    - if <player.flag[cannonfire]||0> == right:
      - flag <[mgk_player]> displacercooldown expire:15s
      - itemcooldown diamond_horse_armor duration:15s	
    - else:
      - flag <[mgk_player]> displacercooldown expire:3s
      - itemcooldown diamond_horse_armor duration:3s	
    - playsound <[mgk_player].eye_location> sound:entity_lightning_bolt_thunder pitch:0 volume:2
    - playsound <[mgk_player].eye_location> sound:custom.hand_short pitch:1 volume:2 custom
    - playsound <[mgk_player].eye_location> sound:custom.bfg pitch:2 volume:2 custom
    - playsound <[mgk_player].eye_location> sound:custom.bfg pitch:1 volume:2 custom
    - playsound <[mgk_player].eye_location> sound:custom.bfg pitch:0 volume:2 custom
    - repeat 17:
      - playsound <[mgk_player].eye_location> sound:block_note_block_bit pitch:<element[1].add[<[value].div[17]>]> volume:3
      - playsound <[mgk_player].eye_location> sound:block_note_block_bit pitch:<element[0.85].add[<[value].div[15]>]> volume:3
      - wait 2t
    - wait 1t
    - define aimtarg <[mgk_player].eye_location.ray_trace[range=80;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.5].forward[2.5]>
    - define posline <[mgk_player].eye_location.points_between[<[aimtarg]>].distance[0.5]>
    - define prenderdist <[mgk_player].eye_location.distance[<[aimtarg]>].add[5]>
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - playsound <[mgk_player].eye_location> sound:entity_lightning_bolt_impact pitch:0 volume:2
    - playsound <[mgk_player].eye_location> sound:entity_lightning_bolt_thunder pitch:2 volume:2
    - playsound <[mgk_player].eye_location> sound:entity_lightning_bolt_thunder pitch:1 volume:2
    - playsound <[mgk_player].eye_location> sound:custom.lightning_charge pitch:0 volume:2 custom
    - playsound <[mgk_player].eye_location> sound:custom.lightning_charge pitch:1 volume:2 custom
    - playsound <[mgk_player].eye_location> sound:entity_wither_spawn pitch:0 volume:2
    - playsound <[mgk_player].eye_location> sound:block_portal_travel pitch:1 volume:2
    - playsound <[mgk_player].eye_location> sound:block_portal_travel pitch:0 volume:2
    - playsound <[mgk_player].eye_location> sound:entity_enderman_stare pitch:0.82 volume:2
    - playsound <[mgk_player].eye_location> sound:entity_enderman_stare pitch:0.8 volume:2
    - playsound <[mgk_player].eye_location> sound:custom.hand pitch:0 volume:2 custom
    - playsound <[mgk_player].eye_location> sound:custom.hand pitch:1 volume:2 custom
    - foreach <[posline]>:
      - playeffect effect:redstone special_data:3|<color[#80FF00]> quantity:3 at:<[value]> offset:0.01 visibility:<[prenderdist]>
      - playeffect effect:redstone special_data:2|<color[#80FF00]> quantity:4 at:<[value]> offset:0.25 visibility:<[prenderdist]>
      - playeffect effect:redstone special_data:1|<color[#80FF00]> quantity:7 at:<[value]> offset:0.7 visibility:<[prenderdist]>
      - define hittemp <[value].find_entities.within[1].exclude[<[mgk_player]>].get[1]||0>
      - if <[hittemp]> != 0:
        - hurt <[hittemp]> amount:100
        - playsound at:<[hittemp].eye_location> sound:custom.gib pitch:1 volume:3 custom
        - playsound at:<[hittemp].eye_location> sound:custom.gib pitch:0 volume:3 custom
        - run GOREBURSTPRO def:<[hittemp].location.above[1]>|0.25
        - flag <[mgk_player]> displacercooldown expire:35s
        - itemcooldown diamond_horse_armor duration:35s	
        - stop
    - flag <player> l_place_f:<[aimtarg]>
    - run portal_l def:<[mgk_player]>|<[aimtarg]>

displace_r:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[displacercooldown]>:
      - stop
    - if <player.flag[cannonfire]||0> == left:
      - flag <[mgk_player]> displacercooldown expire:15s
      - itemcooldown diamond_horse_armor duration:15s	
    - else:
      - flag <[mgk_player]> displacercooldown expire:3s
      - itemcooldown diamond_horse_armor duration:3s	
    - playsound <[mgk_player].eye_location> sound:entity_lightning_bolt_thunder pitch:0 volume:2
    - playsound <[mgk_player].eye_location> sound:custom.hand_short pitch:1 volume:2 custom
    - playsound <[mgk_player].eye_location> sound:custom.bfg pitch:2 volume:2 custom
    - playsound <[mgk_player].eye_location> sound:custom.bfg pitch:1 volume:2 custom
    - playsound <[mgk_player].eye_location> sound:custom.bfg pitch:0 volume:2 custom
    - repeat 17:
      - playsound <[mgk_player].eye_location> sound:block_note_block_pling pitch:<element[1].add[<[value].div[17]>]> volume:3
      - playsound <[mgk_player].eye_location> sound:block_note_block_pling pitch:<element[0.85].add[<[value].div[15]>]> volume:3
      - wait 2t
    - wait 1t
    - define aimtarg <[mgk_player].eye_location.ray_trace[range=80;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.5].forward[2.5]>
    - define posline <[mgk_player].eye_location.points_between[<[aimtarg]>].distance[0.5]>
    - define prenderdist <[mgk_player].eye_location.distance[<[aimtarg]>].add[5]>
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - playsound <[mgk_player].eye_location> sound:entity_lightning_bolt_impact pitch:0 volume:2
    - playsound <[mgk_player].eye_location> sound:entity_lightning_bolt_thunder pitch:2 volume:2
    - playsound <[mgk_player].eye_location> sound:entity_lightning_bolt_thunder pitch:1 volume:2
    - playsound <[mgk_player].eye_location> sound:custom.lightning_charge pitch:0 volume:2 custom
    - playsound <[mgk_player].eye_location> sound:custom.lightning_charge pitch:1 volume:2 custom
    - playsound <[mgk_player].eye_location> sound:entity_wither_spawn pitch:0 volume:2
    - playsound <[mgk_player].eye_location> sound:block_portal_travel pitch:1 volume:2
    - playsound <[mgk_player].eye_location> sound:block_portal_travel pitch:0 volume:2
    - playsound <[mgk_player].eye_location> sound:entity_enderman_stare pitch:0.82 volume:2
    - playsound <[mgk_player].eye_location> sound:entity_enderman_stare pitch:0.8 volume:2
    - playsound <[mgk_player].eye_location> sound:custom.hand pitch:0 volume:2 custom
    - playsound <[mgk_player].eye_location> sound:custom.hand pitch:1 volume:2 custom
    - foreach <[posline]>:
      - playeffect effect:redstone special_data:3|<color[#80FF00]> quantity:3 at:<[value]> offset:0.01 visibility:<[prenderdist]>
      - playeffect effect:redstone special_data:2|<color[#80FF00]> quantity:4 at:<[value]> offset:0.25 visibility:<[prenderdist]>
      - playeffect effect:redstone special_data:1|<color[#80FF00]> quantity:7 at:<[value]> offset:0.7 visibility:<[prenderdist]>
      - define hittemp <[value].find_entities.within[1].exclude[<[mgk_player]>].get[1]||0>
      - if <[hittemp]> != 0:
        - hurt <[hittemp]> amount:100
        - playsound at:<[hittemp].eye_location> sound:custom.gib pitch:1 volume:3 custom
        - playsound at:<[hittemp].eye_location> sound:custom.gib pitch:0 volume:3 custom
        - run GOREBURSTPRO def:<[hittemp].location.above[1]>|0.25
        - flag <[mgk_player]> displacercooldown expire:35s
        - itemcooldown diamond_horse_armor duration:35s	
        - stop
    - flag <player> r_place_f:<[aimtarg]>
    - run portal_r def:<[mgk_player]>|<[aimtarg]>