pipispopper:
  type: item
  material: golden_horse_armor
  display name: <element[Pipis].color_gradient[from=#FFFF00;to=#00C0FF]><element[ ]><element[Popper].color_gradient[from=#00C0FF;to=#FF80A0]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374314
    hides: all
  lore:
  - <element[NOW'S YOUR CHANCE TO].unescaped.color_gradient[from=#808000;to=#006080]><element[ ]><element[BE A &lb&lbBIG SHOT!!!&rb&rb].unescaped.color_gradient[from=#006080;to=#804050]>
  - 
  - <element[VINTAGE].color[#404878].bold>

blast:
  type: item
  material: clay_ball
  display name: <element[blast].color[#FFFFFF]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374325
    hides: all
  lore:
  - <element[no].unescaped.color[#006080]>


pipis:
  type: item
  material: clay_ball
  display name: <element[Pipis].color[#00C0FF]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374323
    hides: all
  lore:
  - <element[(pipis)].unescaped.color[#006080]>
  - 
  - <element[GENUINE].color[#206030].bold>

pipisproj:
  type: entity
  entity_type: snowball
  mechanisms:
    item: pipis

energyblast:
  type: entity
  entity_type: snowball
  mechanisms:
    item: blast
    gravity: false

pipispoppertriggers:
  type: world
  events:
    on player right clicks block with:pipis:
    - playsound <player.eye_location> sound:entity_snowball_throw pitch:1 volume:2
    - shoot pipisproj origin:<player.eye_location.right[0.4]> shooter:<player> spread:0 speed:1
    - take iteminhand quantity:1 from:<player.inventory>
    on player right clicks block with:pipispopper:
    - ratelimit <player> 1t
    - if <player.has_flag[poppercooldown]>:
      - stop
    - playsound <player.eye_location> sound:entity_iron_golem_hurt pitch:2 volume:2
    - playsound <player.eye_location> sound:entity_skeleton_hurt pitch:0 volume:2
    - playsound <player.eye_location> sound:entity_snowball_throw pitch:1 volume:2
    - playsound <player.eye_location> sound:block_piston_extend pitch:1 volume:2
    - playsound <player.eye_location> sound:entity_blaze_shoot pitch:1 volume:2
    - playsound <player.eye_location> sound:block_beacon_power_select pitch:2 volume:2
    - playeffect at:<player.eye_location.forward[1]> effect:flash quantity:1 offset:0 visibility:100
    - flag <player> poppercooldown expire:20t
    - itemcooldown golden_horse_armor duration:20t
    - shoot pipisproj origin:<player.eye_location.right[0.4].below[0.4]> height:1 shooter:<player> spread:0 gravity:0.03
    on player left clicks block with:pipispopper:
    - if <player.has_flag[poppercooldown]>:
      - stop
    - flag <player> poppercooldown
    - repeat 60:
      - playsound at:<player.eye_location> sound:block_beacon_ambient volume:2 pitch:<[value].mul[0.025].add[0.5]>
      - cast <player> slow duration:2t amplifier:3 no_icon hide_particles no_ambient
      - itemcooldown golden_horse_armor duration:9999t
      - wait 1t
    - shoot energyblast origin:<player.eye_location.right[0.4].below[0.4]> shooter:<player> spread:0 speed:0.5
    - flag <player> poppercooldown expire:100t
    - itemcooldown golden_horse_armor duration:100t
    - playsound <player.eye_location> sound:entity_iron_golem_hurt pitch:2 volume:2
    - playsound <player.eye_location> sound:entity_skeleton_hurt pitch:0 volume:2
    - playsound <player.eye_location> sound:entity_snowball_throw pitch:1 volume:2
    - playsound <player.eye_location> sound:block_piston_extend pitch:1 volume:2
    - playsound <player.eye_location> sound:entity_blaze_shoot pitch:1 volume:2
    - wait 1t
    - playsound <player.eye_location> sound:entity_lightning_bolt_thunder pitch:1 volume:2
    - playsound <player.eye_location> sound:custom.lightning_charge pitch:1 volume:2 custom
    - playsound <player.eye_location> sound:custom.lightning_discharge pitch:1 volume:2 custom
    - playsound <player.eye_location> sound:custom.psychicfire pitch:2 volume:2 custom
    - playsound <player.eye_location> sound:custom.psychichit pitch:0 volume:2 custom
    - playsound <player.eye_location> sound:block_beacon_power_select pitch:2 volume:2
    - wait 1t
    - playsound <player.eye_location> sound:entity_lightning_bolt_impact pitch:1 volume:2
    - playsound <player.eye_location> sound:entity_lightning_bolt_impact pitch:2 volume:2
    - playsound <player.eye_location> sound:entity_lightning_bolt_impact pitch:0 volume:2
    on energyblast hits entity:
    - determine cancelled passively
    after energyblast spawns:
    - while <context.entity.is_spawned>:
      - adjust <context.entity> velocity:<context.entity.velocity.mul[1.015]>
      - wait 1t
      - if <[loop_index].mod[10]> == 0:
        - playeffect at:<context.entity.location> quantity:1 offset:0 visibility:100 effect:flash
        - playsound <context.entity.location> sound:block_beacon_activate pitch:2 volume:2
        - playsound <context.entity.location> sound:block_beacon_deactivate pitch:2 volume:2
      - if <[loop_index]> > 100:
        - while stop
      - foreach <context.entity.location.find.living_entities.within[3].exclude[<context.entity.shooter>]>:
        - hurt <[value]> amount:5
        - explode <[value].eye_location> power:1
        - adjust <[value]> velocity:<[value].location.sub[<context.entity.location>].with_y[0.5]>
    - if <context.entity.is_spawned>:
      - explode <context.entity.location> power:5
      - remove <context.entity>
    on energyblast hits block:
    - explode <context.projectile.location> power:5
    - playsound <context.projectile.location> sound:entity_lightning_bolt_thunder pitch:1 volume:2
    - playsound <context.projectile.location> sound:entity_lightning_bolt_thunder pitch:2 volume:2
    - playsound <context.projectile.location> sound:entity_lightning_bolt_thunder pitch:0 volume:2
    - playsound <context.projectile.location> sound:entity_lightning_bolt_impact pitch:1 volume:2
    - playsound <context.projectile.location> sound:entity_lightning_bolt_impact pitch:2 volume:2
    - playsound <context.projectile.location> sound:entity_lightning_bolt_impact pitch:0 volume:2
    on pipisproj hits block:
    - explode <context.projectile.location> power:1
    - playsound <context.projectile.location> sound:block_glass_break pitch:1 volume:2
    - playsound <context.projectile.location> sound:block_glass_break pitch:0 volume:2
    - playsound <context.projectile.location> sound:entity_generic_splash pitch:1.5 volume:2
    - playsound <context.projectile.location> sound:entity_generic_splash pitch:0.75 volume:2
    - playsound <context.projectile.location> sound:custom.gib pitch:1 volume:2 custom
    - repeat 48:
      - playeffect at:<context.projectile.location> effect:item_crack special_data:pipis visibility:100 velocity:<location[0,0.5,0].random_offset[0.6]> quantity:2 offset:0.5
    - repeat 16:
      - playeffect at:<context.projectile.location> effect:item_crack special_data:gold_block visibility:100 velocity:<location[0,0.125,0].random_offset[0.05]> quantity:1 offset:0.5
      - playeffect at:<context.projectile.location> effect:item_crack special_data:quartz_block visibility:100 velocity:<location[0,0.25,0].random_offset[0.3]> quantity:2 offset:0.5
    on pipisproj hits entity:
    - hurt <context.hit_entity> amount:10
    - run dolarspawn def:<context.hit_entity.health_max.mul[0.2].min[25]>|0.25|<context.hit_entity.location>
    - explode <context.projectile.location> power:1
    - playsound <context.projectile.location> sound:block_glass_break pitch:1 volume:2
    - playsound <context.projectile.location> sound:block_glass_break pitch:0 volume:2
    - playsound <context.projectile.location> sound:entity_generic_splash pitch:1.5 volume:2
    - playsound <context.projectile.location> sound:entity_generic_splash pitch:0.75 volume:2
    - playsound <context.projectile.location> sound:custom.gib pitch:1 volume:2 custom
    - repeat 48:
      - playeffect at:<context.projectile.location> effect:item_crack special_data:pipis visibility:100 velocity:<location[0,0,0].random_offset[0.6]> quantity:2 offset:0.5
    - repeat 16:
      - playeffect at:<context.projectile.location> effect:item_crack special_data:gold_block visibility:100 velocity:<location[0,0,0].random_offset[0.05]> quantity:1 offset:0.5
      - playeffect at:<context.projectile.location> effect:item_crack special_data:quartz_block visibility:100 velocity:<location[0,0,0].random_offset[0.3]> quantity:2 offset:0.5
    on pipisproj damages entity:
    - determine cancelled passively