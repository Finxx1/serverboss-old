sovietheavy:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 140
    health: 140
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: <list[minigun|chaingun].random>
    speed: 0.125

sovietheavyhandler:
  type: world
  events:
    after sovietheavy spawns:
    - define sovietname <list[Xx_CUM_xX|BURVIL_ДЕБИЛ_SHITEATER|НЕГРОУБИЙЦА_1337|BRIMSTRUCK44|<element[&lbCHH&rb TRUE_PURIFIER_1945].unescaped>].random>
    - flag <context.entity> sovname:<[sovietname]>
    - announce <&e><element[<[sovietname]> joined the game]>
    - libsdisguise player target:<context.entity> name:<list[IfapToFurries|Military|Sergi2022|KimJongGoon].random> display_name:<[sovietname]>
    - wait <list[10t|1s|2s].random>
    - attack <context.entity> target:<context.entity.location.find_players_within[20].get[1]>
    - wait <list[10t|1s|2s].random>
    - while <context.entity.is_spawned>:
      - wait 2t
      - if <context.entity.target.eye_location.line_of_sight[<context.entity.eye_location>]> && <context.entity.target||0> != 0:
        - define phrases <list[IM COMING FOR YOU!!1|ИДИ НАХУЙ|<context.entity.target.name||LOSER> HACKER|KYSKYSKYSKYSKYS].random>
        - announce <[sovietname]><element[ &gt&gt ].unescaped><[phrases]>
        - ~run shootingshit9 def:<context.entity>|<context.entity.target>
      - else:
        - define phrases <list[HIDE|CRY SOME MORE|L|little baby|coward|1v1|MGE ill win].random>
        - announce <[sovietname]><element[ &gt&gt ].unescaped><[phrases]>
      - wait 70t
    on sovietheavy damaged:
    - attack <context.entity> <context.damager>
    on sovietheavy spawns:
    - wait 1t
    - while <context.entity.is_spawned>:
      - if <context.entity.is_on_ground>:
        - define fuckyou2 <context.entity.target.eye_location||0>
        - define fuckyou <context.entity.target.eye_location||location[0,0,0]>
        - define friend <context.entity.location.find_entities.within[15].filter_tag[<[filter_value].has_flag[sovname].and[<[filter_value].has_flag[ismedic].not>].and[<[filter_value].eye_location.line_of_sight[fuckyou2].not>].exclude[<context.entity>].get[1]||0>
        #- announce <[friend]>
        #- announce <[fuckyou]>
        - if <[friend]> != 0:
          - walk <context.entity> <[friend].eye_location> speed:<element[40].sub[<context.entity.health>].div[216]>
          - walk <[friend]> <[fuckyou]> speed:<element[40].sub[<context.entity.health>].div[216]>
        - else:
          - walk <context.entity> <context.entity.eye_location.with_pitch[0].left[<list[-10|10].random>]> speed:<element[40].sub[<context.entity.health>].div[216]>
      - wait <context.entity.health>t
    on sovietheavy dies:
    - if <util.random_chance[95]>:
      - determine <list[minigun|chaingun]> passively
    - else:
      - determine vintagegift passively
    - define hisnamegodbless <context.entity.flag[sovname]>
    - wait 10t
    - if <util.random_chance[20]>:
      - announce <[hisnamegodbless]><element[ &gt&gt ].unescaped><element[OH YOU'RE LIVE ON TWITCH?]>
      - wait 3s
      - announce <&e><[hisnamegodbless]><element[ left the game (Kicked by an operator)]>
    - else:
      - announce <[hisnamegodbless]><element[ &gt&gt ].unescaped><list[KILL YOURSEEEEELF|-rep|shithead|IM DRILL YOUR MOM].random>
      - announce <&e><[hisnamegodbless]><element[ left the game]>

shootingshit9:
  type: task
  definitions: soviet|target
  script:
  - playsound sound:custom.click1 pitch:0.6 volume:2 at:<[soviet].eye_location> custom
  - wait 12t
  - playsound sound:custom.click2 pitch:0.6 volume:2 at:<[soviet].eye_location> custom
  - wait 17t
  - cast <[soviet]> slow duration:3t amplifier:8 no_icon hide_particles no_ambient
  - wait 2t
  - cast <[soviet]> slow duration:2t amplifier:9 no_icon hide_particles no_ambient
  - while <[soviet].eye_location.line_of_sight[<[target].eye_location>]>:
    - look <[soviet]> <[soviet].target.eye_location.add[0,0.7,0]>
    - if <[loop_index]> > 20:
      - while stop
    - repeat 20:
      - playsound <[soviet].eye_location> sound:entity_iron_golem_hurt pitch:2 volume:1
      - playsound <[soviet].eye_location> sound:entity_skeleton_hurt pitch:2 volume:1
      - playsound <[soviet].eye_location> sound:entity_zombie_attack_wooden_door pitch:2 volume:1
      - playsound <[soviet].eye_location> sound:entity_generic_explode pitch:2 volume:1
      - shoot bullet origin:<[soviet].eye_location.right[0.4].below[0.8]> speed:1.4 script:riflehit2 def:<[soviet]> shooter:<[soviet]> spread:5
      - shoot bullet origin:<[soviet].eye_location.right[0.4].below[0.8]> speed:1 script:riflehit2 def:<[soviet]> shooter:<[soviet]> spread:10
      - wait <list[1|2].random>t