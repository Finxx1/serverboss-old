sunsetsea:
  type: item
  material: shield
  display name: <element[「Sunset Sea」].color_gradient[from=#004040;to=#FFFF80]>
  enchantments:
  - fire_protection:10
  - smite:1
  - knockback:1
  mechanisms:
    unbreakable: true
    hides: all
    base_color: orange
    patterns: <list[yellow/gradient|red/flower|white/circle_middle]>
  lore:
  - <element[-= Fueled by the Sun =-].color_gradient[from=#002020;to=#808040]>
  - <element[-= Tainted by darkness =-].color_gradient[from=#002020;to=#808040]>
  - 
  - <element[UNUSUAL].color[#9040C0].bold>

#ゴ

sunsetseatriggers:
  type: world
  debug: false
  events:
    after delta time secondly every:1:
    - foreach <server.online_players>:
      - if <[value].item_in_hand.script||0> == <script[sunsetsea]> && <[value].location.world.time.period> == day:
        - if <[value].has_flag[hamonoverdrive]>:
          - if <[value].flag[hamon]||0> < 500:
            - if <[value].flag[hamon]> < <element[500].sub[<[value].location.light.sky.div[2].round_up>]>:
              - flag <[value]> hamon:<[value].flag[hamon].add[<[value].location.light.sky.div[2].round_up>]>
              - title "title:" "subtitle:<element[<[value].flag[hamon]>%].color[#FFFFC0].bold>" fade_in:0 stay:1s targets:<[value]>
            - else:
              - flag <[value]> hamon:500
              - playsound sound:block_beacon_activate at:<[value].location> pitch:0 volume:2
              - playsound sound:block_beacon_activate at:<[value].location> pitch:1 volume:2
              - playsound sound:block_beacon_activate at:<[value].location> pitch:2 volume:2
              - playsound sound:entity_evoker_cast_spell at:<[value].location> pitch:0 volume:2
              - title "title:" "subtitle:<element[<[value].flag[hamon]>%].color[#FFFFC0].bold>" fade_in:0 stay:1s targets:<[value]>

        - else if <[value].flag[hamon]||0> < 100:
          - if <[value].flag[hamon]> < <element[100].sub[<[value].location.light.sky.div[5].round_up>]>:
            - flag <[value]> hamon:<[value].flag[hamon].add[<[value].location.light.sky.div[5].round_up>]>
            - title "title:" "subtitle:<element[<[value].flag[hamon]>%].color[#FFFF80]>" fade_in:0 stay:1s targets:<[value]>
          - else:
            - flag <[value]> hamon:100
            - playsound sound:block_beacon_activate at:<[value].location> pitch:0 volume:2
            - playsound sound:block_beacon_activate at:<[value].location> pitch:1 volume:2
            - playsound sound:block_beacon_activate at:<[value].location> pitch:2 volume:2
            - title "title:" "subtitle:<element[<[value].flag[hamon]>%].color[#FFFF80]>" fade_in:0 stay:1s targets:<[value]>
        - ratelimit <[value]> 1s
        - playsound sound:block_beacon_ambient at:<[value].location> pitch:<[value].flag[hamon].div[200].add[0.5]> volume:<[value].flag[hamon].div[100]>
    on player damages entity:
    - if <context.damager.item_in_hand.script> == <script[sunsetsea]> && !<context.damager.has_flag[sunsetcooldown]> && <context.damager.flag[hamon]> > 34:
      - ratelimit <context.damager> 2t
      - if <context.damager.flag[hamon]||0> <= 100:
        - define fucked <context.damager.location.find.living_entities.within[4].exclude[<context.damager>]>
        - define fucked2 <context.damager.location.find.living_entities.within[8].exclude[<context.damager>]>
        - playeffect effect:flame quantity:60 at:<context.entity.eye_location> offset:1
        - hurt <[fucked]> 7
        - burn <[fucked]> duration:7s
        - explode <context.entity.location> power:1 source:<context.damager>
        - playsound sound:block_beacon_deactivate at:<player.location> pitch:0 volume:2
        - playsound sound:entity_generic_burn at:<player.location> pitch:0 volume:2
        - itemcooldown shield duration:4s
        - flag <context.damager> sunsetcooldown expire:4s
        - flag <context.damager> hamon:<context.damager.flag[hamon].sub[35]>
        - title "title:" "subtitle:<element[<player.flag[hamon]>%].color[#FFFF80]>" fade_in:0 stay:1s targets:<player>
      - else:
        - define fucked <context.damager.location.find.living_entities.within[6].exclude[<context.damager>]>
        - define fucked2 <context.damager.location.find.living_entities.within[12].exclude[<context.damager>]>
        - playeffect effect:flame quantity:120 at:<context.entity.eye_location> offset:1.5
        - hurt <[fucked]> 10 source:<context.damager>
        - burn <[fucked2]> duration:10s
        - explode <context.entity.location> power:1 source:<context.damager>
        - playsound sound:block_beacon_deactivate at:<player.location> pitch:0 volume:2
        - playsound sound:entity_generic_burn at:<player.location> pitch:0 volume:2
        - itemcooldown shield duration:1.5s
        - playsound sound:block_beacon_deactivate at:<player.location> pitch:1 volume:2
        - playsound sound:entity_generic_burn at:<player.location> pitch:1 volume:2
        - flag <context.damager> sunsetcooldown expire:1.5s
        - flag <context.damager> hamon:<context.damager.flag[hamon].sub[80]>
        - title "title:" "subtitle:<element[<player.flag[hamon]>%].color[#FFFFC0].bold>" fade_in:0 stay:1s targets:<player>
      - foreach <[fucked2]>:
        - light <[value].location> 15 duration:10t
      # OVERDRIVE PART 2
    - if <context.damager.has_flag[hamonoverdrive]>:
      - flag <context.entity> beingshot expire:1s
      - adjust <context.entity> max_no_damage_duration:3t
    #- hurt <context.entity> 1
      - wait 1s
      - if !<context.entity.has_flag[beingshot]>:
        - adjust <context.entity> max_no_damage_duration:20t
    on player right clicks block with:sunsetsea:
    - if !<player.has_flag[sunsetcooldown]>:
      - if <player.flag[hamon]> > 100:
        - cast <player> REGENERATION duration:5s amplifier:3 hide_particles no_icon
        - cast <player> SPEED duration:5s amplifier:2 hide_particles no_icon
        - cast <player> DAMAGE_RESISTANCE duration:5s amplifier:1 hide_particles no_icon
        - cast <player> INSTANT_HEAL duration:1t amplifier:0 hide_particles no_icon
        - flag <player> sunsetcooldown expire:6s
        - flag <player> hamon:<player.flag[hamon].sub[35]>
        - itemcooldown shield duration:6s
        - playsound sound:block_beacon_deactivate at:<player.location> pitch:0 volume:2
        - playsound sound:block_beacon_deactivate at:<player.location> pitch:1 volume:2
        - playeffect effect:redstone special_data:0.7|<color[#FFFFC0]> quantity:120 at:<player.eye_location> offset:1
        - title "title:" "subtitle:<element[<player.flag[hamon]>%].color[#FFFFC0].bold>" fade_in:0 stay:1s targets:<player>
      - else if <player.flag[hamon]> > 14:
        - cast <player> REGENERATION duration:5s amplifier:2 hide_particles no_icon
        - cast <player> SPEED duration:5s amplifier:1 hide_particles no_icon
        - cast <player> DAMAGE_RESISTANCE duration:5s amplifier:0 hide_particles no_icon
        - flag <player> sunsetcooldown expire:8s
        - flag <player> hamon:<player.flag[hamon].sub[15]>
        - itemcooldown shield duration:8s
        - playsound sound:block_beacon_deactivate at:<player.location> pitch:0 volume:2
        - playeffect effect:redstone special_data:0.5|<color[#FFFF80]> quantity:120 at:<player.eye_location> offset:1
        - title "title:" "subtitle:<element[<player.flag[hamon]>%].color[#FFFF80]>" fade_in:0 stay:1s targets:<player>
      #- light <player.location> 15 duration:2t