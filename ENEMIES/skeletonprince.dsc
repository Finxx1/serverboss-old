skeletonprince:
  type: entity
  entity_type: husk
  mechanisms:
    age: adult
    max_health: 150
    health: 150
    equipment: <map[helmet=<item[air]>;chestplate=<item[air]>;leggings=<item[air]>;boots=<item[air]>]>
    item_in_hand: iron_sword
#    item_in_offhand: bow
    speed: 0.320

haunted_knight_suit:
  type: entity
  entity_type: armor_stand
  mechanisms:
    equipment: <map[helmet=<item[netherite_helmet]>;chestplate=<item[netherite_chestplate]>;leggings=<item[netherite_leggings]>;boots=<item[netherite_boots]>]>
    item_in_hand: netherite_sword
    item_in_offhand: shield

skeletonprincehandler:
  type: world
  events:
    after skeletonprince spawns:
    - flag <context.entity> fightingmode
    - libsdisguise player target:<context.entity> name:Wingonic hide_name
    - while <context.entity.is_spawned> && <context.entity.has_flag[fightingmode]>:
      - define parriablebitch <context.entity.eye_location.find_entities.within[10].exclude[<context.entity>].exclude[<context.entity.target>].filter_tag[<[filter_value].is_in_block.not>].get[1]>
      - if <[parriablebitch].is_projectile>:
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
        - heal <context.entity> 3
        - flag <[parriablebitch]> parried
        - wait 10t
        - while next
      - if <context.entity.target.eye_location.line_of_sight[<context.entity.eye_location>]> && <context.entity.target||0> != 0 && <context.entity.target.item_in_hand.script> != <script[sickle]> && <context.entity.target.item_in_hand.script> != <script[postalshovel]> && <context.entity.target.eye_location.distance[<context.entity.eye_location>]> > 3 && <util.random_chance[95]>:
        - if <context.entity.health> > 75 || <util.random_chance[50]>:
          - if <context.entity.target.eye_location.distance[<context.entity.eye_location>]> < 14:
            - adjust <context.entity> item_in_hand:bow
            - ~run shootingshit3_2 def:<context.entity>|<context.entity.target>
          - else if <context.entity.target.eye_location.distance[<context.entity.eye_location>]> > 14:
            - adjust <context.entity> item_in_hand:crossbow
            - ~run shootingshit4_2 def:<context.entity>|<context.entity.target>
        - else:
          - adjust <context.entity> item_in_hand:dynamite
          - ~run shootingshit5_2 def:<context.entity>|<context.entity.target>
      - else:
        - if <context.entity.target.item_in_hand.material.name> == shield || <context.entity.target.item_in_offhand.material.name> == shield:
          - adjust <context.entity> item_in_hand:stone_axe
        - else:
          - adjust <context.entity> item_in_hand:iron_sword
      - wait 2s
    on skeletonprince damaged:
    - attack <context.entity> <context.damager>
    - playsound at:<context.entity.eye_location> sound:entity_skeleton_hurt pitch:0 volume:1
    - playsound at:<context.entity.eye_location> sound:entity_wither_skeleton_hurt pitch:0.75 volume:1
    on skeletonprince dies:
    - explode <context.entity.eye_location> power:2
    - playsound at:<context.entity.eye_location> sound:entity_wither_block_break pitch:0 volume:2
    #- playeffect at:<context.entity.eye_location> effect:flash offset:0 quantity:1 visibility:100
    - playeffect at:<context.entity.eye_location> effect:block_crack special_data:bone_block offset:1 quantity:50 visibility:100
    - playeffect at:<context.entity.eye_location> effect:item_crack special_data:bone offset:2 quantity:50 visibility:100
    - remove <context.entity>
    on player right clicks haunted_knight_suit:
    - determine cancelled passively
    after haunted_knight_suit spawns:
    - waituntil <context.entity.location.find.living_entities.within[100].filter_tag[<[filter_value].is_player.not>].exclude[<context.entity>].get[1]||0> != 0 max:6s
    - if <context.entity.location.find.living_entities.within[100].filter_tag[<[filter_value].is_player.not>].exclude[<context.entity>].get[1]||0> == 0:
      - explode <context.entity.eye_location> power:2
      - playeffect at:<context.entity.eye_location> effect:flash offset:0 quantity:1 visibility:100
      - playsound at:<context.entity.eye_location> sound:entity_wither_death pitch:0 volume:2
      - playeffect at:<context.entity.eye_location> effect:flash offset:0 quantity:1 visibility:100
      - playeffect at:<context.entity.eye_location> effect:soul quantity:50 offset:2 visibility:100
      - playsound at:<context.entity.eye_location> sound:item_totem_use pitch:1 volume:1
      - playsound at:<context.entity.eye_location> sound:item_totem_use pitch:2 volume:1
      - playsound at:<context.entity.eye_location> sound:block_glass_break pitch:0 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_generic_explode pitch:1 volume:2
      - playsound at:<context.entity.eye_location> sound:block_anvil_land pitch:2 volume:5
      - foreach <context.entity.eye_location.find_entities.within[5].filter_tag[<[filter_value].eye_location.line_of_sight[<context.entity.eye_location>]>]>:
        - adjust <[value]> velocity:<[value].location.sub[<context.entity.location.sub[0,0.5,0]>].normalize>
      - remove <context.entity>
    - define protected <context.entity.location.find.living_entities.within[100].filter_tag[<[filter_value].is_player.not>].exclude[<context.entity>].get[1]>
    - flag <[protected]> blessed
    - while <context.entity.is_spawned>:
      - playeffect at:<context.entity.eye_location> effect:soul quantity:5 offset:1 visibility:100
      - playeffect at:<context.entity.location.add[0,1,0].points_between[<[protected].location.add[0,1,0]>].distance[<list[0.5|0.75].random>]> effect:soul_fire_flame quantity:1 offset:0.05 visibility:100
      - playeffect at:<[protected].eye_location> effect:soul quantity:5 offset:1 visibility:100
      - look <context.entity> <[protected].eye_location>
      - if !<[protected].is_spawned>:
        - playsound at:<context.entity.eye_location> sound:entity_wither_break_block pitch:0 volume:2
        - playsound at:<context.entity.eye_location> sound:entity_wither_break_block pitch:1 volume:2
        - playsound at:<context.entity.eye_location> sound:entity_wither_break_block pitch:2 volume:2
        - wait 5t
        - playeffect at:<context.entity.eye_location> effect:flash offset:0 quantity:1 visibility:100
        - playeffect at:<context.entity.eye_location> effect:soul quantity:50 offset:2 visibility:100
        - playsound at:<context.entity.eye_location> sound:item_totem_use pitch:1 volume:1
        - playsound at:<context.entity.eye_location> sound:item_totem_use pitch:2 volume:1
        - playsound at:<context.entity.eye_location> sound:block_glass_break pitch:0 volume:4
        - playsound at:<context.entity.eye_location> sound:entity_generic_explode pitch:1 volume:2
        - playsound at:<context.entity.eye_location> sound:block_anvil_land pitch:2 volume:5
        - foreach <context.entity.eye_location.find_entities.within[5].filter_tag[<[filter_value].eye_location.line_of_sight[<context.entity.eye_location>]>]>:
          - adjust <[value]> velocity:<[value].location.sub[<context.entity.location.sub[0,0.5,0]>].normalize.mul[2]>
        - remove <context.entity>
      - wait 2t
    - flag <[protected]> blessed:!
    on player damages entity priority:9999:
    - if <context.entity.has_flag[blessed]>:
      - determine cancelled passively 
      - playeffect at:<context.entity.eye_location> effect:flash offset:0 quantity:1 visibility:100
      - playsound <context.entity.eye_location> sound:item_totem_use pitch:2 volume:1
    on haunted_knight_suit damaged:
    - determine cancelled passively
    - playeffect at:<context.entity.eye_location> effect:flash offset:0 quantity:1 visibility:100
    - playeffect at:<context.entity.eye_location> effect:soul quantity:50 offset:2 visibility:100
    - playsound at:<context.entity.eye_location> sound:item_totem_use pitch:1 volume:1
    - playsound at:<context.entity.eye_location> sound:item_totem_use pitch:2 volume:1
    - playsound at:<context.entity.eye_location> sound:block_glass_break pitch:0 volume:4
    - playsound at:<context.entity.eye_location> sound:entity_generic_explode pitch:1 volume:2
    - playsound at:<context.entity.eye_location> sound:block_anvil_land pitch:2 volume:5
    - foreach <context.entity.eye_location.find_entities.within[5].filter_tag[<[filter_value].eye_location.line_of_sight[<context.entity.eye_location>]>]>:
      - adjust <[value]> velocity:<[value].location.sub[<context.entity.location.sub[0,0.5,0]>].normalize.mul[2]>
      #- cast <[value]> slow_falling duration:1s amplifier:0 no_icon hide_particles no_ambient
    - heal <context.damager> <context.damager.health_max>
    - remove <context.entity>

