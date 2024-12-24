femboyhelmet:
  type: item
  material: golden_helmet
  display name: <element[Fembuoy(sic) Helmet].color_gradient[from=#FF00FF;to=#FF80C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374200
  lore:
  - <element[Protects from magic attacks, also pretty].color_gradient[from=#800080;to=#804060]>
  - <&7>
  - <element[UNIQUE].color[#FFEF10].bold>

femboychestplate:
  type: item
  material: diamond_chestplate
  display name: <element[Fembuoy(sic) Chestplate].color_gradient[from=#FF00FF;to=#FF80C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374201
  lore:
  - <element[Protects from magic attacks, also fabulous].color_gradient[from=#800080;to=#804060]>
  - <&7>
  - <element[UNIQUE].color[#FFEF10].bold>

femboyleggings:
  type: item
  material: golden_leggings
  display name: <element[Fembuoy(sic) Leggings].color_gradient[from=#FF00FF;to=#FF80C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374201
  lore:
  - <element[Protects from magic attacks, also pimped out].color_gradient[from=#800080;to=#804060]>
  - <&7>
  - <element[UNIQUE].color[#FFEF10].bold>

femboyboots:
  type: item
  material: golden_boots
  display name: <element[Fembuoy(sic) Boots].color_gradient[from=#FF00FF;to=#FF80C0]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374201
  lore:
  - <element[Protects from magic attacks, also splendid].color_gradient[from=#800080;to=#804060]>
  - <&7>
  - <element[UNIQUE].color[#FFEF10].bold>

femboyarmortrigger:
  type: world
  debug: false
  events:
    on player damaged by MAGIC:
    - if <context.entity.inventory.contains_any[femboyhelmet|femboychestplate|femboyleggings|femboyboots]>:
      - define result <context.damage>
      - if <context.entity.has_equipped[femboyhelmet]>:
        - define result <[result].mul[0.7]>
      - if <context.entity.has_equipped[femboychestplate]>:
        - define result <[result].mul[0.5]>
      - if <context.entity.has_equipped[femboyleggings]>:
        - define result <[result].mul[0.6]>
      - if <context.entity.has_equipped[femboyboots]>:
        - define result <[result].mul[0.8]>
      - determine <[result]>