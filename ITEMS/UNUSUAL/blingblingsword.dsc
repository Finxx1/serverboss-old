blingring:
  type: item
  material: diamond
  display name: <element[The Ring].color_gradient[from=#FFC000;to=#FF8000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375230
  lore:
  - <element[It overflows with mortal power].color_gradient[from=#806000;to=#804000]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

blingblingsword:
  type: item
  material: diamond_sword
  display name: <element[「Bling-bling Sword」].color_gradient[from=#FFC000;to=#FF8000]>
  enchantments:
  - damage_all: 10
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13377777
    attribute_modifiers:
      generic_attack_speed:
        1:
          operation: add_scalar
          amount: 8
          slot: hand
          id: 10000000-1000-1000-1000-100000000000
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: blingring|abrose|sentientsword[attribute_modifiers=map@[GENERIC_ATTACK_SPEED=li@map@[name=GENERIC_ATTACK_SPEED;amount=8;operation=ADD_SCALAR;slot=HAND;id=10000000-1000-1000-1000-100000000000]|;GENERIC_MAX_HEALTH=li@map@[name=GENERIC_MAX_HEALTH;amount=-0.5;operation=ADD_SCALAR;slot=HAND;id=10000000-1000-1000-1000-100000000000]|]]|australium|australium
  lore:
  - <element[-= WHAT DID YOU DO TO IT =-].color_gradient[from=#806000;to=#804000]>
  - <element[-= JESUS FUCKING CHRIST =-].color_gradient[from=#804000;to=#806000]>
  - 
  - <element[UNUSUAL].color[#9040C0].bold>

blingblingtriggers:
  type: world
  debug: false
  events:
    # # # whispering to player
    after delta time secondly every:120:
    - foreach <server.online_players>:
      - if <[value].inventory.contains_item[blingblingsword]||0> && !<[value].has_flag[headsheadsheads]>:
        - random:
            - playsound sound:ambient_cave at:<[value].location> pitch:1
            - playsound sound:entity_blaze_ambient at:<[value].location> pitch:1
        - random:
            - title "title:" "subtitle:<element[GET ME OUT OF HERE].color_gradient[from=#FFC000;to=#FF8000]>" stay:3s targets:<[value]>
            - title "title:" "subtitle:<element[WHAT THE FUCK DID YOU DO TO ME].color_gradient[from=#FFC000;to=#FF8000]>" stay:3s targets:<[value]>
    # # # woosh
    on player left clicks block with:blingblingsword:
    - if <player.attack_cooldown_percent> == 100:
      - playsound sound:entity_player_attack_sweep at:<player.location> pitch:0
    # # # shut up after a kill (satisfied for a while)
    on player kills entity:
    - if <context.damager.item_in_hand.script||0> == s@sentientsword:
      - flag <player> headsheadsheads expire:60s
      - itemcooldown diamond_sword duration:5t
      - random:
        - title "title:<element[HEAD!].color_gradient[from=#FFC000;to=#FF8000]>" "subtitle:" stay:1s targets:<context.damager>
        - title "title:<element[HEAD!!!].color_gradient[from=#FFC000;to=#FF8000]>" "subtitle:" stay:1s targets:<context.damager>
        - title "title:<element[FOUND ONE].color_gradient[from=#FFC000;to=#FF8000]>" "subtitle:" stay:1s targets:<context.damager>
        - title "title:<element[MORE! MORE!! MORE!!!].color_gradient[from=#FFC000;to=#FF8000]>" "subtitle:" stay:1s targets:<context.damager>
        - title "title:<element[NEED MORE].color_gradient[from=#FFC000;to=#FF8000]>" "subtitle:" stay:1s targets:<context.damager>
        - title "title:<element[GET MORE].color_gradient[from=#FFC000;to=#FF8000]>" "subtitle:" stay:1s targets:<context.damager>
        - title "title:<element[ANOTHER ONE! ANOTHER ONE!].color_gradient[from=#FFC000;to=#FF8000]>" "subtitle:" stay:1s targets:<context.damager>
      - playsound sound:ambient_cave at:<player.location> pitch:1.5
      - playsound sound:entity_blaze_ambient at:<player.location> pitch:1.5
    on player damaged by entity:
    - if <context.entity.item_in_hand.script.name> == blingblingsword:
      - hurt <context.damager> amount:5 source:<context.entity>
    on player damaged:
    - if <context.entity.inventory.contains_any[blingring]> || <context.entity.item_in_hand.script.name> == blingblingsword:
      - determine <context.damage.min[2]> passively
    on player damages entity with:blingblingsword:
    - if <context.entity.has_flag[rosetainted]> || <context.damager.has_flag[rosecooldown]>:
      - stop
    - flag <context.entity> rosetainted expire:10s
    - run rosethorns def:<context.entity>
    - flag <context.damager> rosecooldown expire:5s
    - itemcooldown diamond_sword duration:5s