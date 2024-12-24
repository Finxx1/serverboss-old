standarrow:
  type: item
  material: arrow
  display name: <element[ゴ ゴ ゴ STAND ARROW ゴ ゴ ゴ].color_gradient[from=#404000;to=#C0C0C0]>
  lore:
  - <element[Power].color_gradient[from=#202000;to=#606060]>
  - <&7>
  - <element[COMMUNITY].color[#B0E060].bold>

standarrowtriggers:
  debug: false
  type: world
  events:
    on player right clicks block with:standarrow:
    - if !<player.has_flag[arrowcooldown]>:
      - flag <player> arrowcooldown expire:8s
      - hurt <player> 5 cause:custom
      - repeat 80:
        - playeffect cloud at:<player.eye_location> quantity:12 offset:0.4
        - wait 1t
      - if <player.inventory.contains_item[standarrow]>:
        - run giveplayerrequiem def:<player>
    on player damaged:
    - if <context.entity.inventory.contains_item[standarrow]> && <context.cause> != custom:
      - take item:standarrow from:<context.entity.inventory>
      - drop standarrow <context.entity.location.add[0,0.3,0]> quantity:1 speed:3 delay:2s

giveplayerrequiem:
  debug: false
  type: task
  definitions: standuser
  script:
  #- announce "it worked, <[standuser].name> got requiem"
  - heal <[standuser]> <[standuser].health_max>
  - choose <[standuser].name>:
    - case IceTudor:
      - take item:dlbadmodem from:<[standuser].inventory>
      - take item:dlrubberband from:<[standuser].inventory>
      - take item:dltimeout from:<[standuser].inventory>
      - take item:dlpunch from:<[standuser].inventory>
      - take item:dlbarrage from:<[standuser].inventory>
      - playsound <[standuser].location> sound:custom.dialup_stand_summon pitch:0 volume:4 custom
      - give dlrbadmodem
      - give dlrrubberband
      - give dlrtimeout
      - give dlrfreezeframe
      - give dlrlagspike
      - give dlrpunch
      - give dlrbarrage
    - case rika55:
      - take item:eotswap from:<[standuser].inventory>
      - take item:eotblink from:<[standuser].inventory>
      - take item:eotdementia from:<[standuser].inventory>
      - take item:eotpunch from:<[standuser].inventory>
      - take item:eotbarrage from:<[standuser].inventory>
      - playsound <[standuser].location> sound:custom.endofstime_stand_summon pitch:0 volume:4 custom
      - give eotrblink
      - give eotrswap
      - give eotrdementia
      - give eotrtemporaryblissstate
      - give eotrterminallucidity
      - give eotrpunch
      - give eotrbarrage
    - case AGooseWithAPhone:
      - take item:h2hubercharge from:<[standuser].inventory>
      - take item:h2hleap from:<[standuser].inventory>
      - take item:h2hpunch from:<[standuser].inventory>
      - take item:h2hbarrage from:<[standuser].inventory>
      - playsound <[standuser].location> sound:custom.h2h_stand_summon pitch:0 volume:4 custom
      - give h2hrubercharge
      - give h2hrleap
      - give h2hrqf
      - give h2hrpunch
      - give h2hrbarrage
    - default:
      - announce "you havent been given a requiem stand (or any stand at all) yet, ask ice for once"