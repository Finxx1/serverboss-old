ffrocketlauncher:
  type: item
  material: golden_horse_armor
  display name: <element[FreezeFrame Rocket Launcher].color[#60C0C0]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374310
    hides: all
  lore:
  - <element[Kfwoos-].color[#304040]>
  - <&7>
  - <&7>
  - <&7>
  - <&7>
  - <&7>
  - <element[-h, BOOM].color[#304040]>
  - <element[VINTAGE].color[#404878].bold>

ffrocketlaunchertriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:ffrocketlauncher:
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:0 volume:2
      - playsound <player.location> sound:entity_generic_extinguish_fire pitch:0 volume:2
      - playsound <player.location> sound:entity_skeleton_hurt pitch:0 volume:2
      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:0 volume:2
      - flag <player> riflecooldown expire:15t
      - itemcooldown golden_horse_armor duration:15t
      - shoot freezerocket origin:<player.eye_location.right[0.4].below[0.4]> speed:3 script:ffrocketlauncherhit shooter:<player> spread:0 gravity:0 save:sussybaka
      - define coinproj9 <entry[sussybaka].shot_entities.get[1]>
      - run rocketfreezetask def:<[coinproj9]>|<player>
      - wait 2t
    on player left clicks block with:ffrocketlauncher:
    - playsound <player.location> sound:block_note_block_didgeridoo pitch:0 volume:1
    - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
    - if <player.has_flag[rocketsfrozen]>:
      - flag <player> rocketsfrozen:!
    - else:
      - flag <player> rocketsfrozen
    on tick every:2:
    - foreach <server.online_players>:
      - if <[value].has_flag[rocketsfrozen]>:
        - if <[value].flag[freezeframetime]||0> > 0:
          - flag <[value]> freezeframetime:<[value].flag[freezeframetime].sub[0.1]||0>
          - title "title:" "subtitle:<element[<[value].flag[freezeframetime]>].color[#60FFC0].bold>" targets:<[value]> fade_in:0t fade_out:1s stay:1t
        - else:
          - flag <[value]> rocketsfrozen:!
      - else if <[value].flag[freezeframetime]||0> < 5:
        - flag <[value]> freezeframetime:<[value].flag[freezeframetime].add[0.1]||0>
        - title "title:" "subtitle:<element[<[value].flag[freezeframetime]>].color[#60FFC0].bold>" targets:<[value]> fade_in:0t fade_out:1s stay:1t


ffrocketlauncherhit:
  debug: false
  type: task
  script:
  - flag <[hit_entities]> beingshot expire:1s
  - adjust <[hit_entities]> max_no_damage_duration:1t
  - foreach <[hit_entities]>:
    - explode <[value].location> power:3
  - wait 2s
  - foreach <[hit_entities]>:
    - if !<[value].has_flag[beingshot]>:
      - adjust <[value]> max_no_damage_duration:20t

srsrocketlauncher:
  type: item
  material: golden_horse_armor
  display name: <element[S.R.S. Rocket Launcher].color[#80FF80]>
  mechanisms:
    custom_model_data: 13374311
    unbreakable: true
    hides: all
  lore:
  - <element[BALL].color[#408040]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

srsrocketlaunchertriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:srsrocketlauncher:
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:0 volume:2
      - playsound <player.location> sound:entity_generic_extinguish_fire pitch:0 volume:2
      - playsound <player.location> sound:entity_skeleton_hurt pitch:0 volume:2
      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:0 volume:2
      - flag <player> riflecooldown expire:20t
      - itemcooldown golden_horse_armor duration:20t
      - shoot freezerocket origin:<player.eye_location.right[0.4].below[0.4]> speed:2.5 script:ffrocketlauncherhit shooter:<player> spread:0 gravity:0 save:sussybaka
      - define coinproj9 <entry[sussybaka].shot_entities.get[1]>
      - run rocketfreezetask def:<[coinproj9]>|<player>
      - wait 2t
    on player left clicks block with:srsrocketlauncher:
    - if <player.has_flag[riflecooldown]>:
      - stop
    - if !<player.has_flag[chargingball]>:
      - flag <player> chargingball:0
      - playsound <player.eye_location> sound:block_dirt_break pitch:0 volume:1
      - playsound <player.eye_location> sound:block_sand_break pitch:0 volume:1
      - playsound <player.eye_location> sound:block_stone_break pitch:0 volume:1
      - while !<player.has_flag[launchedball]>:
        - if <player.flag[chargingball]> < 100:
          - flag <player> chargingball:<player.flag[chargingball].add[1]>
        - random:
          - playsound <player.eye_location> sound:block_dirt_hit pitch:0 volume:1
          - playsound <player.eye_location> sound:block_sand_hit pitch:0 volume:1
          - playsound <player.eye_location> sound:block_stone_hit pitch:0 volume:1
        - if <player.flag[chargingball]> == 100 && <[loop_index].mod[3]> == 0:
          - playsound <player.eye_location> sound:block_note_block_pling pitch:2 volume:1
        - playeffect effect:block_crack quantity:16 special_data:coarse_dirt at:<player.eye_location.right[0.4].below[0.4]> offset:0.1 velocity:<random_offset[1,1,1]>
        - if <player.flag[chargingball]> < 100:
          - title "title:" "subtitle:<element[&pipe].unescaped.repeat[<player.flag[chargingball]>].color[#80FF80]><element[&pipe].unescaped.repeat[<element[100].sub[<player.flag[chargingball]>]>].color[#808080]>" fade_in:0 stay:2t fade_out:5t targets:<player>
        - else:
          - title "title:" "subtitle:<element[&pipe].unescaped.repeat[100].color[#008000]>" fade_in:0 stay:2t fade_out:5t targets:<player>
        - if <[loop_index]> > 150:
          - flag <player> chargingball:!
          - explode power:3 <player.location>
          - playsound <player.location> sound:entity_wither_break_block pitch:0 volume:1
          - while stop
        - wait 1t
    - else:
      - flag <player> riflecooldown expire:140t
      - itemcooldown golden_horse_armor duration:140t
      - playeffect effect:block_crack quantity:16 special_data:coarse_dirt at:<player.eye_location.right[0.4].below[0.4]> offset:0.1 velocity:<random_offset[1,1,1]>
      - spawn falling_block[fallingblock_type=coarse_dirt;gravity=false] <player.eye_location.right[0.4].below[0.4]> save:dirtsave1
      - define earthball <entry[dirtsave1].spawned_entity>
      - flag <[earthball]> unfalling
      - define lookvec <player.eye_location.direction.vector>
      - playsound <player.location> sound:entity_wither_break_block pitch:0 volume:1
      - define charge <player.flag[chargingball]>
      - flag <player> chargingball:!
      - flag <player> launchedball expire:2t
      - adjust <[earthball]> gravity:true
      - adjust <[earthball]> velocity:<[lookvec].mul[<[charge].div[35]>].add[0,0.25,0]>
      - playeffect effect:block_crack quantity:128 special_data:coarse_dirt at:<[earthball].location> offset:0.7 velocity:<random_offset[1,1,1]>
      - playsound at:<[earthball].location> sound:block_gravel_break pitch:0 volume:2
      - playsound at:<[earthball].location> sound:block_stone_break pitch:0 volume:2
      - playsound at:<[earthball].location> sound:block_sand_break pitch:0 volume:2
      - playsound at:<[earthball].location> sound:entity_zombie_attack_wooden_door pitch:0 volume:2
      - run earthscript2 def:<[earthball]>|<player>|<[charge]>
      