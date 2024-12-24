rocketjumper:
  type: item
  material: iron_horse_armor
  display name: <element[Series RCK7-J Explosive Testing Device].color_gradient[from=#FF8000;to=#FFFFFF]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374325
    hides: all
  lore:
  - <element[Kfwoosh, poof?].color_gradient[from=#804000;to=#808080]>
  - 
  - <element[VINTAGE].color[#404878].bold>

rocketgrabber:
  type: item
  material: iron_horse_armor
  display name: <element[Series RCK7-G Implosive Testing Device].color_gradient[from=#0080FF;to=#FFFFFF]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374326
    hides: all
  lore:
  - <element[?foop, hsoowfK].color_gradient[from=#004080;to=#808080]>
  - 
  - <element[VINTAGE].color[#404878].bold>

jrocket:
  type: entity
  entity_type: snowball
  mechanisms:
    item: rocketsprite
    gravity: false

grocket:
  type: entity
  entity_type: snowball
  mechanisms:
    item: rocketsprite
    gravity: false

rocketjumperstriggers:
  type: world
  events:
    on player right clicks block with:rocketjumper:
    - if <player.has_flag[riflecooldown]>:
      - stop
    - playsound <player.location> sound:entity_iron_golem_hurt pitch:0 volume:2
    - playsound <player.location> sound:entity_generic_extinguish_fire pitch:0 volume:2
    - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:0 volume:2
    - flag <player> riflecooldown expire:20t
    - itemcooldown iron_horse_armor duration:20t
    - shoot jrocket origin:<player.eye_location.forward[0.5]> speed:2 shooter:<player> spread:0
    on player right clicks block with:rocketgrabber:
    - if <player.has_flag[riflecooldown]>:
      - stop
    - playsound <player.location> sound:entity_iron_golem_hurt pitch:0 volume:2
    - playsound <player.location> sound:entity_generic_extinguish_fire pitch:0 volume:2
    - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:0 volume:2
    - flag <player> riflecooldown expire:20t
    - itemcooldown iron_horse_armor duration:20t
    - shoot grocket origin:<player.eye_location.forward[0.5]> speed:2 shooter:<player> spread:0
    on jrocket hits block:
    - playsound at:<context.projectile.location> sound:entity_wither_shoot volume:2 pitch:0
    - foreach <context.projectile.location.find_entities.within[5]>:
      - adjust <[value]> velocity:<[value].velocity.add[<[value].eye_location.sub[<context.projectile.location>].normalize.mul[1.5]>].add[0,0.25,0]>
      - cast <[value]> slow_falling amplifier:0 duration:10t no_icon hide_particles no_ambient
    - playeffect effect:large_explode quantity:5 at:<context.projectile.location> offset:2 visibility:100
    - repeat 30:
      - playeffect effect:cloud quantity:1 at:<context.projectile.location> offset:2.25 visibility:100 velocity:<location[0,0,0].random_offset[1]>
      - playeffect effect:smoke quantity:1 at:<context.projectile.location> offset:2.25 visibility:100 velocity:<location[0,0,0].random_offset[1]>
    on grocket hits block:
    - playsound at:<context.projectile.location> sound:entity_wither_shoot volume:2 pitch:0
    - foreach <context.projectile.location.find_entities.within[7]>:
      - adjust <[value]> velocity:<[value].velocity.add[<[value].eye_location.sub[<context.projectile.location>].normalize.mul[-2.5]>].add[0,0.25,0]>
      - cast <[value]> slow_falling amplifier:0 duration:10t no_icon hide_particles no_ambient
    - playeffect effect:large_explode quantity:5 at:<context.projectile.location> offset:2 visibility:100
    - repeat 30:
      - playeffect effect:cloud quantity:1 at:<context.projectile.location> offset:2.25 visibility:100 velocity:<location[0,0,0].random_offset[1]>
      - playeffect effect:smoke quantity:1 at:<context.projectile.location> offset:2.25 visibility:100 velocity:<location[0,0,0].random_offset[1]>
    on jrocket hits entity:
    - playsound at:<context.projectile.location> sound:entity_wither_shoot volume:2 pitch:0
    - foreach <context.projectile.location.find_entities.within[5]>:
      - adjust <[value]> velocity:<[value].velocity.add[<[value].eye_location.sub[<context.projectile.location>].normalize.mul[1.5]>].add[0,0.25,0]>
      - cast <[value]> slow_falling amplifier:0 duration:10t no_icon hide_particles no_ambient
    - playeffect effect:large_explode quantity:5 at:<context.projectile.location> offset:2 visibility:100
    - repeat 30:
      - playeffect effect:cloud quantity:1 at:<context.projectile.location> offset:2.25 visibility:100 velocity:<location[0,0,0].random_offset[1]>
      - playeffect effect:smoke quantity:1 at:<context.projectile.location> offset:2.25 visibility:100 velocity:<location[0,0,0].random_offset[1]>
    on grocket hits entity:
    - playsound at:<context.projectile.location> sound:entity_wither_shoot volume:2 pitch:0
    - foreach <context.projectile.location.find_entities.within[7]>:
      - adjust <[value]> velocity:<[value].velocity.add[<[value].eye_location.sub[<context.projectile.location>].normalize.mul[-2.5]>].add[0,0.25,0]>
      - cast <[value]> slow_falling amplifier:0 duration:10t no_icon hide_particles no_ambient
    - playeffect effect:large_explode quantity:5 at:<context.projectile.location> offset:2 visibility:100
    - repeat 30:
      - playeffect effect:cloud quantity:1 at:<context.projectile.location> offset:2.25 visibility:100 velocity:<location[0,0,0].random_offset[1]>
      - playeffect effect:smoke quantity:1 at:<context.projectile.location> offset:2.25 visibility:100 velocity:<location[0,0,0].random_offset[1]>
    on jrocket damages entity:
    - determine cancelled passively
    on grocket damages entity:
    - determine cancelled passively