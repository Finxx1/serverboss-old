sovietsniper:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 30
    health: 30
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: <list[sniperrifle].random>
    speed: 0.15

sovietsniperhandler:
  type: world
  events:
    after sovietsniper spawns:
    - define sovietname <list[<element[&lbCRACKED&rb UNSTOPABLE].unescaped>|DidColder|BETATRON|PARTY RAT|discord.gg/complaints].random>
    - flag <context.entity> sovname:<[sovietname]>
    - announce <&e><element[<[sovietname]> joined the game]>
    - libsdisguise player target:<context.entity> name:<list[Tismath|AveragePrawn278|GroggoryMayles].random> display_name:<[sovietname]>
    - run spinlikecrazy def:<context.entity>
    - while <context.entity.is_spawned>:
      - if <context.entity.target.eye_location.line_of_sight[<context.entity.eye_location>]> && <context.entity.target||0> != 0:
        - define phrases <list[DID YOU KNOW 85% OF ****** ****|****** SHOULD BE KILLED IN THE STREETS!|<context.entity.flag[sovname]> IS THE BEST|BUY IMMUNITY HERE ww1.dataleaks.zh/dl/256231].random>
        - announce <[sovietname]><element[ &gt&gt ].unescaped><[phrases]>
      - wait 20t
    on sovietsniper damaged:
    - attack <context.entity> <context.damager>
    on sovietsniper spawns:
    - wait 1t
    - while <context.entity.is_spawned>:
      - attack <context.entity> target:<context.entity.location.find_entities.within[70].filter_tag[<[filter_value].gamemode.is[==].to[adventure]||true>].filter_tag[<[filter_value].has_flag[sovname].not>].exclude[<context.entity>].get[1]>
      - if <context.entity.target||0> != 0 && !<context.entity.has_flag[riflecooldown]>:
        - if !<context.entity.has_flag[targetlocked]>:
          - run sniping def:<context.entity>|<context.entity.target>
        - else:
          - run snipe def:<context.entity>|<context.entity.target>
      - wait 3t
    on sovietsniper dies:
    - define hisnamegodbless <context.entity.flag[sovname]>
    - announce <&e><[hisnamegodbless]><element[ left the game (Kicked by an operator)]>
    - determine NO_DROPS passively
    - remove <context.entity>

sniping:
  type: task
  definitions: soviet|target
  script:
  - if <[target].eye_location.line_of_sight[<[soviet].eye_location>]>:
    - define targdel <[target].eye_location.add[<[target].eye_location.sub[<[soviet].eye_location>].mul[2]>]>
    - wait 15t
    - define posline <[soviet].eye_location.points_between[<[targdel]>].distance[<list[1.5|1].random>]||0>
    - if <[soviet].has_flag[onestopshop]>:
      - stop
    - foreach <[posline]>:
      - if <[soviet].has_flag[targetlocked]>:
        - foreach stop
      - playeffect effect:redstone at:<[value]> special_data:1|<color[#FF0000]> quantity:2 offset:0 visbility:100
      - if <[value].find.living_entities.within[1].exclude[<[soviet]>].get[1]||0> != 0:
        - flag <[soviet]> targetlocked:<[value]>
        - foreach stop
      - if <[value].distance[<[soviet].eye_location>]> > 50:
        - foreach stop
      - if <[value].block.material.name> != air:
        - foreach stop

spinlikecrazy:
  type: task
  definitions: soviet
  script:
  - wait 2t
  - while <[soviet].is_spawned>:
    - look <[soviet]> yaw:<[soviet].eye_location.yaw.add[72]> pitch:-90 duration:1t
    - wait 2t

snipe:
  type: task
  definitions: soviet|target
  script:
  - if <[soviet].has_flag[onestopshop]>:
    - stop
  - flag <[soviet]> onestopshop expire:13t
  - define tarloc <[soviet].flag[targetlocked]>
  - define targdel <[tarloc].add[<[tarloc].sub[<[soviet].eye_location>].mul[2]>]>
  - playsound sound:custom.click1 pitch:0.7 volume:2 at:<[soviet].eye_location> custom
  - playsound sound:block_note_block_bit pitch:1.7 volume:2 at:<[soviet].eye_location>
  - wait 3t
  - playsound sound:custom.click2 pitch:0.7 volume:2 at:<[soviet].eye_location> custom
  - playsound sound:block_note_block_bit pitch:1.3 volume:2 at:<[soviet].eye_location>
  - wait 7t
  - playsound <[soviet].eye_location> sound:entity_iron_golem_hurt pitch:2 volume:1
  - playsound <[soviet].eye_location> sound:entity_skeleton_hurt pitch:2 volume:1
  - playsound <[soviet].eye_location> sound:entity_generic_explode pitch:1 volume:1
  - playsound <[soviet].eye_location> sound:entity_zombie_attack_iron_door pitch:1 volume:1
  - playsound <[soviet].eye_location> sound:entity_zombie_attack_iron_door pitch:0 volume:1
  - flag <[soviet]> riflecooldown expire:20t
  - if <[targdel].line_of_sight[<[soviet].eye_location>]>:
    - define posline <[soviet].eye_location.points_between[<[targdel]>].distance[<list[0.8].random>]>
    - foreach <[posline]>:
      - playeffect effect:smoke at:<[value]> quantity:5 offset:0.05 visbility:100
      - if <[value].find.living_entities.within[1]||0> != 0:
        - hurt <[value].find.living_entities.within[1].exclude[<[soviet]>].get[1]> amount:20
      - if <[value].distance[<[soviet].eye_location>]> > 100:
        - foreach stop
      - if <[value].block.material.name> != air:
        - foreach stop
  - wait 1t
  - flag <[soviet]> targetlocked:!