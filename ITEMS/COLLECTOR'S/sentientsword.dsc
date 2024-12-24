sentientsword:
  type: item
  material: diamond_sword
  display name: <element[Sentient Sword].color_gradient[from=#004080;to=#00FFFF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13377666
    attribute_modifiers:
      generic_attack_speed:
        1:
          operation: add_scalar
          amount: 8
          slot: hand
          id: 10000000-1000-1000-1000-100000000000
      generic_max_health:
        1:
          operation: add_scalar
          amount: -0.5
          slot: hand
          id: 10000000-1000-1000-1000-100000000000
  lore:
  - <element[Some say it has a mind of its own...].color_gradient[from=#002040;to=#008080]>
  - <element[Binds to your very being].color_gradient[from=#002040;to=#008080]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

sentientswordtriggers:
  type: world
  debug: false
  events:
    # # # whispering to player
    after delta time secondly every:30:
    - foreach <server.online_players>:
      - if <[value].inventory.contains_item[sentientsword]||0> && !<[value].has_flag[headsheadsheads]>:
        - random:
            - playsound sound:ambient_cave at:<[value].location> pitch:0
            - playsound sound:entity_blaze_ambient at:<[value].location> pitch:0
        - random:
            - title "title:" "subtitle:<element[heaaadss...].color_gradient[from=#002040;to=#008080]>" stay:3s targets:<[value]>
            - title "title:" "subtitle:<element[heads heads heads heads heads heads].color_gradient[from=#002040;to=#008080]>" stay:3s targets:<[value]>
    # # # woosh
    on player left clicks block with:sentientsword:
    - if <player.attack_cooldown_percent> == 100:
      - playsound sound:entity_player_attack_sweep at:<player.location> pitch:0
    # # # shut up after a kill (satisfied for a while)
    on player kills entity:
    - if <context.damager.item_in_hand.script||0> == s@sentientsword:
      - flag <player> headsheadsheads expire:60s
      - itemcooldown diamond_sword duration:5t
      - random:
        - title "title:<element[HEAD!].color_gradient[from=#004080;to=#00FFFF]>" "subtitle:" stay:1s targets:<context.damager>
        - title "title:<element[HEAD!!!].color_gradient[from=#004080;to=#00FFFF]>" "subtitle:" stay:1s targets:<context.damager>
        - title "title:<element[FOUND ONE].color_gradient[from=#004080;to=#00FFFF]>" "subtitle:" stay:1s targets:<context.damager>
        - title "title:<element[MORE! MORE!! MORE!!!].color_gradient[from=#004080;to=#00FFFF]>" "subtitle:" stay:1s targets:<context.damager>
        - title "title:<element[NEED MORE].color_gradient[from=#004080;to=#00FFFF]>" "subtitle:" stay:1s targets:<context.damager>
        - title "title:<element[GET MORE].color_gradient[from=#004080;to=#00FFFF]>" "subtitle:" stay:1s targets:<context.damager>
        - title "title:<element[ANOTHER ONE! ANOTHER ONE!].color_gradient[from=#004080;to=#00FFFF]>" "subtitle:" stay:1s targets:<context.damager>
      - playsound sound:ambient_cave at:<player.location> pitch:0.75
      - playsound sound:entity_blaze_ambient at:<player.location> pitch:0.75
    on player damaged by entity:
    - if <context.entity.item_in_hand.script.name> == sentientsword:
      - hurt <context.damager> amount:5 source:<context.entity>