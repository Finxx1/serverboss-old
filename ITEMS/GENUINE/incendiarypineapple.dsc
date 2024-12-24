ipineapple:
  type: item
  material: clay_ball
  display name: <element[Incendiary Pineapple].color_gradient[from=#FF8000;to=#FFFF00]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374249
  lore:
  - <element[Spicy!].color_gradient[from=#804000;to=#808000]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

ipineappletriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:ipineapple:
    - ratelimit <player> 40t
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot pineappleproj speed:0.85 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.2]> script:molotov2 save:pineapplesss
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0
    - define pineappleproj <entry[pineapplesss].shot_entity>
    - run pineappletrail def:<[pineappleproj]>

molotov:
  type: task
  debug: false
  script:
  - explode <[location]> power:3
  - define newloc <[location].sub[0,0.5,0]>
  - define fireplace <[newloc].sub[2,0,2].to_cuboid[<[newloc].add[2,2,2]>]>
  - playsound sound:entity_creeper_explode pitch:0 at:<[newloc]> volume:2
  - playsound sound:custom.gib pitch:1 at:<[newloc]> volume:2 custom
  - playsound sound:entity_generic_extinguish_fire pitch:0 at:<[newloc]> volume:2
  - run molotovsfx def:<[newloc]>
  - playsound sound:block_fire_ambient pitch:0 at:<[newloc]> volume:2
  - repeat 450:
    - playeffect at:<[newloc]> effect:flame offset:6,0.01,6 quantity:1 velocity:<location[0,0.2,0].random_offset[0.25,0.5,0.25]> visibility:100
  - playeffect at:<[newloc]> effect:lava offset:1,0,1 quantity:125 visibility:100
  - repeat 54:
    - define motherfucker <[fireplace].entities||null>
    - repeat 90:
      - playeffect at:<[newloc]> effect:flame offset:6,0.01,6 quantity:1 velocity:<location[0,0.1,0].random_offset[0.025,0.15,0.025]> visibility:100
    - playeffect at:<[newloc]> effect:lava offset:1.5,0,1.5 quantity:25 visibility:100
    - if !<[motherfucker]> != null:
      - foreach <[motherfucker]>:
        - hurt <[value]> amount:3
        - burn <[value]> duration:6s
    - wait 3t

molotov2:
  type: task
  debug: false
  script:
  - explode <[location]> power:3
  - foreach <[location].find.surface_blocks.within[2.5]>:
    - run burnspot def:<[value].add[0,0.5,0]>

molotovsfx:
  type: task
  debug: false
  definitions: locplay
  script:
  - wait 2s
  - playsound sound:block_fire_ambient pitch:0 at:<[locplay]> volume:2
  - wait 2s
  - playsound sound:block_fire_ambient pitch:0 at:<[locplay]> volume:2