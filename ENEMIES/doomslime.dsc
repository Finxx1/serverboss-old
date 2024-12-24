hellslime:
  type: entity
  entity_type: magma_cube
  mechanisms:
    max_health: 144
    size: 12
    speed: 3
    health: 144

hslimehandler:
  type: world
  events:
    after hellslime spawns:
    - adjust <context.entity.location.find_players_within[100]> stopsound
    - rename <element[SNOT OF C'THULU].color_gradient[from=#600000;to=#FFC000]> t:<context.entity>
    - bossbar create hellslimeID players:<context.entity.location.find_players_within[100]> title:<element[SNOT OF C'THULU].color_gradient[from=#600000;to=#FFC000]> progress:1 color:red options:create_fog,darken_sky
    - wait 0.8s
    - attack <context.entity> target:<context.entity.location.find_players_within[20].get[1]>
    - run hfighttheme def:<context.entity>
    - while <context.entity.is_spawned>:
      - repeat 5:
        - waituntil <context.entity.is_on_ground> max:10s
        - foreach <context.entity.location.find.surface_blocks.within[12].filter_tag[<util.random_chance[15]>]>:
          - if <[value].add[0,1,0].material> == <material[air]>:
            - modifyblock <[value].add[0,1,0]> fire  duration:8s players:<server.online_players>
          - playeffect at:<[value]> effect:lava offset:1.5,0.2,1.5 quantity:10 velocity:<location[0,0.7,0].random_offset[0.2,0,0.2]>
        - waituntil !<context.entity.is_on_ground> max:10s
      - run hellslimespawn def:<context.entity.location>
    on hellslime spawns:
    - wait 5t
    - while <context.entity.is_spawned>:
      - bossbar update hellslimeID progress:<context.entity.health.div[144]>
      - wait 2t
    on hellslime dies:
    - adjust <context.entity.location.find_players_within[100]> stop_sound
    - playsound <context.entity.location> sound:entity_blaze_death
    - wait 2s
    - bossbar remove hellslimeID
    on entity damages hellslime:
    - attack <context.damager> target:<context.entity.location.find_players_within[20].get[1]>

hfighttheme:
  type: task
  definitions: bossentity
  script:
  - while <[bossentity].is_spawned>:
    - playsound <[bossentity].location> sound:custom.hellslimefight volume:16 pitch:1 custom
    - wait 3205t

hellslimespawn:
  type: task
  definitions: spawnloc
  script:
  # spawn 5 zombies around the zombie, random locations
  - repeat 3:
    - playsound at:<[spawnloc]> volume:0.5 sound:entity_wither_ambient pitch:0
    - wait 8t
  - repeat 4:
    - spawn magma_cube[size=<list[|1|2|4].random>] <[spawnloc].random_offset[5,0,5].find.surface_blocks.within[5].first.above> save:hzombiespawn2
    - define newzombie <entry[hzombiespawn2].spawned_entity>
    - playeffect at:<[newzombie].location> effect:lava offset:1.5,0.2,1.5 quantity:30 velocity:<location[0,0.7,0].random_offset[0.2,0,0.2]>
    - playsound at:<[newzombie].location> volume:0.5 sound:entity_wither_spawn pitch:0