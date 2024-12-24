hermesflops:
  type: item
  material: leather_boots
  display name: <element[Hermes Flops].color_gradient[from=#80C0FF;to=#FFFFFF]>
  mechanisms:
    unbreakable: true
    hides: all
    color: <color[#C0C0C0]>
  lore:
  - <element[look im running out of synonyms for "shoe" alright give me a break].color_gradient[from=#406080;to=#808080]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>


hermesflopstriggers:
  type: world
  debug: false
  events:
    on player jumps:
    - if <player.has_equipped[hermesflops]||0>:
      - flag <player> bhop:<player.flag[bhop].add[1]||0> expires:1s
      - cast <player> speed duration:1s amplifier:<player.flag[bhop]> no_icon hide_particles no_ambient
    on player walks:
    - if <context.old_location.with_pitch[0].with_yaw[0]> == <context.new_location.with_pitch[0].with_yaw[0]>:
      - stop
    #- if !<player.is_on_ground>:
    #  - stop
    - define xmove <context.old_location.x.sub[<context.new_location.x>].round_down_to_precision[0.001]>
    - define ymove <context.old_location.y.sub[<context.new_location.y>].round_down_to_precision[0.001]>
    - define zmove <context.old_location.z.sub[<context.new_location.z>].round_down_to_precision[0.001]>
    #- announce "<[xmove]> <[ymove]> <[zmove]>"
    - define tmove <[xmove].power[2].add[<[ymove].power[2]>].add[<[zmove].power[2]>].sqrt.round_down_to_precision[0.001]>
    - flag <player> totalspeed:<[tmove]>
    on delta time secondly:
    - foreach <server.online_players>:
      - define oldloc <[value].location.with_pitch[0].with_yaw[0]>
      - wait 1t
      - define newloc <[value].location.with_pitch[0].with_yaw[0]>
      - if <[oldloc]> == <[newloc]>:
        - flag <[value]> totalspeed:0