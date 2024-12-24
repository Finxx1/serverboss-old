uzi:
  type: item
  material: iron_horse_armor
  display name: <element[Uzi].color[#A0E0E0]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374335
    hides: all
  lore:
  - <element[Trrrrrrt! Trrrrrt!].color[#507878]>
  - <element[Trrrtt! Trrrrrtt!].color[#507878]>
  - 
  - <element[VINTAGE].color[#404878].bold>

uzitriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:uzi:
    - ratelimit <player> duration:1t
    - if !<player.has_flag[riflecooldown]>:
      - flag <player> riflecooldown expire:9t
      - itemcooldown iron_horse_armor duration:9t
#      - if <player.item_in_offhand.script.name||0> == sawedoff:
#        - run sawedofffire2 def:<player>
      - if <player.item_in_offhand.script.name||0> == uzi:
        - run uzifire2 def:<player>
      - repeat 8:
        - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
        - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:2 volume:1
        - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:2 volume:1
        - shoot bullet origin:<player.eye_location.right[0.45].below[0.4]> speed:2 script:riflehit shooter:<player> spread:5
        - wait 1t

uzifire2:
  type: task
  debug: false
  definitions: playra
  script:
  - wait 6t
  - repeat 8:
    - playsound <[playra].location> sound:entity_skeleton_hurt pitch:1.9 volume:1
    - playsound <[playra].location> sound:entity_zombie_attack_wooden_door pitch:1.9 volume:1
    - playsound <[playra].location> sound:entity_zombie_attack_iron_door pitch:1.9 volume:1
    - shoot bullet origin:<[playra].eye_location.left[0.45].below[0.4]> speed:2.3 script:riflehit shooter:<[playra]> spread:3
    - wait 1t

uzihit:
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