fastscrollguns:
  type: world
  debug: false
  events:
    on player scrolls their hotbar:
    - if <player.inventory.list_contents.get[<context.previous_slot>].material.name||0> == iron_horse_armor:
      - cast <player> fast_digging amplifier:10 duration:3t no_icon no_ambient hide_particles 