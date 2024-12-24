anarchistcookbook:
  type: item
  material: book
  display name: <element[Anarchist Cookbook].color_gradient[from=#606060;to=#800000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374262
  lore:
  - <element[Delicious recipes!].color_gradient[from=#303030;to=#400000]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

anarchytriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:anarchistcookbook:
    - determine cancelled passively
    - if <player.has_flag[anarchycooldown]>:
      - stop
    - flag <player> anarchycooldown expire:320t
    - itemcooldown book duration:320t
    - foreach <player.location.add[0,1,0].points_around_y[radius=1;points=8]>:
      - shoot dynamiteproj speed:0.75 spread:1 origin:<player.location.add[0,0.5,0]> destination:<[value]> script:dynamiteboom save:dynamitethrown3
      - define dynaproj <entry[dynamitethrown3].shot_entity>
      - run dynamitetrail def:<[dynaproj]>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0
    - playsound at:<player.eye_location> sound:entity_blaze_shoot volume:2 pitch:0