timestopcancel:
  debug: false
  type: world
  events:
    on player walks priority:-100:
    - if !<player.location.find.players.within[100].filter[has_flag[timestop]].is_empty||true> && <player.has_flag[timestop].not> && <player.item_in_hand> != jujucrowbar:
      - determine cancelled passively
    on player chats priority:-100:
    - if !<player.location.find.players.within[100].filter[has_flag[timestop]].is_empty||true> && <player.has_flag[timestop].not> && !(<context.message> = "TIME STOP") && !(<context.message> = "TS")  && <player.item_in_hand> != jujucrowbar:
      - determine cancelled
    on command priority:-100:
    - if <player||null> != null && !<player.location.find.players.within[100].filter[has_flag[timestop]].is_empty||true> && <player.has_flag[timestop].not> && <player.item_in_hand> != jujucrowbar:
      - determine cancelled
    on player clicks block priority:-100:
    - if !<player.location.find.players.within[100].filter[has_flag[timestop]].is_empty||true> && <player.has_flag[timestop].not> && <player.item_in_hand> != jujucrowbar:
      - if <player.flag[standability]||null> == starplatinumtimestop || <player.flag[standability]||null> == theworldtimestop:
        - stop
      - determine cancelled
    on player breaks block priority:-100:
    - if !<player.location.find.players.within[100].filter[has_flag[timestop]].is_empty||true> && <player.has_flag[timestop].not> && <player.item_in_hand> != jujucrowbar:
      - determine cancelled
    on player places block priority:-100:
    - if !<player.location.find.players.within[100].filter[has_flag[timestop]].is_empty||true> && <player.has_flag[timestop].not> && <player.item_in_hand> != jujucrowbar:
      - determine cancelled
    on player damages entity priority:-100:
    - if !<context.damager.location.find.players.within[100].filter[has_flag[timestop]].is_empty||true> && <context.damager.has_flag[timestop].not> && <player.item_in_hand> != jujucrowbar:
      - determine cancelled

#timestopcancel2:
#  debug: false
#  type: world
#  events:
#    on tick:
#    - if <player.item_in_hand> == jujucrowbar:
#      - stop
#    - if !<player.location.find.players.within[100].filter[has_flag[timestop]].is_empty||true> && <player.has_flag[timestop].not>:
#      - adjust <player> velocity:[0,0,0]

timestopdamage:
  debug: false
  type: world
  events:
    on entity damaged priority:100:
    - if <context.entity.item_in_hand||0> == jujucrowbar:
      - stop
    # dumbass death like fire
    - if <context.damager||null> == null && !<context.entity.location.find.entities.within[100].filter[has_flag[timestop]].is_empty>:
      - determine cancelled
    - if <context.damager.is_spawned||false> && <context.entity.is_spawned||false> && <context.entity.has_flag[timestop].not> && <context.damager.has_flag[timestop]||false>:
      - flag <context.entity> tsdamage:+:<context.damage>
      - flag <context.entity> tsdamager:<context.damager>
      - determine 0 passively

timestopkb:
  debug: false
  type: world
  events:
    on entity knocks back entity priority:100:
    - if <context.entity.item_in_hand> == jujucrowbar:
      - stop
    - if <context.damager||null> == null && !<context.damager.location.find.entities.within[100].filter[has_flag[timestop]].is_empty>:
      - determine cancelled
    - if <context.damager||null> != null && !<context.damager.location.find.entities.within[100].filter[has_flag[timestop]].is_empty> && <context.damager.has_flag[timestop]>:
      - if <context.entity.has_flag[tsacceleration]>:
        - define y <context.entity.flag[tsacceleration].parse[as_location].parse[y].highest>
        - flag <context.entity> tsacceleration:<context.entity.flag[tsacceleration].as_location.add[<context.acceleration>].with_y[<[y]>]>
      - else:
        - flag <context.entity> tsacceleration:<context.acceleration>
      - determine cancelled

timestopfinishdamage:
  debug: false
  type: task
  definitions: value
  script:
  - if <[value].has_flag[tsacceleration]>:
    - define acceleration <[value].flag[tsacceleration].as_location.mul[1.6]>
    - flag <[value]> tsacceleration:!

    - adjust <[value]> velocity:<[acceleration].add[<[value].velocity>]>
  - if <[value].has_flag[tsdamager]> && <[value].has_flag[tsdamage]>:
    - define damager <[value].flag[tsdamager]>
    - define damage <[value].flag[tsdamage]>
    - flag <[value]> tsdamager:!
    - flag <[value]> tsdamage:!

    - waituntil <[value].last_damage.amount.in_ticks||0> == 0
    - if <[value].is_spawned.not||false>:
      - stop
    - if <[damager].is_spawned>:
      - hurt <[value]> <[damage]> source:<[damager]>
    - else:
      - hurt <[value]> <[damage]>