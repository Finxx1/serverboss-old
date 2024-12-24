tuskpunch:
  type: item
  material: pink_concrete
  display name: <element[ゴ ゴ Tusk ACT 4: Punch ゴ ゴ].color[#FFC0CB]>
  lore:
  - <element[Punches.].color[#FFC5CB]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

tuskbarrage:
  type: item
  material: pink_concrete
  display name: <element[ゴ ゴ Tusk ACT 4 : Barrage ゴ ゴ].color[#FFC0CB]>
  lore:
  - <element[ORAORAORAORAORAORAORAORAORA!].color[#FFC5CB]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

tusknailshot:
  type: item
  material: pink_concrete
  display name: <element[ゴ ゴ Tusk ACT 4 : Nail Shot ゴ ゴ].color[#FFC0CB]>
  lore:
  - <element[Lesson 1. If you have the will, then do it.].color[#FFC5CB]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>


tuskcommand:
  debug: false
  type: world
  events:
    on player chats:
     - if <context.message> == "TUSK":
       - give <player> tuskpunch
       - give <player> tuskbarrage
       - give <player> tusknailshot
    on player damages entity:
    - if <context.damager.item_in_hand.script||0> == <script[tuskpunch]> && !<player.has_flag[tuskcooldown]>:
      - flag <context.damager> tuskcooldown expire:6s
      - itemcooldown pink_concrete duration:6s
      - determine cancelled passively
      - hurt <context.entity> 7 source:<context.damager>
      - define lookvec <context.damager.eye_location.direction.vector>
      - playeffect effect:crit_magic quantity:25 at:<context.damager.eye_location> offset:0.6 velocity:<[lookvec].mul[3]>
    - else if <context.damager.item_in_hand.script||0> == <script[tuskbarrage]> && !<player.has_flag[tuskcooldown]>:
      - flag <context.damager> tuskcooldown expire:8s
      - itemcooldown pink_concrete duration:8s
      - determine cancelled passively
      - define lookvec <context.damager.eye_location.direction.vector>
      - adjust <context.entity> max_no_damage_duration:1t
      - repeat 30:
        - cast <context.damager> slow duration:2t amplifier:4 no_icon no_ambient hide_particles
        - cast <context.entity> slow duration:2t amplifier:5 no_icon no_ambient hide_particles
        - hurt <context.entity> 0.2
        - playeffect effect:crit_magic quantity:2 at:<context.damager.eye_location> offset:1 velocity:<[lookvec].mul[3]>
        - wait 2t
      - hurt <context.entity> 2 source:<context.damager>
      - wait 1t
      - hurt <context.entity> 2 source:<context.damager>
      - wait 1t
      - hurt <context.entity> 2 source:<context.damager>
      - adjust <context.entity> max_no_damage_duration:20t
    on player left clicks block with:tusknailshot:
    - run tusknailshots def:<player>

tusknailshots:
  debug: false
  definitions: tusk_player
  type: task
  script:
    - if <[tusk_player].has_flag[tuskcooldown]>:
      - stop
    - flag <[tusk_player]> tuskcooldown expire:2s
    - itemcooldown pink_concrete duration:2	
    - define aimtarg <[tusk_player].eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;entities=*;ignore=<[tusk_player]>;raysize=0.5]>
    - define posline <[tusk_player].eye_location.points_between[<[aimtarg]>].distance[0.5]>
    - define prenderdist <[tusk_player].eye_location.distance[<[aimtarg]>].add[5]>
    - define lookvec <[tusk_player].eye_location.direction.vector>
    - playsound <[aimtarg]> sound:item_crossbow_shoot pitch:1 volume:2
    - foreach <[posline]>:
      - playeffect effect:redstone special_data:0.8|<color[#ffd700]> quantity:1 at:<[value]> offset:0.01 visibility:<[prenderdist]>
      - define healtarg <[value].find_entities.within[1].exclude[<[tusk_player]>]>
      - foreach <[healtarg]>:
        - hurt <[value]> 4 source:<[tusk_player]>
      - if <[loop_index].mod[6]> == 0:
        - wait 1t