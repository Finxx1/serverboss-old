sawedoff:
  type: item
  material: iron_horse_armor
  display name: <element[Sawedoff].color[#E0E0A0]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374336
    hides: all
  lore:
  - <element[One for the pope...].color[#787850]>
  - <element[And one JUST because I had ammo left].color[#787850]>
  - 
  - <element[VINTAGE].color[#404878].bold>

sawedofftriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:sawedoff:
    - ratelimit <player> duration:1t
    - if !<player.has_flag[riflecooldown]>:
      - playsound sound:custom.classic_explode pitch:1 at:<player.eye_location> volume:2 custom
      - playsound sound:entity_generic_explode pitch:0 at:<player.eye_location> volume:2
      - playsound sound:entity_wither_hurt pitch:0 at:<player.eye_location> volume:2
      - flag <player> riflecooldown expire:24t
      - itemcooldown iron_horse_armor duration:24t
      - if <player.item_in_offhand.script.name||0> == sawedoff:
        - run sawedofffire2 def:<player>
#      - if <player.item_in_offhand.script.name||0> == uzi:
#        - run uzifire2 def:<player>
# couldve been so cool
      - define aimtarg_R <player.eye_location.below[0.3].right[0.3].ray_trace[range=4;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.1]>
      - define aimtarg <player.eye_location.ray_trace[range=4;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.1]>
      - define posline <player.eye_location.points_between[<[aimtarg]>]>
      - define posline_R <player.eye_location.points_between[<[aimtarg_R]>]>
      - foreach <[posline_R]>:
        - playeffect effect:smoke quantity:10 offset:1 visibility:100 at:<[value]>
        - playeffect effect:large_smoke quantity:7 offset:0.5 visibility:100 at:<[value]>
      - foreach <[posline]>:
        - foreach <[value].find.living_entities.within[2].exclude[<player>]> as:ouchie:
          - hurt <[ouchie]> amount:12
          - adjust <[ouchie]> velocity:<player.eye_location.direction.vector.normalize.mul[0.5]>
      - wait 9t
      - playsound sound:entity_skeleton_step pitch:1 at:<player.eye_location> volume:2
      - playsound sound:entity_skeleton_step pitch:0 at:<player.eye_location> volume:2
      - repeat 3:
        - inventory adjust "custom_model_data:<[value].add[13374336]>" destination:<context.damager.inventory> slot:hand
        - if <player.item_in_hand.script.name||0> != sawedoff:
          - stop
        - wait 2t
      - inventory adjust "custom_model_data:13374336" destination:<context.damager.inventory> slot:hand
     

sawedofffire2:
  type: task
  debug: false
  definitions: playra
  script:
  - wait 12t
  - playsound sound:custom.classic_explode pitch:1 at:<[playra].eye_location> volume:2 custom
  - playsound sound:entity_generic_explode pitch:0 at:<[playra].eye_location> volume:2
  - playsound sound:entity_wither_hurt pitch:0 at:<[playra].eye_location> volume:2
  - define aimtarg <[playra].eye_location.ray_trace[range=4;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.1]>
  - define aimtarg_L <[playra].eye_location.below[0.3].left[0.3].ray_trace[range=4;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.1]>
  - define posline <[playra].eye_location.points_between[<[aimtarg]>]>
  - define posline_L <[playra].eye_location.points_between[<[aimtarg_L]>]>
  - foreach <[posline_L]>:
    - playeffect effect:smoke quantity:10 offset:1 visibility:100 at:<[value]>
    - playeffect effect:large_smoke quantity:7 offset:0.5 visibility:100 at:<[value]>
  - foreach <[posline]>:
    - foreach <[value].find.living_entities.within[2].exclude[<[playra]>]> as:ouchie:
      - hurt <[ouchie]> amount:12
      - adjust <[ouchie]> velocity:<[playra].eye_location.direction.vector.normalize.mul[0.5]>
  - wait 9t
  - playsound sound:entity_skeleton_step pitch:1 at:<[playra].eye_location> volume:2
  - playsound sound:entity_skeleton_step pitch:0 at:<[playra].eye_location> volume:2
  - repeat 3:
    - inventory adjust "custom_model_data:<[value].add[13374336]>" destination:<context.damager.inventory> slot:offhand
    - if <player.item_in_offhand.script.name||0> != sawedoff:
      - stop
    - wait 2t
  - inventory adjust "custom_model_data:13374336" destination:<context.damager.inventory> slot:offhand