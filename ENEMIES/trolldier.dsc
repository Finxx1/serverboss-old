trolldier:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 35
    health: 35
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: postalshovel
    item_in_offhand: air
    speed: 0.21

trolldierhandler:
  type: world
  debug: false
  events:
    after trolldier spawns:
    - libsdisguise player target:<context.entity> name:ItsHarry hide_name
    - while <context.entity.is_spawned>:
      - if <context.entity.target||0> != 0:
        - if <context.entity.is_on_ground> && !<context.entity.has_flag[reloadingtroll]>:
          - define jumpspot <context.entity.eye_location.backward_flat[1].with_y[<context.entity.location.y>]>
#          - announce <[jumpspot]>
          - look <context.entity> <[jumpspot]> duration:15t
          - wait 10t
          - playsound at:<[jumpspot]> sound:entity_iron_golem_hurt pitch:0 volume:2
          - playsound at:<[jumpspot]> sound:entity_generic_extinguish_fire pitch:0 volume:2
          - playsound at:<[jumpspot]> sound:entity_zombie_attack_wooden_door pitch:0 volume:2
          - wait 1t
          - playsound at:<[jumpspot]> sound:entity_wither_shoot volume:2 pitch:0
          - playeffect effect:explosion_huge quantity:1 at:<[jumpspot]> offset:0 visibility:100
          - repeat 80:
            - playeffect effect:cloud quantity:1 at:<[jumpspot]> offset:2.25 visibility:100 velocity:<location[0,0,0].random_offset[1]>
            - playeffect effect:smoke quantity:1 at:<[jumpspot]> offset:2.25 visibility:100 velocity:<location[0,0,0].random_offset[1]>
          - shoot <context.entity> destination:<context.entity.target.location.add[0,10,0]> speed:2 spread:2 origin:<context.entity.location.add[0,0.25,0]>
          - wait 10t
          - while !<context.entity.is_on_ground||0>:
            - if <context.entity.fall_distance> > 0 && !<context.entity.has_flag[screameagles]>:
              - flag <context.entity> screameagles
              - adjust <context.entity> item_in_hand:postalshovel
              - playsound sound:custom.eaglecry pitch:1 volume:3 at:<context.entity.location> custom
            - look <context.entity> <context.entity.target.eye_location>
#            - announce <context.entity.velocity.add[<context.entity.eye_location.with_pitch[0].direction.vector.normalize.mul[0.1]>]>
            - wait 1t
            - adjust <context.entity> velocity:<context.entity.velocity.add[<context.entity.eye_location.with_pitch[0].direction.vector.normalize.mul[0.01]>]>
          - flag <context.entity> reloadingtroll expire:45t
          - flag <context.entity> screameagles:!
          - wait 5t
          - adjust <context.entity> item_in_hand:rocketjumper
      - wait 1t
    on trolldier damaged by FALL:
    - define falldam <context.damage>
    - define entdam <context.entity>
    - determine cancelled passively
    - define fuckyou <[entdam].eye_location.find.living_entities.within[3].exclude[<[entdam]>].get[1]||0>
    - if <[fuckyou]> != 0:
      - hurt <[fuckyou]> amount:15 source:<[entdam]>
      - playsound at:<[fuckyou].eye_location> sound:custom.shovelbash<list[1|2].random> pitch:1 volume:2 custom
      - repeat 20:
        - playeffect effect:crit quantity:1 at:<[fuckyou].eye_location> offset:0 visibility:100 velocity:<location[0,0,0].random_offset[1]>
      - stop
    - repeat <[falldam].mul[0.35].round_down>:
      - foreach <[entdam].location.points_around_y[points=<[value].mul[2].round_down.add[4]>;radius=<[value]>]> as:ringloc:
        - explode <[ringloc]> power:1 source:<[entdam]>
      - wait 1t