wrench:
  type: item
  material: blaze_rod
  display name: <element[Wrench].color[#A4A4A4]>
  mechanisms:
    hides: all
    custom_model_data: 13374200
  lore:
  - <element[For changing command block limits].color[#525252]>
  - <&7>
  - <element[DEVELOPER].color[#525252].bold>

magnifyingglass:
  type: item
  material: blaze_rod
  display name: <element[Magnifying Glass].color[#A4A4A4]>
  mechanisms:
    hides: all
    custom_model_data: 13374201
  lore:
  - <element[For finding command blocks].color[#525252]>
  - <&7>
  - <element[DEVELOPER].color[#525252].bold>

gear:
  type: item
  material: paper
  display name: <element[Gear].color[#A4A4A4]>
  mechanisms:
    hides: all
    custom_model_data: 13375403
  lore:
  - <element[Server panel].color[#525252]>
  - <&7>
  - <element[DEVELOPER].color[#525252].bold>

securitycheck:
  type: world
  debug: false
  events:
#    on player right clicks block with:magnifyingglass:
#    - foreach <player.location.find>
    on command:
    - if <context.source_type> == COMMAND_BLOCK:
#      - announce <paper.tick_times.get[1].in_milliseconds>
      - if <context.command_block_location.block.flag[cmd_type]||limited> == unlimited:
        - stop
      - if <context.command_block_location.block.flag[cmd_type]||limited> == locked:
        - determine cancelled
      - if <context.command_block_location.block.flag[cmd_type]||limited> == panic:
        - if <paper.tick_times.get[1].in_milliseconds> >= 100:
          - determine cancelled passively
          - flag <context.command_block_location.block> cmd_type:locked
          - announce <element[⚠ ].color[#A400A4]><element[Command block at ].color[#A452A4]><element[x&at<context.command_block_location.block.x> y&at<context.command_block_location.block.y> z&at<context.command_block_location.block.z> w&at<context.command_block_location.block.world.name>].unescaped.bold.color[#FFFFFF]><element[ locked due to low tickrates!].color[#A452A4]>
        - stop
      - if <context.command_block_location.block.has_flag[haltandcatchfire]>:
        - determine cancelled
      - if <context.command_block_location.block.flag[cmdratelimit]||0> > 75:
        - announce <element[⚠ ].color[#A40000]><element[Command block at ].color[#A45252]><element[x&at<context.command_block_location.block.x> y&at<context.command_block_location.block.y> z&at<context.command_block_location.block.z> w&at<context.command_block_location.block.world.name>].unescaped.bold.color[#FFFFFF].on_click[/ex teleport <context.command_block_location>]><element[ halted due to overstress!].color[#A45252]>
        - determine cancelled passively
        - flag <context.command_block_location.block> haltandcatchfire expire:40t
#        - flag <context.command_block_location.block> cmd_type:locked
        - if <context.command_block_location.block.above[1].block.material.name> == air:
          - modifyblock <context.command_block_location.block.above[1]> fire no_physics
        - playsound <context.command_block_location> sound:custom.reload_error volume:2 pitch:1 custom
        - playsound <context.command_block_location> sound:entity_generic_explode volume:2 pitch:1
        - playeffect at:<context.command_block_location> effect:flash quantity:1 visibility:100 offset:0
      - flag <context.command_block_location.block> cmdratelimit:<context.command_block_location.block.flag[cmdratelimit].add[1]||0> expire:10t
    on player right clicks block with:wrench:
    - determine cancelled passively
    - if <list[command_block|repeating_command_block|chain_command_block].contains_any[<context.location.material.name>]>:
      - choose <context.location.block.flag[cmd_type]||limited>:
        - case limited:
          - announce <element[Command block at ].color[#A4A4A4]><element[x&at<context.location.block.x> y&at<context.location.block.y> z&at<context.location.block.z> w&at<context.location.block.world.name>].unescaped.bold.color[#FFFFFF]><element[ type changed to ].color[#A4A4A4]><element[unlimited].bold.color[#FFFFFF]>
          - flag <context.location.block> cmd_type:unlimited
        - case unlimited:
          - announce <element[Command block at ].color[#A4A4A4]><element[x&at<context.location.block.x> y&at<context.location.block.y> z&at<context.location.block.z> w&at<context.location.block.world.name>].unescaped.bold.color[#FFFFFF]><element[ type changed to ].color[#A4A4A4]><element[locked].bold.color[#FFFFFF]>
          - flag <context.location.block> cmd_type:locked
        - case locked:
          - announce <element[Command block at ].color[#A4A4A4]><element[x&at<context.location.block.x> y&at<context.location.block.y> z&at<context.location.block.z> w&at<context.location.block.world.name>].unescaped.bold.color[#FFFFFF]><element[ type changed to ].color[#A4A4A4]><element[panic].bold.color[#FFFFFF]>
          - flag <context.location.block> cmd_type:panic
        - case panic:
          - announce <element[Command block at ].color[#A4A4A4]><element[x&at<context.location.block.x> y&at<context.location.block.y> z&at<context.location.block.z> w&at<context.location.block.world.name>].unescaped.bold.color[#FFFFFF]><element[ type changed to ].color[#A4A4A4]><element[limited].bold.color[#FFFFFF]>
          - flag <context.location.block> cmd_type:limited
        - default:
          - flag <context.location.block> cmd_type:unlimited