destructioncatalyst:
  type: item
  material: paper
  display name: <element[Destruction Catalyst].color_gradient[from=#C00000;to=#FFC040]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13375523
  lore:
  - <element[Burn].color_gradient[from=#600000;to=#806020]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

destructiontriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:destructioncatalyst:
    - determine cancelled passively
    - itemcooldown paper duration:120t
    - flag <player> destcooldown expire:120t