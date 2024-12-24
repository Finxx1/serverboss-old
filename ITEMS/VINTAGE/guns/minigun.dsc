minigun:
  type: item
  material: iron_horse_armor
  display name: <element[Minigun].color[#C0C0C0]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374301
    hides: all
  lore:
  - <element[YATATATATATATATATATATATATATATATATA].color[#606060]>
  - 
  - <element[VINTAGE].color[#404878].bold>



miniguntriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:minigun:
    - if !<player.has_flag[riflecooldown]>:
      - repeat 5:
        - define lookvec <player.velocity.add[<player.eye_location.direction.vector.mul[-0.05]>]>
        - adjust <player> velocity:<[lookvec]>
        - cast <player> slow duration:4t amplifier:2 no_ambient hide_particles no_icon
        - playsound <player.location> sound:entity_iron_golem_hurt pitch:1 volume:2
        - playsound <player.location> sound:entity_skeleton_hurt pitch:1 volume:2
        - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:2 volume:2
#        - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:1 volume:1
        - shoot bullet origin:<player.eye_location.right[0.4].below[0.4]> speed:2 script:minigunhit shooter:<player> spread:8
        - wait 1t


minigunhit:
  debug: false
  type: task
  script:
  - flag <[hit_entities]> beingshot expire:1s
  - adjust <[hit_entities]> max_no_damage_duration:1t
  - hurt <[hit_entities]> 1
  - wait 2s
  - foreach <[hit_entities]>:
    - if !<[value].has_flag[beingshot]>:
      - adjust <[value]> max_no_damage_duration:20t