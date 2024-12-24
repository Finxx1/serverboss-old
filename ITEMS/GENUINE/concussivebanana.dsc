cbanana:
  type: item
  material: clay_ball
  display name: <element[Concussive Banana].color_gradient[from=#C0C000;to=#808080]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374250
  lore:
  - <element[THIS DOESNT EVEN HAVE ENOUGH SPACE TO HOLD EXPLOSIVE MATERIAL HOW DOES IT FUCKING BLOW UP].color_gradient[from=#606000;to=#404040]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

bananatriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:cbanana:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot bananaproj speed:0.85 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.2]> script:bananerhit save:banany
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0
    #- define bananathrown <entry[banany].shot_entity>
    #- run banana def:<[banany]>

bananerhit:
  type: task
  debug: false
  script:
  - repeat 100:
    - playeffect effect:cloud quantity:1 at:<[location]> offset:1.25  visibility:100 velocity:<location[0,0,0].random_offset[1]>
    - playeffect effect:smoke quantity:1 at:<[location]> offset:1.25  visibility:100 velocity:<location[0,0,0].random_offset[1]>
  - playsound sound:custom.classicshoot pitch:0 at:<[location]> volume:2
  - playsound sound:entity_generic_explode pitch:0 at:<[location]> volume:2
  - define motherfucker <[location].find.entities.within[3]||null>
  - if <[motherfucker]> == null:
    - stop
  - foreach <[motherfucker]>:
    - if <[value].living> && !<[value].is_player>:
      - look <[value]> <[value].eye_location.add[<[value].eye_location.sub[<[location]>]>]>
    - adjust <[value]> velocity:<[value].velocity.add[<[value].eye_location.sub[<[location]>].normalize.div[<[value].eye_location.distance[<[location]>].mul[0.1].add[0.5]>]>].add[0,0.25,0]>
    - adjust <[value]> is_aware:false
    - cast <[value]> slow duration:6s amplifier:2 no_icon hide_particles no_ambient
    - cast <[value]> slow_digging duration:6s amplifier:2 no_icon hide_particles no_ambient
    - cast <[value]> weakness duration:6s amplifier:2 no_icon hide_particles no_ambient
    - cast <[value]> blindness duration:6s amplifier:2 no_icon hide_particles no_ambient
    - cast <[value]> confusion duration:6s amplifier:127 no_icon hide_particles no_ambient
    - wait 5s
    - adjust <[value]> is_aware:true