lgrape:
  type: item
  material: clay_ball
  display name: <element[Clus].color_gradient[from=#40FF40;to=#C00080]><element[ter Grapes].color_gradient[from=#C00080;to=#C000F0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374251
  lore:
  - <element[Do they always come in threes?].color_gradient[from=#600040;to=#600080]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

lgrapetriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:lgrape:
    - determine cancelled passively
    - take item_in_hand quantity:1
    - shoot lgrapeproj speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]> script:split1
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0

split1:
  type: task
  debug: false
  script:
  - playsound sound:custom.gib pitch:0 at:<[location]> volume:2 custom
  - explode <[location]> power:5
  - repeat 9:
    - shoot mgrapeproj speed:0.85 spread:0 origin:<[location]> destination:<[location].add[0,0.5,0].random_offset[1,0,1]> script:split2

split2:
  type: task
  debug: false
  script:
  - playsound sound:custom.gib pitch:1 at:<[location]> volume:2 custom
  - explode <[location]> power:3
  - repeat 9:
    - shoot sgrapeproj speed:0.85 spread:0 origin:<[location]> destination:<[location].add[0,0.5,0].random_offset[1,0,1]> script:split3

split3:
  type: task
  debug: false
  script:
  - playsound sound:custom.gib pitch:2 at:<[location]> volume:2 custom
  - explode <[location]> power:1