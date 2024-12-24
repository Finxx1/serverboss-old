grapple:
  type: item
#  material: string
  material: iron_horse_armor
  display name: <element[「Grappling Hook」].color_gradient[from=#808080;to=#408040]>
  enchantments:
  - infinity:1
  mechanisms:
    unbreakable: true
    hides: all
#    custom_model_data: 13374213
    custom_model_data: 13374322
  lore:
  - <element[-= Thwip! =-].color_gradient[from=#404040;to=#204020]>
  - <&7>
  - <element[UNUSUAL].color[#9040C0].bold>

grappletriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:grapple:
    - determine cancelled passively
    - if <player.has_flag[grapplingrn]>:
      - stop
    - inventory adjust "custom_model_data:13374323" destination:<player.inventory> slot:hand
    - flag <player> grapplingrn
    - playsound sound:item_crossbow_shoot pitch:1 volume:1 <player.eye_location>
    - playsound sound:custom.grapplethrow pitch:1 volume:2 <player.eye_location> custom
    - shoot hook origin:<player.eye_location> speed:6 spread:0 shooter:<player> save:lolhook
    - define hookofinterest <entry[lolhook].shot_entities.get[1]>
    - flag <[hookofinterest]> airborne
    - adjust <[hookofinterest]> pickup_status:disallowed
    - while <[hookofinterest].has_flag[airborne]>:
      - playeffect at:<[hookofinterest].location.points_between[<player.location.add[0,1,0]>].distance[0.1]> effect:redstone special_data:0.3|<color[#000000]> offset:0 quantity:1 visibility:100
      - if <[loop_index]> > 400:
        - while stop
      - if !<[hookofinterest].location.line_of_sight[<player.location.add[0,1,0]>]> || <[hookofinterest].location.distance[<player.location.add[0,1,0]>]> > 100:
        - playeffect at:<[hookofinterest].location.points_between[<player.location.add[0,1,0]>].distance[1]> effect:large_smoke offset:0 quantity:1 visibility:100
        - while stop
      - wait 1t
    - if !<[hookofinterest].is_in_block>:
      - playsound sound:block_note_block_didgeridoo pitch:0 volume:1 <player.eye_location>
      - itemcooldown iron_horse_armor duration:1s
      - flag <player> grapplingrn expire:1s
      - remove <[hookofinterest]>
      - while <player.item_in_hand.script.name||0> != grapple:
        - wait 1t
        - if <[loop_index]> > 600:
          - stop
      - inventory adjust "custom_model_data:13374322" destination:<player.inventory> slot:hand
    #on player left clicks block with:grapple:
    #- determine cancelled passively
    #- define lookvec <player.eye_location.direction.vector>
    #- define facingloc <player.eye_location.forward[2]>
    #- define aimtarg <player.eye_location.ray_trace[range=100;return=precise;default=air;ignore=<player>;nonsolids=false]>
    #- define dist <player.location.add[0,1,0].distance[<[aimtarg]>]>
    #- while !<player.is_sneaking>:
    #  - if <[dist]> < <player.location.add[0,1,0].distance[<[aimtarg]>]>:
    #    - adjust <player> velocity:<player.velocity.mul[0.1].add[<player.location.add[0,1,0].sub[<[aimtarg]>].mul[-2].normalize>]>
    #  - wait 1t
    #  - if <[loop_index]> > 400:
    #    - while stop