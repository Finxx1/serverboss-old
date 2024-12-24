necrozombie:
  type: entity
  entity_type: zombie

necrospider:
  type: entity
  entity_type: spider

necroskele:
  type: entity
  entity_type: skeleton

cageofwrath:
  type: item
  material: spawner
  display name: <element[Cage of Wrath].color_gradient[from=#204020;to=#204060]>
  mechanisms:
    unbreakable: true
    hides: all
  lore:
  - <element[Necromancy!].color_gradient[from=#102010;to=#102030]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

cagetriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:cageofwrath:
    - determine cancelled passively
    - if !<player.has_flag[spawnercooldown]>:
      - flag <player> spawnercooldown expire:15s
      - itemcooldown spawner duration:15s
      - random:
        - run spawnzombies def:<player>
        - run spawnspiders def:<player>
        - run spawnskeletons def:<player>
    on necrozombie targets player:
    - determine cancelled
    on necroskele targets player:
    - determine cancelled
    on necrospider targets player:
    - determine cancelled


spawnzombies:
  type: task
  definitions: thesummoner
  script:
  - playsound at:<[thesummoner].eye_location> sound:entity_evoker_prepare_summon pitch:1 volume:2
  - playeffect effect:flame at:<[thesummoner].eye_location> offset:2 quantity:25 visibility:100
  - define aroundme <[thesummoner].location.find.living_entities.within[15].exclude[<[thesummoner]>]>
  #- announce <[aroundme]>
  - repeat 5:
    - spawn necrozombie[age=adult] <[thesummoner].location.random_offset[4,0,4].find.surface_blocks.within[4].first.above> save:zombiespawn2
    - define attacked <[aroundme].random>
    #- announce <[attacked]>
    - define sus <entry[zombiespawn2].spawned_entity>
    - attack <[sus]> target:<[attacked]>

spawnspiders:
  type: task
  definitions: thesummoner
  script:
  - playsound at:<[thesummoner].eye_location> sound:entity_evoker_prepare_summon pitch:1 volume:2
  - playeffect effect:flame at:<[thesummoner].eye_location> offset:2 quantity:25 visibility:100
  - define aroundme <[thesummoner].location.find.living_entities.within[15].exclude[<[thesummoner]>]>
  #- announce <[aroundme]>
  - repeat 5:
    - spawn necrospider <[thesummoner].location.random_offset[4,0,4].find.surface_blocks.within[4].first.above> save:zombiespawn2
    - define attacked <[aroundme].random>
    #- announce <[attacked]>
    - define sus <entry[zombiespawn2].spawned_entity>
    - attack <[sus]> target:<[attacked]>

spawnskeletons:
  type: task
  definitions: thesummoner
  script:
  - playsound at:<[thesummoner].eye_location> sound:entity_evoker_prepare_summon pitch:1 volume:2
  - playeffect effect:flame at:<[thesummoner].eye_location> offset:2 quantity:25 visibility:100
  - define aroundme <[thesummoner].location.find.living_entities.within[15].exclude[<[thesummoner]>]>
  #- announce <[aroundme]>
  - repeat 5:
    - spawn necroskele[age=adult] <[thesummoner].location.random_offset[4,0,4].find.surface_blocks.within[4].first.above> save:zombiespawn2
    - define attacked <[aroundme].random>
    #- announce <[attacked]>
    - define sus <entry[zombiespawn2].spawned_entity>
    - attack <[sus]> target:<[attacked]>