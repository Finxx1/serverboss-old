hypercube:
  type: item
  material: light_blue_stained_glass
  display name: <element[Hypercube].color_gradient[from=#00FFFF;to=#0000FF]>
  mechanisms:
    unbreakable: true
    hides: all
  lore:
  - <element[Places across dimensions].color_gradient[from=#008080;to=#000080]>

hypercubetriggers:
  type: world
  debug: false
  events:
    on player places block:
    #- if <player.item_in_hand||0> == <script[hypercube]>:
    #  - modifyblock <context.location.with_world[<Superflat>]> light_blue_stained_glass
    #  - modifyblock <context.location.with_world[<empty>]> light_blue_stained_glass
    #  - modifyblock <context.location.with_world[<world>]> light_blue_stained_glass
    - flag server placelogs:<element[<list[<server.flag[placelogs]>|<list[<element[LOC - <context.location>   NEW - <context.material.name>   OLD - <context.old_material.name>   BY - <&l><player.name>]>]>].combine>]>

cubelogs:
    debug: false
    type: command
    name: cubelogs
    description: "i dont like mojang branded spyware so i made my own homebrew"
    aliases:
    - clog
    usage: /cubelogs
    script:
    - narrate <element[<server.flag[placelogs].get[<context.raw_args>]>&nllog index <&a><context.raw_args> &fs <server.flags[placelogs].size>].unescaped> targets:<player> 