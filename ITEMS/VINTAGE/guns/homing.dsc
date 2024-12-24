hominggun:
  type: item
  material: golden_horse_armor
  display name: <element[The Emperor].color[#C040C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374285
  lore:
  - <element[Number 2!].color[#602060]>
  - 
  - <element[VINTAGE].color[#404878].bold>

homingguntriggers:
  type: world
  events:
    on player right clicks block with:hominggun:
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:2 volume:1
      - flag <player> riflecooldown expire:6t
      - itemcooldown iron_horse_armor duration:6t
      - shoot homingbullet origin:<player.eye_location.right[0.4].below[0.4]> speed:2 script:hominghit shooter:<player> spread:5 save:susvented2
      - define coinproj <entry[susvented2].shot_entities.get[1]>
      - run homingtask def:<[coinproj]>|<player>

hominghit:
  debug: false
  type: task
  script:
  - flag <[hit_entities]> beingshot expire:1s
  - adjust <[hit_entities]> max_no_damage_duration:1t
  - hurt <[hit_entities]> 5
  - wait 2s
  - foreach <[hit_entities]>:
    - if !<[value].has_flag[beingshot]>:
      - adjust <[value]> max_no_damage_duration:20t