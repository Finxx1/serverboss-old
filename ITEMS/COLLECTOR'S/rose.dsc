abrose:
  type: item
  material: poppy
  display name: <element[The Abandoned Rose].color_gradient[from=#FF4040;to=#404040]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374200
  lore:
  - <element[Perhaps you are rewarded for remembering it...].color_gradient[from=#802020;to=#202020]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

rosethorns:
  type: task
  definitions: entitylol
  debug: false
  script:
  - repeat 10:
    - playsound sound:entity_player_hurt_sweet_berry_bush at:<[entitylol].location> pitch:1 volume:1
    - hurt <[entitylol]> <[entitylol].health_max.mul[0.04]> source:poison
    - playeffect effect:soul quantity:<[entitylol].health_max.mul[0.08].round_up> at:<[entitylol].eye_location> offset:0.5
    - cast <[entitylol]> slow duration:10t amplifier:8 no_icon hide_particles no_ambient
    - wait 1s

rosetriggers:
  type: world
  debug: false
  events:
    on player damages entity:
    - if <context.damager.item_in_hand.script> == <script[abrose]> && !<context.damager.has_flag[rosecooldown]> && <context.damager.flag[hamon]> > 34:
      - ratelimit <context.damager> 2t
      - if <context.damager.flag[hamon]||0> <= 100:
        - playeffect effect:soul quantity:30 at:<context.entity.eye_location> offset:0.5
        - run rosethorns def:<context.entity>
        - playsound sound:entity_player_hurt_sweet_berry_bush at:<player.location> pitch:1 volume:1
        - itemcooldown wither_rose duration:3s
        - flag <context.damager> rosecooldown expire:3s
        - flag <context.damager> hamon:<context.damager.flag[hamon].sub[35]>
        - title "title:" "subtitle:<element[<player.flag[hamon]>%].color[#FF4040]>" fade_in:0 stay:1s targets:<player>
      - else:
        - playeffect effect:soul quantity:120 at:<context.entity.eye_location> offset:1
        - run rosethorns def:<context.entity>
        - playsound sound:entity_player_hurt_sweet_berry_bush at:<player.location> pitch:1 volume:1
        - playsound sound:entity_player_hurt_sweet_berry_bush at:<player.location> pitch:0 volume:1
        - itemcooldown wither_rose duration:1.5s
        - flag <context.damager> rosecooldown expire:1.5s
        - flag <context.damager> hamon:<context.damager.flag[hamon].sub[35]>
        - title "title:" "subtitle:<element[<player.flag[hamon]>%].color[#FF8080].bold>" fade_in:0 stay:1s targets:<player>
      - foreach <[fucked2]>:
        - light <[value].location> 15 duration:10t
    on player right clicks block with:abrose:
    - if !<player.has_flag[rosecooldown]>:
      - if <player.has_flag[hamonoverdrive]> && <player.health> > 6:
        - if <player.flag[hamon]> < 466:
          - hurt <player> 6
          - flag <player> rosecooldown expire:1s
          - itemcooldown wither_rose duration:1s
          - flag <player> hamon:<player.flag[hamon].add[35]>
          - playeffect effect:redstone quantity:120 special_data:2|red at:<player.eye_location> offset:1      
          - title "title:" "subtitle:<element[<player.flag[hamon]>%].color[#FF8080].bold>" fade_in:0 stay:1s targets:<player>
        - else if <player.flag[hamon]> < 500:
          - hurt <player> 6 
          - flag <player> rosecooldown expire:1s
          - itemcooldown wither_rose duration:1s
          - flag <player> hamon:100
          - playeffect effect:redstone quantity:120 special_data:2|red at:<player.eye_location> offset:1
          - title "title:" "subtitle:<element[<player.flag[hamon]>%].color[#FF8080].bold>" fade_in:0 stay:1s targets:<player>
      - else if <player.health> > 3:        
        - if <player.flag[hamon]> < 91:
          - hurt <player> 3 
          - flag <player> rosecooldown expire:2s
          - itemcooldown wither_rose duration:2s
          - flag <player> hamon:<player.flag[hamon].add[10]>
          - playeffect effect:redstone quantity:60 special_data:1|red at:<player.eye_location> offset:1      
          - title "title:" "subtitle:<element[<player.flag[hamon]>%].color[#FF4040]>" fade_in:0 stay:1s targets:<player>
        - else if <player.flag[hamon]> < 100:
          - hurt <player> 3 
          - flag <player> rosecooldown expire:2s
          - itemcooldown wither_rose duration:2s
          - flag <player> hamon:100
          - playeffect effect:redstone quantity:60 special_data:1|red at:<player.eye_location> offset:1
          - title "title:" "subtitle:<element[<player.flag[hamon]>%].color[#FF4040]>" fade_in:0 stay:1s targets:<player>