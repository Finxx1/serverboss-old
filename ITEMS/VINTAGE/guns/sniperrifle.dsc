sniperrifle:
  type: item
  material: iron_horse_armor
  display name: <element[Sniper Rifle].color[#8080A0]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374306
    hides: all
  lore:
  - <element[click-KaSCHooooo...vvwwwmPThksyw!!!].color[#404050]>
  - 
  - <element[VINTAGE].color[#404878].bold>

sniperrifletriggers:
  type: world
  events:
    on player right clicks block with:sniperrifle:
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_skeleton_hurt pitch:2 volume:1
      - playsound <player.location> sound:entity_generic_explode pitch:1 volume:1
      - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:1 volume:1
      - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:0 volume:1
      - flag <player> riflecooldown expire:70t
      - itemcooldown iron_horse_armor duration:70t
      - shoot sniperbullet origin:<player.eye_location.right[0.4].below[0.4]> speed:4 script:sniperriflehit shooter:<player> spread:0 gravity:0
      - wait 2t

sniperriflehit:
  debug: false
  type: task
  script:
  - flag <[hit_entities]> beingshot expire:1s
  - adjust <[hit_entities]> max_no_damage_duration:1t
  - foreach <[hit_entities]>:
    - if <[location].y> > <[value].location.y.add[1]>:
      - playsound <[value].location> sound:entity_arrow_hit_player pitch:1 volume:3
      - hurt <[value]> 30
    - else:
      - hurt <[value]> 5
  - wait 2s
  - foreach <[hit_entities]>:
    - if !<[value].has_flag[beingshot]>:
      - adjust <[value]> max_no_damage_duration:20t