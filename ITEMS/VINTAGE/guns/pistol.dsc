pistol:
  type: item
  material: iron_horse_armor
  display name: <element[Pistol].color[#808080]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374307
    hides: all
  lore:
  - <element[Pow Pow Pow!].color[#404040]>
  - 
  - <element[VINTAGE].color[#404878].bold>

pistoltriggers:
  type: world
  events:
    on player right clicks block with:pistol:
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:2 volume:1
      - playsound <player.location> sound:entity_generic_explode pitch:2 volume:1
      - flag <player> riflecooldown expire:4t
      - itemcooldown iron_horse_armor duration:4t
      - shoot bullet origin:<player.eye_location.right[0.4].below[0.4]> speed:2 script:pistolhit shooter:<player> spread:1


pistolhit:
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