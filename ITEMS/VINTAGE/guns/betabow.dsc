betabow:
  type: item
  material: golden_hoe
  display name: <element[Beta Bow].color[#905838]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374201
  lore:
  - <element[Pshwoo].color[#404040]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

betabowtriggers:
  type: world
  events:
    on player right clicks block with:betabow:
    - determine cancelled passively
    - choose <player.gamemode>:
      - case CREATIVE:
        - playsound <player.location> sound:custom.classic_bow_shoot volume:1 custom
        - shoot arrow origin:<player.eye_location.right[0.4].below[0.4]> speed:1.5 shooter:<player> spread:5
      - default:
        - if <player.inventory.contains_item[arrow]>:
          - take item:arrow quantity:1 from:<player.inventory>
          - playsound <player.location> sound:custom.classic_bow_shoot volume:1 custom
          - shoot arrow origin:<player.eye_location.right[0.4].below[0.4]> speed:1.5 shooter:<player> spread:5