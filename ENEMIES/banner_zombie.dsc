bannerzombie:
  type: entity
  entity_type: zombie
  mechanisms:
    equipment: <map[helmet=<item[zombiebanner]>;chestplate=<item[iron_chestplate]>]>
    age: adult
    max_health: 20
    health: 20

zombiebanner:
  type: item
  material: blue_banner
  display name: <&2>Zombie Banner
  mechanisms:
    patterns: <list[purple/gradient|green/gradient_up|white/skull]>

bannerzombiehandler:
  type: world
  events:
    on bannerzombie spawns:
#    - announce <context.entity.script>
#    - announce <context.entity.describe>
#    - run bannerzombiespawn def:<context.location>
    - run bannerzombiebuff def:<context.entity>
    - run bannerzombiehide def:<context.entity>
    - wait 1t
    - libsdisguise player target:<context.entity> name:Toastedhead101 hide_name
    #- run bannerzombiefollow def:<context.entity>
    on bannerzombie dies:
    - playsound <context.entity.location> sound:entity_blaze_death
    on entity damages bannerzombie:
    - attack <context.entity> target:<context.damager>

bannerzombiespawn:
  type: task
  definitions: spawnloc
  script:
  # store amount of zombies nearby,
  # stop if there are more than 10
  - define zombieamount <[spawnloc].find_entities[zombie|husk|drowned|zombie_villager].within[20].size||0>
  - if <[zombieamount]> > 10:
    - stop
  # spawn 5 zombies around the zombie, random locations
  - repeat 4:
    - spawn zombie[age=adult] <[spawnloc].random_offset[3,0,3].find.surface_blocks.within[5].first.above> save:zombiespawn
    - define newzombieloc <entry[zombiespawn].spawned_entity.location>
    - define newzombie <entry[zombiespawn].spawned_entity>
    - playeffect at:<[newzombieloc]> effect:block_crack special_data:dirt offset:1.5,0.2,1.5 quantity:30 velocity:<location[0,0.7,0].random_offset[0.2,0,0.2]>
    - playsound at:<[newzombieloc]> volume:0.5 sound:block_grass_break
    # additionally, check if it's day and give them helmets.
    - if <[newzombieloc].world.time.period.is[==].to[day].or[dawn]>:
      - equip <[newzombie]> head:<list[iron_helmet|iron_helmet|leather_helmet|leather_helmet|leather_helmet|golden_helmet|golden_helmet].random>
    - wait 2t

bannerzombiebuff:
  type: task
  definitions: bannerzombie
  script:
  - waituntil <[bannerzombie].is_spawned||false>
  - wait 11t
  # check every 2 seconds to buff nearby zombies
  - while <[bannerzombie].is_spawned||false>:
    - define nearbyzombies <[bannerzombie].location.find_entities[zombie|husk|drowned|zombie_villager].within[10]>
    ## follow zombies
    #- define nearbyzombies2 <[bannerzombie].location.find_entities[zombie|husk|drowned|zombie_villager].within[10].exclude[<[bannerzombie]>].filter[scriptname.is[!=].to[bannerzombie]]>
    #- if <[nearbyzombies2].is_empty.not>:
    #  - define zombietofollow <[nearbyzombies].first>
    #  - follow followers:<[bannerzombie]> target:<[zombietofollow]> no_teleport allow_wander lead:5 speed:0.3
    - foreach <[nearbyzombies]> as:zombie:
      - if <[zombie].has_flag[zombiebannerbuff]>:
        - foreach stop
      - run zombiebuffedbybanner def:<[zombie]>|<[bannerzombie]>
    - wait 2s

bannerzombiehide:
  type: task
  definitions: bannerzombie
  script:
  - waituntil <[bannerzombie].is_spawned||false>
  - while <[bannerzombie].is_spawned||false>:
    # wait for target
    - if <[bannerzombie].target||null> != null:
      #- announce "<&e>[I HAVE A TARGET]"
    # check for the nearest zombie, go behind them
      - define nearbyzombies <[bannerzombie].location.find_entities[zombie|husk|drowned|zombie_villager].within[10].filter[health.is[or_more].than[5]].filter[scriptname.is[!=].to[bannerzombie]||true]>
      - if !<[nearbyzombies].is_empty>:
        #- announce "<&e>[THERE ARE <&d><[nearbyzombies].size><&e> AVAILABLE TO HIDE BEHIND]"
        - define zombie <[nearbyzombies].first>
        - while <[zombie].is_spawned> && <[bannerzombie].is_spawned> && <[bannerzombie].target||null> != null && <[zombie].health.is[or_more].than[5]>:
          - if <[bannerzombie].health> < 35:
            #- announce "<&3>[SHIELD ME]"
            - playeffect at:<[zombie].location.above[2.3]> flame quantity:5 offset:0
            - walk <[bannerzombie]> <[zombie].location.backward_flat[1]> speed:0.3
          - wait 1s
    - wait 2s

zombiebuffedbybanner:
  type: task
  debug: false
  definitions: zombie|bannerzombie
  script:
  - playsound <[zombie].location> sound:entity_zombie_villager_converted volume:0.4
  - flag <[zombie]> zombiebannerbuff expire:<duration[6s]>
  #- cast <[zombie]> increase_damage amplifier:1 duration:6s
  - cast <[zombie]> damage_resistance amplifier:1 duration:6s
  - cast <[zombie]> speed amplifier:0 duration:6s
  - while <[zombie].has_flag[zombiebannerbuff]>:
    - repeat 4:
      - wait 5t
      - if !<[zombie].is_spawned||false>:
        - stop
      - playeffect soul_fire_flame at:<proc[particle_ring].context[<[zombie].location.above[0.25]>|12|1]> quantity:1 offset:0

bannerzombiefollow:
  type: task
  definitions: bannerzombie
  script:
  - wait 1t
  - while <[bannerzombie].is_spawned>:
    - define followers <[bannerzombie].location.find_entities[zombie|husk|stray|zombie_villager].within[35].filter[scriptname.is[!=].to[bannerzombie]||true]>
    - foreach <[followers]>:
      - if <[value].target||null> == null && <[bannerzombie].target||null> == null:
        - follow followers:<[value]> target:<[bannerzombie]> lead:5 no_teleport allow_wander
        #- announce "<&2>[FOLLOW ME]"
      - else:
        - follow followers:<[value]> stop
        - attack <[followers]> target:<[bannerzombie].target>
        #- announce <&c>[ATTACK]
    - wait 0.5s