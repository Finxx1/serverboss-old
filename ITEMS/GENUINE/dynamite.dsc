dynamite:
  type: item
  material: clay_ball
  display name: <element[Dynamite].color_gradient[from=#C03010;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374256
  lore:
  - <element[Boomstick! Litterally!].color_gradient[from=#601808;to=#606060]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

dynamitetriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:dynamite:
    - determine cancelled passively
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:1
    - take item_in_hand quantity:1
    - shoot dynamiteproj speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:dynamiteboom save:dynamitethrown
    - define dynaproj <entry[dynamitethrown].shot_entity>
    - run dynamitetrail def:<[dynaproj]>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0

dynamiteboom:
  type: task
  debug: false
  script:
  - explode <[location]> power:4



holydynamite:
  type: item
  material: clay_ball
  display name: <element[Holy Dynamite].color_gradient[from=#FFFF10;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374257
  lore:
  - <element[The righteous hand of the Father].color_gradient[from=#808008;to=#606060]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

holydynamitetriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:holydynamite:
    - determine cancelled passively
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:1
    - take item_in_hand quantity:1
    - shoot holydynamiteproj speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:holydynamiteboom save:holydynamitethrown
    - define holydynaproj <entry[holydynamitethrown].shot_entity>
    - run holydynamitetrail def:<[holydynaproj]>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0

holydynamiteboom:
  type: task
  debug: false
  script:
  - playeffect effect:end_rod quantity:60 at:<[location]> offset:0.5 visibility:100
  - explode <[location]> power:1
  - wait 5t 
  - playsound at:<[location]> sound:custom.halelujah volume:2 pitch:1 custom
  - wait 39t
  - playeffect effect:end_rod quantity:600 at:<[location]> offset:4 visibility:100
  - foreach <[location].find_entities.within[8].exclude[<[shot_entity]>]>:
    - strike <[value].location>
    - wait 3t

nucleardynamite:
  type: item
  material: clay_ball
  display name: <element[Nuclear Dynamite].color_gradient[from=#208040;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374258
  lore:
  - <element[Sanctified with dynamite!].color_gradient[from=#104020;to=#606060]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

nucleardynamitetriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:nucleardynamite:
    - determine cancelled passively
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:0
    - take item_in_hand quantity:1
    - shoot nucleardynamiteproj speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:nucleardynamiteboom save:nucleardynamitethrown
    - define nucleardynaproj <entry[nucleardynamitethrown].shot_entity>
    - run nucleardynamitetrail def:<[nucleardynaproj]>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0

nucleardynamiteboom:
  type: task
  debug: false
  script:
  - if !<[hit_entities].is_empty>:
    - define entityhit <[hit_entities].get[1]>
  - else:
    - define entityhit 0
  - spawn nucleardynamiteproj[gravity=false;has_ai=false] <[location]> save:ndyn
  - define ncdyna <entry[ndyn].spawned_entity>
  - run dynatick def:<[ncdyna]>|<[entityhit]>

dynatick:
  type: task
  debug: false
  definitions: entexplosive|entsticky
  script:
  - if <[entsticky]||0> != 0:
    - attach <[entexplosive]> to:<[entsticky]>
    - playsound <[entsticky].location> sound:entity_sheep_shear pitch:0 volume:2
    - playsound <[entsticky].location> sound:block_stone_button_click_off pitch:0 volume:2
    - repeat 10:
      - adjust <[entexplosive]> velocity:<location[0,0,0]>
      - adjust <[entexplosive]> gravity:false
      - playsound <[entsticky].location> sound:block_note_block_hat pitch:2 volume:2
      - wait 5t
      - playsound <[entsticky].location> sound:block_note_block_hat pitch:1.85 volume:2
      - wait 5t
    - if <[entexplosive].is_spawned>:
      - run nuclearblast def:<[entsticky].location>
  - else:
    - playsound <[entexplosive].location> sound:entity_sheep_shear pitch:0 volume:2
    - playsound <[entexplosive].location> sound:block_stone_button_click_off pitch:0 volume:2
    - repeat 10:
      - adjust <[entexplosive]> velocity:<location[0,0,0]>
      - adjust <[entexplosive]> gravity:false
      - playsound <[entexplosive].location> sound:block_note_block_hat pitch:2 volume:2
      - wait 5t
      - playsound <[entexplosive].location> sound:block_note_block_hat pitch:1.85 volume:2
      - wait 5t
    - if <[entexplosive].is_spawned>:
      - run nuclearblast def:<[entexplosive].location>
  - remove <[entexplosive]>

explsilent:
  type: task
  debug: false
  definitions: exploc2|expower
  script:
  - foreach <[exploc2].find_entities.within[<[expower]>]||0>:
    - adjust <[value]> velocity:<[value].velocity.add[<[value].eye_location.sub[<[exploc2]>].normalize.mul[<[expower].div[3]>]>]>
    - hurt <[value]> <[expower].mul[2]> cause:ENTITY_EXPLOSION
  - if <[expower]> <= 1:
    - playeffect effect:explosion_large at:<[exploc2]> visibility:100 quantity:1 offset:0.05
  - else:
    - repeat 4:
      - playeffect effect:explosion_large at:<[exploc2]> visibility:100 quantity:2 offset:3
      - wait 1t

nuclearblast:
  type: task
  debug: false
  definitions: exploc
  script: 
  - run explsilent def:<[exploc]>|<element[7]>
  - playsound at:<[exploc]> sound:custom.nuke pitch:1 volume:10 custom
  - playsound at:<[exploc]> sound:custom.nuke pitch:2 volume:10 custom
  - repeat 20:
    - foreach <proc[particle_ring].context[<[exploc]>|15|<[value]>]> as:place:
      - run explsilent def:<[place]>|<element[1]>
      - playeffect effect:flame quantity:15 offset:0.5 visibility:100 at:<[place]>
      - playeffect effect:smoke_large quantity:15 offset:0.5 visibility:100 at:<[place]>
    - run explsilent def:<[exploc].add[0,<[value]>,0]>|<element[2]>
    - playeffect effect:flame quantity:120 offset:3 visibility:100 at:<[exploc].add[0,<[value]>,0]>
    - playeffect effect:smoke_large quantity:120 offset:3 visibility:100 at:<[exploc].add[0,<[value]>,0]>
    - wait 1t
    - playeffect effect:redstone quantity:25 special_data:2|<color[#208040]> at:<[exploc]> offset:5,0,5  visibility:100
  - foreach <proc[particle_ring].context[<[exploc].add[0,10,0]>|25|10]> as:place:
    - run explsilent def:<[place]>|<element[1]>
    - playeffect effect:flame quantity:15 offset:0.5 visibility:100 at:<[place]>
    - playeffect effect:smoke_large quantity:15 offset:0.5 visibility:100 at:<[place]>
  - foreach <proc[particle_ring].context[<[exploc].add[0,25,0]>|25|5]> as:place:
    - run explsilent def:<[place]>|<element[4]>
    - playeffect effect:flame quantity:120 offset:3 visibility:100 at:<[place]>
    - playeffect effect:smoke_large quantity:120 offset:3 visibility:100 at:<[place]>
  - repeat 9:
    - playeffect effect:flame quantity:120 offset:3 visibility:100 at:<[exploc]>
    - playeffect effect:smoke_large quantity:120 offset:3 visibility:100 at:<[exploc]>
  - define cuboidhurty <[exploc].add[7,1,7].to_cuboid[<[exploc].sub[7,0.25,7]>]>
  - run geigersfx def:<[exploc]>
  - repeat 80:
    - wait 3t
    - playeffect effect:redstone quantity:35 special_data:2|<color[#208040]> at:<[exploc]> offset:7,1,7  visibility:100
    - if <[cuboidhurty].entities||0> != 0:
      - foreach <[cuboidhurty].entities>:
        - hurt <[value]> amount:2
        - cast <[value]> poison duration:4t amplifier:0 no_icon hide_particles no_ambient
        - cast <[value]> slow duration:4t amplifier:2 no_icon hide_particles no_ambient
        - cast <[value]> slow_digging duration:4t amplifier:2 no_icon hide_particles no_ambient
        - cast <[value]> confusion duration:5s amplifier:20 no_icon hide_particles no_ambient
        - if <[value].is_player>:
          - playeffect effect:redstone quantity:100 special_data:0.1|<color[#208040]> at:<[value].eye_location> offset:0.6 visibility:10 targets:<[value]>

geigersfx:
  type: task
  debug: false
  definitions: soundloc
  script:
  - repeat 12:
    - playsound <[soundloc]> sound:custom.geiger pitch:1 volume:2 custom
    - wait 1s


jumperdynamite:
  type: item
  material: clay_ball
  display name: <element[Jumper's Dynamite].color_gradient[from=#FF8000;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374259
  lore:
  - <element[SCREAMING EAGLES!].color_gradient[from=#804000;to=#606060]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

jumperdynamitetriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:jumperdynamite:
    - determine cancelled passively
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:1
    - take item_in_hand quantity:1
    - shoot jumperdynamiteproj speed:2 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:jumperdynamiteboom save:jumperdynamitethrown
    - define jumperdynaproj <entry[jumperdynamitethrown].shot_entity>
    - run jumperdynamitetrail def:<[jumperdynaproj]>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0

jumperdynamiteboom:
  type: task
  debug: false
  script:
  #- explode <[location]> power:4
  - playsound at:<[location]> sound:entity_wither_shoot volume:2 pitch:0
  - foreach <[location].find_entities.within[5]>:
    - adjust <[value]> velocity:<[value].velocity.add[<[value].eye_location.sub[<[location]>].normalize.div[<[value].eye_location.distance[<[location]>].mul[0.1].add[0.45]>]>].add[0,0.25,0]>
  - playeffect effect:large_explode quantity:30 at:<[location]> offset:1 visibility:100
  - repeat 160:
    - playeffect effect:cloud quantity:1 at:<[location]> offset:2.25 visibility:100 velocity:<location[0,0,0].random_offset[1]>
    - playeffect effect:smoke quantity:1 at:<[location]> offset:2.25 visibility:100 velocity:<location[0,0,0].random_offset[1]>

armingdynamite:
  type: item
  material: clay_ball
  display name: <element[Arming Dynamite].color_gradient[from=#808080;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374260
  lore:
  - <element[I DONT KNOW, BUT I'VE BEEN TOLD].color_gradient[from=#404040;to=#606060]>
  - <element[STAINLESS STEEL IS HARD TO FOLD].color_gradient[from=#404040;to=#606060]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

armingdynamitetriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:armingdynamite:
    - determine cancelled passively
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:1
    - take item_in_hand quantity:1
    - shoot armingdynamiteproj speed:2 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:armingdynamiteboom save:armingdynamitethrown
    - define armingdynaproj <entry[armingdynamitethrown].shot_entity>
    - run armingdynamitetrail def:<[armingdynaproj]>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0

armingdynamiteboom:
  type: task
  debug: false
  script:
  - explode <[location]> power:2
  - playsound at:<[location]> sound:block_anvil_land volume:2 pitch:0
  - foreach <[location].find_entities.within[5]>:
    - if !<[value].is_player>:
      - if <[value].item_in_hand.material.name> == air:
        - adjust <[value]> item_in_hand:iron_sword[unbreakable=true]
      - if <[value].item_in_offhand.material.name> == air:
        - adjust <[value]> item_in_offhand:iron_sword[unbreakable=true]
      - if <[value].equipment.get[4].material.name> == air:
        - adjust <[value]> equipment:[helmet=iron_helmet[unbreakable=true]]
      - run agressiontask def:<[value]>

agressiontask:
  type: task
  definitions: agressor
  debug: false
  script:
  - repeat 120:
    - define closesttarget <[agressor].eye_location.find.living_entities.within[10].filter_tag[<[filter_value].eye_location.line_of_sight[<[agressor].eye_location>]>].exclude[<[agressor]>].get[1]||0>
    - if <[closesttarget]> != 0:
      - attack <[agressor]> target:<[closesttarget]>
    - wait 5t

stickybomb:
  type: item
  material: clay_ball
  display name: <element[Stickybomb].color_gradient[from=#FF6000;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374261
  lore:
  - <element[OOOOOH THEY'RE GONNA HAVE T'GLUE YOU BACK TOGETHER...].color_gradient[from=#803000;to=#606060]>
  - <element[IN HELL!].color_gradient[from=#803000;to=#606060]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

stickybombtriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:stickybomb:
    - determine cancelled passively
    #- playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:1
    - take item_in_hand quantity:1
    - shoot stickybombproj speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> save:stickybombthrown
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:1

stickyblow:
  type: task
  debug: false
  definitions: entexplosive|entsticky
  script:
  - if <[entsticky]||0> != 0:
    - attach <[entexplosive]> to:<[entsticky]>
    - playsound <[entsticky].location> sound:entity_sheep_shear pitch:0 volume:2
    - playsound <[entsticky].location> sound:block_stone_button_click_off pitch:0 volume:2
    - repeat 8:
      - adjust <[entexplosive]> velocity:<location[0,0,0]>
      - adjust <[entexplosive]> gravity:false
      - playsound <[entsticky].location> sound:block_note_block_hat pitch:2 volume:2
      - wait 4t
      - playsound <[entsticky].location> sound:block_note_block_hat pitch:1.85 volume:2
      - wait 4t
    - if <[entexplosive].is_spawned>:
      - explode <[entsticky].location> power:2
  - else:
    - playsound <[entexplosive].location> sound:entity_sheep_shear pitch:0 volume:2
    - playsound <[entexplosive].location> sound:block_stone_button_click_off pitch:0 volume:2
    - repeat 8:
      - adjust <[entexplosive]> velocity:<location[0,0,0]>
      - adjust <[entexplosive]> gravity:false
      - playsound <[entexplosive].location> sound:block_note_block_hat pitch:2 volume:2
      - wait 4t
      - playsound <[entexplosive].location> sound:block_note_block_hat pitch:1.85 volume:2
      - wait 4t
    - if <[entexplosive].is_spawned>:
      - explode <[entexplosive].location> power:2
  - remove <[entexplosive]>

stickystick:
  type: task
  debug: false
  script:
  - if !<[hit_entities].is_empty>:
    - define entityhit <[hit_entities].get[1]>
  - else:
    - define entityhit 0
  - spawn stickybombproj[gravity=false;has_ai=false] <[location]> save:stickypj
  - define stickybobme <entry[stickypj].spawned_entity>
  - run stickyblow def:<[stickybobme]>|<[entityhit]>


glassencase:
  debug: false
  definitions: wetentity
  type: task
  script:
    - flag <[wetentity]> mgk_frozen expire:80t
    - define loc <[wetentity].location.block.add[0.5,0,0.5]>
    - define awarenessEnt <[wetentity].has_ai>
    - adjust <[wetentity]> velocity:<location[0,0,0]>
    - adjust <[wetentity]> gravity:false
    - adjust <[wetentity]> has_ai:false
    - teleport <[wetentity]> <[loc].with_pose[<[wetentity].eye_location.pitch>,<[wetentity].eye_location.yaw>]> 
    - repeat 4:
      - cast <[wetentity]> slow duration:21t amplifier:7 no_icon hide_particles no_ambient
      - modifyblock <[loc]> glass
      - modifyblock <[loc].add[0,1,0]> glass
      - adjust <[wetentity]> velocity:<location[0,0,0]>
      - wait 20t
      - playeffect effect:block_crack special_data:glass quantity:16 at:<[loc].add[0,1,0]> offset:0.4,0.5,0.4
      - playsound <[loc]> sound:block_glass_hit pitch:0.85 volume:1
    - playeffect effect:block_crack special_data:glass quantity:128 at:<[loc].add[0,1,0]> offset:0.4,0.5,0.4
    - playsound <[loc]> sound:block_glass_break pitch:0.85 volume:1
    - modifyblock <[loc]> air no_physics
    - modifyblock <[loc].add[0,1,0]> air no_physics
    - adjust <[wetentity]> gravity:true
    - adjust <[wetentity]> has_ai:<[awarenessEnt]>

glassamyte:
  type: item
  material: clay_ball
  display name: <element[Glass Dynamite].color_gradient[from=#80FFFF;to=#FFFFFF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374304
  lore:
  - <element[Fragile! AND explosive!].color_gradient[from=#408080;to=#808080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

glassdynamitetriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:glassamyte:
    - determine cancelled passively
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:1
    - take item_in_hand quantity:1
    - shoot glassdynamiteproj speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:glassdynamiteboom save:gdynamitethrown def:<player>
    - define gdynaproj <entry[gdynamitethrown].shot_entity>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0

glassdynamiteboom:
  type: task
  debug: false
  definitions: avoidhit
  script:
  - explode <[location]> power:2
  - repeat 128:
    - playeffect at:<[location]> effect:item_crack special_data:glassamyte visibility:100 velocity:<location[0,0,0].random_offset[1]> quantity:2 offset:0.5
  - repeat 128:
    - playeffect at:<[location]> effect:item_crack special_data:glassamyte visibility:100 velocity:<location[0,0,0].random_offset[1]> quantity:2 offset:0.5
  - repeat 128:
    - playeffect at:<[location]> effect:item_crack special_data:glassamyte visibility:100 velocity:<location[0,0,0].random_offset[1]> quantity:2 offset:0.5
  - repeat 5:
    - playsound <[location]> sound:block_glass_break pitch:2 volume:2
    - playsound <[location]> sound:block_glass_break pitch:1 volume:2
    - playsound <[location]> sound:block_glass_break pitch:0 volume:2
  - foreach <[location].find.living_entities.within[4].exclude[<[avoidhit]>]>:
    - run glassencase def:<[value]>

australium:
  type: item
  material: gold_ingot
  display name: <element[Australium].color_gradient[from=#FF8000;to=#FFC000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374225
  lore:
  - <element[A craving satisfied].color_gradient[from=#804000;to=#806000]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

midasdynamite:
  type: item
  material: clay_ball
  display name: <element[Midas Dynamite].color_gradient[from=#FFC000;to=#FF8000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374305
  lore:
  - <element[His curse forevermore].color_gradient[from=#806000;to=#804000]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

midasdynamitetriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:midasdynamite:
    - determine cancelled passively
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:1
    - take item_in_hand quantity:1
    - shoot midasdynamiteproj speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:midasdynamiteboom save:mdynamitethrown def:<player>
    - define mdynaproj <entry[mdynamitethrown].shot_entity>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0

midasdynamiteboom:
  type: task
  debug: false
  definitions: avoidhit
  script:
  - explode <[location]> power:2
  - playsound sound:entity_player_levelup volume:2 pitch:0 at:<[location]>
  - playsound sound:entity_player_levelup volume:2 pitch:1 at:<[location]>
  - playsound sound:entity_player_levelup volume:2 pitch:2 at:<[location]>
  - wait 1t
  - foreach <[location].find.living_entities.within[5].exclude[<[avoidhit]>]||0>:
    - playsound at:<[value].location> sound:block_chain_place pitch:0 volume:1
    - playsound at:<[value].location> sound:entity_arrow_hit_player pitch:0 volume:1
    - run dolarspawn def:<[value].health_max.mul[0.25]>|0.3|<[value].location>
    - drop australium <[value].location> quantity:<[value].health_max.mul[0.05]> delay:20t speed:0.1

chemicaldynamite:
  type: item
  material: clay_ball
  display name: <element[Chemical Dynamite].color_gradient[from=#00FF60;to=#6000FF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374307
  lore:
  - <element[You're not supposed to have this item, you know?].color_gradient[from=#008030;to=#300080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>


reactiondynamite:
  type: item
  material: clay_ball
  display name: <element[Reaction Dynamite].color_gradient[from=#00FF60;to=#6000FF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374306
  lore:
  - <element[Its irridescent hues are hypnotizing].color_gradient[from=#008030;to=#300080]>
  - <element[Admit it, you want to use it].color_gradient[from=#008030;to=#300080]>
  - <element[But it must be used in the best place possible].color_gradient[from=#008030;to=#300080]>
  - <element[Fireworks like these are not for wasting].color_gradient[from=#008030;to=#300080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

reactiondynamitetriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:reactiondynamite:
    - determine cancelled passively
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:1
    - take item_in_hand quantity:1
    - shoot reactiondynamiteproj speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:reactiondynamiteboom save:rdynamitethrown def:<player>
    - define rdynaproj <entry[rdynamitethrown].shot_entity>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0
    - playsound at:<player.eye_location> sound:block_fire_extinguish volume:2 pitch:0
    - run reactiondynamitetrail def:<[rdynaproj]>


reactiondynamiteboom:
  type: task
  debug: false
  definitions: avoidhit
  script:
  - explode <[location]> power:<list[3|4|5].random>
  - playsound at:<[location]> sound:block_fire_extinguish volume:2 pitch:0
  - repeat 6:
    - shoot chemicaldynamiteproj speed:0.55 spread:5 origin:<[location]> destination:<[location].add[0,0.5,0].random_offset[1,0.2,1]> script:chemicaldynamiteboom def:<player>
  - if <util.random_chance[70]>:
    - shoot reactiondynamiteproj speed:0.65 spread:5 origin:<[location]> destination:<[location].add[0,1.5,0].random_offset[1,0.2,1]> script:reactiondynamiteboom save:rdynamitethrown def:<player>
    - define rdynaproj <entry[rdynamitethrown].shot_entity>
    - run reactiondynamitetrail def:<[rdynaproj]>
# HAPPEN!!!
  - repeat 6:
    - playeffect at:<[location]> offset:<list[1.8|2.2|2.4].random> quantity:64 effect:redstone special_data:2.5|<color[#<list[00FFFF|0080FF|00FF80|0000FF|8000FF].random>]> visibility:100
  - foreach <[location].find.living_entities.within[6].exclude[<[avoidhit]>]||0>:
    - cast <[value]> poison duration:<list[60t|120t|180t].random>

chemicaldynamiteboom:
  type: task
  debug: false
  definitions: avoidhit
  script:
  - explode <[location]> power:<list[1|2|3].random>
  - playsound at:<[location]> sound:block_fire_extinguish volume:2 pitch:1
  - define colrR <list[00FFFF|0080FF|00FF80|0000FF|8000FF].random>
  - repeat 6:
    - playeffect at:<[location]> offset:<list[1.8|2.2|2.4].random> quantity:64 effect:redstone special_data:2.5|<color[#<[colrR]>]> visibility:100
  - foreach <[location].find.living_entities.within[5].exclude[<[avoidhit]>]||0>:
    - cast <[value]> poison duration:<list[60t|120t|180t].random>