anomaloussponge:
  type: item
  material: gold_ingot
  display name: <element[「Anomalous Sponge」].color_gradient[from=#800040;to=#400080]>
  enchantments:
  - infinity:1
  mechanisms:
    custom_model_data: 13374219
    unbreakable: true
    hides: all
  lore:
  - <element[-= Something about this sample is... =-].color_gradient[from=#400020;to=#200040]>
  - <element[-= Hazardous... =-].color_gradient[from=#400020;to=#200040]>
  -
  - <element[UNUSUAL].color[#9040C0].bold>


viruseffect:
  type: world
  debug: false
  events:
    on entity damaged:
    - if <context.entity.has_flag[infected]> && <context.cause> == poison:
      - ratelimit <context.entity> 5t
      - playeffect effect:redstone special_data:0.9|purple quantity:60 at:<context.entity.eye_location> offset:1.5
      - playsound sound:entity_generic_extinguish_fire pitch:1.6 at:<context.entity.location> volume:0.4
      - playsound sound:entity_generic_extinguish_fire pitch:0 at:<context.entity.location> volume:0.4
      - cast <context.entity> slow duration:15t amplifier:1 hide_particles no_icon no_ambient
      - cast <context.entity> poison duration:40t amplifier:0 hide_particles no_icon no_ambient
      - define fucked <context.entity.location.find.living_entities.within[5]>
      - foreach <[fucked]>:
        - flag <[value]> infected expire:4s
        - cast <[value]> poison duration:40t amplifier:0 no_ambient hide_particles no_icon
    on entity killed:
    - if <context.entity.has_flag[infected]>:
      - ratelimit <context.entity> 5t
      - playeffect effect:redstone special_data:8|purple quantity:<context.entity.health_max.mul[6]> at:<context.entity.eye_location> offset:<context.entity.health_max.mul[0.15]>
      - playsound sound:entity_creeper_hurt pitch:0 at:<context.entity.location> volume:1
      - playsound sound:entity_creeper_death pitch:0 at:<context.entity.location> volume:1
      - playsound sound:entity_generic_extinguish_fire pitch:0 at:<context.entity.location> volume:1
      - playsound sound:entity_zombie_villager_cure pitch:0 at:<context.entity.location> volume:1
      - cast <context.entity> slow duration:15t amplifier:1 hide_particles no_icon no_ambient
      - cast <context.entity> poison duration:40t amplifier:0 hide_particles no_icon no_ambient
      - define fucked <context.entity.location.find.living_entities.within[<context.entity.health_max.mul[0.4]>]>
      - hurt <[fucked]> <context.entity.health_max.div[4]> cause:poison
      - foreach <[fucked]>:
        - flag <[value]> infected expire:4s
        - cast <[value]> poison duration:40t amplifier:0 no_ambient hide_particles no_icon


anomalousspongetriggers:
  type: world
  debug: false
  events:
    on player damages entity:
    - if <context.damager.item_in_hand.script||0> == <script[anomaloussponge]> && !<context.damager.has_flag[viruscooldown]>:
      - ratelimit <context.damager> 1t
      - define fucked <context.damager.location.find.living_entities.within[6].exclude[<context.damager>]>
      - foreach <[fucked]>:
        - flag <[value]> infected expire:4s
        - cast <[value]> poison duration:25t amplifier:6 hide_particles no_icon no_ambient
        - playsound sound:entity_zombie_villager_step pitch:0 at:<context.entity.location> volume:1
        - playeffect effect:redstone special_data:4|purple quantity:60 at:<[value].eye_location> offset:1
      - itemcooldown gold_ingot duration:10s
      - flag <context.damager> viruscooldown expire:10s
    on player right clicks block with:anomaloussponge:
    - determine cancelled passively
    - if !<player.has_flag[viruscooldown]>:
      - if <player.health> > 1:
        - if <player.has_flag[infected]>:
          - itemcooldown gold_ingot duration:7s
          - playsound sound:ambient_underwater_exit pitch:0 at:<player.location> volume:1
          - playeffect effect:redstone special_data:3|<color[#ff00ff]> quantity:60 at:<player.eye_location> offset:1
          - flag <player> viruscooldown expire:7s
          - flag <player> infected:!
          - cast <player> remove poison
          - cast <player> remove slow
          - title "title:<element[CURED!].color_gradient[from=#FF0080;to=#8000FF]>" "subtitle:" fade_in:0 stay:1s targets:<player>
        - else:
          - itemcooldown gold_ingot duration:10s
          - playsound sound:ambient_underwater_enter pitch:0 at:<player.location> volume:1
          - flag <player> viruscooldown expire:10s
          - flag <player> infected expire:4s
          - playeffect effect:redstone special_data:3|purple quantity:60 at:<player.eye_location> offset:1
          - title "title:<element[INFECTED!].color_gradient[from=#FF0080;to=#8000FF]>" "subtitle:" fade_in:0 stay:1s targets:<player>
          - cast <player> poison duration:25t amplifier:6 hide_particles no_icon no_ambient
      - else: 
        - ratelimit 5s
        - title "title:" "subtitle:<element[THERE'S NOTHING LEFT OF YOU TO INFECT].color_gradient[from=#800040;to=#400080]>" fade_in:0 stay:1t targets:<player>
        - itemcooldown sponge duration:15t
        - flag <player> viruscooldown expire:15t
        - playsound sound:block_note_block_bass pitch:0 at:<player.location> volume:1
    after delta time secondly:
    - foreach <server.online_players>:
      - if <[value].item_in_hand.script||0> == <script[anomaloussponge]>:
        - random:
          - playsound sound:block_honey_block_slide at:<[value].location> pitch:0 volume:0.5
          #- playsound sound:entity_boat_paddle_water at:<[value].location> pitch:0 volume:1
          - playsound sound:block_ambient_water at:<[value].location> pitch:0 volume:1