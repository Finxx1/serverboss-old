chaingun:
  type: item
  material: iron_horse_armor
  display name: <element[Chaingun].color[#606060]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374324
    hides: all
  lore:
  - <element[ya-ta-ta-ta-ta-ta-ta-ta].color[#303030]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

chainbullet:
  type: entity
  entity_type: snowball
  mechanisms:
    item: bulletsprite

chaintriggers:
  type: world
  events:
    on player right clicks block with:chaingun:
    - if <player.has_flag[riflecooldown]>:
      - stop
    - ratelimit <player> 1t
    - if <player.has_flag[chaingunning]>:
      - flag <player> chaingunning expire:10t
      - stop
    - flag <player> chaingunning expire:10t
    - flag <player> chaingunheat:10 expire:20t
    - while <player.has_flag[chaingunning]>:
      - define lookvec <player.velocity.add[<player.eye_location.direction.vector.mul[-0.05]>]>
#      - adjust <player> velocity:<[lookvec]>
      - cast <player> slow duration:4t amplifier:2 no_ambient hide_particles no_icon
      - playsound <player.location> sound:entity_iron_golem_hurt pitch:0.75 volume:2
      - playsound <player.location> sound:entity_skeleton_hurt pitch:0.75 volume:2
      - playsound <player.location> sound:entity_zombie_attack_iron_door pitch:1.5 volume:2
      - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:0.75 volume:1
      - if <player.flag[chaingunoverheat]> >= 50 && <util.random_chance[25]>:
        - shoot chainbullet[fire_time=<list[10t|1s|2s].random>] origin:<player.eye_location.right[0.4].below[0.4]> speed:2.5 script:minigunhit shooter:<player> spread:5
      - else:
        - shoot chainbullet origin:<player.eye_location.right[0.4].below[0.4]> speed:3 script:minigunhit shooter:<player> spread:<player.flag[chaingunheat]>
      - if <player.flag[chaingunoverheat]> >= 100:
        - burn <player> duration:60t
        - if <util.random_chance[10]>:
          - hurt <player> cause:FIRE amount:1
#      - wait 1t
      - wait <player.flag[chaingunheat]>t
#      - announce <player.flag[chaingunheat]>
      - flag <player> chaingunheat:<player.flag[chaingunheat].sub[1].max[2]||10> expire:20t
      - if <player.flag[chaingunheat]> <= 5:
        - flag <player> chaingunoverheat:<player.flag[chaingunoverheat].add[1].min[100]||0> expire:10t
    on chainbullet hits entity:
    - cast <context.hit_entity> slow duration:5t amplifier:3 no_ambient hide_particles no_icon
    - wait 1t
    - adjust <context.hit_entity> no_damage_duration:1t
    on chainbullet damages entity:
    - determine 2