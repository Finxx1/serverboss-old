weezer:
  type: item
  material: iron_horse_armor
  display name: <element[Weezer Terminator].color[#0090C8]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374316
  lore:
  - <element[finally you can fucking kill them].color[#004864]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

weezertriggers:
  type: world
  events:
    on player right clicks block with:weezer:
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:1.75 volume:1
      - playsound <player.location> sound:entity_skeleton_hurt pitch:1.75 volume:1
      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:1.75 volume:1
      - playsound <player.location> sound:entity_generic_explode pitch:1.75 volume:1
      - flag <player> riflecooldown expire:10t
      - itemcooldown iron_horse_armor duration:10t
      - define shootloc <player.eye_location.right[0.4].below[0.4]>
      - shoot bullet origin:<[shootloc]> destination:<[shootloc].forward[1].left[0.6]> speed:2 script:pistolhit shooter:<player> spread:1 def:<player>
      - shoot bullet origin:<[shootloc]> destination:<[shootloc].forward[1].left[0.2]> speed:2 script:pistolhit shooter:<player> spread:1 def:<player>
      - shoot bullet origin:<[shootloc]> destination:<[shootloc].forward[1].right[0.2]> speed:2 script:pistolhit shooter:<player> spread:1 def:<player>
      - shoot bullet origin:<[shootloc]> destination:<[shootloc].forward[1].right[0.6]> speed:2 script:pistolhit shooter:<player> spread:1 def:<player>

weezerhit:
  debug: false
  definitions: shooterguy
  type: task
  script:
  - flag <[hit_entities]> beingshot expire:1s
  - adjust <[hit_entities]> max_no_damage_duration:1t
  - hurt <[hit_entities]> 5 source:<[shooterguy]>
  - wait 2s
  - foreach <[hit_entities]>:
    - if !<[value].has_flag[beingshot]>:
      - adjust <[value]> max_no_damage_duration:20t