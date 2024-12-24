skeletonking:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 350
    health: 350
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: iron_sword
#    item_in_offhand: bow
    speed: 0.325

skeletonkinghandler:
  type: world
  events:
    on player damaged:
    - flag <player> skeleundying:!
    after skeletonking spawns:
    - foreach <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>]||0>:
      - flag <[value]> skeleundying
      - announce <[value]>
    - flag <context.entity> fightingmode
    - bossbar create skeleking players:<context.entity.location.find_players_within[100]> title:<element[SKELETON].color_gradient[from=#E0D0C0;to=#C0C0C0]><element[ ]><element[KING].color_gradient[from=#FFC020;to=#800000]> progress:<context.entity.health.div[350]> color:white options:create_fog,darken_sky
    - libsdisguise player target:<context.entity> name:_nomor_ hide_name
    - while <context.entity.is_spawned> && <context.entity.has_flag[fightingmode]>:
      - define parriablebitch <context.entity.eye_location.find_entities.within[10].exclude[<context.entity>].exclude[<context.entity.target>].filter_tag[<[filter_value].is_in_block.not>].get[1]>
      - if <[parriablebitch].is_projectile>:
        - if <[parriablebitch].entity_type.is[=].to[arrow]> && <[parriablebitch].is_in_block>:
          - while next
        - adjust <context.entity> item_in_hand:sickle
        - look <context.entity> <context.entity.target>
        #- look <context.entity> <[parriablebitch].location>
        - waituntil <[parriablebitch].location.distance[<context.entity.eye_location>]> < 3 max:10t
        - cast <context.entity> slow duration:1s amplifier:3 no_icon hide_particles no_ambient
        - playeffect at:<[parriablebitch].location> effect:crit offset:0.5 quantity:10 visibility:100
        - playeffect at:<[parriablebitch].location> effect:explosion_large offset:0 quantity:1 visibility:100
        - playsound at:<[parriablebitch].location> volume:2 sound:entity_arrow_hit_player pitch:2
        - playsound at:<[parriablebitch].location> volume:2 sound:entity_wither_break_block pitch:2
        - adjust <[parriablebitch]> velocity:<context.entity.eye_location.direction.vector.mul[2]>
        - heal <context.entity> 5
        - bossbar update skeleking progress:<context.entity.health.div[350]> color:green
        - flag <[parriablebitch]> parried
        - wait 3t
        - run updatecolor
        - while next
      - if <context.entity.target.eye_location.line_of_sight[<context.entity.eye_location>]> && !<context.entity.target.location.line_of_sight[<context.entity.eye_location>]> && <context.entity.eye_location.y> < <context.entity.target.location.y>:
        - adjust <context.entity> item_in_hand:rocketjumper
        - wait 10t
        - define jumpspot <context.entity.eye_location.backward_flat[1].with_y[<context.entity.location.y>]>
#        - announce <[jumpspot]>
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
        - shoot <context.entity> destination:<context.entity.target.location.add[0,10,0]> speed:1.8 spread:2 origin:<context.entity.location.add[0,0.25,0]>
        - wait 10t
        - while !<context.entity.is_on_ground||0>:
          - if <context.entity.fall_distance> > 0 && !<context.entity.has_flag[screameagles]>:
            - flag <context.entity> screameagles
            - adjust <context.entity> item_in_hand:postalshovel
            - playsound sound:custom.eaglecry pitch:1 volume:3 at:<context.entity.location> custom
          - look <context.entity> <context.entity.target.eye_location>
#          - announce <context.entity.velocity.add[<context.entity.eye_location.with_pitch[0].direction.vector.normalize.mul[0.1]>]>
          - wait 1t
          - adjust <context.entity> velocity:<context.entity.velocity.add[<context.entity.eye_location.with_pitch[0].direction.vector.normalize.mul[0.01]>]>
        - flag <context.entity> reloadingtroll expire:45t
        - wait 1t
        - flag <context.entity> screameagles:!
        - wait 8t
#        - wait 5t
#        - adjust <context.entity> item_in_hand:rocketjumper
      - if <context.entity.target.eye_location.line_of_sight[<context.entity.eye_location>]> && <context.entity.target||0> != 0 && <context.entity.target.item_in_hand.script> != <script[sickle]> && <context.entity.target.item_in_hand.script> != <script[postalshovel]> && <context.entity.target.eye_location.distance[<context.entity.eye_location>]> > 3 && <util.random_chance[95]>:
        - if <context.entity.health> > 50 || <util.random_chance[50]>:
          - if <context.entity.target.eye_location.distance[<context.entity.eye_location>]> < 14:
            - adjust <context.entity> item_in_hand:bow
            - ~run shootingshit3 def:<context.entity>|<context.entity.target>
          - else if <context.entity.target.eye_location.distance[<context.entity.eye_location>]> > 14:
#            - announce <context.entity.location.y> <context.entity.target.location.y.sub[4]>
            - if <context.entity.location.y> < <context.entity.target.location.y.sub[4]>:
              - adjust <context.entity> item_in_hand:grapple
              - ~run shootinghook def:<context.entity>|<context.entity.target>
            - else:
              - adjust <context.entity> item_in_hand:crossbow
              - ~run shootingshit4 def:<context.entity>|<context.entity.target>
        - else:
          - adjust <context.entity> item_in_hand:dynamite
          - ~run shootingshit5 def:<context.entity>|<context.entity.target>
      - else if <util.random_chance[95]>:
        - if <context.entity.target.item_in_hand.material.name> == shield || <context.entity.target.item_in_offhand.material.name> == shield:
          - adjust <context.entity> item_in_hand:iron_axe
        - else:
          - adjust <context.entity> item_in_hand:iron_sword
      - else:
        - adjust <context.entity> item_in_hand:spawner
        - cast <context.entity> slow duration:1s amplifier:4 no_icon hide_particles no_ambient
        - wait 1s
        - random:
          - run spawnzombies def:<context.entity>
          - run spawnspiders def:<context.entity>
          - run spawnskeletons def:<context.entity>
        - wait 1s
      - wait 1s
    on skeletonking damaged by FALL:
    - if <context.entity.has_flag[screameagles]>:
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
    on skeletonking damaged:
    - attack <context.entity> <context.damager>
    - playsound at:<context.entity.eye_location> sound:entity_skeleton_death pitch:2 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_wither_skeleton_death pitch:1 volume:2
    - bossbar update skeleking progress:<context.entity.health.div[350]>
    on skeletonking dies:
    - adjust <context.entity> invulnerable:true
    - determine cancelled passively 
    - bossbar update skeleking progress:0 color:RED
    - flag <context.entity> fightingmode:!
    - adjust <context.entity> item_in_hand:air
    - adjust <context.entity> is_aware:false
    - look <context.entity> <context.damager.eye_location>
    - playsound at:<context.entity.eye_location> sound:entity_skeleton_death pitch:0 volume:2
    - playsound at:<context.entity.eye_location> sound:entity_wither_skeleton_death pitch:0 volume:2
    - wait 1s
    - announce "<element[SKELETON].color_gradient[from=#E0D0C0;to=#C0C0C0]><element[ ]><element[KING].color_gradient[from=#FFC020;to=#800000]><&f><element[ &gt&gt ].unescaped>..."
    - wait 3s
    - announce "<element[SKELETON].color_gradient[from=#E0D0C0;to=#C0C0C0]><element[ ]><element[KING].color_gradient[from=#FFC020;to=#800000]><&f><element[ &gt&gt ].unescaped>Forgive me."
    - wait 3s
    - announce "<element[SKELETON].color_gradient[from=#E0D0C0;to=#C0C0C0]><element[ ]><element[KING].color_gradient[from=#FFC020;to=#800000]><&f><element[ &gt&gt ].unescaped>I have tried to save those lost of soul."
    - wait 3s
    - announce "<element[SKELETON].color_gradient[from=#E0D0C0;to=#C0C0C0]><element[ ]><element[KING].color_gradient[from=#FFC020;to=#800000]><&f><element[ &gt&gt ].unescaped>Waging war upon war against the divine."
    - wait 3s
    - announce "<element[SKELETON].color_gradient[from=#E0D0C0;to=#C0C0C0]><element[ ]><element[KING].color_gradient[from=#FFC020;to=#800000]><&f><element[ &gt&gt ].unescaped>I have become the very thing I was fighting..."
    - wait 4s
    - announce "<element[SKELETON].color_gradient[from=#E0D0C0;to=#C0C0C0]><element[ ]><element[KING].color_gradient[from=#FFC020;to=#800000]><&f><element[ &gt&gt ].unescaped>How many countless innocents have I used in combat?"
    - wait 5s
    - announce "<element[SKELETON].color_gradient[from=#E0D0C0;to=#C0C0C0]><element[ ]><element[KING].color_gradient[from=#FFC020;to=#800000]><&f><element[ &gt&gt ].unescaped>Those who only wanted a second chance."
    - wait 3s
    - announce "<element[SKELETON].color_gradient[from=#E0D0C0;to=#C0C0C0]><element[ ]><element[KING].color_gradient[from=#FFC020;to=#800000]><&f><element[ &gt&gt ].unescaped>I took it away..."
    - wait 5s
    - announce "<element[SKELETON].color_gradient[from=#E0D0C0;to=#C0C0C0]><element[ ]><element[KING].color_gradient[from=#FFC020;to=#800000]><&f><element[ &gt&gt ].unescaped>This is what I deserve."
    - wait 4s
    - playsound at:<context.entity.eye_location> sound:entity_ender_dragon_flap pitch:2 volume:5
    - adjust <context.entity> item_in_hand:dynamite
    - wait 30t
    - look <context.entity> <context.damager.eye_location>
    - playsound at:<context.entity.eye_location> sound:item_flintandsteel_use pitch:1 volume:5
    - announce "<element[SKELETON].color_gradient[from=#E0D0C0;to=#C0C0C0]><element[ ]><element[KING].color_gradient[from=#FFC020;to=#800000]><&f><element[ &gt&gt ].unescaped>But I won't go without one last sacrifice."
    - wait 1s
    - playsound at:<context.entity.eye_location> sound:entity_creeper_primed pitch:1 volume:5
    - wait 1s
    - announce "<element[SKELETON].color_gradient[from=#E0D0C0;to=#C0C0C0]><element[ ]><element[KING].color_gradient[from=#FFC020;to=#800000]><&f><element[ &gt&gt ].unescaped>GET THE FUCK OVER HERE!"
    - wait 10t
    - adjust <context.entity> is_aware:true
    - attack <context.entity> target:<context.damager>
    - repeat 10:
      - playsound <context.entity.location> sound:block_note_block_hat pitch:1 volume:2
      - wait 4t
      - playsound <context.entity.location> sound:block_note_block_hat pitch:0.85 volume:2
      - wait 4t
    - explode <context.entity.eye_location> power:4
    - playsound at:<context.entity.eye_location> sound:entity_wither_death pitch:0 volume:2
    - playeffect at:<context.entity.eye_location> effect:flash offset:0 quantity:1 visibility:100
    - playeffect at:<context.entity.eye_location> effect:block_crack special_data:bone_block offset:1 quantity:200 visibility:100
    - playeffect at:<context.entity.eye_location> effect:item_crack special_data:bone offset:2 quantity:200 visibility:100
    - bossbar remove skeleking
    - foreach <server.online_players.filter_tag[<[filter_value].gamemode.is[==].to[ADVENTURE]>].filter_tag[<[filter_value].has_flag[skeleundying]>]||0>:
      - run achievementgive def:<[value]>|skelenohit
    - remove <context.entity>

shootingshit3:
  type: task
  definitions: soviet|target
  script:
  - cast <[soviet]> slow duration:4s amplifier:2 no_icon hide_particles no_ambient
  - playsound at:<[soviet].eye_location> sound:block_anvil_destroy pitch:2 volume:5
  - wait 1s
  - define mvdir <list[-1|1].random.mul[0.15]>
  - repeat 7:
    - repeat 6:
      - adjust <[soviet]> velocity:<[soviet].velocity.add[<[soviet].eye_location.left[<[mvdir]>].forward[0.05].sub[<[soviet].eye_location>]>]>
      - look <[soviet]> <[target].eye_location.add[0,1,0]>
      - wait 1t
    - playsound at:<[soviet].eye_location> sound:custom.classic_bow_shoot pitch:1 volume:2 custom
    - look <[soviet]> <[target].eye_location.add[0,1,0]>
    - shoot arrow origin:<[soviet].eye_location.right[0.4].below[0.8]> speed:1.5 def:<[soviet]> shooter:<[soviet]> spread:5
    - if !<[soviet].has_flag[fightingmode]> || <[soviet].location.distance[<[target].location>]> >= 14 || <[soviet].location.distance[<[target].location>]> <= 3:
      - stop
    
updatecolor:
  type: task
  script:
  - wait 4t
  - bossbar update skeleking color:white

shootingshit4:
  type: task
  definitions: soviet|target
  script:
  - cast <[soviet]> slow duration:2s amplifier:6 no_icon hide_particles no_ambient
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_start pitch:1 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_start pitch:2 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_start pitch:0 volume:5
  - wait 17t
  - if <[soviet].location.y> < <[target].location.y.sub[4]> || <[soviet].location.distance[<[target].location>]> < 14:
    - stop
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_middle pitch:1 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_middle pitch:2 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_middle pitch:0 volume:5
  - wait 17t
  - if <[soviet].location.y> < <[target].location.y.sub[4]> || <[soviet].location.distance[<[target].location>]> < 14:
    - stop
  - inventory adjust slot:<[soviet].item_in_hand.slot> charged_projectiles:<list[<item[arrow[quantity=4]]>]>
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_end pitch:1 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_end pitch:2 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_end pitch:0 volume:5
  - wait 17t
  - if <[soviet].location.y> < <[target].location.y.sub[4]> || <[soviet].location.distance[<[target].location>]> < 14:
    - stop
  - playsound at:<[soviet].eye_location> sound:item_crossbow_shoot pitch:1 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_shoot pitch:2 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_shoot pitch:0 volume:5
  - if <[target].is_sprinting>:
    - look <[soviet]> <[target].eye_location.with_pitch[0].forward[2.25].add[0,1.5,0]>
  - else:
    - look <[soviet]> <[target].eye_location.add[0,1.5,0]>
  - shoot arrow[critical=true] origin:<[soviet].eye_location.right[0.4].below[0.8]> speed:3 def:<[soviet]> shooter:<[soviet]> spread:0

shootingshit5:
  type: task
  definitions: soviet|target
  script:
  - cast <[soviet]> slow duration:3s amplifier:4 no_icon hide_particles no_ambient
  - playsound at:<[soviet].eye_location> sound:item_flintandsteel_use pitch:1 volume:5
  - wait 10t
  - playsound at:<[soviet].eye_location> sound:entity_creeper_primed pitch:1 volume:5
  - wait 1s
  - look <[soviet]> <[target].eye_location>
  - shoot dynamiteproj origin:<[soviet].eye_location.right[0.4].below[0.8]> def:<[soviet]> shooter:<[soviet]> spread:0 height:6 script:dynamiteboom save:dynamitethrown5 destination:<[target]> gravity:0.0175
  - define dynaproj <entry[dynamitethrown5].shot_entity>
  - run dynamitetrail def:<[dynaproj]>
  - playsound at:<[soviet].eye_location> sound:entity_snowball_throw volume:2 pitch:0

shootinghook:
  type: task
  definitions: soviet|target
  script:
  - announce "<element[SKELETON].color_gradient[from=#E0D0C0;to=#C0C0C0]><element[ ]><element[KING].color_gradient[from=#FFC020;to=#800000]><&f><element[ &gt&gt ].unescaped>GET OVER HERE!"
  - playsound sound:custom.overhere pitch:1 volume:2 <[soviet].eye_location> custom
  - wait 35t
  - flag <[soviet]> grapplingrn
  - playsound sound:item_crossbow_shoot pitch:1 volume:1 <[soviet].eye_location>
  - look <[soviet]> <[target].eye_location.add[0,-1,0]>
  - shoot hook origin:<[soviet].eye_location> speed:6 spread:0 shooter:<[soviet]> save:lolhook2
  - define hookofinterest <entry[lolhook2].shot_entities.get[1]>
  - flag <[hookofinterest]> airborne
  - adjust <[hookofinterest]> pickup_status:disallowed
  - while <[hookofinterest].has_flag[airborne]>:
    - playeffect at:<[hookofinterest].location.points_between[<[soviet].location.add[0,1,0]>].distance[0.1]> effect:redstone special_data:0.3|<color[#000000]> offset:0 quantity:1 visibility:100
    - if <[loop_index]> > 400:
      - while stop
    - if !<[hookofinterest].location.line_of_sight[<[soviet].location.add[0,1,0]>]> || <[hookofinterest].location.distance[<[soviet].location.add[0,1,0]>]> > 100:
      - playeffect at:<[hookofinterest].location.points_between[<[soviet].location.add[0,1,0]>].distance[1]> effect:large_smoke offset:0 quantity:1 visibility:100
      - while stop
    - wait 1t
  - if !<[hookofinterest].is_in_block>:
    - playsound sound:block_note_block_didgeridoo pitch:0 volume:1 <[soviet].eye_location>
    - itemcooldown string duration:1s
    - flag <[soviet]> grapplingrn expire:1s
    - remove <[hookofinterest]>