maneax:
  type: item
  material: netherite_axe
  display name: <element[Mane Ax].color_gradient[from=#808080;to=#80FFC0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374260
#    attribute_modifiers:
#      GENERIC_ATTACK_DAMAGE:
#        1:
#          operation: add_number
#          amount: 16
#          slot: hand
  lore:
  - <element[Quiet people piss it off].color_gradient[from=#404040;to=#408060]>
  - <&7>
  - <element[COLLECTOR'S].color[#800000].bold>

maneaxhits:
  type: world
  debug: false
  events:
    on player breaks block with:maneax:
    - determine cancelled passively
    on player damages entity with:maneax:
    - if !<context.damager.has_flag[tension]>:
      - flag <context.damager> tension:0
      - flag <context.damager> redtension:0
    - if <context.damager.flag[tension]> < 100:
      - flag <context.damager> tension:<context.damager.flag[tension].add[<context.damage>].min[100].round_down>
      - title "title:<element[<context.damager.flag[tension]>%].bold.italicize.color[#80FFC0]>" "subtitle:<element[&pipe].unescaped.repeat[<context.damager.flag[tension]>].color[#80FFC0]><element[&pipe].unescaped.repeat[<element[100].sub[<context.damager.flag[tension]>]>].color[#808080]>" fade_in:0 stay:10t fade_out:5t targets:<context.damager>
    - else if <context.damager.flag[redtension]> < 100:
      - if <context.damage> >= <element[100].sub[<context.damager.flag[redtension]>]>:
        - announce <context.damage>
        - announce <element[100].sub[<context.damager.flag[redtension]>]>
        - inventory adjust "display_name:<element[Mean Axe].color_gradient[from=#606060;to=#FF0000]>" destination:<context.damager.inventory> slot:hand
        - inventory adjust "lore:<list[<element[. . .].color_gradient[from=#303030;to=#800000]>|<&7>Aggression IX|<&7>|<element[HAUNTED].color[#38F0A8].bold>]>" destination:<context.damager.inventory> slot:hand
        - inventory adjust "enchantments:[thorns=5;sharpness=1;knockback=1]" destination:<context.damager.inventory> slot:hand
        - inventory adjust "custom_model_data:13374263" destination:<context.damager.inventory> slot:hand
        - inventory adjust "hides:all" destination:<context.damager.inventory> slot:hand
      - flag <context.damager> redtension:<context.damager.flag[redtension].add[<context.damage>].min[100].round_down>
      - title "title:<element[<context.damager.flag[redtension]>%].bold.italicize.color[#FF0000]>" "subtitle:<element[&pipe].unescaped.repeat[<context.damager.flag[redtension]>].color[#FF0000]><element[&pipe].unescaped.repeat[<element[100].sub[<context.damager.flag[redtension]>]>].color[#606060]>" fade_in:0 stay:10t fade_out:5t targets:<context.damager>
    on player damaged:
    - if <player.item_in_hand.script.name> == maneax:
      - flag <player> tension:<player.flag[tension].add[<context.damage.mul[2]>].min[100].round_down>
      - title "title:<element[<player.flag[tension]>%].bold.italicize.color[#80FFC0]>" "subtitle:<element[&pipe].unescaped.repeat[<player.flag[tension]>].color[#80FFC0]><element[&pipe].unescaped.repeat[<element[100].sub[<player.flag[tension]>]>].color[#808080]>" fade_in:0 stay:10t fade_out:5t targets:<player>
    on player right clicks block with:maneax:
    - if <player.flag[tension]> >= 50:
      - if <player.flag[redtension]> < 100:
        - flag <player> tension:<player.flag[tension].sub[50]>
        - playsound at:<player.eye_location> sound:entity_drowned_shoot pitch:1 volume:2
        - playsound at:<player.eye_location> sound:entity_drowned_shoot pitch:0 volume:2
        - playsound at:<player.eye_location> sound:entity_evoker_prepare_attack pitch:1 volume:2
#       - playsound at:<player.eye_location> sound:custom.psychicfire pitch:0 volume:1 custom
        - define aimtarg <player.eye_location.ray_trace[range=50;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.1]>
        - define endingPos <[aimtarg]>
        - define posline <player.eye_location.points_between[<[aimtarg]>].distance[1]>
        - run rudebusterconsumeanim def:<player>
        - foreach <[posline]>:
          - playeffect effect:redstone at:<[value]> special_data:2|<color[#FF30FF]> quantity:5 offset:0.4 visibility:100
          - define hittarg <[value].find.living_entities.within[1].exclude[<player>].get[1]||0>
          - if <[hittarg]> != 0:
            - define endingPos <[value]>
            - define hittarg2 <[value].find.living_entities.within[4].exclude[<player>]||0>
            - adjust <[hittarg]> velocity:<[hittarg].eye_location.sub[<[value]>].normalize.mul[1].add[0,0.5,0]>
            - hurt <[hittarg]> <[hittarg].health_max.mul[0.2].add[15]> source:<player>
            - foreach <[hittarg2]> as:val2:
              - hurt <[val2]> <[val2].health_max.mul[0.2].add[5]> source:<player>
              - adjust <[val2]> velocity:<[val2].eye_location.sub[<[value]>].normalize.mul[0.5].add[0,0.25,0]>
#             - define posline1 <[value].points_between[<[hittarg].eye_location>].distance[0.15]>
            - foreach stop
          - wait 1t
        - playeffect effect:redstone at:<[endingPos]> special_data:2|<color[#FF30FF]> quantity:60 offset:0.7 visibility:100
        - playsound at:<[endingPos]> sound:entity_generic_explode pitch:1 volume:2
        - playsound at:<[endingPos]> sound:entity_generic_explode pitch:2 volume:2
        - playsound at:<[endingPos]> sound:entity_generic_explode pitch:0 volume:2
        - repeat 5:
          - playeffect effect:large_explode at:<[endingPos]> quantity:3 offset:1 visibility:100
          - wait 1t
      - else:
        - inventory adjust "display_name:<element[Mane Ax].color_gradient[from=#808080;to=#80FFC0]>" destination:<context.damager.inventory> slot:hand
        - inventory adjust "lore:<element[Quiet people piss it off].color_gradient[from=#404040;to=#408060]>|<&7>|<element[COLLECTOR'S].color[#800000].bold>" destination:<context.damager.inventory> slot:hand
        - inventory adjust "remove_enchantments" destination:<context.damager.inventory> slot:hand
        - inventory adjust "custom_model_data:13374260" destination:<context.damager.inventory> slot:hand
        - flag <player> tension:0
        - flag <player> redtension:0
        - playsound at:<player.eye_location> sound:entity_drowned_shoot pitch:1 volume:2
        - playsound at:<player.eye_location> sound:entity_drowned_shoot pitch:0 volume:2
        - playsound at:<player.eye_location> sound:entity_ender_dragon_growl pitch:1 volume:7
        - playsound at:<player.eye_location> sound:entity_evoker_prepare_attack pitch:0 volume:2
#       - playsound at:<player.eye_location> sound:custom.psychicfire pitch:0 volume:1 custom
        - define aimtarg <player.eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;ignore=*;raysize=0.1]>
        - define endingPos <[aimtarg]>
        - define posline <player.eye_location.points_between[<[aimtarg]>].distance[1]>
        - run redbusterconsumeanim def:<player>
        - foreach <[posline]>:
          - playeffect effect:redstone at:<[value]> special_data:2.5|<color[#FF0000]> quantity:7 offset:0.55 visibility:100
          - define hittarg <[value].find.living_entities.within[1].exclude[<player>].get[1]||0>
          - if <[hittarg]> != 0:
            - define endingPos <[value]>
            - define hittarg2 <[value].find.living_entities.within[6].exclude[<player>]||0>
            - adjust <[hittarg]> velocity:<[hittarg].eye_location.sub[<[value]>].normalize.mul[1.25].add[0,0.5,0]>
            - hurt <[hittarg]> <[hittarg].health_max.mul[0.35].add[25]> source:<player>
            - foreach <[hittarg2]> as:val2:
              - hurt <[val2]> <[val2].health_max.mul[0.35].add[15]> source:<player>
              - adjust <[val2]> velocity:<[val2].eye_location.sub[<[value]>].normalize.mul[0.75].add[0,0.25,0]>
#             - define posline1 <[value].points_between[<[hittarg].eye_location>].distance[0.15]>
            - foreach stop
          - if <[loop_index].mod[2]> == 0:
            - wait 1t
        - playeffect effect:redstone at:<[endingPos]> special_data:2.5|<color[#FF0000]> quantity:100 offset:1 visibility:100
        - playsound at:<[endingPos]> sound:entity_generic_explode pitch:1 volume:2
        - playsound at:<[endingPos]> sound:entity_generic_explode pitch:2 volume:2
        - playsound at:<[endingPos]> sound:entity_generic_explode pitch:0 volume:2
        - playsound at:<[endingPos]> sound:entity_ender_dragon_hurt pitch:1 volume:2
        - playsound at:<[endingPos]> sound:item_totem_use pitch:0 volume:2
        - repeat 5:
          - playeffect effect:large_explode at:<[endingPos]> quantity:3 offset:1 visibility:100
          - wait 1t

rudebusterconsumeanim:
  type: task
  definitions: playa
  debug: false
  script:
  - define tenstemp <[playa].flag[tension]>
  - title "title:<element[<[tenstemp].add[50]>%].bold.italicize.color[#80FFC0]>" "subtitle:<element[&pipe].unescaped.repeat[<[tenstemp]>].color[#80FFC0]><element[&pipe].unescaped.repeat[50].color[#FFFFFF]><element[&pipe].unescaped.repeat[<element[100].sub[50].sub[<[tenstemp]>]>].color[#808080]>" fade_in:0 stay:10t fade_out:5t targets:<[playa]>
  - wait 1t
  - title "title:<element[<[tenstemp].add[38]>%].bold.italicize.color[#80FFC0]>" "subtitle:<element[&pipe].unescaped.repeat[<[tenstemp]>].color[#80FFC0]><element[&pipe].unescaped.repeat[38].color[#FFFFFF]><element[&pipe].unescaped.repeat[<element[100].sub[38].sub[<[tenstemp]>]>].color[#808080]>" fade_in:0 stay:10t fade_out:5t targets:<[playa]>
  - wait 1t
  - title "title:<element[<[tenstemp].add[25]>%].bold.italicize.color[#80FFC0]>" "subtitle:<element[&pipe].unescaped.repeat[<[tenstemp]>].color[#80FFC0]><element[&pipe].unescaped.repeat[25].color[#FFFFFF]><element[&pipe].unescaped.repeat[<element[100].sub[25].sub[<[tenstemp]>]>].color[#808080]>" fade_in:0 stay:10t fade_out:5t targets:<[playa]>
  - wait 1t
  - title "title:<element[<[tenstemp].add[12]>%].bold.italicize.color[#80FFC0]>" "subtitle:<element[&pipe].unescaped.repeat[<[tenstemp]>].color[#80FFC0]><element[&pipe].unescaped.repeat[12].color[#FFFFFF]><element[&pipe].unescaped.repeat[<element[100].sub[12].sub[<[tenstemp]>]>].color[#808080]>" fade_in:0 stay:10t fade_out:5t targets:<[playa]>
  - wait 1t
  - title "title:<element[<[tenstemp]>%].bold.italicize.color[#80FFC0]>" "subtitle:<element[&pipe].unescaped.repeat[<[tenstemp]>].color[#80FFC0]><element[&pipe].unescaped.repeat[<element[100].sub[<[tenstemp]>]>].color[#808080]>" fade_in:0 stay:10t fade_out:5t targets:<[playa]>


redbusterconsumeanim:
  type: task
  definitions: playa
  debug: false
  script:
  - define tenstemp <[playa].flag[tension]>
  - title "title:<element[RED BUSTER! ].bold.color[#FF0000]>" "subtitle:<element[&pipe].unescaped.repeat[100].color[#FF0000]><element[&pipe].unescaped.repeat[0].color[#C0C0C0]><element[&pipe].unescaped.repeat[0].color[#606060]>" fade_in:0 stay:10t fade_out:5t targets:<[playa]>
  - wait 5t
  - title "title:<element[RED BUSTER! ].bold.color[#FF0000]>" "subtitle:<element[&pipe].unescaped.repeat[0].color[#FF0000]><element[&pipe].unescaped.repeat[100].color[#C0C0C0]><element[&pipe].unescaped.repeat[0].color[#606060]>" fade_in:0 stay:10t fade_out:5t targets:<[playa]>
  - wait 2t
  - title "title:<element[RED BUSTER! ].bold.color[#FF0000]>" "subtitle:<element[&pipe].unescaped.repeat[0].color[#FF0000]><element[&pipe].unescaped.repeat[75].color[#C0C0C0]><element[&pipe].unescaped.repeat[25].color[#606060]>" fade_in:0 stay:10t fade_out:5t targets:<[playa]>
  - wait 2t
  - title "title:<element[RED BUSTER! ].bold.color[#FF0000]>" "subtitle:<element[&pipe].unescaped.repeat[0].color[#FF0000]><element[&pipe].unescaped.repeat[50].color[#C0C0C0]><element[&pipe].unescaped.repeat[50].color[#606060]>" fade_in:0 stay:10t fade_out:5t targets:<[playa]>
  - wait 2t
  - title "title:<element[RED BUSTER! ].bold.color[#FF0000]>" "subtitle:<element[&pipe].unescaped.repeat[0].color[#FF0000]><element[&pipe].unescaped.repeat[25].color[#C0C0C0]><element[&pipe].unescaped.repeat[75].color[#606060]>" fade_in:0 stay:10t fade_out:5t targets:<[playa]>
  - wait 2t
  - title "title:<element[RED BUSTER! ].bold.color[#FF0000]>" "subtitle:<element[&pipe].unescaped.repeat[0].color[#FF0000]><element[&pipe].unescaped.repeat[0].color[#C0C0C0]><element[&pipe].unescaped.repeat[100].color[#606060]>" fade_in:0 stay:10t fade_out:5t targets:<[playa]>