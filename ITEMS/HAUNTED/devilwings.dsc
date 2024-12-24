devilwings:
  type: item
  material: elytra
  display name: <element[Devil Wings].color_gradient[from=#5808B0;to=#983878]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374997
  lore:
  - <element[&lbSilly Strings&rb TAKE HOLD!!!].unescaped.color_gradient[from=#2C0468;to=#4C1C3C]>
  - 
  - <element[HAUNTED].color[#38F0A8].bold>

devilwingstriggers:
  type: world
  debug: false
  events:
    on player starts gliding:
    - if <player.has_equipped[devilwings]||0>:
      - if <player.flag[gasolineused]||100> < 100 && !<player.has_flag[refilling]>:
        - if <player.is_sneaking>:
          - adjust <player> velocity:<player.velocity.add[<player.eye_location.direction.vector.normalize.mul[0.085]>].add[0,0.15,0]>
          - while <player.is_sneaking> && <player.flag[gasolineused]||100> < 100:
            - flag <player> gasolineused:<player.flag[gasolineused].add[1]>
            - cast <player> slow_falling duration:2t amplifier:0 no_icon hide_particles no_ambient
            - repeat 5:
              - playeffect at:<player.location.right[0.2].forward[1]> effect:flame offset:0 quantity:1 velocity:<player.eye_location.direction.vector.normalize.mul[-0.3].random_offset[0.1]> visibility:100
              - playeffect at:<player.location.left[0.2].forward[1]> effect:flame offset:0 quantity:1 velocity:<player.eye_location.direction.vector.normalize.mul[-0.3].random_offset[0.1]> visibility:100
            - adjust <player> velocity:<player.velocity.add[<player.eye_location.direction.vector.normalize.mul[0.03]>].add[0,0.02,0]>
            - wait 1t
            - define highup <player.location.y.sub[<player.location.with_pitch[90].ray_trace[range=100;return=precise;default=air;ignore=<player>;nonsolids=false].y>]>
            - define surfblock <player.location.with_pitch[90].ray_trace[range=255;return=precise;default=air;ignore=<player>;nonsolids=false].below[1].block.material.name>
            - if <[highup]> > 97 && <[surfblock]> != void_air:
              - adjust <player> gliding:false
              - playsound sound:item_crossbow_shoot pitch:1 volume:1 <player.eye_location>
              - shoot badhook origin:<player.location.with_pitch[90]> speed:8 spread:0 shooter:<player> save:lolhook2
              - run achievementgive def:<player>|bigshot
              - define hookofinterest <entry[lolhook2].shot_entities.get[1]>
              - flag <[hookofinterest]> airborne
              - adjust <[hookofinterest]> pickup_status:disallowed
              - while <[hookofinterest].has_flag[airborne]>:
                - playeffect at:<[hookofinterest].location.points_between[<player.location.add[0,1,0]>].distance[0.1]> effect:redstone special_data:0.3|<color[#000000]> offset:0 quantity:1 visibility:100
                - if <[loop_index]> > 400:
                  - while stop
                - if !<[hookofinterest].location.line_of_sight[<player.location.add[0,1,0]>]> || <[hookofinterest].location.distance[<player.location.add[0,1,0]>]> > 200:
                  - playeffect at:<[hookofinterest].location.points_between[<player.location.add[0,1,0]>].distance[1]> effect:large_smoke offset:0 quantity:1 visibility:100
                  - while stop
                - wait 1t
              - if !<[hookofinterest].is_in_block>:
                - playsound sound:block_note_block_didgeridoo pitch:0 volume:1 <player.eye_location>
                - itemcooldown string duration:1s
                - flag <player> grapplingrn expire:1s
                - remove <[hookofinterest]>
              - while stop
          - adjust <player> gliding:false
          - if <player.is_sneaking>:
            - title "title:<element[REFILLING!].color_gradient[from=#5808B0;to=#983878]>" "subtitle:" fade_in:0 stay:20t fade_out:180t targets:<player>
            - flag <player> refilling expire:200t
            - wait 200t
            - flag <player> gasolineused:0
            - playsound at:<player.eye_location> sound:item_bucket_fill_lava pitch:0 volume:2
        - else if !<player.has_flag[devilcooldown]>:
          - determine cancelled passively
          - adjust <player> velocity:<player.velocity.add[0,1.5,0]>
          - flag <player> gasolineused:<player.flag[gasolineused].add[25].min[100]>
          - repeat 25:
            - playeffect at:<player.location.right[0.2].above[1]> effect:flame offset:0 quantity:1 velocity:<location[0,-0.4,0].random_offset[0.1]> visbility:100
            - playeffect at:<player.location.left[0.2].above[1]> effect:flame offset:0 quantity:1 velocity:<location[0,-0.4,0].random_offset[0.1]> visbility:100
          - flag <player> devilcooldown expire:40t
          - playsound at:<player.eye_location> sound:entity_blaze_shoot volume:2 pitch:1
        - else:
          - determine cancelled passively
      - else if !<player.has_flag[refilling]>:
        - title "title:<element[REFILLING!].color_gradient[from=#5808B0;to=#983878]>" "subtitle:" fade_in:0 stay:20t fade_out:180t targets:<player>
        - flag <player> refilling expire:200t
        - wait 200t
        - flag <player> gasolineused:0
        - playsound at:<player.eye_location> sound:item_bucket_fill_lava pitch:0 volume:2
      - else:
        - determine cancelled passively
    on player damaged by FALL:
    - if <player.has_equipped[devilwings]||0>:
      - determine cancelled passively
    on player damaged:
    - if <player.has_equipped[devilwings]||0>:
      - if <player.health> <= 4:
        - determine <context.damage.mul[0.2]>