poisonapple:
  type: item
  material: clay_ball
  display name: <element[Poison Apple].color_gradient[from=#408020;to=#606060]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374248
  lore:
  - <element[what the fuck is this, snow white?].color_gradient[from=#204010;to=#303030]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

poisontriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:poisonapple:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot poisonappleproj speed:0.85 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.2]> script:poisoning save:applesss
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0
    - define appleproj <entry[applesss].shot_entity>
    - run poisonappletrail def:<[appleproj]>

poisoning:
  type: task
  debug: false
  script:
  - playeffect effect:redstone quantity:200 special_data:2|<color[#80FF00]> at:<[location]> offset:1.25  visibility:100
  - playsound sound:entity_creeper_hurt pitch:0 at:<[location]> volume:2
  - playsound sound:entity_creeper_death pitch:0 at:<[location]> volume:2
  - playsound sound:entity_generic_extinguish_fire pitch:0 at:<[location]> volume:2
  - playsound sound:entity_zombie_villager_cure pitch:0 at:<[location]> volume:2
  - define motherfucker <[location].find.living_entities.within[3]||null>
  - if <[motherfucker]> == null:
    - stop
  - foreach <[motherfucker]>:
    - adjust <[value]> velocity:<[value].velocity.add[<[value].eye_location.sub[<[location]>].normalize.div[<[value].eye_location.distance[<[location]>].mul[0.2].add[1]>]>]>
    - hurt <[value]> amount:3
    - cast <[value]> poison duration:6s amplifier:2 no_icon