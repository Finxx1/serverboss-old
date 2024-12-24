hat:
  type: item
  material: paper
  display name: <element[hat].color[#000000]>
  mechanisms:
    custom_model_data: 13375524
    hides: all
  lore:
  - <element[hat].color[#000000]>
  - <&8>
  - <element[HAT].color[#000000].bold>

hattriggers:
  type: world
  debug: false
  events:
    on entity drops hat:
    - determine cancelled passively