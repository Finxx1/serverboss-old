redrifle:
  type: item
  material: golden_horse_armor
  display name: <element[Redstone Rifle].color[#C00000]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374312
    hides: all
  lore:
  - <element[ZRatatatata!!].color[#600000]>
  - 
  - <element[VINTAGE].color[#404878].bold>

redstonebolt:
  type: item
  material: clay_ball
  display name: <element[Redstone Bolt].color[#FF0000]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374311
    hides: all
  lore:
  - <element[you shouldnt have this!!].color[#800000]>
#  - 
#  - <element[VINTAGE].color[#404878].bold>

redstoneball:
  type: item
  material: clay_ball
  display name: <element[Redstone Ball].color[#FF0000]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374366
    hides: all
  lore:
  - <element[you shouldnt have this!!].color[#800000]>

redbullet:
  type: entity
  entity_type: snowball
  mechanisms:
    gravity: false
    item: redstonebolt

energyball:
  type: entity
  entity_type: snowball
  mechanisms:
    gravity: false
    item: redstoneball

redrifletriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:redrifle:
    - if !<player.has_flag[riflecooldown]>:
      - flag <player> riflecooldown expire:9t
      - itemcooldown golden_horse_armor duration:9t
      - repeat 6:
        - playsound <player.location> sound:entity_iron_golem_hurt pitch:2 volume:1
        - playsound <player.location> sound:item_trident_return pitch:2 volume:1
#        - playsound <player.location> sound:custom.lightning_charge pitch:2 volume:0.5 custom
        - playsound <player.location> sound:block_piston_extend pitch:2 volume:1
        - playsound <player.location> sound:BLOCK_RESPAWN_ANCHOR_DEPLETE pitch:2 volume:1
        - playsound <player.location> sound:BLOCK_RESPAWN_ANCHOR_CHARGE pitch:2 volume:1
        - shoot redbullet origin:<player.eye_location.right[0.4].below[0.4]> speed:3 shooter:<player> spread:1
        - wait 2t
    on player left clicks block with:redrifle:
    - if !<player.has_flag[riflecooldown]>:
      - flag <player> riflecooldown expire:250t
      - itemcooldown golden_horse_armor duration:250t
      - playsound <player.eye_location> sound:custom.eball_charge pitch:1 volume:1 custom
      - wait 21t
      - playsound <player.eye_location> sound:entity_iron_golem_hurt pitch:1 volume:1
      - playsound <player.eye_location> sound:custom.eball_bust pitch:2 volume:1 custom
      - playsound <player.eye_location> sound:item_trident_return pitch:1 volume:1
      - playsound <player.eye_location> sound:custom.lightning_charge pitch:1 volume:0.5 custom
      - playsound <player.eye_location> sound:block_piston_extend pitch:1 volume:1
      - playsound <player.eye_location> sound:BLOCK_RESPAWN_ANCHOR_DEPLETE pitch:1 volume:1
      - playsound <player.eye_location> sound:BLOCK_RESPAWN_ANCHOR_CHARGE pitch:1 volume:1
      - playsound <player.eye_location> sound:BLOCK_RESPAWN_ANCHOR_CHARGE pitch:1 volume:1
      - shoot energyball origin:<player.eye_location> speed:1.5 shooter:<player> spread:0
    on energyball spawns:
    - wait 1t
    - while <context.entity.is_spawned>:
      - if <[loop_index].mod[2]> == 0:
        - playsound <context.entity.location> sound:block_beacon_ambient pitch:2 volume:0.5
      - if <[loop_index]> > 100 || <context.entity.flag[grenadetimer]> < 0:
        - playsound <context.entity.location> sound:custom.eball_bust pitch:1 volume:2 custom
        - explode <context.location> power:1
        - repeat 16:
          - playeffect effect:lava at:<context.entity.location> offset:0 quantity:4 visibility:100 
        - playeffect effect:explode_large at:<context.entity.location> offset:0 quantity:1 visibility:100 
        - remove <context.entity>
      - flag <context.entity> grenadetimer:<context.entity.flag[grenadetimer].sub[1]||100>
      - adjust <context.entity> velocity:<context.entity.velocity.mul[1.01]>
      - wait 2t
    on energyball hits block:
    - define timerleft <context.projectile.flag[grenadetimer]||100>
    - define projvel <context.projectile.velocity>
    - define projbnc <context.projectile.flag[bounces]>
    - define shootercont <context.shooter>
    - define hitface <context.hit_face>
    - define pvel2 <location[<[projvel].x.mul[<[hitface].x.abs.mul[-2].add[1]>]>,<[projvel].y.mul[<[hitface].y.abs.mul[-2].add[1]>]>,<[projvel].z.mul[<[hitface].z.abs.mul[-2].add[1]>]>].mul[1.05]>
    - define bounceloc <context.location.add[0.5,0.5,0.5].add[<[hitface].mul[0.75]>]>
    - playsound <context.location> sound:entity_anvil_place pitch:1 volume:1
    - playsound <context.location> sound:entity_blaze_hurt pitch:1 volume:1
    - playsound <context.location> sound:entity_zombie_attack_iron_door pitch:1 volume:1
    - playeffect at:<[bounceloc]> effect:flash offset:0 visibility:100
    - playeffect at:<[bounceloc]> effect:lava offset:0 quantity:4 visibility:100
    - spawn energyball[velocity=<[pvel2]>;shooter=<[shootercont]>] <[bounceloc]> save:rrenadeBnc
    - define grnd <entry[rrenadeBnc].spawned_entity>
    - flag <[grnd]> grenadetimer:<[timerleft]>
    on energyball hits entity:
    - playsound <context.hit_entity.location> sound:custom.eball_annihilate pitch:1 volume:2 custom
    - adjust <context.hit_entity> velocity:<context.hit_entity.velocity.add[<context.projectile.velocity.mul[2]>].add[0,0.5,0]>
    - hurt <context.hit_entity> amount:20
    - determine cancelled passively