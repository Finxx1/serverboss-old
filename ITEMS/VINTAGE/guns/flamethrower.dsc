flamethrower:
  type: item
  material: iron_horse_armor
  display name: <element[Flamethrower].color[#C08040]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374315
  lore:
  - <element[FWOOOSHHHHHHHHHHHHHHH].color[#604020]>
  - <element[PFWWWWFFFFFFFFFFFFFPT].color[#604020]>
  -
  - <element[VINTAGE].color[#404878].bold>



flamethrowertriggers:
  type: world
  events:
    on player right clicks block with:flamethrower:
    - if !<player.has_flag[riflecooldown]>:
      - playsound <player.location> sound:entity_generic_burn pitch:0 volume:1
      #- playsound <player.location> sound:block_fire_ambient pitch:0 volume:1
      - playsound <player.location> sound:entity_blaze_shoot pitch:0 volume:1
      - flag <player> riflecooldown expire:30t
      - itemcooldown iron_horse_armor duration:30t
      - shoot fireparticle origin:<player.eye_location.right[0.4].below[0.6]> speed:3 shooter:<player> spread:0 save:ballsack
      - define fireblast <entry[ballsack].shot_entities.get[1]>
      - run fireprojhandlertask def:<[fireblast]>|<player>
    on player left clicks block with:flamethrower:
    - if !<player.has_flag[riflecooldown]>:
      - define lookvec <player.eye_location.direction.vector.mul[1]>
      - define blastpoint <player.eye_location.add[<[lookvec].mul[2]>]>
      - define airblasted <[blastpoint].find_entities.within[3].exclude[<player>]>
      #- playsound <player.location> sound:entity_blaze_death pitch:0 volume:1
      - playsound <player.location> sound:entity_blaze_shoot pitch:0 volume:1
      - adjust <[airblasted]> gravity:false
      - adjust <[airblasted]> velocity:<[lookvec].mul[2]>
      - adjust <player> critical:true
      - foreach <[airblasted]>:
        - if <[value]||0> == <entity[arrow]> || <[value]||0> == <entity[trident]>:
          - adjust <[value]> critical:true
          - adjust <[value]> damage:<[value].damage.mul[3]>
          - adjust <[value]> shooter:<player>
      - playeffect effect:cloud quantity:10 at:<[blastpoint]> offset:2 velocity:<[lookvec].div[5]>
      - playeffect effect:flash quantity:1 at:<[blastpoint]> offset:0 velocity:<[lookvec].div[5]>
      - flag <player> riflecooldown expire:30t
      - itemcooldown iron_horse_armor duration:30t
      - adjust <[airblasted]> gravity:true

flammenwerfer:
  type: item
  material: iron_horse_armor
  display name: <element[Flammenwerfer].color[#4080C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374321
  lore:
  - <element[FWhrrrrrrrrrrrrffghhhhhhhhhhhhhrrrrfrrrrrhrhrrrrrr].color[#204060]>
  - <element[GlplShgsh!].color[#204060]>
  -
  - <element[VINTAGE].color[#404878].bold>

fireparticlesmall:
  type: entity
  entity_type: snowball
  mechanisms:
    item: napalmballsprite

gassprite:
  type: item
  material: clay_ball
  display name: <element[gas]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374331
  

gasparticle:
  type: entity
  entity_type: snowball
  mechanisms:
    item: gassprite

flammenwerfertriggers:
  type: world
  events:
    on player right clicks block with:flammenwerfer:
    - if <player.flag[gasolineused]> >= 100:
      - stop
    - if <player.has_flag[riflecooldown]>:
      - stop
    - if <player.has_flag[flaming]>:
      - flag <player> flaming expire:5t
      - stop
    - flag <player> flaming expire:5t
    - playsound <player.location> sound:entity_generic_extinguish_fire pitch:0 volume:2
    - while <player.has_flag[flaming]>:
      - shoot fireparticlesmall origin:<player.eye_location.right[0.4].below[0.6]> speed:1.5 shooter:<player> spread:5
      - if <[loop_index].mod[2]> == 0:
        - flag <player> gasolineused:<player.flag[gasolineused].add[1]||1>
      - if <[loop_index].mod[7]> == 0:
        - playsound <player.location> sound:block_fire_ambient pitch:0 volume:2
      - if <[loop_index].mod[5]> == 0:
        - playsound <player.location> sound:block_lava_extinguish pitch:0 volume:2
      - if <player.flag[gasolineused]> >= 100:
        - title "title:<element[REFILLING!].color_gradient[from=#80C040;to=#4080C0]>" "subtitle:" fade_in:0 stay:200t targets:<player>
        - itemcooldown iron_horse_armor duration:40t
        - flag <player> riflecooldown expire:40t
        - wait 10s
        - flag <player> gasolineused:0
        - playsound at:<player.eye_location> sound:item_bucket_fill_lava pitch:0 volume:2
        - stop
      - wait 1t
    - itemcooldown iron_horse_armor duration:40t
    - flag <player> riflecooldown expire:40t
    on player left clicks block with:flammenwerfer:
    - if <player.flag[gasolineused]> >= 100:
      - stop
    - if <player.has_flag[riflecooldown]>:
      - stop
    - itemcooldown iron_horse_armor duration:40t
    - flag <player> riflecooldown expire:40t
    - playsound <player.location> sound:item_bucket_fill_lava pitch:2 volume:2
    - playsound <player.location> sound:item_bucket_fill_lava pitch:1 volume:2
    - playsound <player.location> sound:item_bucket_fill_lava pitch:0 volume:2
    - repeat 6: 
      - shoot gasparticle origin:<player.eye_location.right[0.4].below[0.6]> speed:0.85 shooter:<player> spread:10
      - shoot gasparticle origin:<player.eye_location.right[0.4].below[0.6]> speed:0.85 shooter:<player> spread:10
      - wait 1t
    - flag <player> gasolineused:<player.flag[gasolineused].add[25]||1>
    - if <player.flag[gasolineused]> >= 100:
      - title "title:<element[REFILLING!].color_gradient[from=#80C040;to=#4080C0]>" "subtitle:" fade_in:0 stay:200t targets:<player>
      - itemcooldown iron_horse_armor duration:40t
      - flag <player> riflecooldown expire:40t
      - wait 10s
      - flag <player> gasolineused:0
    after fireparticlesmall spawns:
    - while <context.entity.is_spawned>:
      - playeffect effect:flame quantity:8 offset:0.125 at:<context.entity.location> visibility:100
      - if <[loop_index]> > 7:
        - while stop
      - wait 1t
    - if <context.entity.is_spawned>:
      - remove <context.entity>
    on fireparticlesmall hits entity:
    - burn <context.hit_entity> duration:80t
    after gasparticle spawns:
    - while <context.entity.is_spawned>:
      - playeffect at:<context.entity.location> effect:falling_dust offset:0.125 quantity:3 special_data:dried_kelp_block visibility:100
      - if <[loop_index]> > 15:
        - while stop
      - wait 1t
    - if <context.entity.is_spawned>:
      - remove <context.entity>
    on gasparticle damages entity:
    - determine cancelled passively
    on gasparticle hits entity:
    - determine cancelled passively
    - if <context.hit_entity.has_flag[gascoated]>:
      - stop
    - if <context.hit_entity.fire_time> > 0:
      - burn <context.hit_entity> duration:8s
      - stop
    - flag <context.hit_entity> gascoated expire:12s
    - run gascoatentity def:<context.hit_entity>
    - remove <context.projectile>
    on gasparticle hits block:
    - if <context.hit_face> == <location[0,1,0]>:
      - if !<context.location.add[<context.hit_face>].block.has_flag[gascoated]> && !<context.location.add[<context.hit_face>].block.has_flag[burningup]>:
        - run gascoat def:<context.location.add[<context.hit_face>].block>
    on fireparticlesmall hits block:
    - if <context.location.add[0,1,0].block.has_flag[gascoated]>:
      - flag <context.location.add[0,1,0].block> gascoated:!
      - flag <context.location.add[0,1,0].block> burningup:!
      - run burnbabyburn2 def:<context.location.add[0,1,0].block>