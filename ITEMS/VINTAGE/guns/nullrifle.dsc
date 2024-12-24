nullrifle:
  type: item
  material: diamond_horse_armor
  display name: <element[ ].color[#000000]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374204
    hides: all
  lore:
  - <element[ ].color[#000000]>
  - 
  - <element[VINTAGE].color[#404878].bold>

darkprojs:
  type: item
  material: clay_ball
  display name: <element[Dark Matter].color[#000000]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374327
    hides: all
  lore:
  - <element[you shouldnt have this!!].color[#000000]>
#  - 
#  - <element[VINTAGE].color[#404878].bold>

redprojs:
  type: item
  material: clay_ball
  display name: <element[Red Matter].color[#800000]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374328
    hides: all
  lore:
  - <element[you shouldnt have this!!].color[#400000]>
#  - 
#  - <element[VINTAGE].color[#404878].bold>

darkprojp:
  type: entity
  entity_type: snowball
  mechanisms:
    gravity: false
    item: darkprojs

redprojp:
  type: entity
  entity_type: snowball
  mechanisms:
    gravity: true
    item: redprojs

nullrifletriggers:
  type: world
  debug: false
  events:
    on player left clicks block with:nullrifle:
    - if <player.has_flag[nriflecooldown]>:
      - stop
    - flag <player> nriflecooldown expire:460t
    - itemcooldown diamond_horse_armor duration:460t
    - title targets:<player> "title:<element[Red Matter].bold.color_gradient[from=#000000;to=#800000]>" fade_out:10t stay:5t fade_in:0t
    - shoot redprojp origin:<player.eye_location.right[0.4].below[0.4]> speed:2 shooter:<player> spread:0
    on player right clicks block with:nullrifle:
    - if <player.has_flag[nriflecooldown]>:
      - stop
    - flag <player> nriflecooldown expire:6t
    - itemcooldown diamond_horse_armor duration:6t
    - if <player.is_sneaking>:
      - choose <player.flag[nullriflemode]||dark_energy>:
        - case dark_energy:
          - flag <player> nullriflemode:dark_matter
          - title targets:<player> "title:<element[Dark Matter].bold.color_gradient[from=#000000;to=#600060]>" fade_out:10t stay:5t fade_in:0t
          - playsound <player.location> sound:BLOCK_RESPAWN_ANCHOR_CHARGE pitch:0 volume:1
        - case dark_matter:
          - flag <player> nullriflemode:dark_energy
          - title targets:<player> "title:<element[Dark Energy].bold.color_gradient[from=#000000;to=#000080]>" fade_out:10t stay:5t fade_in:0t
          - playsound <player.location> sound:BLOCK_RESPAWN_ANCHOR_CHARGE pitch:0 volume:1
    - else:
      - choose <player.flag[nullriflemode]||dark_energy>:
        - case dark_energy:
          - repeat 2:
            - playsound <player.location> sound:item_bottle_fill_dragonbreath pitch:1 volume:1
            - define aimtarg <player.eye_location.ray_trace[range=40;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.5]>
            - define posline <player.eye_location.points_between[<[aimtarg]>].distance[0.5]>
            - foreach <[posline]>:
              - playeffect at:<[value]> effect:redstone special_data:0.5|<color[#000000]> quantity:1 offset:0 visibility:100
            - foreach <[aimtarg].find_entities.within[4].exclude[<player>]>:
              - adjust <[value]> velocity:<[value].velocity.add[<[value].location.sub[<[aimtarg]>].normalize.mul[0.3]>]>
            - foreach <[aimtarg].find_entities.within[2].exclude[<player>]>:
              - hurt <[value]> amount:3
            - playeffect at:<[aimtarg]> effect:redstone special_data:1|<color[#000000]> quantity:16 offset:0.1 visibility:100
            - wait 4t
        - case dark_matter:
          - repeat 2:
            - playsound <player.location> sound:item_trident_return pitch:0 volume:1
            - shoot darkprojp origin:<player.eye_location.right[0.4].below[0.4]> speed:3 shooter:<player> spread:1
            - wait 4t
    on darkprojp hits block:
    - playeffect at:<context.projectile.location> effect:redstone special_data:2|<color[#000000]> quantity:16 offset:0.4 visibility:100
    - playsound <context.projectile.location> sound:item_trident_return pitch:1 volume:1
    - foreach <context.projectile.location.find_entities.within[5].exclude[<context.projectile.shooter>]>:
      - adjust <[value]> velocity:<[value].velocity.add[<[value].location.sub[<context.projectile.location>].normalize.mul[-0.2]>]>
    on darkprojp hits entity:
    - playeffect at:<context.projectile.location> effect:redstone special_data:2|<color[#000000]> quantity:16 offset:0.4 visibility:100
    - playsound <context.projectile.location> sound:item_trident_return pitch:1 volume:1
    - foreach <context.projectile.location.find_entities.within[5].exclude[<context.projectile.shooter>]>:
      - adjust <[value]> velocity:<[value].velocity.add[<[value].location.sub[<context.projectile.location>].normalize.mul[-0.2]>]>
    on entity damaged by darkprojp:
    - determine 7 passively
    on redprojp hits block:
    - playsound <context.projectile.location> sound:BLOCK_RESPAWN_ANCHOR_DEPLETE pitch:0 volume:3
    - playsound <context.projectile.location> sound:ENTITY_WITHER_DEATH pitch:0 volume:2
    - playsound <context.projectile.location> sound:ENTITY_ENDER_DRAGON_DEATH pitch:0 volume:2
    - define hitloc <context.projectile.location.add[<context.hit_face>]>
    - define shtr <context.projectile.shooter>
    - repeat 360:
      - foreach <[hitloc].find_entities.within[16].exclude[<[shtr]>]>:
        - adjust <[value]> velocity:<[value].velocity.add[<[value].location.sub[<[hitloc]>].normalize.mul[-0.15]>]>
      - foreach <[hitloc].find_entities.within[2].exclude[<[shtr]>]>:
        - hurt <[value]> amount:3 source:fire
        - burn <[value]> duration:80t
      - playeffect at:<[hitloc]> effect:redstone special_data:3|<color[#800000]> quantity:32 offset:0.7 visibility:100
      - repeat 8:
        - playeffect at:<[hitloc]> effect:flame quantity:1 offset:0.1 visibility:100 velocity:<location[0,0,0].random_offset[0.25]>
      - wait 1t
    on redprojp hits entity:
    - playsound <context.projectile.location> sound:BLOCK_RESPAWN_ANCHOR_DEPLETE pitch:0 volume:3
    - playsound <context.projectile.location> sound:ENTITY_WITHER_DEATH pitch:0 volume:2
    - playsound <context.projectile.location> sound:ENTITY_ENDER_DRAGON_DEATH pitch:0 volume:2
    - define hitloc <context.hit_entity.eye_location>
    - define shtr <context.projectile.shooter>
    - repeat 360:
      - foreach <[hitloc].find_entities.within[16].exclude[<[shtr]>]>:
        - adjust <[value]> velocity:<[value].velocity.add[<[value].location.sub[<[hitloc]>].normalize.mul[-0.15]>]>
      - foreach <[hitloc].find_entities.within[2].exclude[<[shtr]>]>:
        - hurt <[value]> amount:3 source:fire
        - burn <[value]> duration:80t
      - playeffect at:<[hitloc]> effect:redstone special_data:3|<color[#800000]> quantity:32 offset:0.7 visibility:100
      - repeat 8:
        - playeffect at:<[hitloc]> effect:flame quantity:1 offset:0.1 visibility:100 velocity:<location[0,0,0].random_offset[0.25]>
      - wait 1t