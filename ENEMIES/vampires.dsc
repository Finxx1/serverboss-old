vampire:
  type: entity
  entity_type: zombie
  mechanisms:
    age: adult
    max_health: 20
    health: 20
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: air
    item_in_offhand: air
    speed: 0.315

vampirehandler:
  type: world
  events:
    after vampire spawns:
    - libsdisguise player target:<context.entity> name:nulleuro hide_name
    - while <context.entity.is_spawned>:
      - wait 20t
      - if <context.entity.target.eye_location.line_of_sight[<context.entity.eye_location>]> && <context.entity.target||0> != 0 && <context.entity.location.find_path[<context.entity.target.location>].is_empty> && <context.entity.is_on_ground>:
        - playeffect effect:smoke_large at:<context.entity.location.add[0,1,0]> quantity:64 offset:0.5 visibility:100
        - playsound at:<context.entity.location.add[0,1,0]> sound:ENTITY_BLAZE_SHOOT volume:2 pitch:0 
        - spawn bat[max_health=<context.entity.health_max>;health=<context.entity.health>;gravity=false] <context.entity.eye_location> save:vampbats
        - define vampiBat <entry[vampbats].spawned_entity>
        - flag <[vampiBat]> petergriffin:<context.entity.target>
        - run batform def:<[vampiBat]>
        - remove <context.entity>
        - stop
      - if <context.entity.health> > 0:
        - heal <context.entity> 2
    on vampire damages entity:
    - heal <context.damager> 5
    - attack <context.entity> <context.damager>
    on vampire damaged by FIRE:
    - determine <context.damage.mul[2].add[5]> passively
    on vampire damaged by FIRE_TICK:
    - determine <context.damage.mul[2].add[5]> passively

batform:
  type: task
  definitions: batEnt
  script:
  - wait 20t
  - if <[batEnt].flag[petergriffin]||0> == 0:
    - flag <[batEnt]> petergriffin:<[batEnt].location.find_players_within[50].get[1]>
  - define flyTarg <[batEnt].flag[petergriffin].location>
  - while <[batEnt].location.distance[<[flyTarg]>]> > 0.5 && <[batEnt].location.sub[0,2,0].block.material.name.is[=].to[air]>:
    - playeffect effect:smoke at:<[batEnt].location> quantity:5 offset:0.2 visibility:100
    - adjust <[batEnt]> velocity:<[batEnt].velocity.add[<[batEnt].location.sub[<[flyTarg].add[0,0.5,0]>].normalize.mul[-0.25]>]>
    - look <[batEnt]> <[batEnt].flag[petergriffin]>
    - wait 1t
  - playeffect effect:smoke_large at:<[flyTarg]> quantity:64 offset:0.5 visibility:100
  - playsound at:<[flyTarg]> sound:ENTITY_BLAZE_SHOOT volume:2 pitch:0
  - spawn vampire[max_health=<[batEnt].health_max>;health=<[batEnt].health>] <[flyTarg]> save:savedVamp
  - define vampSpawned <entry[savedVamp].spawned_entity>
  - cast invisibility amplifier:1 duration:1t no_ambient hide_particles no_icon <[vampSpawned]>
  - attack <[vampSpawned]> <[batEnt].flag[petergriffin]>
  - remove <[batEnt]>