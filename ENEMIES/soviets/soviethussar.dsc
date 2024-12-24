soviethussar:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 40
    health: 40
    equipment: <map[helmet=<item[netherite_helmet]>;chestplate=<item[elytra]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: iron_sword
    speed: 0.5

soviethorse:
  type: entity
  entity_type: horse
  mechanisms:
    age: adult
    max_health: 40
    health: 40
    equipment: <list[<item[air]>|<item[air]>|<item[iron_horse_armor]>|<item[air]>]>
    speed: 0.5

soviethandlerhussar:
  type: world
  events:
    after soviethussar spawns:
    - spawn <context.entity.location> soviethorse save:myhussar
    - define horsey <entry[myhussar].spawned_entity>
    - flag <[horsey]> arenamob:<context.entity.flag[arenamob]>
    - define sovietname <list[kurwaSoldier<list[1|2|3|4|5|6|7|8|9].random><list[0|1|2|3|4|5|6|7|8|9].random><list[0|1|2|3|4|5|6|7|8|9].random><list[0|1|2|3|4|5|6|7|8|9].random>]|Koxu_PL|Xx_Kacpix_xX|MistrzOfSwag|CebularzGaming|Xx_BurakCebulak_xX|orzel|JebacRuskow_PL|Brzeczyszczykiewicz_Plays|WielkiPolak|Jan_Pawel_II|LewandowskiToKox_PL|Kurwica_Gaming|milisz123232|kolesizminecraft|CokeMaster13|ZuzaaxPL|XxNinjaKoks|KURWA_BOBER_55656].random>
    - mount <context.entity>|<[horsey]>
    - flag <context.entity> sovname:<[sovietname]>
    - announce <&e><element[<[sovietname]> joined the game]>
    - libsdisguise player target:<context.entity> name:<list[IfapToFurries|Military|Sergi2022|KimJongGoon].random> display_name:<[sovietname]>
    - wait <list[10t|1s|2s].random>
    #- attack <context.entity> target:<context.entity.location.find_players_within[20].get[1]>
    - wait <list[10t|1s|2s].random>
    - while <context.entity.is_spawned>:
      - look <context.entity> <context.entity.target.eye_location>
      - wait <element[80].sub[<context.entity.health>]>t
    on soviethussar damaged:
    - attack <context.entity> <context.damager>
    on soviethussar dies:
    - define hisnamegodbless <context.entity.flag[sovname]>
    - define phrases2 <list[POLSKA GUROOOM!!!!|Bog, Honor, Ojczyzna.|jebac pis|Od morza, do morza!|XD|kys|Polacy nic sie nie stalo!|KURWA!|<element[23&co17].unescaped>].random>
    - wait 10t
    - announce <[hisnamegodbless]><element[ &gt&gt ].unescaped><[phrases2]>
    - wait 3s
    - announce <&e><[hisnamegodbless]><element[ left the game]>
    on soviethussar spawns:
    - wait 2t
    - while <context.entity.is_spawned>:
      - if !<context.entity.is_on_ground> && !<context.entity.is_inside_vehicle> && <context.entity.location.block.sub[0,2,0].material.name> == air && <context.entity.location.block.sub[0,1,0].material.name> == air:
        - adjust <context.entity> gliding:true
      - else:
        - adjust <context.entity> gliding:false
      - wait 1t