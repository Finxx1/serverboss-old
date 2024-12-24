heaponsneo:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 200
    health: 200

heaponsneohandler:
  type: world
  events:
    after heaponsneo spawns:
    - libsdisguise player target:<context.entity> name:Heapons display_name:"HEAPONS NEO"
    - adjust <context.entity.location.find_players_within[100]> stopsound
    - rename "Heapons NEO" t:<context.entity>
    - bossbar create heaponsneoID players:<context.entity.location.find_players_within[100]> title:<element[HEAPONS NEO].color[#FFFFFF]> progress:1 color:aqua options:create_fog,darken_sky
    - wait 0.8s
    - attack <context.entity> target:<context.entity.location.find_players_within[20].get[1]>
    - wait 2.0s
#    - run fighttheme def:<context.entity>
    - wait 0.2s
    #- while <context.entity.is_spawned>:
    #  - cast <context.entity> slow duration:10t amplifier:2 no_icon hide_particles no_ambient
    #  - random:
    #    - run herobrinespawn def:<context.entity.location>
    #    - run herobrinewaveattack def:<context.entity>
    #    - run herobrinerocket def:<context.entity>|<context.entity.target>
    #  - wait 10s
    #- wait 2s
    #- bossbar remove herobrineID
    on heaponsneo spawns:
    - wait 5t
    - while <context.entity.is_spawned>:
      - if <context.entity.health> < 100:
        - cast <context.entity> speed amplifier:1 duration:3t no_icon hide_particles no_ambient
        - cast <context.entity> strength amplifier:1 duration:3t no_icon hide_particles no_ambient
        - playeffect at:<context.entity.location.add[0,1,0]> effect:soul_fire_flame offset:1.1,1.5,1.1 quantity:5 velocity:<location[0,0.075,0]>
        - heal <context.entity> 0.05
      - bossbar update heaponsneoID progress:<context.entity.health.div[200]>
      - wait 2t
    on heaponsneo dies:
    - adjust <context.entity.location.find_players_within[100]> stop_sound
    - playsound <context.entity.location> sound:entity_blaze_death
    - wait 2s
    - bossbar remove heaponsneoID
    on entity damages heaponsneo:
    - if <context.damage> > 50:
      - determine 20 passively 
      - title title:<element[DON'T YOU KNOW?].bold.color_gradient[from=#00FFFF;to=#009880]> subtitle:<element[NEO IS FAMOUS FOR ITS HIGH DEFENSE!].bold.color_gradient[from=#00FFFF;to=#009880]> targets:<context.damager> fade_in:0t stay:2s fade_out:2s
    - attack <context.damager> target:<context.entity.location.find_players_within[20].get[1]>

#fightthemeheroin:
#  type: task
#  definitions: bossentity
#  script:
#  - while <[bossentity].is_spawned>:
#    - playsound <[bossentity].location> sound:custom.herobrinefight volume:16 pitch:1 custom
#    - wait 3323t

heaponsneospawn:
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