gasoline:
  type: item
  material: rabbit_foot
  display name: <element[Gasoline].color_gradient[from=#C04040;to=#408020]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374293
  lore:
  - <element[I love the smell of napalm in the morning!].color_gradient[from=#602020;to=#204010]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

gasolinetriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:gasoline:
    - determine cancelled passively
    - if <player.has_flag[gascooldown]>:
      - stop
    - if <player.flag[gasolineused]||0> == 100:
      - title "title:<element[REFILLING!].color_gradient[from=#C04040;to=#408020]>" "subtitle:" fade_in:0 stay:200t targets:<player>
      - flag <player> gascooldown expire:10s
      - itemcooldown rabbit_foot duration:10s
      - flag <player> gasolineused:0
      - playsound at:<player.eye_location> sound:item_bucket_fill_lava pitch:0 volume:2
      - stop
    - flag <player> gasolineused:<player.flag[gasolineused].add[5].min[100]||0>
    - title "title:" "subtitle:<element[<player.flag[gasolineused].mul[-1].add[100]>%].color_gradient[from=#602020;to=#204010]>" fade_in:0 stay:5t targets:<player>
    - define clickloc <player.eye_location.ray_trace[range=2;return=precise;default=air;ignore=<player>;nonsolids=false]>
    - define aimtarg <[clickloc].with_pitch[90].ray_trace[range=25;return=precise;default=air;ignore=<player>;nonsolids=false]>
    - foreach <[clickloc].points_between[<[aimtarg]>].distance[0.35]>:
      - playeffect at:<[value]> effect:falling_dust offset:0.1 quantity:2 special_data:dried_kelp_block visibility:100
      - wait 1t
    - if !<[aimtarg].block.has_flag[gascoated]> && !<[aimtarg].block.has_flag[burningup]>:
      - run gascoat def:<[aimtarg].block>
    on player left clicks block with:gasoline:
    - determine cancelled passively
    - if <player.has_flag[gascooldown2]>:
      - stop
    - playsound <player.location> sound:block_fire_extinguish pitch:0 volume:1
    - flag <player> gascooldown2 expire:45t
    #- itemcooldown iron_horse_armor duration:2t
    - shoot matchstick origin:<player.eye_location.right[0.4].below[0.6]> speed:0.5 shooter:<player> spread:0 save:postalgas
    - define matchy <entry[postalgas].shot_entities.get[1]>
    - run matchsticktask def:<[matchy]>|<player>
    on player right clicks entity with:gasoline:
    - if <player.has_flag[gascooldown]>:
      - stop
    - if <player.flag[gasolineused]||0> == 100:
      - title "title:<element[REFILLING!].color_gradient[from=#C04040;to=#408020]>" "subtitle:" fade_in:0 stay:200t targets:<player>
      - flag <player> gascooldown expire:10s
      - itemcooldown rabbit_foot duration:10s
      - flag <player> gasolineused:0
      - playsound at:<player.eye_location> sound:item_bucket_fill_lava pitch:0 volume:2
      - stop
    - flag <player> gasolineused:<player.flag[gasolineused].add[5].min[100]||0>
    - title "title:" "subtitle:<element[<player.flag[gasolineused].mul[-1].add[100]>%].color_gradient[from=#602020;to=#204010]>" fade_in:0 stay:5t targets:<player>
    - if <context.entity.has_flag[gascoated]>:
      - stop
    - if <context.entity.fire_time> > 0:
      - burn <context.entity> duration:8s
      - stop
    - flag <context.entity> gascoated expire:12s
    - run gascoatentity def:<context.entity>
    on entity damaged:
    - if <context.entity.has_flag[gascoated]>:
      - flag <context.entity> gascoated:!
      - burn <context.entity> duration:8s
      - repeat 90:
        - playeffect at:<context.entity.eye_location.sub[0,0.5,0]> effect:flame offset:1,0.01,1 quantity:1 velocity:<location[0,0.2,0].random_offset[0.05,0.3,0.05]> visibility:100
      - playeffect at:<context.entity.eye_location.sub[0,0.5,0]> effect:lava offset:0.25,0,0.25 quantity:5 visibility:100

gascoat:
  type: task
  definitions: blockloc
  debug: false
  script:
  - if <[blockloc].has_flag[burningup]>:
    - stop
  - playsound at:<[blockloc].add[0.5,1,0.5]> sound:item_bucket_empty_lava pitch:0 volume:2
  - flag <[blockloc]> gascoated expire:12s
  - repeat 120:
    - playeffect at:<[blockloc].add[0.5,0,0.5]> effect:falling_dust offset:0.35,0,0.35 quantity:2 special_data:dried_kelp_block visibility:100
    - wait 2t
    - if <[blockloc].has_flag[burningup]>:
      - flag <[blockloc]> gascoated:!
      - repeat stop
    - if <[blockloc].sub[0,1,0].material.name> == air:
      - flag <[blockloc]> gascoated:!
      - repeat stop

gascoatentity:
  type: task
  definitions: coatedguy
  debug: false
  script:
  - playsound at:<[coatedguy].eye_location> sound:item_bucket_empty_lava pitch:1 volume:2
  - repeat 120:
    - playeffect at:<[coatedguy].eye_location> effect:falling_dust offset:0.35 quantity:1 special_data:dried_kelp_block visibility:100
    - wait 2t
    - if !<[coatedguy].has_flag[gascoated]>:
      - repeat stop

burnbabyburn2:
  type: task
  debug: false
  definitions: surfspot
  script:
  - wait 1t
  - playeffect at:<[surfspot].add[0.5,0,0.5]> effect:flame offset:1,0.01,1 quantity:1 velocity:<location[0,0.2,0].random_offset[0.05,0.3,0.05]> visibility:100
  - playeffect at:<[surfspot].add[0.5,0,0.5]> effect:lava offset:0.25,0,0.25 quantity:5 visibility:100
  - playsound at:<[surfspot].add[0.5,0,0.5]> sound:entity_blaze_shoot pitch:0 volume:2
  - playsound at:<[surfspot].add[0.5,0,0.5]> sound:block_fire_ambient pitch:<list[0|0.75|1].random> volume:1
  - foreach <[surfspot].find_blocks_flagged[gascoated].within[2]>:
    - flag <[value].block> gascoated:!
    - run burnbabyburn2 def:<[value].block>
  - repeat 55:
    - repeat 7:
      - playeffect at:<[surfspot].add[0.5,0,0.5]> effect:flame offset:1.65,0,1.65 quantity:1 velocity:<location[0,0.2,0].random_offset[0.1,0.1,0.1]> visibility:100
      - playeffect at:<[surfspot].add[0.5,0,0.5]> effect:flame offset:1.65,0,1.65 quantity:5 velocity:<location[0,0.015,0].random_offset[0.05,0,0.05]> visibility:100
    - playeffect at:<[surfspot].add[0.5,0,0.5]> effect:smoke offset:1.65,0.2,1.65 quantity:1 velocity:<location[0,0.5,0].random_offset[0.1,0.2,0.1]> visibility:100
    - playeffect at:<[surfspot].add[0.5,0,0.5]> effect:lava offset:1.65,0.2,1.65 quantity:1 velocity:<location[0,0.5,0].random_offset[0.1,0.2,0.1]> visibility:100
    - foreach <[surfspot].find_entities.within[1.5]||0>:
      - burn <[value]> duration:120t
      - hurt <[value]> amount:2 cause:FIRE
    - wait <list[1|2|3|4|5].random>t
    - if <[value].mod[10]> == 0:
      - playsound at:<[surfspot].add[0.5,1,0.5]> sound:block_fire_ambient pitch:<list[0|0.75|1].random> volume:1

burnbabyburn:
  type: task
  definitions: blockloc
  debug: false
  script:
  - flag <[blockloc]> burningup expire:8s
  - repeat 90:
    - playeffect at:<[blockloc].add[0.5,0,0.5]> effect:flame offset:1,0.01,1 quantity:1 velocity:<location[0,0.2,0].random_offset[0.05,0.3,0.05]> visibility:100
  - playeffect at:<[blockloc].add[0.5,0,0.5]> effect:lava offset:0.25,0,0.25 quantity:5 visibility:100
  - playsound at:<[blockloc].add[0.5,0,0.5]> sound:entity_blaze_shoot pitch:0 volume:2
  - playsound at:<[blockloc].add[0.5,0,0.5]> sound:block_fire_ambient pitch:<list[0|0.75|1].random> volume:1
  - repeat 54:
    - repeat 9:
      - playeffect at:<[blockloc].add[0.5,0,0.5]> effect:flame offset:1,0.01,1 quantity:1 velocity:<location[0,0.1,0].random_offset[0.025,0.15,0.025]> visibility:100
    - playeffect at:<[blockloc].add[0.5,0,0.5]> effect:lava offset:0.25,0,0.25 quantity:1 visibility:100
    - wait 3t
    - foreach <[blockloc].find_blocks_flagged[gascoated].within[2.5]>:
      - flag <[value].block> gascoated:!
      - run burnbabyburn def:<[value].block>
    - if <[blockloc].sub[0,1,0].material.name> == air:
      - flag <[blockloc]> burningup:!
      - repeat stop
    - if <[value].mod[10]> == 0:
      - playsound at:<[blockloc].add[0,1,0]> sound:block_fire_ambient pitch:<list[0|0.75|1].random> volume:1
    - foreach <[blockloc].find_entities.within[0.65]>:
      - hurt <[value]> 6 cause:fire
      - burn <[value]> duration:6s