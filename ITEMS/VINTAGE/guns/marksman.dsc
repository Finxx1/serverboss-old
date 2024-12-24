piercer:
  type: item
  material: iron_horse_armor
  display name: <element[Piercer].color[#80C0FF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 1374200
  lore:
  - <element[KaPOWW!].color[#406080]>
  - 
  - <element[VINTAGE].color[#404878].bold>

marksman:
  type: item
  material: iron_horse_armor
  display name: <element[Marksman].color[#80FF80]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 1374201
  lore:
  - <element[Re-kapow!].color[#408040]>
  - 
  - <element[VINTAGE].color[#404878].bold>

sharpshooter:
  type: item
  material: iron_horse_armor
  display name: <element[Sharpshooter].color[#FF6060]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 1374202
  lore:
  - <element[Kapow! Kapow?].color[#803030]>
  - 
  - <element[VINTAGE].color[#404878].bold>

marksmantriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:marksman:
    - determine cancelled passively
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:2 volume:1
      - flag <player> riflecooldown expire:6t
      - itemcooldown iron_horse_armor duration:6t
      - shoot marksmanbullet origin:<player.eye_location.right[0.4].below[0.4]> speed:3 shooter:<player> spread:0.5 save:bampow
      - define bampowproj <entry[bampow].shot_entities.get[1]>
      - flag <[bampowproj]> firepower:1
    on player left clicks block with:marksman:
    - determine cancelled passively
    - if !<player.has_flag[riflecooldown]>:
      - if <player.flag[coins]> == 0:
        - playsound <player.location> sound:block_note_block_bass pitch:0 volume:1
        - title "title:" "subtitle:<element[✗].color[#802020].bold>" targets:<player> fade_in:0t fade_out:1s stay:1t
        - stop
      - playsound <player.location> sound:entity_arrow_hit_player pitch:2 volume:1
      - flag <player> riflecooldown expire:2t
      - itemcooldown iron_horse_armor duration:2t
      - shoot coin origin:<player.eye_location.right[0.4].below[0.6]> height:6 shooter:<player> spread:0 gravity:0.02 save:susvented
      - define coinproj <entry[susvented].shot_entities.get[1]>
      - run coinprojhandlertask def:<[coinproj]>|<player>
      - flag <player> coins:<player.flag[coins].sub[1]>
      #- if <player.flag[coins]> == 0:
      #  - playsound <player.location> sound:block_note_block_bass pitch:0 volume:1
      #  - title "title:" "subtitle:<element[0].color[#802020].bold>" targets:<player> fade_in:0t fade_out:1s stay:1t
      #- else:
        #- title "title:" "subtitle:<element[<player.flag[coins]>].color[#80FF80].bold>" targets:<player> fade_in:0t fade_out:1s stay:1t
    on delta time secondly every:5:
    - foreach <server.online_players>:
      - define saybool <[value].item_in_hand.script.name.is[=].to[marksman]||false>
      - if !<[value].has_flag[coins]>:
        - flag <[value]> coins:4
      - if <[value].flag[coins]> < 3:
        - flag <[value]> coins:<[value].flag[coins].add[1]>
        - playsound at:<[value].location> sound:entity_arrow_hit_player pitch:0 volume:1
        - if !<[saybool]>:
          - title "title:" "subtitle:<element[.].repeat[<[value].flag[coins]>].color[#C0C040].bold>" targets:<[value]> fade_in:0 fade_out:5t stay:2t
      - else if <[value].flag[coins]> < 4:
        - flag <[value]> coins:4
        - playsound at:<[value].location> sound:entity_arrow_hit_player pitch:0 volume:1
        - playsound at:<[value].location> sound:entity_player_levelup pitch:0 volume:1
        - if !<[saybool]>:
          - title "title:" "subtitle:<element[.].repeat[<[value].flag[coins]>].color[#20C000].bold>" targets:<[value]> fade_in:0 fade_out:5t stay:2t
    on tick:
    - foreach <server.online_players>:
      - if <[value].item_in_hand.script.name||0> == marksman && <[value].flag[coins]> > 0:
        - if <[value].flag[coins]> < 4:
          - title "title:" "subtitle:<element[.].repeat[<[value].flag[coins]>].color[#C0C040].bold>" targets:<[value]> fade_in:0 fade_out:5t stay:2t
        - else:
          - title "title:" "subtitle:<element[.].repeat[<[value].flag[coins]>].color[#20C000].bold>" targets:<[value]> fade_in:0 fade_out:5t stay:2t

piercertriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:piercer:
    - determine cancelled passively
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:2 volume:1
      - flag <player> riflecooldown expire:6t
      - itemcooldown iron_horse_armor duration:6t
      - shoot marksmanbullet origin:<player.eye_location.right[0.4].below[0.4]> speed:3 shooter:<player> spread:0.5 save:bampow2
      - define bampowproj <entry[bampow2].shot_entities.get[1]>
      - flag <[bampowproj]> firepower:1
    on player left clicks block with:piercer:
    - determine cancelled passively
    - if <player.has_flag[riflecooldown]>:
      - stop
    - if !<player.has_flag[piercercharging]>:
      - flag <player> piercercharging:0
      - while <player.has_flag[piercercharging]>:
        - if <player.flag[piercercharging]> < 30:
          - flag <player> piercercharging:<player.flag[piercercharging].add[1]>
        - if <player.flag[piercercharging]> < 30:
          - title "title:" "subtitle:<element[&pipe].unescaped.repeat[<player.flag[piercercharging]>].bold.color[#80C0FF]><element[&pipe].unescaped.repeat[<element[30].sub[<player.flag[piercercharging]>]>].bold.color[#808080]>" fade_in:0 stay:2t fade_out:5t targets:<player>
        - else:
          - title "title:" "subtitle:<element[&pipe].unescaped.repeat[30].color[#B8D8FF].bold>" fade_in:0 stay:2t fade_out:5t targets:<player>
        - if <player.flag[piercercharging]> == 30 && <[loop_index].mod[3]> == 0:
          - playsound <player.eye_location> sound:block_note_block_pling pitch:2 volume:1
        - if <[loop_index]> > 80:
          - flag <player> piercercharging:!
        - wait 1t
    - else:
      - if <player.flag[piercercharging]> < 30:
        - stop
      - flag <player> piercercharging:!
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:1.5 volume:1
      - playsound <player.location> sound:entity_lightning_bolt_thunder pitch:2 volume:1
      - playsound <player.location> sound:entity_skeleton_hurt pitch:1.5 volume:1
      - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:1.5 volume:1
      - flag <player> riflecooldown expire:50t
      - itemcooldown iron_horse_armor duration:50t
      - shoot marksmanbullet origin:<player.eye_location.right[0.4].below[0.4]> speed:4 shooter:<player> spread:0 save:bampow3
      - define bampowproj <entry[bampow3].shot_entities.get[1]>
      - flag <[bampowproj]> firepower:3
      - flag <[bampowproj]> piercing:5


sharpshootertriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:sharpshooter:
    - determine cancelled passively
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:2 volume:1
      - flag <player> riflecooldown expire:6t
      - itemcooldown iron_horse_armor duration:6t
      - shoot marksmanbullet origin:<player.eye_location.right[0.4].below[0.4]> speed:3 shooter:<player> spread:0.5 save:bampow2
      - define bampowproj <entry[bampow2].shot_entities.get[1]>
      - flag <[bampowproj]> firepower:1
      - if <player.item_in_hand.script.name||0> == sharpshooter && <player.item_in_offhand.script.name||0> == sharpshooter:
        - wait 4t
        - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:1
        - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
        - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:2 volume:1
        - shoot marksmanbullet origin:<player.eye_location.right[-0.4].below[0.4]> speed:3 shooter:<player> spread:0.5 save:bampow2
        - define bampowproj <entry[bampow2].shot_entities.get[1]>
        - flag <[bampowproj]> firepower:1
    on player left clicks block with:sharpshooter:
    - determine cancelled passively
    - if !<player.has_flag[sharpshootercharges]>:
      - flag player sharpshootercharges:3
    - if <player.flag[sharpshootercharges]> < 1:
      - playsound <player.location> sound:block_note_block_bass pitch:0 volume:1
      - title "title:<element[✗].color[#802020].bold> <element[✗].color[#802020].bold> <element[✗].color[#802020].bold>" "subtitle:" targets:<player> fade_in:0t fade_out:1s stay:1t
      - stop
    - if <player.has_flag[riflecooldown]>:
      - stop
    - if !<player.has_flag[sharpshootercharging]>:
      - if <player.item_in_hand.script.name||0> == sharpshooter && <player.item_in_offhand.script.name||0> == sharpshooter:
        - inventory adjust slot:offhand custom_model_data:1374203
      - inventory adjust slot:<player.item_in_hand.slot> custom_model_data:1374203
      - flag <player> sharpshootercharging:0
      - while <player.has_flag[sharpshootercharging]>:
        - if <player.flag[sharpshootercharging]> < 8 && <[loop_index].mod[10]> == 9:
          - flag <player> sharpshootercharging:<player.flag[sharpshootercharging].add[1]>
        - if <player.flag[sharpshootercharging]> < 8:
          - title "title:<element[❈].repeat[<player.flag[sharpshootercharges]>].color[#803030]><element[❈].repeat[<element[3].sub[<player.flag[sharpshootercharges]>]>].color[#404040]>" "subtitle:<element[⋇].repeat[<player.flag[sharpshootercharging]>].bold.color[#FF6060]><element[⋇].repeat[<element[8].sub[<player.flag[sharpshootercharging]>]>].bold.color[#808080]>" fade_in:0 stay:2t fade_out:5t targets:<player>
        - else:
          - title "title:<element[❈].repeat[<player.flag[sharpshootercharges]>].color[#803030]><element[❈].repeat[<element[3].sub[<player.flag[sharpshootercharges]>]>].color[#404040]>" "subtitle:<element[⋇].repeat[8].bold.color[#FF0000]>" fade_in:0 stay:2t fade_out:5t targets:<player>
        - if <player.flag[sharpshootercharging]> == 8 && <[loop_index].mod[3]> == 0:
          - playsound <player.eye_location> sound:block_note_block_pling pitch:2 volume:1
        - if <[loop_index]> == 49:
          - inventory adjust slot:<player.item_in_hand.slot> custom_model_data:1374204
          - if <player.item_in_hand.script.name||0> == sharpshooter && <player.item_in_offhand.script.name||0> == sharpshooter:
            - inventory adjust slot:offhand custom_model_data:1374204
        - if !<player.is_on_ground> && <player.item_in_hand.script.name||0> == sharpshooter && <player.item_in_offhand.script.name||0> == sharpshooter:
          - cast <player> slow_falling duration:2t amplifier:2 no_icon hide_particles no_ambient
          - adjust <player> velocity:<player.velocity.add[<player.eye_location.direction.vector.mul[0.1]>].add[0,0.075,0]>
        - if <[loop_index]> > 160:
          - flag <player> sharpshootercharging:!
        - wait 1t
      - if <player.item_in_hand.script.name||0> == sharpshooter && <player.item_in_offhand.script.name||0> == sharpshooter:
        - inventory adjust slot:offhand custom_model_data:1374202
      - inventory adjust slot:<player.item_in_hand.slot> custom_model_data:1374202
    - else:
      - if <player.flag[sharpshootercharging]> < 1:
        - stop
      - if <player.item_in_hand.script.name||0> == sharpshooter && <player.item_in_offhand.script.name||0> == sharpshooter:
        - playsound <player.location> sound:entity_iron_golem_hurt pitch:1.5 volume:1
        - playsound <player.location> sound:entity_lightning_bolt_impact pitch:2 volume:1
        - playsound <player.location> sound:entity_skeleton_hurt pitch:1.5 volume:1
        - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:1.5 volume:1
        - shoot marksmanbullet origin:<player.eye_location.right[-0.4].below[0.4]> speed:<player.flag[sharpshootercharging].div[5].add[3]> shooter:<player> spread:0 save:bampow3
        - define bampowproj <entry[bampow3].shot_entities.get[1]>
        - flag <[bampowproj]> firepower:2
        - flag <[bampowproj]> bouncesleft:<player.flag[sharpshootercharging]>
        - flag <[bampowproj]> piercing:1
        - wait 4t
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:1.5 volume:1
      - playsound <player.location> sound:entity_lightning_bolt_impact pitch:2 volume:1
      - playsound <player.location> sound:entity_skeleton_hurt pitch:1.5 volume:1
      - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:1.5 volume:1
      - flag <player> riflecooldown expire:7t
      - itemcooldown iron_horse_armor duration:7t
      - shoot marksmanbullet origin:<player.eye_location.right[0.4].below[0.4]> speed:<player.flag[sharpshootercharging].div[5].add[3]> shooter:<player> spread:0 save:bampow3
      - define bampowproj <entry[bampow3].shot_entities.get[1]>
      - flag <[bampowproj]> firepower:2
      - flag <[bampowproj]> bouncesleft:<player.flag[sharpshootercharging]>
      - flag <[bampowproj]> piercing:1
      - flag <player> sharpshootercharging:!
      - flag <player> sharpshootercharges:<player.flag[sharpshootercharges].sub[1]>
      - if <player.flag[sharpshootercharging]> < 8:
        - title "title:<element[❈].repeat[<player.flag[sharpshootercharges]>].color[#803030]><element[❈].repeat[<element[3].sub[<player.flag[sharpshootercharges]>]>].color[#404040]>" "subtitle:" fade_in:0 stay:10t fade_out:20t targets:<player>
      - else:
        - title "title:<element[❈].repeat[<player.flag[sharpshootercharges]>].color[#803030]><element[❈].repeat[<element[3].sub[<player.flag[sharpshootercharges]>]>].color[#404040]>" "subtitle:" fade_in:0 stay:10t fade_out:20t targets:<player>
      - wait 7s
      - flag <player> sharpshootercharges:<player.flag[sharpshootercharges].add[1]>
    on player drags in inventory:
    - if <player.has_flag[sharpshootercharging]>:
      - determine cancelled
    on player scrolls their hotbar:
    - if <player.has_flag[sharpshootercharging]>:
      - determine cancelled
    on player swaps items:
    - if <player.has_flag[sharpshootercharging]>:
      - determine cancelled

marksmanhit:
  debug: false
  type: task
  script:
  - define coinshit <[shot_entity].flag[firepower]>
  - flag <[hit_entities]> beingshot expire:1s
  - adjust <[hit_entities]> max_no_damage_duration:1t
  - hurt <[hit_entities]> <[coinshit].mul[2]>
  - wait 2s
  - foreach <[hit_entities]>:
    - if !<[value].has_flag[beingshot]>:
      - adjust <[value]> max_no_damage_duration:20t