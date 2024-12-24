jarpeas:
  type: item
  material: clay_ball
  display name: <element[Jar of Peas].color_gradient[from=#008000;to=#808000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374368
  lore:
  - <element[You know what happens to people who are wrong?].color_gradient[from=#004000;to=#404000]>
  - <element[They DIE!!!].color_gradient[from=#004000;to=#404000]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

jarpeasthrown:
  type: entity
  entity_type: snowball
  mechanisms:
    item: jarpeas

pea:
  type: entity
  entity_type: snowball
  mechanisms:
    item: peas

peas:
  type: item
  material: clay_ball
  display name: <element[pea].color_gradient[from=#008000;to=#808000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374369
  lore:
  - <element[pea].color_gradient[from=#004000;to=#404000]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

jarate:
  type: item
  material: clay_ball
  display name: <element[Jarate].color_gradient[from=#80FFFF;to=#FFC000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374308
  lore:
  - <element[Is this...].color_gradient[from=#408080;to=#806000]>
  - <element[MON DIEU!!!].color_gradient[from=#408080;to=#806000]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

peatriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:jarpeas:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot jarpeasthrown speed:0.8 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:peasplash def:<player>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0

jaratetriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:jarate:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot jarateproj speed:0.8 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:jaratesplash def:<player>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0
    on entity damaged:
    - if <context.entity.has_flag[jarated]>:
      - determine <context.damage.mul[1.35]> passively
      - playsound at:<context.entity.eye_location> sound:entity_arrow_hit_player pitch:2 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_zombie_break_wooden_door pitch:2 volume:2

jaratesplash:
  type: task
  debug: false
  definitions: avoidhit
  script:
  - repeat 128:
    - playeffect at:<[location]> effect:item_crack special_data:glassamyte visibility:100 velocity:<location[0,0,0].random_offset[0.5]> quantity:2 offset:0.5
  - repeat 16:
    - playeffect at:<[location]> effect:redstone special_data:2|<color[#FFC000]> visibility:100 quantity:16 offset:1.5
  - playsound <[location]> sound:block_glass_break pitch:1 volume:2
  - playsound <[location]> sound:block_glass_break pitch:0 volume:2
  - playsound <[location]> sound:entity_generic_splash pitch:1 volume:2
  - playsound <[location]> sound:entity_generic_splash pitch:0 volume:2
  - foreach <[location].find.living_entities.within[4].exclude[<[avoidhit]>]>:
    - if !<[value].has_flag[jarated]>:
      - run jaratecoat def:<[value]>
    - flag <[value]> jarated expire:120t

jaratecoat:
  type: task
  debug: false
  definitions: coated
  script:
  - wait 2t
  - while <[coated].has_flag[jarated]>:
    - playeffect at:<[coated].location.add[0,1,0]> effect:falling_dust offset:0.25,0.4,0.25 quantity:4 special_data:pumpkin visibility:100
    - wait 5t
    - if <[loop_index]> > 24:
      - while stop

madmilk:
  type: item
  material: clay_ball
  display name: <element[Mad Milk].color_gradient[from=#80FFFF;to=#FFFFD0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374309
  lore:
  - <element[That just ain't right!].color_gradient[from=#408080;to=#808068]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

madmilktriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:madmilk:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot madmilkproj speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:madmilksplash def:<player>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0.75
    on entity damaged:
    - if <context.entity.has_flag[madmilked]>:
      - heal <context.damager> <context.damage.mul[0.35]>
    on pea hits entity:
    - playsound at:<context.hit_entity.eye_location> sound:custom.gib volume:0.7 pitch:2 custom
    - hurt <context.hit_entity> amount:4
    - if !<context.entity.has_flag[gascoated]>:
      - flag <context.entity> gascoated expire:12s
      - run gascoatentity def:<context.hit_entity>
    - determine cancelled passively
    on pea hits block:
    - playsound at:<context.location.eye_location> sound:custom.gib volume:0.7 pitch:2 custom
    - if <context.hit_face> == <location[0,1,0]> && ( <context.location.add[0,1,0].material.name> == air || <context.location.add[0,1,0].material.name> == structure_void ) && !<context.location.add[0,1,0].block.has_flag[burningup]>:
      - run gascoat def:<context.location.add[0,1,0].block>

peasplash:
  type: task
  debug: false
  definitions: avoidhit
  script:
  - repeat 64:
    - playeffect at:<[location]> effect:item_crack special_data:glassamyte visibility:100 velocity:<location[0,0,0].random_offset[0.5]> quantity:2 offset:0.5
  - repeat 16:
    - playeffect at:<[location]> effect:redstone special_data:2|<color[#808000]> visibility:100 quantity:6 offset:0.35
  - playsound <[location]> sound:block_glass_break pitch:1.5 volume:2
  - playsound <[location]> sound:block_glass_break pitch:0.75 volume:2
  - playsound <[location]> sound:entity_generic_splash pitch:0 volume:2
  - playsound <[location]> sound:block_honey_break pitch:0 volume:2
  - repeat 32:
    - spawn pea[velocity=<location[0,0.3,0].random_offset[0.25,0.125,0.25]>] <[location]>

madmilksplash:
  type: task
  debug: false
  definitions: avoidhit
  script:
  - repeat 128:
    - playeffect at:<[location]> effect:item_crack special_data:glassamyte visibility:100 velocity:<location[0,0,0].random_offset[0.5]> quantity:2 offset:0.5
  - repeat 16:
    - playeffect at:<[location]> effect:redstone special_data:2|<color[#FFFFD0]> visibility:100 quantity:12 offset:1.25
  - playsound <[location]> sound:block_glass_break pitch:1.5 volume:2
  - playsound <[location]> sound:block_glass_break pitch:0.75 volume:2
  - playsound <[location]> sound:entity_generic_splash pitch:1.5 volume:2
  - playsound <[location]> sound:entity_generic_splash pitch:0.75 volume:2
  - foreach <[location].find.living_entities.within[4].exclude[<[avoidhit]>]>:
    - if !<[value].has_flag[madmilked]>:
      - run madmilkcoat def:<[value]>
    - flag <[value]> madmilked expire:120t

madmilkcoat:
  type: task
  debug: false
  definitions: coated
  script:
  - wait 2t
  - while <[coated].has_flag[madmilked]>:
    - playeffect at:<[coated].location.add[0,1,0]> effect:falling_dust offset:0.25,0.4,0.25 quantity:3 special_data:smooth_quartz visibility:100
    - wait 5t
    - if <[loop_index]> > 24:
      - while stop

nitrojar:
  type: item
  material: clay_ball
  display name: <element[Nitroglycerin Jar].color_gradient[from=#80FFFF;to=#C04040]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374322
  lore:
  - <element[This is so fucking unsafe].color_gradient[from=#408080;to=#602020]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

nitrojartriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:nitrojar:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot nitroproj speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:nitrosplash def:<player>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:1
    on entity damaged:
    - if <context.entity.has_flag[nitroed]>:
      - flag <context.entity> nitroed:!
      - explode <context.entity.eye_location> power:3
      - hurt <context.entity> amount:10 cause:FIRE
      - burn <context.entity> duration:40t

nitrosplash:
  type: task
  debug: false
  definitions: avoidhit
  script:
  - repeat 128:
    - playeffect at:<[location]> effect:item_crack special_data:glassamyte visibility:100 velocity:<location[0,0,0].random_offset[0.5]> quantity:2 offset:0.5
  - if <util.random_chance[10]>:
    - explode <[location]> power:5
    - stop
  - repeat 16:
    - playeffect at:<[location]> effect:redstone special_data:2|<color[#C04040]> visibility:100 quantity:12 offset:1
  - playsound <[location]> sound:block_glass_break pitch:2 volume:2
  - playsound <[location]> sound:block_glass_break pitch:1 volume:2
  - playsound <[location]> sound:entity_generic_splash pitch:2 volume:2
  - playsound <[location]> sound:entity_generic_splash pitch:1 volume:2
  - foreach <[location].find.living_entities.within[3].exclude[<[avoidhit]>]>:
    - if !<[value].has_flag[nitroed]>:
      - run nitrocoat def:<[value]>
    - flag <[value]> nitroed expire:120t

nitrocoat:
  type: task
  debug: false
  definitions: coated
  script:
  - wait 2t
  - while <[coated].has_flag[nitroed]>:
    - playeffect at:<[coated].location.add[0,1,0]> effect:falling_dust offset:0.25,0.4,0.25 quantity:3 special_data:pink_terracotta visibility:100
    - wait 5t
    - if <[loop_index]> > 24:
      - while stop