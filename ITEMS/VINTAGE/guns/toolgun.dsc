toolgun:
  type: item
  material: iron_horse_armor
  display name: <element[Tool].color[#40A0FF]><element[g].bold.color[#FFFFFF]><element[un].color[#40A0FF]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374333
    hides: all
  lore:
  - <element[You have not crashed! ].color[#205080]><element[Click Here].underline.color[#205080]><element[ to crash!].color[#205080]>
  - 
  - <element[VINTAGE].color[#404878].bold>

toolguntriggers:
  type: world
  events:
    on player left clicks block with:toolgun:
    - determine cancelled passively
    - playsound sound:block_lever_click pitch:2 volume:2 at:<player.eye_location>
    - if <player.has_flag[stillusing]>:
      - title "subtitle:<element[Cannot switch mode while welding!].bold.color_gradient[from=#0000C0;to=#808080]>" "title:" stay:0t targets:<player> fade_in:0t 
      - playsound sound:custom.toolgun_undo at:<player.eye_location> pitch:1 volume:1 custom
      - stop
    - if !<player.has_flag[toolgun_mode]>:
      - title "title:<element[tool_weld].bold.color_gradient[from=#0000C0;to=#808080]>" "subtitle:" stay:0t targets:<player> fade_in:0t 
      - flag <player> toolgun_mode:tool_weld
      - stop
    - choose <player.flag[toolgun_mode]>:
      - case tool_weld:
        - title "title:<element[tool_ignite].bold.color_gradient[from=#0000C0;to=#808080]>" "subtitle:" stay:0t targets:<player> fade_in:0t
        - flag <player> toolgun_mode:tool_ignite
      - case tool_ignite:
        - title "title:<element[tool_leafblower].bold.color_gradient[from=#0000C0;to=#808080]>" "subtitle:" stay:0t targets:<player> fade_in:0t
        - flag <player> toolgun_mode:tool_leafblower
      - case tool_leafblower:
        - title "title:<element[tool_spawn].bold.color_gradient[from=#0000C0;to=#808080]>" "subtitle:" stay:0t targets:<player> fade_in:0t
        - flag <player> toolgun_mode:tool_spawn
      - case tool_spawn:
        - title "title:<element[tool_weld].bold.color_gradient[from=#0000C0;to=#808080]>" "subtitle:" stay:0t targets:<player> fade_in:0t
        - flag <player> toolgun_mode:tool_weld
      - default:
        - title "title:<element[tool_weld].bold.color_gradient[from=#0000C0;to=#808080]>" "subtitle:" stay:0t targets:<player> fade_in:0t 
        - flag <player> toolgun_mode:tool_weld
    on player right clicks block with:toolgun:
    - if <player.has_flag[tgirlguncooldown]>:
      - stop
    - choose <player.flag[toolgun_mode]||0>:
      - itemcooldown iron_horse_armor duration:10t
      - case tool_weld:
        - define aimtarg <player.eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.1]>
        - define posline <player.eye_location.points_between[<[aimtarg]>].distance[1]>
        - foreach <[posline]||0>:
          - playeffect at:<[value]> effect:MAGIC_CRIT quantity:2 offset:0 visibility:100
        - playsound sound:custom.toolgun_fire at:<player.eye_location> pitch:1 volume:1 custom
        - if <[aimtarg].find.living_entities.within[2].exclude[<player>].get[1]||0> != 0:
          - if <player.has_flag[stillusing]>:
            - stop
          - playsound sound:custom.toolgun_undo at:<player.eye_location> pitch:2 volume:1 custom
          - flag <player> stillusing:<[aimtarg].find.living_entities.within[1.5].exclude[<player>].get[1]>
        - else if <player.has_flag[stillusing]>:
          - itemcooldown iron_horse_armor duration:240t
          - flag <player> tgirlguncooldown expire:240t
          - playsound sound:custom.toolgun_undo at:<player.eye_location> pitch:2 volume:1 custom
          - define weldedmob <player.flag[stillusing]>
          - flag <player> stillusing:!
          - cast <[weldedmob]> slow duration:200t amplifier:12 no_ambient hide_particles no_icon
          - wait 200t
          - if <[weldedmob].is_spawned>:
            - playeffect effect:block_crack special_data:iron_bars at:<[weldedmob].location.add[0,0.5,0]> offset:0.4 quantity:64 visbility:100
            - playsound sound:block_anvil_place at:<[weldedmob].eye_location> pitch:2 volume:2
            - playsound sound:block_anvil_place at:<[weldedmob].eye_location> pitch:1 volume:2
      - case tool_ignite:
        - itemcooldown iron_horse_armor duration:10t
        - define aimtarg <player.eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.1]>
        - define posline <player.eye_location.points_between[<[aimtarg]>].distance[1]>
        - foreach <[posline]||0>:
          - playeffect at:<[value]> effect:MAGIC_CRIT quantity:2 offset:0 visibility:100
        - playsound sound:custom.toolgun_fire at:<player.eye_location> pitch:1 volume:1 custom
        - if <[aimtarg].find.living_entities.within[2].exclude[<player>].get[1]||0> != 0:
          - define burntmob <[aimtarg].find.living_entities.within[2].exclude[<player>].get[1]||0>
          - playsound sound:custom.toolgun_undo at:<player.eye_location> pitch:2 volume:1 custom
          - playsound sound:entity_blaze_shoot at:<player.eye_location> pitch:0 volume:1
          - burn <[burntmob]> duration:120t
          - itemcooldown iron_horse_armor duration:60t
          - flag <player> tgirlguncooldown expire:60t
          - repeat 90:
            - playeffect at:<[burntmob].eye_location.sub[0,0.5,0]> effect:flame offset:1,0.01,1 quantity:1 velocity:<location[0,0.2,0].random_offset[0.05,0.3,0.05]> visibility:100
          - playeffect at:<[burntmob].eye_location.sub[0,0.5,0]> effect:lava offset:0.25,0,0.25 quantity:5 visibility:100
      - case tool_leafblower:
        - define lookvec <player.eye_location.direction.vector.mul[1]>
        - define aimtarg <player.eye_location.ray_trace[range=4;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.2]>
        - playeffect effect:cloud quantity:2 at:<player.eye_location.forward[1.5]> offset:0.5 velocity:<[lookvec]>
        - playsound at:<player.eye_location> sound:ITEM_ELYTRA_FLYING pitch:2 volume:0.2
        - playsound at:<player.eye_location> sound:ENTITY_BEE_AMBIENT pitch:2 volume:0.2
        - define blownmob <[aimtarg].find.living_entities.within[2.5].exclude[<player>]||0>
        - if <[blownmob]> != 0:
          - foreach <[blownmob]>:
            - adjust <[value]> velocity:<[value].velocity.add[<[lookvec].div[3].add[0,0.2,0]>]>
      - case tool_spawn:
        - itemcooldown iron_horse_armor duration:80t
        - flag <player> tgirlguncooldown expire:80t
        - define aimtarg <player.eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.1]>
        - define posline <player.eye_location.points_between[<[aimtarg]>].distance[1]>
        - foreach <[posline]||0>:
          - playeffect at:<[value]> effect:MAGIC_CRIT quantity:2 offset:0 visibility:100
        - playsound sound:custom.toolgun_fire at:<player.eye_location> pitch:1 volume:1 custom
        - spawn fathergrigori at:<[aimtarg].forward[1]>
      - default:
        - title "subtitle:<element[Missing player flag "toolgun_mode"].bold.color_gradient[from=#0000C0;to=#808080]>" "title:" stay:0t targets:<player> fade_in:0t 
        - playsound sound:custom.toolgun_undo at:<player.eye_location> pitch:1 volume:1 custom