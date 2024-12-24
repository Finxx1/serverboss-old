rifle:
  type: item
  material: iron_horse_armor
  display name: <element[Rifle].color[#80C0C0]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374300
    hides: all
  lore:
  - <element[Ratatatatatatatatata!!].color[#406060]>
  - 
  - <element[VINTAGE].color[#404878].bold>

rifletriggers:
  type: world
  events:
    on player right clicks block with:rifle:
    - if !<player.has_flag[riflecooldown]>:
      - flag <player> riflecooldown expire:9t
      - itemcooldown iron_horse_armor duration:9t
      - repeat 4:
        - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:1
        - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
        - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:2 volume:1
        - playsound <player.location> sound:entity_generic_explode pitch:2 volume:1
        - shoot bullet origin:<player.eye_location.right[0.4].below[0.4]> speed:2 script:riflehit shooter:<player> spread:3
        - wait 3t


riflehit:
  debug: false
  type: task
  script:
  - flag <[hit_entities]> beingshot expire:1s
  - adjust <[hit_entities]> max_no_damage_duration:1t
  - hurt <[hit_entities]> 2
  - wait 2s
  - foreach <[hit_entities]>:
    - if !<[value].has_flag[beingshot]>:
      - adjust <[value]> max_no_damage_duration:20t