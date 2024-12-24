hpreset:
  type: item
  material: diamond
  display name: <element[HP Reset].color[#A4A4A4]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13375200
    hides: all
  lore:
  - <element[Resets max hp].color[#525252]>
  - <&7>
  - <element[DEVELOPER].color[#525252].bold>

chestreset:
  type: item
  material: diamond
  display name: <element[Chest Reset].color[#A4A4A4]>
  mechanisms:
    unbreakable: true
    custom_model_data: 13375201
    hides: all
  lore:
  - <element[Resets loot chest generation].color[#525252]>
  - <&7>
  - <element[DEVELOPER].color[#525252].bold>

mgrape:
  type: item
  material: clay_ball
  display name: <element[medium grape].color[#525252]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374252
  lore:
  - <element[youre not supposed to have this item it does nothing].color[#808080]>
  - <&7>
  - <element[DEVELOPER].color[#525252].bold>

sgrape:
  type: item
  material: clay_ball
  display name: <element[small grape].color[#525252]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374253
  lore:
  - <element[youre not supposed to have this item it does nothing].color[#808080]>
  - <&7>
  - <element[DEVELOPER].color[#525252].bold>

earth:
  type: item
  material: clay_ball
  display name: <element[earth].color[#525252]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374300
  lore:
  - <element[youre not supposed to have this item it does nothing].color[#808080]>
  - <&7>
  - <element[DEVELOPER].color[#525252].bold>

mars:
  type: item
  material: clay_ball
  display name: <element[earth].color[#525252]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374301
  lore:
  - <element[youre not supposed to have this item it does nothing].color[#808080]>
  - <&7>
  - <element[DEVELOPER].color[#525252].bold>

venus:
  type: item
  material: clay_ball
  display name: <element[earth].color[#525252]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374302
  lore:
  - <element[youre not supposed to have this item it does nothing].color[#808080]>
  - <&7>
  - <element[DEVELOPER].color[#525252].bold>

moon:
  type: item
  material: clay_ball
  display name: <element[earth].color[#525252]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374303
  lore:
  - <element[youre not supposed to have this item it does nothing].color[#808080]>
  - <&7>
  - <element[DEVELOPER].color[#525252].bold>

duriannails:
  type: item
  material: clay_ball
  display name: <element[durian nail].color[#525252]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374255
  lore:
  - <element[youre not supposed to have this item it does nothing].color[#808080]>
  - <&7>
  - <element[DEVELOPER].color[#525252].bold>

devtriggers:
  type: world
  events:
    on player right clicks block with:hpreset:
    - adjust <player> max_health:20
    on player right clicks block with:chestreset:
    - flag <player> gennedchests:!