roulettegun:
  type: item
  material: iron_horse_armor
  display name: <element[The Buckshot Roulette].color[#E0C080]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13374328
    hides: all
  lore:
  - <element[Six rounds enter the chamber in a hidden sequence].color[#706040]>
  - 
  - <element[VINTAGE].color[#404878].bold>

roulettetriggers:
  type: world
  events:
    on player right clicks block with:roulettegun:
    - ratelimit <player> 1t
    - if <player.has_flag[unfireable]>:
      - stop
    - if <player.flag[shotsloaded].size||0> == 0:
      - flag <player> unfireable
      - repeat 6:
        - flag <player> shotsloaded:->:<list[blank|live].random>
        - title "title:" "subtitle:<element[<player.flag[shotsloaded].size>].bold.color[#E0C080]>" targets:<player> fade_in:0t fade_out:5t stay:10t
        - playsound <player.location> sound:block_stone_button_click_on pitch:1.5 volume:2
        - playsound <player.location> sound:entity_skeleton_step pitch:1.5 volume:2
        - wait 5t
      - title "title:" "subtitle:<element[<player.flag[shotsloaded].count_matches[live]>].bold.color[#FF4040]>" targets:<player> fade_in:0t fade_out:5t stay:10t
      - playsound <player.location> sound:block_piston_extend pitch:1.5 volume:2
      - playsound <player.location> sound:block_piston_extend pitch:1 volume:2
      - wait 5t
      - title "title:" "subtitle:<element[<player.flag[shotsloaded].count_matches[live]>].bold.color[#FF4040]> <element[<player.flag[shotsloaded].count_matches[blank]>].bold.color[#203050]>" targets:<player> fade_in:0t fade_out:5t stay:10t
      - playsound <player.location> sound:block_piston_contract pitch:1.5 volume:2
      - playsound <player.location> sound:block_piston_contract pitch:1 volume:2
      - flag <player> unfireable:!
      - stop
    - if !<player.has_flag[riflecooldown]>:
      - define shotkind <player.flag[shotsloaded].get[1]>
      - flag <player> shotsloaded[1]:<-
      - title "title:" "subtitle:<element[<player.flag[shotsloaded].size>].bold.color[#E0C080]>" targets:<player> fade_in:0t fade_out:5t stay:10t
      - if <[shotkind]> == live:
        - playsound <player.location> sound:entity_iron_golem_hurt pitch:1.5 volume:1
        - playsound <player.location> sound:entity_skeleton_hurt pitch:1.5 volume:1
        - playsound <player.location> sound:entity_generic_explode pitch:1.5 volume:1
        - playsound <player.location> sound:custom.classic_explode pitch:1.5 volume:1 custom
        - playsound <player.location> sound:entity_zombie_attack_wooden_door pitch:1.5 volume:1
      - flag <player> riflecooldown expire:20t
      - itemcooldown iron_horse_armor duration:20t
      - if <player.item_in_hand.custom_model_data> == 13374328:
        - choose <[shotkind]>:
          - case live:
            - repeat <element[10].add[<player.flag[gamblingshotgun].mul[10]>]||10>:
              - shoot pellet origin:<player.eye_location.right[0.4].below[0.4]> speed:<element[2].sub[<player.flag[gamblingshotgun].mul[0.1]>]||2> shooter:<player> spread:15 
              - flag <player> gamblingshotgun:0
          - case blank:
            - playsound <player.location> sound:block_stone_button_click_on pitch:2 volume:2
            - playsound <player.location> sound:entity_creeper_hurt pitch:2 volume:2
            - flag <player> gamblingshotgun:0
      - else if <player.item_in_hand.custom_model_data> == 13374329:
        - choose <[shotkind]>:
          - case live:
            - hurt <player> amount:<element[10].add[<player.flag[gamblingshotgun].mul[4]>]>
            - flag <player> gamblingshotgun:0
            - flag <player> goring expire:1s
            - playsound at:<player.eye_location> sound:custom.gib pitch:1 volume:2 custom
            - run GOREBURSTPRO def:<player.location.above[1]>|0.2
            - cast <player> weakness duration:20t amplifier:1 no_icon hide_particles no_ambient
            - cast <player> blindness duration:40t amplifier:1 no_icon hide_particles no_ambient
            - cast <player> slow duration:20t amplifier:1 no_icon hide_particles no_ambient
            - adjust <player> velocity:<player.eye_location.direction.vector.normalize.mul[-0.75]>
          - case blank:
            - playsound <player.location> sound:block_stone_button_click_on pitch:2 volume:2
            - playsound <player.location> sound:entity_creeper_hurt pitch:2 volume:2
            - flag <player> gamblingshotgun:++
      - title "title:" "subtitle:<element[<player.flag[shotsloaded].size>].bold.color[#E0C080]>" targets:<player> fade_in:0t fade_out:5t stay:10t
      - wait 8t
      - playsound <player.location> sound:block_piston_extend pitch:1.5 volume:2
      - playsound <player.location> sound:block_piston_extend pitch:1 volume:2
      - wait 5t
      - playsound <player.location> sound:block_piston_contract pitch:1.5 volume:2
      - playsound <player.location> sound:block_piston_contract pitch:1 volume:2
    on player left clicks block with:roulettegun:
    - if <player.item_in_hand.custom_model_data> == 13374328:
      - inventory adjust "custom_model_data:13374329" destination:<player.inventory> slot:hand
      - itemcooldown iron_horse_armor duration:5t
    - else if <player.item_in_hand.custom_model_data> == 13374329:
      - inventory adjust "custom_model_data:13374328" destination:<player.inventory> slot:hand
      - itemcooldown iron_horse_armor duration:5t