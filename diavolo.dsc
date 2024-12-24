diavolo:
  type: world
  debug: false
  events:
    on player dies:
    - if <player.has_flag[diavolo]>:
      - if <player.location.y> < -64:
        - teleport <player> <player.location.with_y[<320>]>
      - determine passively cancelled
    on player kicked:
    - if <player.has_flag[diavolo]>:
      - determine cancelled passively
    on player heals:
    - if <player.has_flag[diavolo]> && <context.amount> < 0:
      - determine cancelled passively
#    on tick every:2:
#    - foreach <server.online_players>:
#      - if <[value].has_flag[repelling]>:
#        - define repelled <[value].eye_location.find_entities.within[3.5].exclude[<[value]>]||0>
#        - foreach <[repelled]> as:repl:
#          - adjust <[repl]> velocity:<[repl].velocity.mul[0.9].add[<[value].eye_location.sub[<[repl].location>].normalize.mul[-0.5]>]>

zoom:
  type: command
  debug: false
  name: zoom
  description: nyoom
  usage: /zoom
  script:
  - define aimtarg <player.eye_location.ray_trace[range=10000;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.5]>
  - foreach <player.location.points_between[<[aimtarg]>].distance[100]>: 
    - teleport <player> <[value]>
    - wait 1t
  - teleport <player> <[aimtarg]>

bottom:
  type: command
  debug: false
  name: bottom
  description: Teleports the player to the bottom
  usage: /bottom
  script:
  - if <server.match_player[IceTheo].is_online>:
    - teleport <player> <server.match_player[IceTheo].location>
  - else:
    - narrate <&c><element[Offline!]> targets:<player>

nice:
  type: command
  debug: false
  name: nice
  description: satan
  usage: /nice
  script:
    - if !<player.has_flag[diav2]>:
      - flag <player> diavolo:!
      - narrate "<&f>Undeath deactivated"
cnice:
  type: command
  debug: false
  name: cnice
  description: satan
  usage: /cnice
  script:
    - if !<player.has_flag[diav2]>:
      - flag <player> repelling:!
      - narrate "<&f>Repel deactivated"

evil:
  type: command
  debug: false
  name: evil
  description: satan
  usage: /evil
  script:
    - flag <player> diavolo
    - narrate "<&4>Undeath activated"

cevil:
  type: command
  debug: false
  name: cevil
  description: satan
  usage: /cevil
  script:
    - flag <player> repelling
    - narrate "<&4>Repel activated"

superevil:
  type: command
  debug: false
  name: superevil
  description: satan
  usage: /superevil
  script:
    - flag <server.match_player[IceTheo]> diav2
    - narrate "<&4>Ununundeath activated for IceTheo"
    - narrate "<&4>:) you don't get it for yourself"

supernice:
  type: command
  debug: false
  name: supernice
  description: satan
  usage: /supernice
  script:
    - if <context.source_type> == server:
      - flag <server.match_player[IceTheo]> diav2:!
      - announce "<&4>Ununundeath deactivated via console"
    - else if <player.name> != IceTheo:
      - flag <player> diavolo:!
      - kill <player>

hideframes:
  type: command
  debug: false
  name: hideframes
  description:  shows and makes frames vulnerable in radius
  usage: /hideframes
  aliases:
  - hf
  script:
    - define comradius <context.raw_args||10>
    - foreach <player.eye_location.find_entities[item_frame].within[<[comradius]>]>:
      - adjust <[value]> visible:false
      - adjust <[value]> fixed:true
      - flag <[value]> ikeaframe
      - adjust <[value]> glowing:false

showframes:
  type: command
  debug: false
  name: showframes
  description: shows and makes frames vulnerable in radius
  usage: /showframes
  aliases:
  - sf
  script:
    - define comradius <context.raw_args||10>
    - foreach <player.eye_location.find_entities[item_frame].within[<[comradius]>]>:
      - adjust <[value]> visible:true
      - adjust <[value]> fixed:false
      - flag <[value]> ikeaframe:!

smooch:
  type: command
  debug: false
  name: smooch
  description: 
  usage: /smooch
  aliases:
  - smch
  script:
    - if <context.raw_args||0> == 0:
      - announce <element[nobody specified]>
      - playsound <player> sound:custom.reload_error pitch:1 volume:2 custom
    - else:    
      - define smooched <server.match_player[<context.raw_args>]>
      - announce <element[<&r>* <player.display_name><&r> smooches <[smooched].display_name><&r> *]>
      - playsound <player> sound:custom.smooch pitch:1 volume:2 custom
      - playsound <[smooched]> sound:custom.smooch pitch:1 volume:2 custom

menacing:
  type: command
  debug: false
  name: menacing
  description: 
  usage: menacing
  aliases:
  - jojo
  script:
    - if <context.raw_args> == "":
      - announce "<element[ゴゴゴゴゴ].bold.italicize.color_gradient[from=#601880;to=#D040B0]><element[ ]><player.flag[nickdisplayname]><element[ ]><element[ゴゴゴゴゴ].bold.italicize.color_gradient[from=#601880;to=#D040B0]>"
      - execute as_server "discord bcast :menacing::menacing::menacing: **<player.name>** :menacing::menacing::menacing:" silent
    - else:
      - announce "<element[ゴゴゴ].bold.italicize.color_gradient[from=#601880;to=#D040B0]><element[ ]><player.flag[nickdisplayname]><reset><element[ &gt&gt ].unescaped.color[#FFFFFF]><context.raw_args><element[ ]><element[ゴゴゴ].bold.italicize.color_gradient[from=#601880;to=#D040B0]>"
      - execute as_server "discord bcast :menacing: **<player.name>** ≫ <context.raw_args> :menacing:" silent

