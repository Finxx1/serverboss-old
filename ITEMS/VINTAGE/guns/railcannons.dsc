electricrailcannon:
  type: item
  material: diamond_horse_armor
  display name: <element[Electric Railcannon].color[#40C0FF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374201
  lore:
  - <element[CrapowsZh!].color[#206080]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

maliciousrailcannon:
  type: item
  material: diamond_horse_armor
  display name: <element[Malicious Railcannon].color[#FF4020]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374203
  lore:
  - <element[CraBOOwmsZh!].color[#802010]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

screwdriverrailcannon:
  type: item
  material: diamond_horse_armor
  display name: <element[Screwdriver Railcannon].color[#40FF40]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374202
  lore:
  - <element[Cratzzzzzzzzzzzzzzzzzzzzzzzzzzzrrrzzzzzzzzzzthh!].color[#208020]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

quantumrailcannon:
  type: item
  material: diamond_horse_armor
  display name: <element[Positive Quantum Railcannon].color[#101010]>
  mechanisms:
    unbreakable: true
    hides: all
  lore:
  - <element[oh shit oh no].color[#080808]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

antiquantumrailcannon:
  type: item
  material: diamond_horse_armor
  display name: <element[Negative Quantum Railcannon].color[#FFFFFF]>
  mechanisms:
    unbreakable: true
    hides: all
  lore:
  - <element[oh shit oh no].color[#808080]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

quantumrailcannon2:
  type: item
  material: diamond_horse_armor
  display name: <element[Duplex Quantum Railcannon].color_gradient[from=#101010;to=#FFFFFF]>
  mechanisms:
    unbreakable: true
    hides: all
  lore:
  - <element[oh shit oh no].color_gradient[from=#080808;to=#808080]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

railtriggers:
  debug: false
  type: world
  events:
    on player left clicks block with:electricrailcannon:
    - determine cancelled passively
    - run erail def:<player>
    on player left clicks block with:maliciousrailcannon:
    - determine cancelled passively
    - run mrail def:<player>
    on player left clicks block with:screwdriverrailcannon:
    - determine cancelled passively
    - if <player.has_flag[rgcooldown]>:
      - stop
    - shoot drill origin:<player.eye_location> speed:4 shooter:<player> spread:0 save:railed
    - define screw <entry[railed].shot_entities.get[1]>
    - run srail def:<[screw]>|<player>
    on player left clicks block with:quantumrailcannon:
    - determine cancelled passively
    - run qrail def:<player>
    on player left clicks block with:quantumrailcannon2:
    - determine cancelled passively
    - run qrail def:<player>
    on player right clicks block with:quantumrailcannon2:
    - determine cancelled passively
    - run qrail2 def:<player>
    on player left clicks block with:antiquantumrailcannon:
    - determine cancelled passively
    - run qrail2 def:<player>


erail:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[rgcooldown]>:
      - stop
    - flag <[mgk_player]> rgcooldown expire:10s
    - itemcooldown diamond_horse_armor duration:10s	
    - define aimtarg <[mgk_player].eye_location.ray_trace[range=80;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.5]>
    - define posline <[mgk_player].eye_location.points_between[<[aimtarg]>].distance[0.5]>
    - define prenderdist <[mgk_player].eye_location.distance[<[aimtarg]>].add[5]>
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - foreach <[posline]>:
      - playeffect effect:redstone special_data:1|<color[#80FFFF]> quantity:3 at:<[value]> offset:0.01 visibility:<[prenderdist]>
      - playeffect effect:magic_crit quantity:2 at:<[value]> offset:0.5 visibility:<[prenderdist]>
      - define hittemp <[value].find_entities.within[1].exclude[<[mgk_player]>].get[1]||0>
      - if <[hittemp].script.name||0> == coin:
        - define targloc <[hittemp].location.find_entities.within[25].exclude[<[hittemp]>].exclude[<[mgk_player]>].get[1].eye_location>
        - look <[hittemp]> <[targloc]>
        - define posyaw <[hittemp].location.direction[<[targloc]>].yaw||0>
        - define targvec <[hittemp].location.sub[<[targloc]>].direction.vector>
        - define dYd <[hittemp].location.y.sub[<[targloc].y>].mul[-1]>
        - define dyAw <[hittemp].location.with_y[0].distance[<[targloc].with_y[0]>]>
        - define pospitch <[dyAw].abs.mul[-1].div[<[dYd].abs>].atan.to_degrees.add[90].mul[<[dYd].div[<[dYd].abs>]>].mul[-1]>
        - run erailricochet def:<[mgk_player]>|<[hittemp].location>|<[pospitch]>|<[posyaw]>|<element[1]>|<[hittemp]>
        - foreach stop
      - hurt <[hittemp]> 35
#      - adjust <[hittemp]> no_damage_duration:2t
      - run mgk_chainlightning def:<[mgk_player]>|<[hittemp]>|<element[10]>
    #- playeffect effect:redstone special_data:2|<color[#800000]> quantity:120 at:<[aimtarg]> offset:1 visibility:<[prenderdist]>
    #- playeffect effect:smoke quantity:120 at:<[aimtarg]> offset:2.5 visibility:<[prenderdist]>
    - playsound <[mgk_player].location> sound:custom.lightning_charge pitch:0 volume:2 custom
    - playsound <[mgk_player].location> sound:custom.lightning_charge pitch:1 volume:2 custom
    - playsound <[mgk_player].location> sound:custom.lightning_charge pitch:2 volume:2 custom
    - wait 10s
    - playsound <[mgk_player].location> sound:custom.lightning_discharge pitch:2 volume:2 custom
    - playsound <[mgk_player].location> sound:custom.lightning_discharge pitch:1 volume:2 custom
    - playsound <[mgk_player].location> sound:custom.lightning_discharge pitch:0 volume:2 custom

erailricochet:
  debug: false
  definitions: mgk_player|pose|ppitch|pyaw|chit|coinhit
  type: task
  script:
    - playsound sound:custom.lightning_discharge at:<[pose]> pitch:2 volume:2 custom
    - playsound sound:entity_arrow_hit_player at:<[pose]> volume:2 pitch:0
    - playsound sound:entity_arrow_hit_player at:<[pose]> volume:2 pitch:1
    - playsound sound:entity_arrow_hit_player at:<[pose]> volume:2 pitch:2
    - playeffect effect:flash quantity:0 at:<[pose]> offset:0 visibility:100
    - wait 1t
    - remove <[coinhit]>
    - define aimtarg <[pose].with_yaw[<[pyaw]>].with_pitch[<[ppitch]>].ray_trace[range=50;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.5]>
    - define posline <[pose].points_between[<[aimtarg]>].distance[0.5]>
    - define prenderdist <[mgk_player].eye_location.distance[<[aimtarg]>].add[5]>
    - define lookvec <[pose].with_yaw[<[pyaw]>].with_pitch[<[ppitch]>].direction.vector>
    - define confirmhit 0
    - foreach <[posline]>:
      - playeffect effect:redstone special_data:1|<color[#80FFFF]> quantity:3 at:<[value]> offset:0.01 visibility:<[prenderdist]>
      - playeffect effect:magic_crit quantity:2 at:<[value]> offset:0.5 visibility:<[prenderdist]>
      - define hittemp <[value].find_entities.within[1].exclude[<[mgk_player]>].exclude[<[coinhit]>].get[1]||0>
      - if <[hittemp].script.name||0> == coin:
        - define targloc <[hittemp].location.find_entities.within[25].exclude[<[hittemp]>].exclude[<[mgk_player]>].exclude[<[coinhit]>].get[1].eye_location>
        - define targvec <[hittemp].location.sub[<[targloc]>].direction.vector>
        - define posyaw <[hittemp].location.direction[<[targloc]>].yaw||0>
        - define dYd <[hittemp].location.y.sub[<[targloc].y>].mul[-1]>
        - define dyAw <[hittemp].location.with_y[0].distance[<[targloc].with_y[0]>]>
        - define pospitch <[dyAw].abs.mul[-1].div[<[dYd].abs>].atan.to_degrees.add[90].mul[<[dYd].div[<[dYd].abs>]>].mul[-1]>
        - run erailricochet def:<[mgk_player]>|<[hittemp].location>|<[pospitch]>|<[posyaw]>|<[chit].add[1]>|<[hittemp]>
        - stop
      - flag <[mgk_player]> stylestatus:<context.projectile.shooter.flag[stylestatus].add[<element[75].mul[<[chit].mul[2]>]>]>
      - define confirmhit 1
      - hurt <[hittemp]> <element[35].add[<[chit].mul[7]>]>
      - adjust <[hittemp]> no_damage_duration:2t
      - run mgk_chainlightning def:<[mgk_player]>|<[hittemp]>|<element[10].add[<[chit].mul[3]>]>
    - if <[confirmhit]> == 1:
      - if <[chit]> > 1:
        - narrate <element[+ ].italicize.bold.color[#FFFFFF]><element[ULTRA].italicize.bold.color[#FF00FF]><element[RICOSHOT ].italicize.bold.color[#00FFFF]><element[x<[chit]>].italicize.bold.color[#00FFFF]> targets:<[mgk_player]>
      - else:
        - narrate <element[+ ].italicize.bold.color[#FFFFFF]><element[ULTRA].italicize.bold.color[#FF00FF]><element[RICOSHOT].italicize.bold.color[#00FFFF]> targets:<context.projectile.shooter>

mrail:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[rgcooldown]>:
      - stop
    - flag <[mgk_player]> rgcooldown expire:10s
    - itemcooldown diamond_horse_armor duration:10s	
    - define aimtarg <[mgk_player].eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;entities=*;ignore=<[mgk_player]>;raysize=0.5]>
    - define posline <[mgk_player].eye_location.points_between[<[aimtarg]>].distance[0.5]>
    - define prenderdist <[mgk_player].eye_location.distance[<[aimtarg]>].add[5]>
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - foreach <[posline]>:
      - playeffect effect:redstone special_data:1|<color[#FFC060]> quantity:3 at:<[value]> offset:0.01 visibility:<[prenderdist]>
      - playeffect effect:flame quantity:2 at:<[value]> offset:0.5 visibility:<[prenderdist]>
    #- playsound <[mgk_player].location> sound:custom.lightning_charge pitch:2 volume:1 custom
    - playsound <[mgk_player].location> sound:entity_wither_spawn pitch:2 volume:2
    - playsound <[mgk_player].location> sound:entity_evoker_prepare_summon pitch:1 volume:2
    - foreach <[aimtarg].find_entities.within[4]>:
      - burn <[value]> 6s
    - explode <[aimtarg]> power:4

srail:
  debug: false
  definitions: screw|mgk_player
  type: task
  script:
    - flag <[mgk_player]> rgcooldown expire:10s
    - itemcooldown diamond_horse_armor duration:10s
    - while <[screw].is_spawned>:
      - playeffect effect:redstone special_data:1.5|<color[#60FF60]> quantity:3 at:<[screw].location> offset:0.125 visibility:100
      - wait 1t

qrail:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[rgcooldown]>:
      - stop
    - flag <[mgk_player]> rgcooldown expire:16s
    - itemcooldown diamond_horse_armor duration:16s	
    - define aimtarg <[mgk_player].eye_location.ray_trace[range=25;return=precise;default=air;nonsolids=false;entities=*;ignore=<[mgk_player]>;raysize=0.5].forward[2]>
    - define posline <[mgk_player].eye_location.points_between[<[aimtarg]>].distance[0.5]>
    - define prenderdist <[mgk_player].eye_location.distance[<[aimtarg]>].add[5]>
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - foreach <[posline]>:
      - playeffect effect:redstone special_data:1|<color[#000000]> quantity:1 at:<[value]> offset:0 visibility:<[prenderdist]>
    #- playsound <[mgk_player].location> sound:custom.lightning_charge pitch:2 volume:1 custom
    - playsound <[mgk_player].location> sound:entity_wither_spawn pitch:0 volume:2
    - playsound <[mgk_player].location> sound:block_portal_travel pitch:0 volume:2
    - playsound <[mgk_player].location> sound:entity_evoker_prepare_summon pitch:0 volume:2
    - repeat 200:
      - playeffect effect:redstone special_data:4|<color[#000000]> quantity:60 at:<[aimtarg]> offset:0.5 visibility:100
      - foreach <[aimtarg].find_entities.within[24].exclude[<[mgk_player]>]>:
        - adjust <[value]> velocity:<[value].velocity.mul[0.9].add[<[aimtarg].sub[<[value].eye_location>].normalize.div[<[value].eye_location.distance[<[aimtarg]>].power[2].div[3].add[1]>]>]>]>
        - if <[value].eye_location.distance[<[aimtarg]>]> < 1.5:
          - if <[value].health> <= 5:
            - remove <[value]>
          - else:
            - hurt <[value]> 5 source:VOID
          - if !<[value].is_living>:
            - remove <[value]>
      - wait 1t

qrail2:
  debug: false
  definitions: mgk_player
  type: task
  script:
    - if <[mgk_player].has_flag[rgcooldown]>:
      - stop
    - flag <[mgk_player]> rgcooldown expire:16s
    - itemcooldown diamond_horse_armor duration:16s	
    - define aimtarg <[mgk_player].eye_location.ray_trace[range=25;return=precise;default=air;nonsolids=false;entities=*;ignore=<[mgk_player]>;raysize=0.5].forward[2]>
    - define posline <[mgk_player].eye_location.points_between[<[aimtarg]>].distance[0.5]>
    - define prenderdist <[mgk_player].eye_location.distance[<[aimtarg]>].add[5]>
    - define lookvec <[mgk_player].eye_location.direction.vector>
    - foreach <[posline]>:
      - playeffect effect:redstone special_data:1|<color[#FFFFFF]> quantity:1 at:<[value]> offset:0 visibility:<[prenderdist]>
    #- playsound <[mgk_player].location> sound:custom.lightning_charge pitch:2 volume:1 custom
    - playsound <[mgk_player].location> sound:entity_wither_spawn pitch:0 volume:2
    - playsound <[mgk_player].location> sound:block_portal_travel pitch:0 volume:2
    - playsound <[mgk_player].location> sound:entity_evoker_prepare_summon pitch:0 volume:2
    - light <[aimtarg]> 15 duration:10s
    - repeat 200:
      - playeffect effect:redstone special_data:4|<color[#FFFFFF]> quantity:60 at:<[aimtarg]> offset:0.5 visibility:100
      - foreach <[aimtarg].find_entities.within[24].exclude[<[mgk_player]>]>:
        - adjust <[value]> velocity:<[value].velocity.mul[0.9].add[<[aimtarg].sub[<[value].eye_location>].normalize.div[<[value].eye_location.distance[<[aimtarg]>].power[2].div[3].add[1]>].mul[-1]>]>]>
      - wait 1t
    - repeat 15:
      - light <[aimtarg]> <element[15].sub[<[value]>]> duration:5t
      - wait 5t