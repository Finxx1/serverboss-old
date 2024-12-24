teslastick:
  type: item
  material: stick
  display name: <element[Tesla Stick].color_gradient[from=#806020;to=#008080]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374299
  lore:
  - <element[Do not submerge the device in liquid, even partially.].color_gradient[from=#403010;to=#004040]>
  - 
  - <element[HAUNTED].color[#38F0A8].bold>

teslatriggers:
  type: world
  debug: false
  events:
    on player left clicks block with:teslastick:
    - determine cancelled passively
    - if <player.has_flag[teslacooldown]>:
      - stop
    - flag <player> teslacooldown expire:5s
    - itemcooldown stick duration:5s
    - run lightning_mgk def:<player>