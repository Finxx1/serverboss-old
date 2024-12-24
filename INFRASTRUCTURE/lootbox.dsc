paidchests:
  debug: false
  type: world
  events:
    on player right clicks chest:
    - if <player.gamemode> == CREATIVE:
      - stop
    - define aimtarg <player.eye_location.ray_trace[range=10;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.5]>
    - if <[aimtarg].material.name> == chest:
      - choose <[aimtarg].sub[0,1,0].material.name>:
        - case COAL_BLOCK:
          - flag <player> shopping:0
          #- announce "SHOPPING TIER 1"
        - case IRON_BLOCK:
          - flag <player> shopping:1
          #- announce "SHOPPING TIER 2"
        - case GOLD_BLOCK:
          - flag <player> shopping:2
          #- announce "SHOPPING TIER 3"
        - case DIAMOND_BLOCK:
          - flag <player> shopping:3
          #- announce "SHOPPING TIER 4"
        - case EMERALD_BLOCK:
          - flag <player> shopping:4
          #- announce "SHOPPING TIER 5"
        - default:
          - flag <player> shopping:!
    - else:
      - determine cancelled passively
    on player closes inventory:
    - flag <player> shopping:!
    on player clicks in inventory:
    - if <player.has_flag[shopping]> && <context.item.material.name> != air:
      - if !<player.has_flag[holdonyoulittlefuckhead]> && <context.clicked_inventory> != <player.inventory>:
        - choose <player.flag[shopping]>:
          - case 0:
            - if <player.flag[money]> >= 15:
              - give <context.item>
              - playsound at:<player.location> sound:block_note_block_pling pitch:2 volume:1
              - flag <player> money:<player.flag[money].sub[15]>
              - announce <element[<player.display_name>]><element[ bought <context.item.display||<context.item.material.name>>].color[#80FF80]><element[ for ¤15!].color[#80FF80]>
            - else:
              - playsound at:<player.location> sound:block_note_block_didgeridoo pitch:0 volume:1
              - narrate <element[Failed to buy <context.item.display||<context.item.material.name>>].color[#FF8080]><element[ for ¤15!].color[#FF8080]>
          - case 1:
            - if <player.flag[money]> >= 55:
              - give <context.item>
              - playsound at:<player.location> sound:block_note_block_pling pitch:2 volume:1
              - flag <player> money:<player.flag[money].sub[55]>
              - announce <element[<player.display_name>]><element[ bought <context.item.display||<context.item.material.name>>].color[#80FF80]><element[ for ¤55!].color[#80FF80]>
            - else:
              - playsound at:<player.location> sound:block_note_block_didgeridoo pitch:0 volume:1
              - narrate <element[Failed to buy <context.item.display||<context.item.material.name>>].color[#FF8080]><element[ for ¤55!].color[#FF8080]>
          - case 2:
            - if <player.flag[money]> >= 225:
              - give <context.item>
              - playsound at:<player.location> sound:block_note_block_pling pitch:2 volume:1
              - flag <player> money:<player.flag[money].sub[225]>
              - announce <element[<player.display_name>]><element[ bought <context.item.display||<context.item.material.name>>].color[#80FF80]><element[ for ¤225!].color[#80FF80]>
            - else:
              - playsound at:<player.location> sound:block_note_block_didgeridoo pitch:0 volume:1
              - narrate <element[Failed to buy <context.item.display||<context.item.material.name>>].color[#FF8080]><element[ for ¤225!].color[#FF8080]>
          - case 3:
            - if <player.flag[money]> >= 875:
              - give <context.item>
              - playsound at:<player.location> sound:block_note_block_pling pitch:2 volume:1
              - flag <player> money:<player.flag[money].sub[875]>
              - announce <element[<player.display_name>]><element[ bought <context.item.display||<context.item.material.name>>].color[#80FF80]><element[ for ¤875!].color[#80FF80]>
            - else:
              - playsound at:<player.location> sound:block_note_block_didgeridoo pitch:0 volume:1
              - narrate <element[Failed to buy <context.item.display||<context.item.material.name>>].color[#FF8080]><element[ for ¤875!].color[#FF8080]>
          - case 4:
            - if <player.flag[money]> >= 3375:
              - give <context.item>
              - playsound at:<player.location> sound:block_note_block_pling pitch:2 volume:1
              - flag <player> money:<player.flag[money].sub[3375]>
              - announce <element[<player.display_name>]><element[ bought <context.item.display||<context.item.material.name>>].color[#80FF80]><element[ for ¤3375!].color[#80FF80]>
            - else:
              - playsound at:<player.location> sound:block_note_block_didgeridoo pitch:0 volume:1
              - narrate <element[Failed to buy <context.item.display||<context.item.material.name>>].color[#FF8080]><element[ for ¤3375!].color[#FF8080]>
        - flag <player> holdonyoulittlefuckhead expire:2t
      - determine cancelled passively
#    on player damaged by FALL:
#    - define damagetaken <context.damage>
#    - determine <context.damage.min[6]>

dolar:
  type: entity
  entity_type: dropped_item
  mechanisms:
    item: filled_map

dolar:
  type: entity
  entity_type: dropped_item
  mechanisms:
    item: filled_map

dolarhandler:
  type: world
  events:
    on player picks up filled_map:
    - if <context.entity.script||0> == <script[dolar]>:
      - if !<player.has_flag[recentmoney]>:
        - flag <player> recentmoney:0
      - define moneyget <list[5|10|20].random>
      - determine cancelled passively
      - flag <player> money:<player.flag[money].add[<[moneyget]>]||50>
      - flag <player> recentmoney:<player.flag[recentmoney].add[<[moneyget]>]||50> expire:2s
      - actionbar <element[+ ¤<player.flag[recentmoney]>].color[#80FF80].bold> targets:<player>
      - playsound at:<player.location> sound:block_chain_place pitch:1 volume:1
      - playsound at:<player.location> sound:entity_arrow_hit_player pitch:1 volume:1
      - remove <context.entity>
    on filled_map merges:
    - if <context.entity.script||0> == <script[dolar]>:
      - determine cancelled passively

dolarspawn:
  type: task
  definitions: spamount|spspread|splocation
  script:
    - repeat <[spamount]>:
      - spawn dolar[velocity=<location[0,0,0].random_offset[<[spspread]>]>;pickup_delay=5t] <[splocation]> save:dollarfunc
      - define dolerrr <entry[dollarfunc].spawned_entity>
      - run dollarkill def:<[dolerrr]>

dolarspawn:
  type: task
  definitions: spamount|spspread|splocation
  script:
    - repeat <[spamount]>:
      - spawn dolar[velocity=<location[0,0,0].random_offset[<[spspread]>]>;pickup_delay=5t] <[splocation]> save:dollarfunc

dollarkill:
  type: task
  definitions: tagself
  script:
   - wait <list[10s|13s|16s|19s|22s].random>
   - if !<[tagself].is_spawned>:
     - stop
   - repeat 64:
     - playeffect effect:flame quantity:1 at:<[tagself].location> offset:0 velocity:<location[0,0,0].random_offset[0.25]>
     - playeffect effect:smoke quantity:1 at:<[tagself].location> offset:0 velocity:<location[0,0,0].random_offset[0.5]>
   - playsound at:<player.location> sound:block_fire_ambient pitch:<list[0|1|2].random> volume:0.5
   #- playsound at:<player.location> sound:entity_blaze_shoot pitch:0 volume:0.5
   - remove <[tagself]>

dolarcheck:
  type: command
  debug: false
  name: balcheck
  description: checks bal
  usage: /balcheck
  script:
    - narrate <element[¤<player.flag[money]>].color[#80FF80].bold> targets:<player>


discordnitro:
  type: command
  debug: false
  name: discordnitro
  description: removes bal
  usage: /discordnitro
  script:
    - flag <player> money:0
    - narrate <element[¤0].color[#FF8080].bold> targets:<player>

moneyzombie:
  type: entity
  entity_type: zombie

arbysblowup:
  type: world
  events:
    on moneyzombie dies:
    - run dolarspawn def:5|0.2|<context.entity.location>