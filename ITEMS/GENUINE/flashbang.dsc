flashbang:
  type: item
  material: clay_ball
  display name: <element[Flashbang].color_gradient[from=#205060;to=#404040]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374334
  lore:
  - <element[Think fast chucklenuts!].color_gradient[from=#102830;to=#202020]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

flashbangproj:
  type: entity
  entity_type: snowball
  mechanisms:
    item: flashbang

flashbangtriggers:
  type: world
  debug: false
  events:
#    on tick:
#    - foreach <server.online_players>:
#      - if <[value].has_flag[deafened]>:
#        - adjust <[value]> stop_sound 
    on player right clicks block with:flashbang:
    - determine cancelled passively
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:1
    - take item_in_hand quantity:1
    - shoot flashbangproj speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0
    on flashbangproj hits block:
    - playsound at:<context.projectile.location> sound:custom.classic_explode pitch:0 volume:2 custom
    - playsound at:<context.projectile.location> sound:block_anvil_place pitch:0 volume:2
    - playeffect at:<context.projectile.location> effect:flash offset:0 quantity:1 visibility:100
    - foreach <context.projectile.location.find.living_entities.within[5]>:
      - run sandstun def:<[value]>|50
    on flashbangproj collides with entity:
    - playsound at:<context.projectile.location> sound:custom.classic_explode pitch:0 volume:2 custom
    - playsound at:<context.projectile.location> sound:block_anvil_place pitch:0 volume:2
    - playeffect at:<context.projectile.location> effect:flash offset:0 quantity:1 visibility:100
    - foreach <context.projectile.location.find.living_entities.within[5]>:
      - run sandstun def:<[value]>|50

24kpotato:
  type: item
  material: clay_ball
  display name: <element[24k Potato].color_gradient[from=#FFC000;to=#FF8000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374333
  lore:
  - <element[I LOVE GOOOOOOOLD].color_gradient[from=#806000;to=#804000]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

24kpotatoproj:
  type: entity
  entity_type: snowball
  mechanisms:
    item: 24kpotato

potatoproj:
  type: entity
  entity_type: snowball
  mechanisms:
    item: 24kpotato

poisonpotatoproj:
  type: entity
  entity_type: snowball
  mechanisms:
    item: poisonous_potato

bakedpotatoproj:
  type: entity
  entity_type: snowball
  mechanisms:
    item: baked_potato

groundtato:
  type: entity
  entity_type: item_frame
  mechanisms:
    framed: 24kpotato
    visible: false
    fixed: true
    flag_map: <map[ikeaframe=<map[__value=true]>]>
    framed_item_rotation: <list[none|clockwise_45|clockwise|clockwise_135|flipped|flipped_45|counter_clockwise].random>

24kpotatotriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:24kpotato:
    - determine cancelled passively
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:1
    - take item_in_hand quantity:1
    - shoot 24kpotatoproj speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0
    on 24kpotatoproj hits block:
    - if <context.location.find_entities[groundtato].get[1]||0> != 0:
      - drop 24kpotato <context.projectile.location> quantity:1 speed:1
      - playsound at:<context.projectile.location> sound:block_note_block_bass pitch:0 volume:2
    - else:
      - spawn at:<context.location.add[<context.hit_face>]> groundtato
      - playsound at:<context.projectile.location> sound:custom.gib pitch:2 volume:2 custom
    on 24kpotatoproj hits entity:
    - drop 24kpotato <context.projectile.location> quantity:1 speed:1
    - playsound at:<context.projectile.location> sound:block_note_block_bass pitch:0 volume:2
    after groundtato spawns:
    - wait 15t
    - playsound at:<context.entity.location> sound:block_note_block_bell pitch:2 volume:2
    - playeffect at:<context.entity.location> effect:flash offset:0 quantity:1 visibility:100
    - while <context.entity.location.find_entities.within[0.5].exclude[<context.entity>].get[1]||0> == 0:
      - if <[loop_index].mod[20]> == 10:
        - playsound at:<context.entity.location> sound:block_note_block_snare pitch:1 volume:2
      - if <[loop_index].mod[20]> == 0:
        - playsound at:<context.entity.location> sound:block_note_block_snare pitch:2 volume:2
      - if <[loop_index]> == 299:
        - while stop
      - wait 1t
    - repeat 4:
      - playsound at:<context.entity.location> sound:block_note_block_bell pitch:1 volume:2
      - wait 2t
    - playsound at:<context.entity.location> sound:custom.classic_explode pitch:1 volume:2 custom
    - playsound at:<context.entity.location> sound:custom.gib pitch:0 volume:2 custom
    - explode at:<context.entity.location> power:3
    - remove <context.entity>