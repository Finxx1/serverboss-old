sovietgrunt:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 40
    health: 40
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: <list[rifle|shotgun].random>
    speed: 0.25

soviethandler:
  type: world
  events:
    after sovietgrunt spawns:
    - define dudetype <context.entity.item_in_hand.script.name>
    - define firerate <list[2t|1t|3t|4t].random>
    - define efficiency <list[4|5|6].random>
    - define speed <list[1.3|1.5|1.7].random>
    - define tenacity <list[4|6|8|13].random>
    - define sovietname <list[IvanTerror|Xx_MENACE_xX|друг|zhudo.goliyotov@yandex.mail|vladimir_reaper|-=-метатель_дерьма-=-|<element[&lbRU&rb жерма985].unescaped>|PUTIN BEST|jorjiGamer|VolynskSodom_Y|borisGaming].random>
    - flag <context.entity> sovname:<[sovietname]>
    - announce <&e><element[<[sovietname]> joined the game]>
    - libsdisguise player target:<context.entity> name:<list[IfapToFurries|Military|Sergi2022|KimJongGoon].random> display_name:<[sovietname]>
    - wait <list[10t|1s|2s].random>
    #- attack <context.entity> target:<context.entity.location.find_players_within[20].get[1]>
    - wait <list[10t|1s|2s].random>
    - while <context.entity.is_spawned>:
      - if <context.entity.target.eye_location.line_of_sight[<context.entity.eye_location>]> && <context.entity.target||0> != 0:
        - run shootingshit def:<context.entity>|<context.entity.target>|<[firerate]>|<[efficiency]>|<[speed]>|<[tenacity]>|<[dudetype]>
        - if <context.target.has_flag[sovname]>:
          - define phrases <list[Cука блять!|die|motherfcuker!!1|stupid pice of shit!!|урод|ИДИ НАХУЙ|<context.entity.target.name||u> is fuck shit!!].random>
        - else:
          - define phrases <list[Cука блять!|die|motherfcuker!!1|stupid pice of shit!!|урод|ИДИ НАХУЙ|<context.entity.target.flag[sovname]||u> is fuck shit!!].random>
        - announce <[sovietname]><element[ &gt&gt ].unescaped><[phrases]>
      - wait <element[80].sub[<context.entity.health>]>t
    on sovietgrunt damaged:
    - attack <context.entity> <context.damager>
    on sovietgrunt spawns:
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
    on sovietgrunt dies:
    - if <util.random_chance[95]>:
      - determine <list[rifle|shotgun].random> passively
    - else:
      - determine vintagegift passively
    - define hisnamegodbless <context.entity.flag[sovname]>
    - define phrases2 <list[ДА НУ НАХУЙ!|FUCK YOU!!!|SHIT GAME].random>
    - wait 10t
    - announce <[hisnamegodbless]><element[ &gt&gt ].unescaped><[phrases2]>
    - wait 3s
    - announce <&e><[hisnamegodbless]><element[ left the game]>
    on sovietgrunt damaged by fire_tick:
    - define hisnamegodbless <context.entity.flag[sovname]>
    - define phrases2 <list[FIRE FIRE FIRE|ОГОНЬ ОГОНЬ|Я В ОГНЕ!!!|HELP FIRE!!1!].random>
    - wait <list[5t|10t|1s].random>
    - if <util.random_chance[30]>:
      - announce <[hisnamegodbless]><element[ &gt&gt ].unescaped><[phrases2]>

shootingshit:
  type: task
  definitions: soviet|target|fr|ef|sp|tn|wep
  script:
  - playsound sound:custom.click1 pitch:0.85 volume:2 at:<[soviet].eye_location> custom
  - wait 7t
  - playsound sound:custom.click2 pitch:0.85 volume:2 at:<[soviet].eye_location> custom
  - wait 15t
  - choose <[wep]>:
    - case rifle:
      - cast <[soviet]> slow duration:3t amplifier:8 no_icon hide_particles no_ambient
      - wait 2t
      - repeat <[tn]>:
        - wait 1t
        - cast <[soviet]> slow duration:2t amplifier:9 no_icon hide_particles no_ambient
        - playsound <[soviet].eye_location> sound:entity_iron_golem_hurt pitch:2 volume:1
        - playsound <[soviet].eye_location> sound:entity_skeleton_hurt pitch:2 volume:1
        - playsound <[soviet].eye_location> sound:entity_zombie_attack_wooden_door pitch:2 volume:1
        - playsound <[soviet].eye_location> sound:entity_generic_explode pitch:2 volume:1
        - look <[soviet]> <[target].eye_location.add[0,0.5,0]>
        - shoot bullet origin:<[soviet].eye_location> speed:<[sp]> script:riflehit2 def:<[soviet]> shooter:<[soviet]> spread:<[ef]>
        - wait <[fr]>
    - case shotgun:
      - cast <[soviet]> slow duration:3t amplifier:8 no_icon hide_particles no_ambient
      - wait 2t
      - repeat <[tn].div[5].round_up>:
        - cast <[soviet]> slow duration:2t amplifier:9 no_icon hide_particles no_ambient
        - playsound <[soviet].eye_location> sound:entity_iron_golem_hurt pitch:1.5 volume:1
        - playsound <[soviet].eye_location> sound:entity_skeleton_hurt pitch:1.5 volume:1
        - playsound <[soviet].eye_location> sound:entity_generic_explode pitch:1.5 volume:1
        - playsound <[soviet].eye_location> sound:entity_zombie_attack_wooden_door pitch:1.5 volume:1
        - look <[soviet]> <[target].eye_location.add[0,0.5,0]>
        - repeat 5:
          - shoot pellet origin:<[soviet].eye_location> speed:<[sp]> def:<[soviet]> shooter:<[soviet]> spread:<[ef].mul[6]>
        - wait <[fr]>
        - wait <[fr]>
        - wait <[fr]>

riflehit2:
  debug: false
  definitions: shootersoviet
  type: task
  script:
  - flag <[hit_entities]> beingshot expire:1s
  - hurt <[hit_entities]> 1 source:<[shootersoviet]>
  - adjust <[hit_entities]> no_damage_duration:1t
  - wait 2s
  - adjust <[hit_entities]> no_damage_duration:20t