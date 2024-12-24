celestialclaw:
  type: item
  material: stick
  display name: <element[Celestial Claw].color_gradient[from=#804020;to=#000038]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374295
  lore:
  - <element[IT DEMANDS A SACRIFICE].color_gradient[from=#402010;to=#00001C]>
  - <&7>
  - <element[STRANGE].color[#D87840].bold>

celestialclawtriggers:
  type: world
  events:
    on player right clicks block with:celestialclaw:
    - ratelimit <player> 1t
    - if <player.has_flag[clawcooldown]>:
      - stop
    - if <player.flag[killmana]> < 20:
      - stop
    - flag <player> killmana:<player.flag[killmana].sub[20]>
    - flag <player> clawcooldown expire:5t
    - determine cancelled passively
    - playsound <player.location> sound:entity_lightning_bolt_thunder pitch:2 volume:1
    - playsound <player.location> sound:item_crossbow_shoot pitch:0 volume:1
    - playsound <player.location> sound:entity_blaze_shoot pitch:0 volume:1
    - flag <player> shotplanet:<list[earthproj|marsproj|venusproj|moonproj].exclude[<player.flag[shotplanet]>].random||moonproj>
    - shoot <player.flag[shotplanet]> origin:<player.eye_location.below[0.75]> speed:2 script:planet shooter:<player> spread:0 save:planproj
    - run planettrail def:<entry[planproj].shot_entity>
    on entity killed:
    - define closestbastard <context.entity.eye_location.find_players_within[100].get[1]>
    #- announce <[closestbastard]>
    - if <[closestbastard]||0> == 0:
      - stop
    - flag <[closestbastard]> stylestatus:<[closestbastard].flag[stylestatus].add[<context.entity.health_max>].min[1200]||0>

planettrail:
  debug: false
  type: task
  definitions: planetproj
  script:
  - wait 1t
  - while <[planetproj].is_spawned>:
    - if <[loop_index]> > 120:
      - while stop
    - playeffect effect:item_crack special_data:<[planetproj].item> offset:0.15 quantity:2 at:<[planetproj].location.add[0,0.07,0]> visibility:100
    - wait 1t

planet:
  debug: false
  type: task
  script:
  - explode <[location]> power:3
  - playsound at:<[location]> sound:entity_wither_break_block pitch:0 volume:4
  - playsound at:<[location]> sound:entity_zombie_attack_iron_door pitch:0 volume:4