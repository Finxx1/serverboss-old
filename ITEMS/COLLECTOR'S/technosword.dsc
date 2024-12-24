cybersword:
  type: item
  material: diamond_sword
  display name: <element[Cyber].color_gradient[from=#FF0000;to=#606060]><element[sword].color_gradient[from=#606060;to=#00FF00]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374210
  lore:
  - <element[Repay with altern].color_gradient[from=#800000;to=#303030]><element[ating current tenfold].color_gradient[from=#303030;to=#008000]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>



cswordtriggers:
  type: world
  debug: false
  events:
    on player damages entity with:cybersword:
    - if <context.damager.flag[energy]||0> > 0:
      - determine <context.damage.add[<context.damager.flag[energy].mul[0.25]>]> passively
      - if <context.damager.flag[energy]||0> == 100:
        - run lightning_mgk def:<player>
      - flag <context.damager> energy:0
      - flag <player> energyfull:!
    on tick every:5:
    - foreach <server.online_players>:
      - if <[value].flag[energy]||0> < 100:
        - flag <[value]> energy:<[value].flag[energy].add[1].min[100]||0>
      - if <[value].item_in_hand.script.name||0> == cybersword:
        - if <[value].flag[energy]> < 100:
          - title "title:<element[⚡ <[value].flag[energy]>,000V ⚡].bold.italicize.color_gradient[from=#008080;to=#00FFFF]>" "subtitle:<element[⚡].color[#00FFFF]> <element[.].unescaped.repeat[<[value].flag[energy].sub[1]>].color_gradient[from=#008080;to=#00FFFF]><element[ϟ].unescaped.bold.color[#00FFFF]><element[.].unescaped.repeat[<element[100].sub[<[value].flag[energy]>]>].color[#204040]> <element[⚡].color[#204040]>" fade_in:0 stay:10t fade_out:5t targets:<[value]>
        - else:
          - title "title:<element[⚡ <[value].flag[energy]>,000V ⚡].bold.italicize.color_gradient[from=#008080;to=#00FFFF]>" "subtitle:<element[⚡].color[#00FFFF]> <element[.].unescaped.repeat[<[value].flag[energy].sub[1]>].color_gradient[from=#008080;to=#00FFFF]><element[ϟ].unescaped.bold.color[#00FFFF]><element[.].unescaped.repeat[<element[100].sub[<[value].flag[energy]>]>].color[#204040]> <element[⚡].color[#00FFFF]>" fade_in:0 stay:10t fade_out:5t targets:<[value]>
          - if !<[value].has_flag[energyfull]>:
            - playsound at:<[value].eye_location> sound:custom.lightning_charge pitch:1 volume:2 custom
          - flag <[value]> energyfull