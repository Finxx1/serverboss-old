taucannon:
  type: item
  material: diamond_horse_armor
  display name: <element[XVL-1456].color_gradient[from=#FFC020;to=#C020FF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374200
  lore:
  - <element["What do you mean overcha- *kabzoom*].color_gradient[from=#806010;to=#601080]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

taucannontriggers:
  type: world
  events:
    on player left clicks block with:taucannon:
    - determine cancelled passively
    - if <player.has_flag[u235cooldown]>:
      - stop
    - if !<player.has_flag[taucharging2]>:
      - flag <player> taucharging:0
      - flag <player> taucharging2
      - while <player.has_flag[taucharging2]>:
        - playsound at:<player.eye_location> sound:block_beacon_ambient pitch:<player.flag[taucharging].min[<player.flag[u235used].mul[-1].add[100]>].div[65].add[0.5]> volume:2
        - if <[loop_index]> > 135:
          - explode <player.eye_location> power:3 source:0
          - flag <player> taucharging:!
          - playsound <player.location> sound:entity_lightning_bolt_thunder pitch:2 volume:2
          - playsound <player.location> sound:entity_lightning_bolt_thunder pitch:1 volume:2
          - playsound <player.location> sound:entity_lightning_bolt_thunder pitch:0 volume:2
          - playsound <player.location> sound:custom.lightning_discharge pitch:0 volume:2 custom
          - playsound <player.location> sound:custom.lightning_discharge pitch:1 volume:2 custom
          - flag <player> taucharging2:!
          - title "title:<element[RECHARGING!].color_gradient[from=#FFC020;to=#C020FF]>" "subtitle:" fade_in:0 stay:200t targets:<player>
          - flag <player> u235cooldown expire:8s
          - itemcooldown diamond_horse_armor duration:8s
          - flag <player> u235used:0
          - playsound at:<player.eye_location> sound:block_piston_extend pitch:0 volume:2
          - while stop
        - flag <player> taucharging:<player.flag[taucharging].add[1].min[100]||0>
        - if <[loop_index]> > <player.flag[u235used].mul[-1].add[100]>:
          - title "title:" "subtitle:<element[<player.flag[taucharging]>%].color_gradient[from=#FF8020;to=#FF2080]>" fade_in:0 stay:1s targets:<player>
          - if <[loop_index].mod[3]> == 0:
            - playsound sound:block_note_block_pling pitch:2 volume:2 at:<player.location>
        - else:
          - title "title:" "subtitle:<element[<player.flag[taucharging]>%].color_gradient[from=#FFC020;to=#C020FF]>" fade_in:0 stay:1s targets:<player>
        - wait 1t
    on player right clicks block with:taucannon:
    - determine cancelled passively
    - ratelimit <player> 15t
    - if <player.has_flag[u235cooldown]>:
      - stop
    - define aimtarg <player.eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.5]>
    - define posline <player.eye_location.points_between[<[aimtarg]>].distance[0.5]>
    - if !<player.has_flag[taucharging2]>:
      - foreach <[posline]>:
        - playeffect at:<[value]> effect:redstone special_data:0.8|<color[#FFC020]> quantity:1 offset:0 visibility:100
      - define hittarg <[aimtarg].find.living_entities.within[1].exclude[<player>].get[1]||0>
      - hurt <[hittarg]> amount:4 source:<player>
      - playsound <player.location> sound:custom.lightning_charge pitch:1 volume:2 custom
      - flag <player> u235used:<player.flag[u235used].add[2].min[100]||0>
      - title "title:" "subtitle:<element[<player.flag[u235used].mul[-1].add[100]>%].color_gradient[from=#806010;to=#601080]>" fade_in:0 stay:5t targets:<player>
      - if <player.flag[u235used]||0> == 100:
        - title "title:<element[RECHARGING!].color_gradient[from=#FFC020;to=#C020FF]>" "subtitle:" fade_in:0 stay:200t targets:<player>
        - flag <player> u235cooldown expire:10s
        - itemcooldown diamond_horse_armor duration:10s
        - flag <player> u235used:0
        - playsound at:<player.eye_location> sound:block_piston_extend pitch:0 volume:2
        - while stop
    - else:
      - define hittarg <[aimtarg].find.living_entities.within[1.5].exclude[<player>].get[1]||0>
      - hurt <[hittarg]> amount:<player.flag[taucharging].min[<player.flag[u235used].mul[-1].add[100]>].div[3].add[4]> source:<player> 
      - flag <player> taucharging2:!
      - adjust <player> velocity:<player.velocity.sub[<player.eye_location.direction.vector.normalize.mul[<player.flag[taucharging].min[<player.flag[u235used].mul[-1].add[100]>].div[40]>]>]>
      - playsound <player.location> sound:entity_lightning_bolt_thunder pitch:2 volume:2
      - playsound <player.location> sound:custom.lightning_discharge pitch:0 volume:2 custom
      - playsound <player.location> sound:custom.lightning_discharge pitch:1 volume:2 
      - playsound <player.location> sound:custom.lightning_charge pitch:1 volume:2 custom
      - flag <player> u235used:<player.flag[u235used].add[<player.flag[taucharging]>].min[100]||0>
      - title "title:" "subtitle:<element[<player.flag[u235used].mul[-1].add[100]>%].color_gradient[from=#806010;to=#601080]>" fade_in:0 stay:5t targets:<player>
      - if <player.flag[u235used]||0> == 100:
        - title "title:<element[RECHARGING!].color_gradient[from=#FFC020;to=#C020FF]>" "subtitle:" fade_in:0 stay:200t targets:<player>
        - flag <player> u235cooldown expire:10s
        - itemcooldown diamond_horse_armor duration:10s
        - flag <player> u235used:0
        - playsound at:<player.eye_location> sound:block_piston_extend pitch:0 volume:2
        - while stop
      - foreach <[posline]>:
        - playeffect at:<[value]> effect:redstone special_data:1.2|<color[#C020FF]> quantity:1 offset:0 visibility:100

gluongun:
  type: item
  material: diamond_horse_armor
  display name: <element[Gluon Gun].color_gradient[from=#0080FF;to=#8000FF]>
  mechanisms:
    unbreakable: true
    hides: all
  lore:
  - <element[If you peel off this sticker it says "Egon Gun"].color_gradient[from=#004080;to=#400080]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

gluonguntriggers:
  type: world
  events:
    on player right clicks block with:gluongun:
    - flag <player> gluonfire expire:6t
    - if <player.has_flag[gluonfire2]> || <player.has_flag[u235cooldown]>:
      - stop
    - flag <player> gluonfire2
    - playsound <player.location> sound:entity_lightning_bolt_impact pitch:0 volume:2
    - playsound <player.location> sound:entity_lightning_bolt_thunder pitch:0 volume:2
    - playsound <player.location> sound:custom.lightning_discharge pitch:0 volume:2 custom
    - playsound <player.location> sound:custom.lightning_charge pitch:0 volume:2 custom
    - while <player.has_flag[gluonfire]>:
      - playsound at:<player.eye_location> sound:entity_lightning_bolt_thunder pitch:0 volume:2
      - playsound at:<player.eye_location> sound:block_beacon_ambient pitch:0 volume:2
      - define firephase <[loop_index].div[5]>
      #- announce <[firephase]>
      - if <player.has_flag[u235cooldown]>:
        - stop
      - if <player.flag[u235used]||0> == 100:
        - title "title:<element[RECHARGING!].color_gradient[from=#0080FF;to=#8000FF]>" "subtitle:" fade_in:0 stay:200t targets:<player>
        - flag <player> u235cooldown expire:10s
        - itemcooldown diamond_horse_armor duration:10s
        - flag <player> u235used:0
        - playsound at:<player.eye_location> sound:block_piston_extend pitch:0 volume:2
        - while stop
      - flag <player> u235used:<player.flag[u235used].add[1].min[100]||0>
      - title "title:" "subtitle:<element[<player.flag[u235used].mul[-1].add[100]>%].color_gradient[from=#004080;to=#400080]>" fade_in:0 stay:5t targets:<player>
      - define aimtarg <player.eye_location.ray_trace[range=40;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.5]>
      - define posline <player.eye_location.points_between[<[aimtarg]>].distance[2]>
      - foreach <[posline]>:
        - playeffect at:<[value]> effect:redstone special_data:2|<color[#0080FF]> quantity:1 offset:0 visibility:100
        - if <[loop_index].mod[1]> == 0:
          - define valvec <[value].with_pitch[<player.eye_location.pitch>].with_yaw[<player.eye_location.yaw>]>
          #- repeat 8 as:spinangle:
          - define spinangle <[loop_index].add[<[firephase]>]>
          - define xoff <[spinangle].sin>
          - define yoff <[spinangle].cos>
          - playeffect at:<[valvec].up[<[yoff]>].right[<[xoff]>]> effect:redstone special_data:2|<color[#8000FF]> quantity:1 offset:0 visibility:100
      - define hittarg <[aimtarg].find.living_entities.within[2].exclude[<player>]||0>
      - foreach <[hittarg]> as:lased:
        - adjust <[lased]> max_no_damage_duration:5t
        - hurt <[lased]> amount:4 source:<player> 
        - adjust <[lased]> max_no_damage_duration:20t
      - wait 1t
    - flag <player> gluonfire2:!
    - playsound <player.location> sound:entity_lightning_bolt_impact pitch:0 volume:2
    - playsound <player.location> sound:entity_lightning_bolt_thunder pitch:0 volume:2