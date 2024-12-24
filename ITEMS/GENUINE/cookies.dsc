heartcookie:
  type: item
  material: cookie
  mechanisms:
    custom_model_data: 13375200
  display name: <element[Heart Cookie].color_gradient[from=#FF0020;to=#C00018]>
  lore:
  - <element[So fruity and loving].color_gradient[from=#800010;to=#60000C]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

diamondcookie:
  type: item
  material: cookie
  mechanisms:
    custom_model_data: 13375202
  display name: <element[Diamond Cookie].color_gradient[from=#C06060;to=#804040]>
  lore:
  - <element[So sweet and friendly].color_gradient[from=#603030;to=#402020]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

spadecookie:
  type: item
  material: cookie
  mechanisms:
    custom_model_data: 13375201
  display name: <element[Spade Cookie].color_gradient[from=#404040;to=#202020]>
  lore:
  - <element[So bitter and hateful].color_gradient[from=#202020;to=#101010]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>

clubscookie:
  type: item
  material: cookie
  mechanisms:
    custom_model_data: 13375203
  display name: <element[Clubs Cookie].color_gradient[from=#808080;to=#606060]>
  lore:
  - <element[So smooth and helpful].color_gradient[from=#404040;to=#303030]>
  - <&7>
  - <element[GENUINE].color[#206030].bold>


suitcookieseat:
  debug: false
  type: world
  events:
    on player consumes heartcookie:
    - feed <player> amount:-2
    - heal <player> amount:10
    - cast <player> regeneration duration:600t amplifier:2 no_icon hide_particles no_ambient
    on player consumes spadecookie:
    - feed <player> amount:-2
    - adjust <player> absorption_health:<player.absorption_health.add[2]||2>
    - cast <player> increase_damage duration:600t amplifier:1 no_icon hide_particles no_ambient
    on player consumes diamondcookie:
    - feed <player> amount:-2
    - cast <player> damage_resistance duration:60t amplifier:1 no_icon hide_particles no_ambient
    - adjust <player> armor_bonus:<player.armor_bonus.add[2]>
    on player consumes clubscookie:
    - feed <player> amount:4
    - foreach <player.inventory.list_contents.filter_tag[<server.flag[loot_genuine].contains_any[<[filter_value].script.name>]>]||0>:
      - if <[value].script.name> != clubscookie && <[value].script.name> != ironkey:
        - repeat <[value].quantity.mul[2]> as:reps:
          - give <[value].script.name> quantity:1 to:<player.inventory>