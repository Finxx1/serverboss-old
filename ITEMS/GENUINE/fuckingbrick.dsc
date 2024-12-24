fuckingbrick:
  type: item
  material: clay_ball
  display name: <element[BRICK].color_gradient[from=#C84C40;to=#A83C30]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374321
  lore:
  - <element[ITS A FUCKING BRICK].color_gradient[from=#642620;to=#A41618]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

bricktriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:fuckingbrick:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot brickproj speed:0.85 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.2]> script:brickhit save:woebrickbeuponye
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0
    #- define bananathrown <entry[woebrickbeuponye].shot_entity>
    #- run banana def:<[banany]>

brickhit:
  type: task
  debug: false
  script:
  - define hitmotherfucker <[hit_entities].get[1]||0>
  - playsound sound:block_stone_break pitch:1 at:<[location]> volume:2
  - playsound sound:entity_armor_stand_break pitch:1 at:<[location]> volume:2
  - hurt <[hitmotherfucker]> amount:10 source:<player>
  - adjust <[hitmotherfucker]> velocity:<[hit_entities].get[1].velocity.add[<[value].eye_location.sub[<[location]>].normalize.div[<[hit_entities].get[1].eye_location.distance[<[location]>].mul[0.1].add[0.5]>]>].add[0,0.25,0].mul[0.25]>