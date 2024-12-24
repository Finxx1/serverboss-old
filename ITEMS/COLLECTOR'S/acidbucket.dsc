acidbucket:
  type: item
  material: diamond
  display name: <element[Acid Bucket].color_gradient[from=#80FF00;to=#00FF20]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375241
  lore:
  - <element[WRONG, SULFURIC ACID!!!!!].color_gradient[from=#408000;to=#008010]>
  -
  - <element[COLLECTOR'S].color[#800000].bold>

acidsprite:
  type: item
  material: clay_ball
  display name: <element[acids]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374332

acidparticle:
  type: entity
  entity_type: snowball
  mechanisms:
    item: acidsprite

acidbuckettriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:acidbucket:
    - if <player.has_flag[acidcooldown]>:
      - stop
    - itemcooldown diamond duration:70t
    - flag <player> acidcooldown expire:70t
    - playsound <player.location> sound:item_bucket_fill pitch:2 volume:2
    - playsound <player.location> sound:item_bucket_fill pitch:1 volume:2
    - playsound <player.location> sound:item_bucket_fill pitch:0 volume:2
    - repeat 8: 
      - shoot acidparticle origin:<player.eye_location.right[0.4].below[0.6]> speed:0.95 shooter:<player> spread:15
      - shoot acidparticle origin:<player.eye_location.right[0.4].below[0.6]> speed:0.95 shooter:<player> spread:15
      - wait 1t
    after acidparticle spawns:
    - while <context.entity.is_spawned>:
      - playeffect at:<context.entity.location> effect:redstone offset:0.125 quantity:3 special_data:2|<color[#<list[80|40|00].random>FF00]> visibility:100
      - if <[loop_index]> > 15:
        - while stop
      - wait 1t
    - if <context.entity.is_spawned>:
      - remove <context.entity>
    on acidparticle hits entity:
    - define oopsie <context.hit_entity>
    - determine cancelled passively
    - if !<[oopsie].has_flag[acidized]>:
      - flag <[oopsie]> acidized expire:120t
      - run acidcoat def:<[oopsie]>
    - else:
      - flag <[oopsie]> acidized expire:120t

acidcoat:
  type: task
  debug: false
  definitions: coated
  script:
  - wait 2t
  - while <[coated].has_flag[acidized]>:
    - playeffect at:<[coated].location.add[0,1,0]> effect:falling_dust offset:0.25,0.4,0.25 quantity:3 special_data:lime_glazed_terracotta visibility:100
    - wait 5t
    - hurt <[coated]> amount:<[coated].health_max.sub[<[coated].health>].mul[0.1].min[19].add[1]>
    - if <[loop_index]> > 24:
      - while stop

oilbucket:
  type: item
  material: diamond
  display name: <element[Oil Bucket].color_gradient[from=#C0C060;to=#C08060]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375243
  lore:
  - <element[2) cover yourself in oil].color_gradient[from=#606030;to=#604030]>
  -
  - <element[COLLECTOR'S].color[#800000].bold>

oilsprite:
  type: item
  material: clay_ball
  display name: <element[oil]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374335

oilparticle:
  type: entity
  entity_type: snowball
  mechanisms:
    item: oilsprite

oilbuckettriggers:
  type: world
  debug: false
  events:
    on player left clicks block with:oilbucket:
    - determine cancelled passively
    - if <player.has_flag[oilcooldown]>:
      - stop
    - itemcooldown diamond duration:70t
    - flag <player> oilcooldown expire:70t
    - playsound <player.location> sound:item_bucket_fill pitch:2 volume:2
    - playsound <player.location> sound:item_bucket_fill pitch:1 volume:2
    - playsound <player.location> sound:item_bucket_fill pitch:0 volume:2
    - playeffect at:<player.eye_location> effect:redstone offset:0.5 quantity:16 special_data:2|<color[#FFC060]> visibility:100
    - define oopsie <player>
    - if !<[oopsie].has_flag[oiled]>:
      - flag <[oopsie]> oiled expire:120t
      - run oiledcoat def:<[oopsie]>
    - else:
      - flag <[oopsie]> oiled expire:120t
    on player right clicks block with:oilbucket:
    - if <player.has_flag[oilcooldown]>:
      - stop
    - itemcooldown diamond duration:70t
    - flag <player> oilcooldown expire:70t
    - playsound <player.location> sound:item_bucket_fill pitch:2 volume:2
    - playsound <player.location> sound:item_bucket_fill pitch:1 volume:2
    - playsound <player.location> sound:item_bucket_fill pitch:0 volume:2
    - repeat 8: 
      - shoot oilparticle origin:<player.eye_location.right[0.4].below[0.6]> speed:0.95 shooter:<player> spread:15
      - wait 1t
    after oilparticle spawns:
    - while <context.entity.is_spawned>:
      - playeffect at:<context.entity.location> effect:redstone offset:0.125 quantity:3 special_data:1.5|<color[#FFC060]> visibility:100
      - if <[loop_index]> > 15:
        - while stop
      - wait 1t
    - if <context.entity.is_spawned>:
      - remove <context.entity>
    on oilparticle hits entity:
    - define oopsie <context.hit_entity>
    - determine cancelled passively
    - if !<[oopsie].has_flag[oiled]>:
      - flag <[oopsie]> oiled expire:360t
      - run oiledcoat def:<[oopsie]>
    - else:
      - flag <[oopsie]> oiled expire:360t

oiledcoat:
  type: task
  debug: false
  definitions: coated
  script:
  - wait 2t
  - while <[coated].has_flag[oiled]>:
    - playeffect at:<[coated].location.add[0,1,0]> effect:falling_dust offset:0.25,0.4,0.25 quantity:3 special_data:horn_coral_block visibility:100
    - wait 5t
    - if <[coated].has_flag[mgk_wet]>:
      - adjust <[coated]> gravity:false
      - while <[coated].has_flag[mgk_wet]>:
        - adjust <[coated]> velocity:<[coated].velocity.add[0,0.005,0].add[<[coated].eye_location.direction.vector.mul[0.035]>]>
        - if <[loop_index]> > 360:
          - adjust <[coated]> gravity:true
          - stop
        - wait 1t
        - if <[loop_index]
      - adjust <[coated]> gravity:true
    - if <[loop_index]> > 72:
      - while stop