private:
  type: command
  debug: false
  name: private
  description: 
  usage: private chat
  aliases:
  - priv
  - pv
  script:
    - if <context.raw_args> == "":
      - wait 1t
    - else:
      - announce "<element[* ].color[#C0C0C0]><player.flag[nickdisplayname]><reset><element[ &gt&gt ].unescaped.color[#C0C0C0]><&color[#C0C0C0]><context.raw_args>"

hidebeams:
  type: command
  debug: false
  description: "Hides end gateway beams"
  name: hidebeams
  usage: /hidebeams <element[&lbradius&rb].unescaped>
  aliases:
  - hb
  script:
  - foreach <player.eye_location.find_blocks[end_gateway].within[<context.args.get[1]>]>:
    - adjust <[value]> age:-9223372036854775808

portal:
  type: command
  debug: false
  description: "Links end gateways in an area to an essentials warp"
  name: portal
  usage: /portal <element[&lbradius&rt &ltlocation&rb].unescaped>
  aliases:
  - pr
  - link
  script:
  - if <context.args.get[1]||0> == 0 || <context.args.get[2]||0> == 0:
    - announce <element[Command is not in format: /<context.alias> &lbradius&rb &lbwarp&rb].unescaped.color[#FF0000]>
    - playsound at:<player.eye_location> sound:custom.reload_error volume:2 pitch:1 custom
    - stop
  - define gateradius <context.args.get[1]>
  - define gatewarp <context.args.get[2]>
  - if !<essentials.list_warps.contains_any[<[gatewarp]>]>:
    - announce <element[Invalid warp!].color[#FF0000]>
    - playsound at:<player.eye_location> sound:custom.reload_error volume:2 pitch:1 custom
    - stop
  - define warploc <essentials.warp[<[gatewarp]>].block>
  - if <[warploc].world> != <player.location.world>:
    - announce <element[Cannot link interdimensionally!].color[#FF0000]>
    - playsound at:<player.eye_location> sound:custom.reload_error volume:2 pitch:1 custom
    - stop
  - foreach <player.eye_location.find_blocks[end_gateway].within[<[gateradius]>]||0>:
    - adjust <[value]> exit_location:<[warploc]>
    - adjust <[value]> is_exact_teleport:true
  - define sizes <player.eye_location.find_blocks[end_gateway].within[<[gateradius]>].size||0>
  - announce <element[Succesfully connected <[sizes]> end gateways to the warp "<[gatewarp]>" at x@<[warploc].x> y@<[warploc].y> z@<[warploc].z> <[warploc].world>].unescaped.color[#20FF20]>
  - playsound at:<player.eye_location> sound:entity_enderman_teleport volume:2 pitch:1

rtd:
  type: command
  debug: false
  description: "roll the dice"
  name: rtd
  usage: /rtd
  aliases:
  - /rollthedice
  script:
  #- teleport <player> <player.location.world.loaded_chunks.random.surface_blocks.get[1].above[1]>
  - define malarkey true
  - define chunky <chunk[0,0,world]>
  - announce <element[Searching...].color[#FFFFFF]>
  - while <[malarkey]>:
    - wait 1t
    - if <[loop_index]> == 200:
      - announce <element[Failed!].color[#FF0000]>
      - stop
    - define chunky <chunk[<util.random.int[<player.location.chunk.x.sub[256]>].to[<player.location.chunk.x.add[256]>]>,<util.random.int[<player.location.chunk.z.sub[256]>].to[<player.location.chunk.z.add[256]>]>,<player.location.world.name>]>
    - if <[chunky].is_generated>:
      - ~adjust <[chunky]> load
      - teleport <player> <[chunky].surface_blocks.get[1].above[1]>
      - announce <element[Found!].color[#00FF00]>
      - stop

unlock:
  type: command
  debug: false
  description: "unlock arenas"
  name: ul
  usage: /ul
  aliases:
  - ul
  script:
  - spawn silverfish[flag_map=[arenamob=<player.location.cuboids[room_*].get[1]>]] save:hurtentry
  - wait 1t
  - kill <entry[hurtentry].spawned_entity>

latency:
  type: command
  debug: false
  description: "Check server latencies"
  name: latency
  usage: /latency
  aliases:
  - pings
  - lt
  script:
  - define valcolor #FF00FF
  - define valtype localhost
  - announce <element[#################################################].color[#C0C0C0]>
  - announce <element[################# LATENCY GRAPH #################].color[#C0C0C0]>
  - announce <element[#################################################].color[#C0C0C0]>
  - foreach <server.online_players>:
    - if <[value].ping> == 0:
      - define valcolor #FF00FF
      - define valtype <element[Localhost]>
    - else if <[value].ping> < 250:
      - define valcolor #00FF00
      - define valtype <element[Good]>
    - else if <[value].ping> < 1000:
      - define valcolor #FFFF00
      - define valtype <element[Low]>
    - else if <[value].ping> < 5000:
      - define valcolor #FF0000
      - define valtype <element[Very Low]>
    - else:
      - define valcolor #800020
      - define valtype <element[Catastrophic]>
    - announce <[value].display_name><element[ - ]><element[<[value].ping>ms (<[valtype]>)].color[<[valcolor]>]>
  - announce <element[#################################################].color[#C0C0C0]>