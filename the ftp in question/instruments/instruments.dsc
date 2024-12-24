
banjo:
  type: item
  material: clock
  display name: <reset>Birch Banjo
  flags:
    sound: block.note_block.banjo
    custom: true
    texture: banjo
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - air|string|birch_planks
      - birch_planks|birch_planks|string
      - birch_planks|birch_planks|string
basedrum:
  type: item
  material: clock
  display name: <reset>War Drum
  flags:
    sound: block_note_block_basedrum
    texture: basedrum
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - leather|leather|leather
      - leather|oak_planks/birch_planks/spruce_planks/jungle_planks/acacia_planks/dark_oak_planks|leather
      - oak_planks/birch_planks/spruce_planks/jungle_planks/acacia_planks/dark_oak_planks|oak_planks/birch_planks/spruce_planks/jungle_planks/acacia_planks/dark_oak_planks|oak_planks/birch_planks/spruce_planks/jungle_planks/acacia_planks/dark_oak_planks
bass:
  type: item
  material: clock
  display name: <reset>Oak Bass
  flags:
    sound: block_note_block_bass
    texture: bass
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - air|string|oak_planks
      - oak_planks|oak_planks|string
      - oak_planks|oak_planks|string
bell:
  type: item
  material: clock
  display name: <reset>Golden Bell
  flags:
    sound: block_note_block_bell
    texture: bell
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - air|gold_nugget|air
      - gold_ingot|gold_ingot|gold_ingot
      - gold_ingot|gold_nugget|gold_ingot
bit:
  type: item
  material: clock
  display name: <reset>Redstone Bitbox
  flags:
    sound: block.note_block.bit
    custom: true
    texture: bit
  debug: false
chime:
  type: item
  material: clock
  display name: <reset>Diorite Chime
  flags:
    sound: block_note_block_chime
    texture: chime
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - polished_diorite|polished_diorite|polished_diorite
      - polished_diorite|iron_ingot|polished_diorite
      - polished_diorite|iron_ingot|polished_diorite
cow_bell:
  type: item
  material: clock
  display name: <reset>Cow Bell
  flags:
    sound: block.note_block.cow_bell
    custom: true
    texture: cow_bell
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - air|iron_ingot|air
      - iron_ingot|stick|iron_ingot
      - iron_ingot|air|iron_ingot
didgeridoo:
  type: item
  material: clock
  display name: <reset>Acacia Didgeridoo
  flags:
    sound: block.note_block.didgeridoo
    custom: true
    texture: didgeridoo
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - air|air|acacia_planks
      - air|acacia_planks|acacia_planks
      - acacia_planks|acacia_planks|air
flute:
  type: item
  material: clock
  display name: <reset>Dark Oak Flute
  flags:
    sound: block_note_block_flute
    texture: flute
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - air|air|dark_oak_planks
      - air|dark_oak_planks|air
      - birch_planks|air|air
guitar:
  type: item
  material: clock
  display name: <reset>Jungle Guitar
  flags:
    sound: block_note_block_guitar
    texture: guitar
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - air|string|jungle_planks
      - jungle_planks|jungle_planks|string
      - jungle_planks|jungle_planks|string
harp:
  type: item
  material: clock
  display name: <reset>Basalt Harp
  flags:
    sound: block_note_block_harp
    texture: harp
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - polished_granite|polished_granite|polished_granite
      - polished_granite|string|polished_granite
      - polished_granite|polished_granite|polished_granite
hihat:
  type: item
  material: clock
  display name: <reset>Sticks
  flags:
    sound: block_note_block_hat
    texture: hat
  debug: false
  recipes:
    1:
      type: shapeless
      input: stick|stick
iron_xylophone:
  type: item
  material: clock
  display name: <reset>Iron Xylophone
  flags:
    sound: block.note_block.iron_xylophone
    custom: true
    texture: iron_xylophone
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - polished_granite|air|iron_ingot
      - iron_ingot|iron_ingot|air
      - air|iron_ingot|polished_granite
pling:
  type: item
  material: clock
  display name: <reset>Obsidian Pling
  flags:
    sound: block_note_block_pling
    texture: pling
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - obsidian|obsidian|obsidian
      - obsidian|harp|obsidian
      - obsidian|obsidian|obsidian
xylophone:
  type: item
  material: clock
  display name: <reset>Bone Xylophone
  mechanisms:
    flag_map:
      sound: block_note_block_xylophone
      texture: xylophone
  debug: false
slap_bass:
  type: item
  material: clock
  display name: <reset>Birch Bass
  mechanisms:
    flag_map:
      sound: block.note_block.slap_bass
      custom: true
      texture: slap_bass
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - air|string|birch_planks
      - birch_planks|birch_log|string
      - birch_planks|birch_planks|string
snare:
  type: item
  material: clock
  display name: <reset>Short Drums
  mechanisms:
    flag_map:
      sound: block_note_block_snare
      texture: snare
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - leather|leather
      - oak_planks/birch_planks/spruce_planks/jungle_planks/acacia_planks/dark_oak_planks|oak_planks/birch_planks/spruce_planks/jungle_planks/acacia_planks/dark_oak_planks
cymbal_hi-hat:
  type: item
  material: clock
  display name: <reset>Iron Plate
  mechanisms:
    flag_map:
      sound: block.note_block.cymbal_hi-hat
      custom: true
      texture: cymbal_hi-hat
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - air|iron_ingot|air
      - iron_ingot|air|iron_ingot
      - air|iron_ingot|air
cymbal_splash:
  type: item
  material: clock
  display name: <reset>Golden Plate
  mechanisms:
    flag_map:
      sound: block.note_block.cymbal_splash
      custom: true
      texture: cymbal_splash
  debug: false
  recipes:
    1:
      type: shaped
      input:
      - air|gold_ingot|air
      - gold_ingot|air|gold_ingot
      - air|gold_ingot|air
instrument_error:
  type: item
  material: stick
  display name: <reset>Error
  mechanisms:
    flag_map:
      sound: custom.reload_error
      custom: true
  debug: false