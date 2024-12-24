moonshoes:
  type: item
  material: iron_boots
  display name: <element[Moon Shoes].color_gradient[from=#C0C0C0;to=#FFFFFF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374200
  lore:
  - <element[Boing!].color_gradient[from=#606060;to=#808080]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>


moonshoestriggers:
  type: world
  debug: false
  events:
    on player jumps:
    - if <player.has_equipped[moonshoes]||0>:
      - playsound <player.location> sound:entity_fishing_bobber_retrieve pitch:0 volume:2
      - playeffect effect:cloud quantity:60 at:<player.location.add[0,0.2,0]> offset:0.8,0,0.8
      - adjust <player> gravity:false
      - wait 90t
      - cast <player> slow_falling duration:1t amplifier:1 no_ambient hide_particles no_icon
      - adjust <player> gravity:true 
      - while !<player.is_on_ground>:
        - if !<player.is_sneaking>:
          - cast <player> slow_falling duration:4t amplifier:1 no_ambient hide_particles no_icon
        - else:
          - cast <player> slow_falling remove
        - wait 3t
    on player damaged by FALL:
    - if <player.has_equipped[moonshoes]||0>:
      - determine cancelled passively
    on player starts sneaking:
    - if <player.has_equipped[moonshoes]||0>:
      - adjust <player> gravity:true