seraph:
  type: entity
  entity_type: armor_stand
  mechanisms:
    max_health: 1
    health: 1
    equipment: <map[helmet=<item[serapheye]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    visible: false

serapheye:
  type: item
#  material: player_head
  material: clay_ball
  display name: <element[Seraph Eye].color_gradient[from=#C04040;to=#C0C0FF]>
  mechanisms:
#    skull_skin: Vize214
# thanks for the skin Vize214 but i got a model
    custom_model_data: 13374357
  lore:
  - <element[Angel eyes can double as grenades!].color_gradient[from=#602020;to=#606080]>
  - 
  - <element[GENUINE].color[#206030].bold>

seraphrings:
  type: item
#  material: player_head
  material: clay_ball
  display name: <element[Seraph Rings].color_gradient[from=#F0C060;to=#C0C0FF]>
  mechanisms:
#    skull_skin: Vize214
# thanks for the skin Vize214 but i got a model
    custom_model_data: 13374358
  lore:
  - <element[Freely encaged!].color_gradient[from=#806030;to=#606080]>
  - 
  - <element[GENUINE].color[#206030].bold>

seraphhandler:
  type: world
  debug: false
  events:
    on projectile hits seraph:
    - determine cancelled passively
    - playeffect effect:flash quantity:1 at:<context.hit_entity.eye_location> offset:0 visibility:100
    - playsound <context.hit_entity.eye_location> sound:item_totem_use pitch:2 volume:1
    - adjust <context.projectile> velocity:<context.projectile.velocity.mul[-1].random_offset[0.25]>
    on player right clicks block with:serapheye:
    - shoot seraphproj origin:<player.eye_location.right[0.4].below[0.4]> speed:1.5 spread:0 shooter:<player>
    - take from:<player> item_in_hand
    on player right clicks seraph:
    - determine cancelled passively
    - give to:<player.inventory> slot:<player.item_in_hand.slot> serapheye
    - playsound at:<context.entity.eye_location> sound:custom.gib pitch:2 volume:2 custom
    - playeffect effect:block_crack special_data:nether_quartz_ore at:<context.entity.eye_location> offset:0.25 quantity:100 visibility:100
    - adjust <context.entity> equipment:<map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    - kill <context.entity>
    after seraph spawns:
    - wait 5t
    - while <context.entity.is_spawned>:
      - repeat 40:
        - repeat 2:
          - playeffect effect:soul_fire_flame at:<context.entity.eye_location> offset:0.25 visibility:100 velocity:<location[0,0,0].random_offset[0.1]>
        - playsound <context.entity.eye_location> sound:block_beacon_ambient pitch:1 volume:2
        - define targ <context.entity.eye_location.find_players_within[50].filter_tag[<[filter_value].eye_location.line_of_sight[<context.entity.eye_location>]>].get[1].eye_location>
        - run lookdelayed def:<context.entity>|<[targ]>
        - wait 1t
      - if <util.random_chance[25]>:
        - define targ <context.entity.eye_location.find_players_within[50].filter_tag[<[filter_value].eye_location.line_of_sight[<context.entity.eye_location>]>].get[1].eye_location>
        - look <context.entity> <[targ]>
        - adjust <context.entity> velocity:<context.entity.velocity.add[0,0.75,0]>]>
        - wait 10t
        - adjust <context.entity> gravity:false
        - playsound <context.entity.eye_location> sound:block_beacon_activate pitch:0 volume:2
        - repeat 60:
          - define targ <context.entity.eye_location.find_players_within[50].filter_tag[<[filter_value].eye_location.line_of_sight[<context.entity.eye_location>]>].get[1].eye_location>
          - look <context.entity> <[targ]>
          - foreach <context.entity.eye_location.points_around_x[radius=1;points=20]>:
            - playeffect effect:flame at:<[value]> offset:0 visibility:100
          - foreach <context.entity.eye_location.points_around_y[radius=1;points=20]>:
            - playeffect effect:flame at:<[value]> offset:0 visibility:100
          - foreach <context.entity.eye_location.points_around_z[radius=1;points=20]>:
            - playeffect effect:flame at:<[value]> offset:0 visibility:100
          - wait 1t
        - playsound <context.entity.eye_location> sound:block_beacon_activate pitch:1 volume:2
        - playsound <context.entity.eye_location> sound:block_beacon_activate pitch:0 volume:2
        - playsound <context.entity.eye_location> sound:block_beacon_activate pitch:2 volume:2
        - foreach <context.entity.eye_location.points_around_x[radius=2;points=35]>:
          - playeffect effect:flame at:<[value]> offset:0 visibility:100
        - foreach <context.entity.eye_location.points_around_y[radius=2;points=35]>:
          - playeffect effect:flame at:<[value]> offset:0 visibility:100
        - foreach <context.entity.eye_location.points_around_z[radius=2;points=35]>:
          - playeffect effect:flame at:<[value]> offset:0 visibility:100
        - repeat 25:
          - foreach <context.entity.eye_location.points_around_x[radius=1;points=20]>:
            - playeffect effect:flame at:<[value]> offset:0 visibility:100
          - foreach <context.entity.eye_location.points_around_y[radius=1;points=20]>:
            - playeffect effect:flame at:<[value]> offset:0 visibility:100
          - foreach <context.entity.eye_location.points_around_z[radius=1;points=20]>:
            - playeffect effect:flame at:<[value]> offset:0 visibility:100
          - wait 1t
        - foreach <context.entity.eye_location.points_between[<[targ]>].distance[0.25]>:
          - playeffect effect:flame at:<[value]> offset:0 visibility:100
        - if !<context.entity.is_spawned>:
          - stop
        - explode <[targ]> power:3 source:<context.entity>
        - wait 5t
        - adjust <context.entity> gravity:true
      - wait 1t 


lookdelayed:
  type: task
  debug: false
  definitions: ser|target
  script:
  - wait 10t
  - adjust <[ser]> armor_pose:<[ser].armor_pose_map.include[head=<[ser].eye_location.pitch.div[180].mul[3.14]>,0,0]>
#  - light <[target]> 15 duration:20t
#  - announce <[ser].eye_location.pitch.sub[90].add[180].div[180].mul[3.14]>
  - look <[ser]> <[target]>
  - if <[ser].eye_location.distance[<[target]>]> > 8:
    - adjust <[ser]> velocity:<[ser].velocity.add[<[ser].eye_location.sub[<[target]>].normalize.mul[-0.025]>]>
  - else:
    - adjust <[ser]> velocity:<[ser].velocity.add[<[ser].eye_location.sub[<[target]>].normalize.mul[0.0125]>]>
  - if <[ser].eye_location.y.sub[4]> < <[target].y>: 
    - adjust <[ser]> velocity:<[ser].velocity.add[0,0.1,0]>
  - else:
    - adjust <[ser]> velocity:<[ser].velocity.with_y[<[ser].velocity.y.div[2]>]>


lookdelayed2:
  type: task
  debug: false
  definitions: ser|target
  script:
  - wait 3t
  - look <[ser]> <[target]>