saintsrow:
  type: item
  material: stick
  display name: <element[The Penetrator].color_gradient[from=#800080;to=#FF80FF]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374211
  lore:
  - <element[Uhhhhh.....???].color_gradient[from=#400040;to=#804080]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

saintsrowtriggers:
  type: world
  debug: false
  events:
    on player damages entity with:saintsrow:
    - determine 0 passively
    - foreach <context.entity.eye_location.find.living_entities.within[1.5].exclude[<player>]>:
      - hurt <[value]> 0
      - adjust <[value]> velocity:<[value].velocity.add[<context.damager.eye_location.direction.vector.mul[2].random_offset[1]>]>
    - wait 2t
    - playsound <context.entity.eye_location> sound:block_honey_block_break volume:1 pitch:<list[0.8|1|1.2].random>
    on player right clicks block with:saintsrow:
    - determine cancelled passively
    - ratelimit <player> 1s
    - if !<player.has_flag[saints]>:
      - title "title:<element[WHY WOULD YOU USE THIS???].bold.color_gradient[from=#800080;to=#FF80FF]>" "subtitle:<element[NO SERIOUSLY WHAT WERE YOU EXPECTING?].bold.color_gradient[from=#400040;to=#804080]>" stay:1s targets:<player>
    - playsound at:<player.eye_location> sound:block_note_block_didgeridoo volume:2 pitch:0
    - flag <player> saints expire:2s