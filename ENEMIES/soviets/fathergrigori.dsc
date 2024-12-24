fathergrigori:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 20
    health: 20
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: <list[annabelle].random>
    speed: 0.1

fathergrigorihandler:
  type: world
  events:
    after fathergrigori spawns:
    - flag <context.entity> grigor
    - libsdisguise player target:<context.entity> name:leehyukjoon hide_name
    - wait <list[10t|1s|2s].random>
    - attack <context.entity> target:<context.entity.location.find.living_entities.within[25].filter_tag[<[filter_value].is_player.not>].exclude[<context.entity>].filter_tag[<[filter_value].has_flag[grigor].not>].get[1]||0>
    - while <context.entity.is_spawned>:
      - if <context.entity.target.eye_location.line_of_sight[<context.entity.eye_location>]> && <context.entity.target||0> != 0:
        - ~run holyshit def:<context.entity>|<context.entity.target>
      - else:
        - attack <context.entity> target:<context.entity.location.find.living_entities.within[25].filter_tag[<[filter_value].is_player.not>].exclude[<context.entity>].filter_tag[<[filter_value].has_flag[grigor].not>].get[1]||0>
      - wait <element[40].sub[<context.entity.health>]>t
      - if <[loop_index]> > 20:
        - hurt <context.entity> amount:5
    on fathergrigori damaged:
    - attack <context.entity> <context.damager>
    on fathergrigori dies:
    - if <util.random_chance[2]>:
      - determine annabelle passively
    - else:
      - determine NO_DROPS passively

holyshit:
  type: task
  definitions: soviet|target
  script:
  - playsound sound:custom.click1 pitch:1 volume:2 at:<[soviet].eye_location> custom
  - wait 5t
  - playsound sound:custom.click2 pitch:1 volume:2 at:<[soviet].eye_location> custom
  - wait 13t
  - playsound at:<[soviet].eye_location> sound:entity_iron_golem_hurt pitch:0 volume:1
  - playsound at:<[soviet].eye_location> sound:entity_generic_explode pitch:1 volume:1
  - playsound at:<[soviet].eye_location> sound:custom.classic_explode pitch:1 volume:1 custom
  - playsound at:<[soviet].eye_location> sound:entity_firework_rocket_large_blast pitch:2 volume:1
  - playsound at:<[soviet].eye_location> sound:entity_firework_rocket_large_blast pitch:1 volume:1
  - playsound at:<[soviet].eye_location> sound:entity_firework_rocket_large_blast pitch:0 volume:1
  - define aimtarg <[soviet].eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;entities=*;ignore=<[soviet]>;raysize=0.1]>
  - define posline <[soviet].eye_location.points_between[<[aimtarg]>].distance[1]>
  - foreach <[posline]>:
    - playeffect at:<[value]> effect:smoke offset:0 quantity:2 visibility:100
  - define targeted <[aimtarg].find.living_entities.within[1.5].exclude[<[soviet]>].get[1]||0>
  - if <[targeted]> != 0:
    - if <list[husk|zombie|skeleton|stray|drowned|skeletonprince|skeletonking|bloaterzombie|hivezombie|knightzombie].contains_any[<[targeted].name>]>:
      - if <[targeted].health> < 36:
        - flag <[soviet]> mantles:<[soviet].flag[mantles].add[1]||1>
      - hurt <[targeted]> amount:36 source:[soviet]
    - else:
      - if <[targeted].health> < 18:
        - flag <[soviet]> mantles:<[soviet].flag[mantles].add[1]||1>
      - hurt <[targeted]> amount:18 source:[soviet]
  - wait 20t