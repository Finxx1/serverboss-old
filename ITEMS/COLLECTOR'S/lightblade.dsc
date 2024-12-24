lightblade:
  type: item
  material: diamond_sword
  display name: <element[Light Blade].color_gradient[from=#FFFF00;to=#FFFF80]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374212
#  enchantments:
#  - smite:1
  lore:
  - <element[24 Hours until it fades].color_gradient[from=#808000;to=#808040]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

lightbladetriggers:
  type: world
  debug: false
  events:
    on player walks:
    - ratelimit <player> 6t
    - if <player.item_in_hand.script||0> == <script[lightblade]> && <player.is_on_ground>:
      - if !<player.has_flag[lightaccel]>:
        - flag <player> lightaccel:0 expire:7t
      - else:
        - flag <player> lightaccel:<player.flag[lightaccel].add[1].min[10]> expire:7t
      - cast <player> speed duration:7t amplifier:<player.flag[lightaccel]> no_icon hide_particles no_ambient
      - cast <player> jump duration:7t amplifier:<player.flag[lightaccel].div[1.5]> no_icon hide_particles no_ambient
      - cast <player> fast_digging duration:7t amplifier:<player.flag[lightaccel].div[1.5]> no_icon hide_particles no_ambient
      - cast <player> damage_resistance duration:7t amplifier:<player.flag[lightaccel].div[10]> no_icon hide_particles no_ambient
      - run lightacceltrail def:<player>
    on player damages entity with:lightblade:
    - if <context.entity.monster_type||0> == UNDEAD:
      - determine <element[15].add[<player.flag[lightaccel]>]>
    - else:
      - determine <element[15].add[<player.flag[lightaccel]>].mul[1.777]>

lightacceltrail:
  type: task
  debug: false
  definitions: rascal
  script:
  - repeat 6:
    - playeffect at:<[rascal].location.add[0,1,0]> effect:redstone special_data:<[rascal].flag[lightaccel].div[5]>|<color[#FFFF80]> offset:0,0.5,0 quantity:<[rascal].flag[lightaccel]>
    - wait 1t