powertool:
  type: item
  material: stick
  display name: <element[Pow].color_gradient[from=#4080FF;to=#FFFFFF]><element[ert].color_gradient[from=#FFFFFF;to=#FF00FF]><element[ool].color_gradient[from=#FF00FF;to=#800000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374293
  lore:
  - <element[He who wiel].color_gradient[from=#204080;to=#808080]><element[ds will meet t].color_gradient[from=#808080;to=#800080]><element[hee who yields].color_gradient[from=#800080;to=#400000]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

powertooltriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:powertool:
    - determine cancelled passively
    - if <player.has_flag[powertoolcooldown]>:
      - stop
    - flag <player> powertoolcooldown expire:3t
    - itemcooldown stick duration:3t
    - choose <player.flag[powertoolmode]>:
      - case lightning:
        - flag <player> powertoolmode:wither
        - title "title:<element[☣ WITHERING ☣].bold.color_gradient[from=#404040;to=#303018]>" "subtitle:" stay:0t targets:<player> fade_in:0t
      - case wither:
        - flag <player> powertoolmode:lol
        - title "title:<element[Ψ PSIONIC Ψ].bold.color_gradient[from=#FF00FF;to=#00FF00]>" "subtitle:" stay:0t targets:<player> fade_in:0t
      - case lol:
        - flag <player> powertoolmode:fireball
        - title "title:<element[⚙ FIREBALL ⚙].bold.color_gradient[from=#800000;to=#804000]>" "subtitle:" stay:0t targets:<player> fade_in:0t
      - case fireball:
        - flag <player> powertoolmode:ascend
        - title "title:<element[↑ ASCENSION ↑].bold.color_gradient[from=#FFFFFF;to=#FFFF80]>" "subtitle:" stay:0t targets:<player> fade_in:0t
      - case ascend:
        - flag <player> powertoolmode:lightning
        - title "title:<element[⚡ LIGHTNING ⚡].bold.color_gradient[from=#40C0FF;to=#FFFFFF]>" "subtitle:" stay:0t targets:<player> fade_in:0t
      - default:
        - random:
          - repeat 1:
            - flag <player> powertoolmode:wither
            - title "title:<element[☣ WITHERING ☣].bold.color_gradient[from=#404040;to=#303018]>" "subtitle:" stay:0t targets:<player> fade_in:0t
          - repeat 1:
            - flag <player> powertoolmode:lol
            - title "title:<element[⚝ PSIONIC ⚝].bold.color_gradient[from=#FF00FF;to=#00FF00]>" "subtitle:" stay:0t targets:<player> fade_in:0t
          - repeat 1:
            - flag <player> powertoolmode:fireball
            - title "title:<element[⚙ FIREBALL ⚙].bold.color_gradient[from=#800000;to=#804000]>" "subtitle:" stay:0t targets:<player> fade_in:0t
          - repeat 1:
            - flag <player> powertoolmode:lightning
            - title "title:<element[⚡ LIGHTNING ⚡].bold.color_gradient[from=#40C0FF;to=#FFFFFF]>" "subtitle:" stay:0t targets:<player> fade_in:0t
          - repeat 1:
            - flag <player> powertoolmode:ascend
            - title "title:<element[↑ ASCENSION ↑].bold.color_gradient[from=#FFFFFF;to=#FFFF80]>" "subtitle:" stay:0t targets:<player> fade_in:0t
    - playsound at:<player.location> sound:block_stone_button_click_on pitch:1 volume:1
    on player left clicks block with:powertool:
    - determine cancelled passively
    - if <player.has_flag[powertoolcooldown]>:
      - stop
    - flag <player> powertoolcooldown expire:4s
    - itemcooldown stick duration:4s
    - choose <player.flag[powertoolmode]>:
      - case lightning:
        - define aimtarg <player.eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.5]>
        - playsound at:<player.eye_location> sound:custom.halelujah pitch:1 volume:2 custom
        - wait <list[10t|15t|20t|25t].random>
        - adjust <server.online_players> stop_sound:minecraft:custom.halelujah
        - strike <[aimtarg]>
        - strike <[aimtarg]>
        - strike <[aimtarg]>
        - strike <[aimtarg]>
        - strike <[aimtarg]>
      - case fireball:
        - repeat 3:
          - shoot xfireball origin:<player.eye_location.right[0.4].below[0.4]> speed:2 shooter:<player> spread:3
          - playsound at:<player.eye_location> sound:entity_blaze_shoot pitch:1 volume:2
          - wait 2t
      - case wither:
        - shoot xskull origin:<player.eye_location.right[0.4].below[0.4]> speed:4 shooter:<player> spread:0
        - playsound at:<player.eye_location> sound:entity_wither_shoot pitch:1 volume:2
      - case lol:
        - playsound at:<player.eye_location> sound:custom.psychicfire pitch:1 volume:2 custom
        - define aimtarg <player.eye_location.ray_trace[range=40;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.1]>
        - define posline <player.eye_location.points_between[<[aimtarg]>].distance[0.15]>
        - foreach <[posline]>:
          - playeffect effect:redstone at:<[value]> special_data:2|<color[#FF30FF]> quantity:1 offset:0 visibility:100
          - define hittarg <[value].find_entities.within[4].exclude[<player>].filter_tag[<[filter_value].has_flag[psyched].not>].get[1]||0>
          - if <[hittarg]> != 0:
            - playsound at:<[value]> sound:custom.psychichit pitch:1 volume:2 custom
            - adjust <[hittarg]> velocity:<[hittarg].eye_location.sub[<[value]>].normalize.mul[4].add[0,0.35,0]>
            - flag <[hittarg]> psyched expire:10t
            - define posline1 <[value].points_between[<[hittarg].eye_location>].distance[0.15]>
            - foreach <[posline1]> as:val2:
              - playeffect effect:redstone at:<[val2]> special_data:0.5|<color[#FF30FF]> quantity:1 offset:0 visibility:100
          - if <[loop_index].mod[5]> == 0:
            - wait 1t
      - case ascend:
        - define aimtarg <player.eye_location.with_pitch[-90].ray_trace[range=13;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.1].sub[0,3,0].block.add[0.5,0.5,0.5]>
        - showfake barrier <[aimtarg]> players:<server.online_players> d:4s
        - adjust <player> noclip:true
        - playeffect effect:barrier at:<[aimtarg]> quantity:1 offset:0 visibility:100
        - teleport <player> <[aimtarg].add[0,1,0].with_pitch[<player.eye_location.pitch>].with_yaw[<player.eye_location.yaw>]>
        - playsound at:<player.eye_location> sound:entity_enderman_teleport pitch:2 volume:2
        - wait 4s
        - playeffect effect:block_crack special_data:barrier at:<[aimtarg]> quantity:128 offset:0.5 visibility:100
        - playsound sound:block_glass_break at:<[aimtarg]> volume:2 pitch:2
        - playsound sound:block_glass_break at:<[aimtarg]> volume:2 pitch:1
        - playsound sound:block_glass_break at:<[aimtarg]> volume:2 pitch:0
        - if <player.location.distance[<[aimtarg]>]> < 2:
          - cast <player> slow_falling duration:3s amplifier:0 no_icon hide_particles no_ambient
        - adjust <player> noclip:false
      - default:
        - title "title:<element[RIGHT CLICK TO SELECT MODE].bold.color_gradient[from=#FFFF00;to=#00FFFF]>" "subtitle:" stay:0t targets:<player> fade_in:0t