spoon:
  type: item
  material: stick
  display name: <element[Spoon].color_gradient[from=#808080;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374306
  lore:
  - <element[THE SPOON...].color_gradient[from=#404040;to=#606060]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

fork:
  type: item
  material: stick
  display name: <element[Fork].color_gradient[from=#808080;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374307
  lore:
  - <element[Fork you!].color_gradient[from=#404040;to=#606060]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

knife:
  type: item
  material: stick
  display name: <element[Knife].color_gradient[from=#808080;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374308
  lore:
  - <element[My name is Scout! Rainbows make me cry!!!].color_gradient[from=#404040;to=#606060]>
  - <element[HONHONHONHONHONHONHON].color_gradient[from=#404040;to=#606060]>
  -
  - <element[COLLECTOR'S].color[#800000].bold>

cutlerytriggers:
  type: world
  debug: false
  events:
    on player damages entity with:fork:
    - heal <context.damager> amount:1 
    - playsound sound:entity_generic_eat at:<context.damager.eye_location> volume:2 pitch:1
    on player damages entity with:knife:
    - if <context.entity.location.yaw> < <context.damager.location.yaw.add[20]> && <context.entity.location.yaw> > <context.damager.location.yaw.sub[20]>:
      - title title:<element[BACKSTAB!].bold.color_gradient[from=#C04040;to=#404040]> fade_in:0t stay:0t fade_out:5t targets:<context.damager>
      - playeffect effect:block_crack quantity:16 special_data:redstone_wire at:<context.entity.eye_location> offset:0.25
      - playeffect effect:redstone quantity:16 special_data:1.2|red at:<context.entity.eye_location> offset:0.25
      - playsound at:<context.entity.eye_location> sound:block_slime_block_break pitch:0 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_salmon_flop pitch:0 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_arrow_hit_player pitch:0 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_arrow_hit_player pitch:1 volume:2
      - playsound at:<context.entity.eye_location> sound:entity_arrow_hit_player pitch:2 volume:2
      - determine <context.damage.mul[16]> CLEAR_MODIFIERS
    on player damages entity with:spoon:
    - repeat 40 as:repval:
       - foreach <context.entity.eye_location.find.living_entities.within[8].exclude[<context.damager>].exclude[<context.entity>]||0>:
         - look <[value]> <[value].location.sub[<context.entity.location>].add[<[value].location>]>
         - adjust <[value]> velocity:<[value].velocity.add[<[value].location.sub[<context.entity.location>].normalize.mul[0.25]>]>
         - wait 1t
    on item_frame damaged:
    - if <context.entity.has_flag[ikeaframe]>:
      - determine cancelled passively
    on projectile hits item_frame:
    - if <context.entity.has_flag[ikeaframe]>:
      - determine cancelled passively
    on item_frame breaks:
    - if <context.hanging.has_flag[ikeaframe]>:
      - determine cancelled passively