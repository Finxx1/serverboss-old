thebucket:
  type: item
  material: bucket
  display name: <element[⚠ ].bold.color[#C00000]><element[「The Bucket」].color[#A4A4A4]><element[ ⚠].bold.color[#C00000]>
  enchantments:
  - infinity:1
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374220
  lore:
  - <element[-= Pocket dimension! =- <&l>⚠<&r> BUSTED VARIANT <&l>⚠<&r>].color[#525252]>
  - <&7>
  - <element[DEVELOPER].color[#525252].bold>

thebuckettriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:thebucket:
    - ratelimit <player> 0t
    - flag player sucking expire:5t
    - determine cancelled passively
    - define lookvec <player.eye_location.direction.vector>
    - define facingloc <player.eye_location.forward[2]>
    - playeffect at:<[facingloc].forward[1]> effect:cloud quantity:3 velocity:<[lookvec].mul[-0.5]> data:1 offset:0.5
    - playsound at:<[facingloc]> sound:ITEM_ELYTRA_FLYING pitch:1 volume:0.4
    - playsound at:<[facingloc]> sound:ITEM_ELYTRA_FLYING pitch:2 volume:0.4
    - define shitaroundme <[facingloc].find_entities.within[5].exclude[<player>]>
    - if !<[shitaroundme].is_empty>:
      - foreach <[shitaroundme]>:
        - if <[value].has_flag[ikeaframe]>:
          - foreach next
        - adjust <[value]> velocity:<[value].velocity.mul[1].add[<[facingloc].sub[<[value].eye_location>].normalize.div[<[value].eye_location.distance[<[facingloc]>].power[1.5].div[3].add[1]>]>]>]>
        - if <[value].eye_location.distance[<[facingloc]>]> < 1.5:
          - playsound at:<[facingloc]> sound:ITEM_BUCKET_FILL pitch:1 volume:9
          - teleport <[value]> <location[0,10,0,bucket2]>
    - wait 6t
    - if <player.has_flag[sucking]>:
      - stop
    - adjust <server.online_players> stop_sound:minecraft:item.elytra.flying
    on player left clicks block with:thebucket:
    - determine cancelled passively
    - if <world[bucket2].entities.is_empty>:
      - stop
    - define lookvec <player.eye_location.direction.vector>
    - define lookpitch <player.eye_location.pitch>
    - define lookyaw <player.eye_location.yaw>
    - define facingloc <player.eye_location.forward[1]>
    - playsound at:<[facingloc]> sound:ITEM_BUCKET_EMPTY pitch:1 volume:1
    - playeffect at:<[facingloc].forward[1]> effect:cloud quantity:3 velocity:<[lookvec].mul[0.5]> data:1
    - define pickedentity <world[bucket2].entities.random>
    - teleport <[pickedentity]> <[facingloc].with_pose[<[lookpitch]>,<[lookyaw]>]>
    - if !<[pickedentity].is_in_block>:
      - adjust <[pickedentity]> velocity:<[lookvec].mul[2]>
    - else:
      - adjust <[pickedentity]> velocity:<[lookvec].mul[10]>

thebucketnerfed:
  type: item
  material: bucket
  display name: <element[「The Bucket」].color_gradient[from=#8080C0;to=#C0C0C0]>
  enchantments:
  - infinity:1
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374220
  lore:
  - <element[-= Pocket dimension! =-].color_gradient[from=#404060;to=#606060]>
  - <&7>
  - <element[UNUSUAL].color[#9040C0].bold>

thebuckettriggers2:
  type: world
  debug: false
  events:
    on player right clicks block with:thebucketnerfed:
    - ratelimit <player> 0t
    - flag player sucking expire:5t
    - determine cancelled passively
    - define lookvec <player.eye_location.direction.vector>
    - define facingloc <player.eye_location.forward[3.5]>
    - playeffect at:<[facingloc].forward[1]> effect:cloud quantity:3 velocity:<[lookvec].mul[-0.5]> data:1 offset:0.5
    - playsound at:<[facingloc]> sound:ITEM_ELYTRA_FLYING pitch:1 volume:0.4
    - playsound at:<[facingloc]> sound:ITEM_ELYTRA_FLYING pitch:2 volume:0.4
    - define shitaroundme <[facingloc].find_entities.within[7].exclude[<player>]>
    - if !<[shitaroundme].is_empty>:
      - foreach <[shitaroundme]>:
        - adjust <[value]> velocity:<[value].velocity.mul[1].add[<[facingloc].sub[<[value].eye_location>].normalize.div[<[value].eye_location.distance[<[facingloc]>].power[1.5].div[3].add[1]>]>]>]>
        - if <[value].eye_location.distance[<[facingloc]>]> < 1.5:
          - if <[value].health> > <[value].health_max.div[10]>:
            - hurt <[value]> <[value].health_max.div[3].min[20]> source:<player>
          - else:
            - if !<[value].has_flag[unsuckable]> && !<[value].has_flag[ikeaframe]>:
              - playsound at:<[facingloc]> sound:ITEM_BUCKET_FILL pitch:1 volume:9
              - teleport <[value]> <location[0,10,0,bucket2]>
    - wait 6t
    - if <player.has_flag[sucking]>:
      - stop
    - adjust <server.online_players> stop_sound:minecraft:item.elytra.flying
    on player left clicks block with:thebucketnerfed:
    - determine cancelled passively
    - if <world[bucket2].entities.is_empty>:
      - stop
    - define lookvec <player.eye_location.direction.vector>
    - define lookpitch <player.eye_location.pitch>
    - define lookyaw <player.eye_location.yaw>
    - define facingloc <player.eye_location.forward[1]>
    - playsound at:<[facingloc]> sound:ITEM_BUCKET_EMPTY pitch:1 volume:1
    - playeffect at:<[facingloc].forward[1]> effect:cloud quantity:3 velocity:<[lookvec].mul[0.5]> data:1
    - define pickedentity <world[bucket2].entities.random>
    - teleport <[pickedentity]> <[facingloc].with_pose[<[lookpitch]>,<[lookyaw]>]>
    - if !<[pickedentity].is_in_block>:
      - adjust <[pickedentity]> velocity:<[lookvec].mul[0.5]>
    - else:
      - adjust <[pickedentity]> velocity:<[lookvec].mul[10]>