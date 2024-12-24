aries:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375301
  display name: <element[Aries].color[#A00000]>
  lore:
  - <element[time is 0n y0ur side 0_0].color[#500000]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

taurus:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375302
  display name: <element[Taurus].color[#A05000]>
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: capricorn|heartscard
  lore:
  - <element[dEVASTATING CHARGE ATTACK].color[#502800]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

gemini:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375303
  display name: <element[Gemini].color[#A0A000]>
  lore:
  - <element[leviitating power2].color[#505000]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

cancer:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375312
  display name: <element[Cancer].color[#606060]>
  lore:
  - <element[A LOT OF FUCKING SNEAKING AROUND].color[#303030]>
  - <element[LIKE A SHITTY HOBBIT WITH DYSENTERY].color[#303030]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

leo:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375304
  display name: <element[Leo].color[#406800]>
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: sagittarius|diamondscard
  lore:
  - <element[:33 &lt purrfect agility!!!].unescaped.color[#203C00]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

virgo:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375305
  display name: <element[Virgo].color[#008040]>
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: scorpio|taurus|clubscard
  lore:
  - <element[Life Draining Attacks].color[#004020]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

libra:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375306
  display name: <element[Libra].color[#008080]>
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: scorpio|spadescard
  lore:
  - <element[B4L4NC3 1S K3Y].color[#004040]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

scorpio:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375307
  display name: <element[Scorpio].color[#005880]>
  lore:
  - <element[All 8f the luck, 8ll of 8t].color[#002C40]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

sagittarius:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375308
  display name: <element[Sagittarius].color[#0020D0]>
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: leo|diamondscard
  lore:
  - <element[D --&gt f100d of e%tra bolts].unescaped.color[#001068]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

capricorn:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375309
  display name: <element[Capricorn].color[#4000B0]>
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: taurus|heartscard
  lore:
  - <element[dUdE i Am So MoThErFuCkIn HiGH rIgHt NoW...].color[#200058]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

aquarius:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375310
  display name: <element[Aquarius].color[#680068]>
  recipes:
    1:
      type: shapeless
      output_quantity: 1
      input: aquarius|heartscard
  lore:
  - <element[vvirtue in wwater].color[#340034]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

pisces:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375311
  display name: <element[Pisces].color[#780038]>
  lore:
  - <element[-Everyw)(ere fluid is your strengt)( 38D].color[#3C001C]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

ophiuchus:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375313
  display name: <element[Ophiuchus].color[#30D838]>
  lore:
  - <element[IMMuNITY TO POISONOuS DEBuFFS].color[#186C1C]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

cetus:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375314
  display name: <element[Cetus].color[#FF0000]>
  lore:
  - <element[YoU ArE ThE SeA }-{ons+eR!!!!!!!.!!!!!!!!!!!!!!..!,!!!!!!].color[#800000]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

sol:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375315
  display name: <element[Sol].color[#FFD080]>
  lore:
  - <element[T H E   C E N T E R   O F   E V E R Y T H I N G].color[#807040]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

nullyx:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375316
  display name: <element[Nullyx].color[#402060]>
  lore:
  - <element[insignificantinthegrandschemeofthings].color[#201030]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

starsignhandler:
  type: world
  debug: false
  events:
    on spider targets player:
    - if <context.target.inventory.contains_any[scorpio]>:
      - determine cancelled passively
    on cave_spider targets player:
    - if <context.target.inventory.contains_any[scorpio]>:
      - determine cancelled passively
    on silverfish targets player:
    - if <context.target.inventory.contains_any[scorpio]>:
      - determine cancelled passively
    on tick every:5:
    - foreach <server.online_players>:
      - if <[value].inventory.contains_any[capricorn]||0> && !<[value].has_flag[snapped]>:
        - cast <[value]> slow amplifier:0 duration:6t no_icon hide_particles no_ambient
        - cast <[value]> slow_digging amplifier:0 duration:6t no_icon hide_particles no_ambient
      - if <[value].inventory.contains_any[leo]||0>:
        - cast <[value]> speed amplifier:1 duration:6t no_icon hide_particles no_ambient
        - cast <[value]> fast_digging amplifier:1 duration:6t no_icon hide_particles no_ambient
      - if <[value].inventory.contains_any[scorpio]||0>:
        - cast <[value]> luck amplifier:88 duration:6t no_icon hide_particles no_ambient
        - foreach <[value].eye_location.find.living_entities.within[30].exclude[<[value]>]||0> as:enemy:
          - if <list[SPIDER|CAVE_SPIDER|SILVERFISH].contains_any[<[enemy].entity_type>]>:
            - define attTarg <[enemy].eye_location.find.living_entities.within[30].filter_tag[<list[SPIDER|CAVE_SPIDER|SILVERFISH].contains_any[<[filter_value].entity_type>].not>].exclude[<[value]>].get[1]||0>
            - if <[attarg]> != 0:
              - attack <[enemy]> target:<[attTarg]>
          - if <[enemy].target> == <[value]>:
            - attack <[enemy]> cancel
      - if <[value].inventory.contains_any[aquarius]||0>:
        - if <[value].has_flag[mgk_wet]>:
          - flag <[value]> mgk_wet:!
        - cast <[value]> water_breathing amplifier:0 duration:6t no_icon hide_particles no_ambient
      - if <[value].inventory.contains_any[cancer]||0>:
        - if <[value].eye_location.find.living_entities.within[3].exclude[<[value]>].is_empty>:
          - cast <[value]> invisibility amplifier:0 duration:6t no_icon hide_particles no_ambient
          - foreach <[value].eye_location.find.living_entities.within[30].exclude[<[value]>]||0> as:enemy:
            - if <[enemy].target> == <[value]>:
              - attack <[enemy]> cancel
      - if <[value].inventory.contains_any[pisces]||0>:
        - if <[value].has_flag[mgk_wet]>:
          - cast <[value]> speed amplifier:2 duration:6t no_icon hide_particles no_ambient
          - cast <[value]> dolphins_grace amplifier:2 duration:6t no_icon hide_particles no_ambient
          - cast <[value]> conduit_power amplifier:2 duration:6t no_icon hide_particles no_ambient
          - cast <[value]> water_breathing amplifier:0 duration:6t no_icon hide_particles no_ambient
          - cast <[value]> damage_all amplifier:0 duration:6t no_icon hide_particles no_ambient
          - cast <[value]> fire_resistance amplifier:0 duration:6t no_icon hide_particles no_ambient
          - cast <[value]> resistance amplifier:0 duration:6t no_icon hide_particles no_ambient
        - foreach <[value].eye_location.find.living_entities.within[30].exclude[<[value]>]||0> as:enemy:
          - if <[enemy].has_flag[mgk_wet]>:
            - define attTarg <[enemy].eye_location.find.living_entities.within[30].filter_tag[<[filter_value].has_flag[mgk_wet].not>].exclude[<[value]>].get[1]||0>
            - attack <[enemy]> target:<[attTarg]>
      - if <[value].inventory.contains_any[ophiuchus]||0>:
        - cast <[value]> poison remove
        - cast <[value]> wither remove
        - cast <[value]> slow remove
        - cast <[value]> slow_digging remove
        - cast <[value]> bad_omen remove
        - cast <[value]> unluck remove
        - cast <[value]> confusion remove
        - cast <[value]> hunger remove
        - cast <[value]> levitation remove
        - cast <[value]> weakness remove
      - if <[value].inventory.contains_any[cetus]||0>:
        - foreach <[value].eye_location.find.living_entities.within[32].exclude[<[value]>]||0> as:enemy:
          - if <[enemy].has_flag[mgk_wet]> && <util.random_chance[7]>:
            - spawn evoker_fangs at:<[enemy].location>
      - if <[value].inventory.contains_any[sol]||0>:
        - cast <[value]> night_vision amplifier:0 duration:300t no_icon hide_particles no_ambient
    on player damages entity:
    - if <context.damager.inventory.contains_any[virgo]>:
      - heal <context.damager> amount:<context.damage.mul[0.65]>
    - if <context.damager.inventory.contains_any[cetus]>:
      - cast <context.entity> poison amplifier:1 duration:100t
    on player damaged:
    - if <context.entity.inventory.contains_any[sagittarius]>:
      - if <context.entity.has_flag[equiuscooldown]>:
        - stop
      - flag <context.entity> equiuscooldown expire:60t
      - itemcooldown paper duration:60t
      - repeat 20:
        - spawn arrow[shooter=<context.entity>;velocity=<location[0,0,0].random_offset[2,0.25,2]>] at:<context.entity.eye_location>
    - if <context.entity.inventory.contains_any[capricorn]>:
      - if <util.random_chance[5]> && !<context.entity.has_flag[snapped]>:
        - playsound at:<context.entity.eye_location> sound:entity_enderman_stare pitch:0 volume:3
        - flag <context.entity> snapped
        - worldborder <context.entity> warningdistance:600000002
        - while !<context.entity.flag[guilty]||0> < 12:
          - cast <context.entity> increase_damage amplifier:2 duration:12t no_icon hide_particles no_ambient
          - if <util.random_chance[5]>:
            - playsound sound:custom.honk at:<context.entity.eye_location> pitch:<list[0|0.75|1|1.5|2].random> volume:2 custom
            - title "title:<element[HONK].bold.color[#4000B0]>" "subtitle:<element[&coo<list[)|(].random>].unescaped.bold.color[#200058]>" targets:<context.entity> fade_in:0t fade_out:7t stay:3t
          - else: 
            - title "title:<element[KILL].bold.color[#4000B0]>" "subtitle:" targets:<context.entity> fade_in:0t fade_out:5t stay:2t
          - wait 10t
        - flag <context.entity> snapped:!
        - worldborder <context.entity> warningdistance:1
        - flag <context.entity> guilty:0
    on player starts sneaking:
    - if <player.inventory.contains_any[gemini]>:
      - if <player.has_flag[solluxcooldown]>:
        - stop
      - adjust <player> gravity:false
      - wait 1t
      - while <player.is_sneaking>:
        - wait 1t
        - if <[loop_index]> > 200:
          - while stop
        - adjust <player> velocity:<player.velocity.add[0,0.002,0]>
      - adjust <player> gravity:true
      - cast <player> slow_falling duration:20t amplifier:0 no_icon hide_particles no_ambient
      - flag <player> solluxcooldown expire:200t
      - itemcooldown paper duration:200t
    on player damaged by FALL:
    - if <player.inventory.contains_any[gemini]>:
      - determine cancelled passively
    on player left clicks block:
    - if <player.item_in_hand.material.name> == air && <player.inventory.contains_any[taurus]> && !<player.has_flag[tavroscooldown]>:
      - flag <player> tavroscooldown expire:80t
      - itemcooldown paper duration:80t
      - repeat 80:
        - playsound sound:block_beacon_power_select pitch:<[value].mul[0.0125].add[1]> volume:1.5 at:<player.eye_location>
        - adjust <player> velocity:<player.velocity.add[<player.eye_location.with_pitch[0].direction.vector.normalize.mul[<[value].mul[0.0065].add[0.1]>]>]>
        - define hittarg <player.eye_location.forward[0.25].find.living_entities.within[1.5].exclude[<player>]||0>
        - if !<[hittarg].is_empty>:
          - foreach <[hittarg]> as:bashed:
            - hurt <[bashed]> <element[5].add[<[value].mul[0.2]>]>
            - adjust <[bashed]> velocity:<player.eye_location.with_pitch[0].direction.vector.normalize.mul[0.5].add[0,0.25,0].mul[<[value].mul[0.05].add[1]>]>
            - adjust <player> velocity:<player.eye_location.with_pitch[0].direction.vector.normalize.mul[0.5].add[0,0.5,0].mul[-0.3]>
          - playsound sound:entity_wither_break_block pitch:0 volume:2 at:<player.eye_location>
          - playsound sound:entity_wither_break_block pitch:1 volume:2 at:<player.eye_location>
          - playsound sound:entity_ender_dragon_growl pitch:1 volume:2 at:<player.eye_location>
          - playsound sound:entity_ender_dragon_growl pitch:2 volume:2 at:<player.eye_location>
          - playsound sound:block_anvil_place pitch:0 volume:2 at:<player.eye_location>
          - repeat stop
        - wait 1t
      - flag <player> tavroscooldown expire:160t
      - itemcooldown paper duration:160t
    - if <player.item_in_hand.material.name> == air && <player.inventory.contains_any[sol]> && !<player.has_flag[prospitcooldown]>:
      - flag <player> prospitcooldown expire:80t
      - itemcooldown paper duration:80t
      - repeat 80:
        - foreach <player.eye_location.find_entities.within[32].exclude[<player>]||0>:
          - adjust <[value]> velocity:<[value].velocity.add[<[value].location.sub[<player.location>].normalize.mul[-0.2]>]>
        - wait 1t
      - flag <player> prospitcooldown expire:160t
      - itemcooldown paper duration:160t
    on player dies:
    - if <player.inventory.contains_any[nullyx]>:
      - determine cancelled passively
      - take nullyx from:<player.inventory> quantity:1
      - adjust <player> health:2
      - adjust <player> max_health:2
      - adjust <player> absorption_health:<player.absorption_health.add[18]>
      - cast <player> blindness duration:40t amplifier:0 no_icon hide_particles no_ambient
      - playsound sound:entity_ender_dragon_growl pitch:0 volume:2 at:<player.eye_location>
      - playsound sound:block_end_portal_open pitch:0 volume:2 at:<player.eye_location>
      - playsound sound:entity_wither_death pitch:0 volume:2 at:<player.eye_location>
      - playsound sound:block_portal_travel pitch:0 volume:2 at:<player.eye_location>
    on player damaged by FIRE:
    - if <player.inventory.contains_any[sol]>:
      - determine cancelled passively
    on player kills entity:
    - if <context.damager.has_flag[snapped]>:
      - flag <context.damager> guilty:<context.damager.flag[guilty].add[1]||1>