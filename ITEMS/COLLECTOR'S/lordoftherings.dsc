thebible3:
  type: item
  material: book
  display name: <element[The Lord of The Rings].color_gradient[from=#008080;to=#503010]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374261
  lore:
  - <element[The third saint's book].color_gradient[from=#004040;to=#281808]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

thebible3triggers:
  type: world
  debug: false
  events:
    on player right clicks block with:thebible3:
    - determine cancelled passively
    - if <player.has_flag[knightmode]>:
      - stop
    - flag <player> knightmode
    - take <player.inventory> iteminhand quantity:1
    - give <player.inventory> netherite_sword slot:HAND
    - drop <player.inventory.slot[37]> <player.eye_location> quantity:1 speed:0.1 delay:3s
    - drop <player.inventory.slot[38]> <player.eye_location> quantity:1 speed:0.1 delay:3s
    - drop <player.inventory.slot[39]> <player.eye_location> quantity:1 speed:0.1 delay:3s
    - drop <player.inventory.slot[40]> <player.eye_location> quantity:1 speed:0.1 delay:3s
    - take <player.inventory> slot:BOOTS quantity:1
    - take <player.inventory> slot:LEGGINGS quantity:1
    - take <player.inventory> slot:HELMET quantity:1
    - take <player.inventory> slot:CHESTPLATE quantity:1
    - equip <player> helmet:netherite_helmet
    - equip <player> chestplate:netherite_chestplate
    - equip <player> leggings:netherite_leggings
    - equip <player> boots:netherite_boots
    - wait 8s
    - flag <player> knightmode:!
    - take <player.inventory> slot:BOOTS quantity:1
    - take <player.inventory> slot:LEGGINGS quantity:1
    - take <player.inventory> slot:HELMET quantity:1
    - take <player.inventory> slot:CHESTPLATE quantity:1
    - take <player.inventory> iteminhand quantity:1
    - give <player.inventory> thebible3 slot:HAND
    on player walks:
    - if <player.has_flag[knightmode]>:
      - cast <player> slow duration:2t amplifier:1 no_icon hide_particles no_ambient
      - cast <player> resistance duration:2t amplifier:2 no_icon hide_particles no_ambient
      - cast <player> strength duration:2t amplifier:1 no_icon hide_particles no_ambient
      - if <player.is_on_ground>:
        - if <util.random_chance[20]>:
          - playsound at:<player.location> sound:entity_iron_golem_hurt pitch:<list[0.8|1|1.2].random> volume:2
        - wait 5t
        - cast <player> jump duration:2t amplifier:254 no_icon hide_particles no_ambient
    on player drags in inventory:
    - if <player.has_flag[knightmode]>:
      - determine cancelled
    on player scrolls their hotbar:
    - if <player.has_flag[knightmode]>:
      - determine cancelled
    on player swaps items:
    - if <player.has_flag[knightmode]>:
      - determine cancelled
    on player damaged by FALL:
    - if <player.has_flag[knightmode]>:
      - repeat 3 as:dx:
        - repeat 3 as:dz:
          - repeat 2 as:dy:
            - define loc <player.location.sub[<[dx].sub[2]>,<[dy].sub[1.5]>,<[dz].sub[2]>].block>
            - playeffect at:<[loc].add[0.5,0.5,0.5]> effect:block_crack special_data:<[loc].material.name> offset:0.25 quantity:128
            - playeffect at:<[loc].add[0.5,0.5,0.5]> effect:large_explode offset:0.25 quantity:1
            - playsound at:<player.location> sound:entity_wither_break_block pitch:1 volume:2
            - adjust <player> velocity:<player.velocity.with_y[0.1]>
            - showfake air <[loc]> players:<server.online_players> d:8s