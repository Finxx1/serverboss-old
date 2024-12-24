toaster:
  type: item
  material: diamond
  display name: <element[Toaster].color_gradient[from=#707070;to=#505050]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375245
  lore:
  - <element[Literal bath bomb].color_gradient[from=#383838;to=#282828]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

toasteralt:
  type: item
  material: diamond
  display name: <element[Toaster].color_gradient[from=#707070;to=#505050]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375247
  lore:
  - <element[Literal bath bomb].color_gradient[from=#383838;to=#282828]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

toast:
  type: item
  material: bread
  display name: <element[Toast].color_gradient[from=#E0A090;to=#202020]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374200
  lore:
  - <element[All toasters toast toast!].color_gradient[from=#705048;to=#101010]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

toasterproj:
  type: entity
  entity_type: snowball
  mechanisms:
    item: toaster

toastproj:
  type: entity
  entity_type: snowball
  mechanisms:
    item: toast

groundtoaster:
  type: entity
  entity_type: item_frame
  mechanisms:
    framed: toasteralt
    visible: false
    fixed: true
    flag_map: <map[ikeaframe=<map[__value=true]>]>
    framed_item_rotation: <list[none|clockwise_45|clockwise|clockwise_135|flipped|flipped_45|counter_clockwise].random>

toastertriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:toaster:
    - determine cancelled passively
    - playsound at:<player.eye_location> sound:entity_creeper_primed volume:2 pitch:1
    - take item_in_hand quantity:1
    - shoot toasterproj speed:1 spread:0 origin:<player.eye_location.below[0.2].right[0.3].forward[0.5]>
    - playsound at:<player.eye_location> sound:entity_snowball_throw volume:2 pitch:0
    on toasterproj hits block:
    - if <context.location.find_entities[groundtoaster].get[1]||0> != 0:
      - drop toaster <context.projectile.location> quantity:1 speed:1
      - playsound at:<context.projectile.location> sound:block_note_block_bass pitch:0 volume:2
    - else:
      - spawn at:<context.location.add[<context.hit_face>]> groundtoaster
      - playsound at:<context.projectile.location> sound:entity_zombie_attack_iron_door pitch:1 volume:2
    on toasterproj hits entity:
    - drop toaster <context.projectile.location> quantity:1 speed:1
    - playsound at:<context.projectile.location> sound:block_note_block_bass pitch:0 volume:2
    - playsound at:<context.projectile.location> sound:entity_zombie_attack_iron_door pitch:1 volume:2
    - hurt <context.hit_entity> amount:6
    on toastproj hits entity:
    - drop toast <context.projectile.location> quantity:1 speed:1
    - playsound at:<context.projectile.location> sound:entity_generic_burn pitch:0 volume:2
    - playsound at:<context.projectile.location> sound:entity_generic_hurt pitch:1 volume:2
    - burn <context.hit_entity> duration:80t
    on toastproj hits block:
    - drop toast <context.projectile.location> quantity:1 speed:1
    after groundtoaster spawns:
    - if <context.entity.location.block.material.name> == water:
      - run mgk_chainlightning def:<context.entity>|<context.entity.location.find_entities.within[5].exclude[<context.entity>].get[1]||0>|<element[15]>
      - explode at:<context.entity.location> power:1
      - remove <context.entity>
      - stop
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
    - playsound at:<context.entity.location> sound:block_note_block_bell pitch:1 volume:2
    - playsound at:<context.entity.location> sound:block_note_block_bell pitch:2 volume:2
    - playsound at:<context.entity.location> sound:block_note_block_bell pitch:0 volume:2
    - wait 20t
    - playsound at:<context.entity.location> sound:custom.classic_explode pitch:0 volume:1 custom
    - repeat 40:
      - playsound at:<context.entity.location> sound:custom.classic_bow_shoot pitch:2 volume:2 custom
      - shoot toastproj speed:0.6 spread:0 origin:<context.entity.location> destination:<context.entity.location.forward[4].random_offset[0.5,0.5,0.5]>
      - wait 4t
    - explode at:<context.entity.location> power:2
    - remove <context.entity>