shootingshit3_2:
  type: task
  definitions: soviet|target
  script:
  - cast <[soviet]> slow duration:4s amplifier:2 no_icon hide_particles no_ambient
  - playsound at:<[soviet].eye_location> sound:block_anvil_destroy pitch:2 volume:5
  - wait 1.5s
  - define mvdir <list[-1|1].random.mul[0.075]>
  - repeat 4:
    - repeat 9:
      - adjust <[soviet]> velocity:<[soviet].velocity.add[<[soviet].eye_location.left[<[mvdir]>].forward[0.05].sub[<[soviet].eye_location>]>]>
      - look <[soviet]> <[target].eye_location.add[0,1,0]>
      - wait 1t
    - playsound at:<[soviet].eye_location> sound:custom.classic_bow_shoot pitch:1 volume:2 custom
    - look <[soviet]> <[target].eye_location.add[0,1,0]>
    - shoot arrow origin:<[soviet].eye_location.right[0.4].below[0.8]> speed:1.25 def:<[soviet]> shooter:<[soviet]> spread:15
    - if !<[soviet].has_flag[fightingmode]>:
      - stop
   
shootingshit4_2:
  type: task
  definitions: soviet|target
  script:
  - cast <[soviet]> slow duration:4s amplifier:7 no_icon hide_particles no_ambient
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_start pitch:1 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_start pitch:2 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_start pitch:0 volume:5
  - wait 1.2s
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_middle pitch:1 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_middle pitch:2 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_middle pitch:0 volume:5
  - wait 1.2s
  - inventory adjust slot:<[soviet].item_in_hand.slot> charged_projectiles:<list[<item[arrow[quantity=4]]>]>
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_end pitch:1 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_end pitch:2 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_loading_end pitch:0 volume:5
  - wait 1.2s
  - playsound at:<[soviet].eye_location> sound:item_crossbow_shoot pitch:1 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_shoot pitch:2 volume:5
  - playsound at:<[soviet].eye_location> sound:item_crossbow_shoot pitch:0 volume:5
  - if <[target].is_sprinting>:
    - look <[soviet]> <[target].eye_location.with_pitch[0].forward[2.5].add[0,1.5,0]>
  - else:
    - look <[soviet]> <[target].eye_location.add[0,1.5,0]>
  - shoot arrow[critical=true] origin:<[soviet].eye_location.right[0.4].below[0.8]> speed:3 def:<[soviet]> shooter:<[soviet]> spread:5

shootingshit5_2:
  type: task
  definitions: soviet|target
  script:
  - cast <[soviet]> slow duration:4s amplifier:5 no_icon hide_particles no_ambient
  - playsound at:<[soviet].eye_location> sound:item_flintandsteel_use pitch:1 volume:5
  - wait 15t
  - playsound at:<[soviet].eye_location> sound:entity_creeper_primed pitch:1 volume:5
  - wait 1.5s
  - look <[soviet]> <[target].eye_location>
  - shoot dynamiteproj origin:<[soviet].eye_location.right[0.4].below[0.8]> def:<[soviet]> shooter:<[soviet]> spread:0 height:6 script:dynamiteboom save:dynamitethrown5 destination:<[target]> gravity:0.0175
  - define dynaproj <entry[dynamitethrown5].shot_entity>
  - run dynamitetrail def:<[dynaproj]>
  - playsound at:<[soviet].eye_location> sound:entity_snowball_throw volume:2 pitch:0