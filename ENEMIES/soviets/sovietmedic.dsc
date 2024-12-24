sovietmedic:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 20
    health: 20
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: honey_bottle
    speed: 0.25

soviethandlermedic:
  type: world
  events:
    after sovietmedic spawns:
    - define medictype femboy
#<list[femboy|afk].random>
    #- choose <[medictype]>:
      #- case afk:
        #- define sovietname <list[Xx_CUM_xX|BURVIL_ДЕБИЛ_SHITEATER|НЕГРОУБИЙЦА_1337].random>
      #- case femboy:
    - define sovietname <list[<element[X_Alexa_&lt3_&lt3].unescaped>|soft_boy_xxx|healingfam563|LittleStar1337|-=-Zosia-=-|horni-nurse_XOXO].random>
    - flag <context.entity> sovname:<[sovietname]>
    - flag <context.entity> ismedic
    - announce <&e><element[<[sovietname]> joined the game]>
    - choose <[medictype]>:
      - case femboy:
        - libsdisguise player target:<context.entity> name:<list[X3S|melanholyy|Ayuwoki_Rusbe].random> display_name:<[sovietname]>
      - case afk:
        - wait 1t
    - wait <list[10t|1s|2s].random>
    - wait <list[10t|1s|2s].random>
    - while <context.entity.is_spawned>:
      - define friend <context.entity.location.find_entities.within[15].filter_tag[<[filter_value].has_flag[sovname].and[<[filter_value].health.is_less_than[35]>].and[<[filter_value].health.is_more_than[0]>].and[<[filter_value].has_flag[ismedic].not>]>].exclude[<context.entity>].get[1]||0>
      - if <context.entity.is_on_ground>:
        - if <[friend].eye_location.distance[<context.entity.eye_location>]> > 2.5:
          - walk <context.entity> <[friend].eye_location.backward_flat[0.75]> speed:<element[40].sub[<context.entity.health>].div[108]>
        - else:
          - run healthefucker def:<context.entity>|<[friend]>
      - if <util.random_chance[1]>:
        - if <context.target.has_flag[sovname]>:
          - define phrases <list[<element[&lt3].unescaped>|hii!!|hehe x3|uwu|hi|help is here|ily <context.entity.target.name||u>].random>
        - else:
          - define phrases <list[<element[&lt3].unescaped>|hii!!|hehe x3|uwu|hi|help is here|ily <context.entity.target.flag[sovname]||u>].random>
        - announce <[sovietname]><element[ &gt&gt ].unescaped><[phrases]>
      - wait 1s
    on sovietmedic spawns:
    - wait 5t
    - while <context.entity.is_spawned>:
      - attack <context.entity> cancel
      - heal <context.entity> 0.05
      - wait 1t
    on sovietmedic dies:
    - determine <list[elixirofvitality|heartscard[quantity=<list[4|7|6|23].random.add[<list[4|7|6|23].random>]>]|heartcookie[quantity=<list[4|7|6|23].random.add[<list[4|7|6|23].random>]>]|elixirofcharisma].random> passively
#    - drop .random> <context.entity.location>
    - define theirnamegodbless <context.entity.flag[sovname]>
    - define phrases2 <list[ouuuch you meanie x(|ow!! that hurt|you guys are toxic...|i dont like this game,, ,|im gonna go now sorry|that's domestic abuse!!!|wtf??].random>
    - wait 10t
    - announce <[theirnamegodbless]><element[ &gt&gt ].unescaped><[phrases2]>
    - wait 3s
    - announce <&e><[theirnamegodbless]><element[ left the game]>

healthefucker:
  type: task
  definitions: soviet|target
  script:
  - playeffect at:<[target].location.add[0,1,0]> effect:spell_witch quantity:60 visibility:100 offset:0.25
  - heal <[target]> 5
