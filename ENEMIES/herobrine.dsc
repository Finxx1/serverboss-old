herobrine:
  type: entity
  entity_type: zombie
  mechanisms:
    age: adult
    max_health: 200
    health: 200

herobrinehandler:
  type: world
  events:
    after herobrine spawns:
    - libsdisguise player target:<context.entity> name:MHF_Herobrine display_name:Herobrine
    - adjust <context.entity.location.find_players_within[100]> stopsound
    - rename <element[Herobrine].color[#FFFFFF]> t:<context.entity>
    - bossbar create herobrineID players:<context.entity.location.find_players_within[100]> title:<element[Herobrine].color[#FFFFFF]> progress:1 color:white options:create_fog,darken_sky
    - wait 0.8s
    - attack <context.entity> target:<context.entity.location.find_players_within[20].get[1]>
    - wait 2.0s
#    - run fighttheme def:<context.entity>
    - wait 0.2s
    - repeat 60:
      - playeffect at:<context.entity.location.add[0,1,0]> effect:soul_fire_flame offset:1.1,1.5,1.1 quantity:1 velocity:<location[0,0,0].random_offset[1]>
    - explode <context.entity.location> power:4 source:<context.entity>
    #- while <context.entity.is_spawned>:
    #  - cast <context.entity> slow duration:10t amplifier:2 no_icon hide_particles no_ambient
    #  - random:
    #    - run herobrinespawn def:<context.entity.location>
    #    - run herobrinewaveattack def:<context.entity>
    #    - run herobrinerocket def:<context.entity>|<context.entity.target>
    #  - wait 10s
    #- wait 2s
    #- bossbar remove herobrineID
    on herobrine spawns:
    - wait 5t
    - while <context.entity.is_spawned>:
      - if <context.entity.health> < 100:
        - cast <context.entity> speed amplifier:1 duration:3t no_icon hide_particles no_ambient
        - cast <context.entity> strength amplifier:1 duration:3t no_icon hide_particles no_ambient
        - playeffect at:<context.entity.location.add[0,1,0]> effect:soul_fire_flame offset:1.1,1.5,1.1 quantity:5 velocity:<location[0,0.075,0]>
        - heal <context.entity> 0.05
      - bossbar update herobrineID progress:<context.entity.health.div[200]>
      - wait 2t
    on herobrine dies:
    - adjust <context.entity.location.find_players_within[100]> stop_sound
    - playsound <context.entity.location> sound:entity_blaze_death
    - wait 2s
    - bossbar remove herobrineID
    on entity damages herobrine:
    - attack <context.damager> target:<context.entity.location.find_players_within[20].get[1]>

#fightthemeheroin:
#  type: task
#  definitions: bossentity
#  script:
#  - while <[bossentity].is_spawned>:
#    - playsound <[bossentity].location> sound:custom.herobrinefight volume:16 pitch:1 custom
#    - wait 3323t

herobrinespawn:
  type: task
  definitions: spawnloc
  script:
  # spawn 5 zombies around the zombie, random locations
  - repeat 3:
    - playsound at:<[spawnloc]> volume:0.5 sound:block_note_block_didgeridoo pitch:0
    - wait 8t
  - repeat 4:
    - spawn zombie[age=adult] <[spawnloc].random_offset[5,0,5].find.surface_blocks.within[5].first.above> save:zombiespawn2
    - define newzombie <entry[zombiespawn2].spawned_entity>
    - playeffect at:<[newzombie].location> effect:note offset:1.5,0.2,1.5 quantity:30 velocity:<location[0,0.7,0].random_offset[0.2,0,0.2]>
    - playsound at:<[newzombie].location> volume:0.5 sound:block_note_block_guitar

herobrinewaveattack:
  type: task
  definitions: herobrinemob2
  script: 
  - repeat 5:
    - playsound at:<[herobrinemob2].location> volume:0.5 sound:block_note_block_didgeridoo
    - wait 5t
  - repeat 3:
    - run herobrinewave def:<[herobrinemob2]>
    - wait 20t

herobrinewave:
  type: task
  definitions: herobrinemob
  script:
  - repeat 8:
    - foreach <proc[particle_ring].context[<[herobrinemob].location>|<[value].mul[6]>|<[value].mul[2]>]> as:val2:
      - playeffect at:<[val2]> effect:note offset:1,1,1 quantity:4 velocity:<location[0,1,0]>
      - hurt <[val2].sub[0,0.75,0].find.living_entities.within[1].exclude[<[herobrinemob]>].exclude[zombie]> 4
      #- playeffect at:<[val2]> effect:note offset:0,0,0 quantity:3 velocity:<location[0,1,0]>
    - playsound at:<[herobrinemob].location> volume:0.5 sound:block_note_block_bass pitch:<[value].div[4]>
    - wait 3t  
  - foreach <proc[particle_ring].context[<[herobrinemob].location>|60|18]> as:val2:
    - hurt <[val2].find.living_entities.within[2].exclude[<[herobrinemob]>].exclude[zombie]> 8 source:<[herobrinemob]>
    #- explode <[val2]>
    - playeffect at:<[val2]> effect:note offset:2,2,2 quantity:9 velocity:<location[0,1,0]>

herobrinerocket:
  type: task
  definitions: herobrinemob|aimtarget
  script:
    - repeat 8:
      - playsound at:<[herobrinemob].location> volume:2 sound:block_note_block_guitar pitch:2
      - wait 2t
    - define targetloc <[aimtarget].eye_location>
    - playsound at:<[herobrinemob].location> volume:2 sound:block_note_block_bass pitch:0
    - playsound at:<[herobrinemob].location> volume:2 sound:block_note_block_didgeridoo pitch:0
    - wait 20t
    - playeffect at:<[skyrllidmob]> effect:note offset:1,1,1 quantity:4 velocity:<location[0,1,0]>
    - foreach <[herobrinemob].eye_location.points_between[<[targetloc]>].distance[1]> as:val2:
      - hurt <[val2].find.living_entities.within[1].exclude[<[herobrinemob]>].exclude[zombie]> 4 source:<[herobrinemob]>
      - playeffect at:<[val2]> effect:note offset:1,1,1 quantity:4 velocity:<location[0,1,0]>
      - wait 1t  
    - explode <[targetloc]> power:2