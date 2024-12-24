ambrosium:
  type: item
  material: diamond
  display name: <element[Ambrosium].color_gradient[from=#FFFF00;to=#C0C000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375232
  lore:
  - <element[Food of the gods].color_gradient[from=#808000;to=#606000]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

holymackarel:
  type: item
  material: stick
  display name: <element[Holy].color_gradient[from=#C0C060;to=#C0C0C0]><element[ ]><element[Mackarel].color_gradient[from=#408080;to=#60C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374305
  lore:
  - <element[Divine and].color_gradient[from=#606030;to=#606060]><element[ ]><element[fishy].color_gradient[from=#204040;to=#306060]>
  - <&7>
  - <element[COLLECTOR'S].color[#800000].bold>

holysword:
  type: item
  material: stone_sword
  display name: <element[Holy Sword].color_gradient[from=#C0C060;to=#C0C0C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374200
  lore:
  - <element[Divine and shitty].color_gradient[from=#606030;to=#606060]>
  - <&7>
  - <element[UNIQUE].color[#FFEF10].bold>

ambrosiumtriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:ambrosium:
    - determine cancelled passively
    - if <player.health> < <player.health_max>:
      - heal <player> amount:2
    - else:
      - if <player.absorption_health> < <player.health_max>:
        - adjust <player> absorption_health:<player.absorption_health.add[2]>
      - else:
        - stop
    - take item_in_hand quantity:1
    - playsound sound:block_beacon_power_select pitch:2 volume:2 at:<player.eye_location>
    - playsound sound:BLOCK_ANCIENT_DEBRIS_PLACE pitch:0 volume:2 at:<player.eye_location>
    on player damages entity with:holysword:
    - if <util.random_chance[7]>:
      - drop ambrosium <context.entity.location> quantity:1 speed:0.05 delay:10t
    on player damages entity with:holymackarel:
    - if <util.random_chance[10]>:
      - determine 5 passively
      - title targets:<context.damager> "title:<element[CRITICAL HIT!].bold.italicize.color_gradient[from=#00FF00;to=#FF0000;style=HSB]>" "subtitle:" fade_in:0 stay:5t fade_out:10t
      - adjust <context.entity> velocity:<context.entity.velocity.add[<context.damager.eye_location.direction.vector.mul[2].random_offset[1]>]>
      - playsound <context.entity.eye_location> sound:entity_arrow_hit_player volume:1 pitch:2
      - playsound <context.entity.eye_location> sound:entity_player_levelup volume:1 pitch:1
      - playsound <context.entity.eye_location> sound:entity_salmon_flop volume:2 pitch:1
      - playsound <context.entity.eye_location> sound:entity_salmon_flop volume:2 pitch:0
      - playsound <context.entity.eye_location> sound:block_honey_block_break volume:2 pitch:1
      - playsound <context.entity.eye_location> sound:block_honey_block_break volume:2 pitch:0
      - adjust <context.entity> fire_time:0t
      - adjust <context.entity> velocity:<[lookvec].add[0,1,0].mul[0.5]>
      - if !<context.entity.has_flag[mgk_wet]>:
        - flag <context.entity> mgk_wet expire:4s
        - run wet_run def:<context.entity>
      - else:
        - flag <context.entity> mgk_wet expire:4s
      - if <util.random_chance[7]>:
        - drop ambrosium <context.entity.location> quantity:1 speed:0.05 delay:10t
    - else:
      - determine 0 passively
      - playsound <context.entity.eye_location> sound:entity_salmon_flop volume:2 pitch:1
      - playsound <context.entity.eye_location> sound:entity_salmon_flop volume:2 pitch:0
      - playsound <context.entity.eye_location> sound:block_honey_block_break volume:2 pitch:1
      - playsound <context.entity.eye_location> sound:block_honey_block_break volume:2 pitch:0
      - adjust <context.entity> fire_time:0t
      - adjust <context.entity> velocity:<[lookvec].add[0,1,0].mul[0.5]>
      - if !<context.entity.has_flag[mgk_wet]>:
        - flag <context.entity> mgk_wet expire:4s
        - run wet_run def:<context.entity>
      - else:
        - flag <context.entity> mgk_wet expire:4s
      - if <util.random_chance[7]>:
        - drop ambrosium <context.entity.location> quantity:1 speed:0.05 delay:10t
    on player left clicks block with:holymackarel:
    - playsound <player.eye_location> sound:entity_salmon_flop volume:2 pitch:1
    - playsound <player.eye_location> sound:block_honey_block_break volume:2 pitch:1
 #   - playsound <player.eye_location> sound:entity_player_attack_weak volume:1 pitch:0