rubberchicken:
  type: item
  material: stick
  display name: <element[Rubber Chicken].color_gradient[from=#C08000;to=#C04000]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374302
  lore:
  - <element[i fucking hate these].color_gradient[from=#604000;to=#602080]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

rubberchickentriggers:
  type: world
  debug: false
  events:
    on player damages entity with:rubberchicken:
    - determine 0 passively
    - adjust <context.entity> armor_bonus:<context.entity.armor_bonus.sub[1]>
    - playsound <context.entity.eye_location> sound:custom.chicken_honk volume:1 pitch:<list[0.8|1|1.2].random> custom
    on player right clicks block with:rubberchicken:
    - determine cancelled passively
    - if !<player.has_flag[chicky]>:
      - foreach <player.eye_location.find.living_entities.within[50].exclude[<player>]||0>:
#        - adjust <[value]> last_hurt_by:<player>
        - attack <[value]> target:<player>
      - playsound <player.eye_location> sound:custom.chicken_honk volume:2 pitch:<list[0.8|1|1.2].random> custom
      - flag <player> chicky expire:2s