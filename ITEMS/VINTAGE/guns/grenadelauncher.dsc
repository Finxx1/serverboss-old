grenadelauncher:
  type: item
  material: iron_horse_armor
  display name: <element[Grenade Launcher].color[#A080A0]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374309
    hides: all
  lore:
  - <element[Krlrkklk... kABOOOOM!!!].color[#504050]>
  - 
  - <element[VINTAGE].color[#404878].bold>

grenadelaunchertriggers:
  type: world
  events:
    on player right clicks block with:grenadelauncher:
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:0 volume:2
      - playsound <player.location> sound:block_note_block_didgeridoo pitch:0 volume:2
      - playsound <player.location> sound:entity_skeleton_hurt pitch:0 volume:2
      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:0 volume:2
      - flag <player> riflecooldown expire:50t
      - itemcooldown iron_horse_armor duration:50t
      - shoot grenade origin:<player.eye_location.right[0.4].below[0.4]> height:4 script:grenadelauncherhit shooter:<player> spread:0 gravity:0.015
      - wait 2t


grenadelauncherhit:
  debug: false
  type: task
  script:
  - flag <[hit_entities]> beingshot expire:1s
  - adjust <[hit_entities]> max_no_damage_duration:1t
  - foreach <[hit_entities]>:
    - explode <[value].location> power:2
  - wait 2s
  - foreach <[hit_entities]>:
    - if !<[value].has_flag[beingshot]>:
      - adjust <[value]> max_no_damage_duration:20t