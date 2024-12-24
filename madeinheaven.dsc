mihcommand:
  debug: false
  type: world
  events:
    on player chats:
    - if <context.message> = "MADE IN HEAVEN" || <context.message> = "MIH":
      # SHUT THE FUCK UP
      - determine cancelled passively
      - adjust <player> skin_blob:ewogICJ0aW1lc3RhbXAiIDogMTY3NTg2OTA1MzU4MywKICAicHJvZmlsZUlkIiA6ICIwZDZjODU0ODA3ZGQ0NWZkYmMxZDEyMzY2OGY1ZWQwZiIsCiAgInByb2ZpbGVOYW1lIiA6ICJXcWxmZnhJcmt0IiwKICAic2lnbmF0dXJlUmVxdWlyZWQiIDogdHJ1ZSwKICAidGV4dHVyZXMiIDogewogICAgIlNLSU4iIDogewogICAgICAidXJsIiA6ICJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2ZmZDJkM2Q2ZDEwYjE3MzgwNDYyMGJiYjdkYmRiNjk2ZTFiNmIzOTJjMmM5ZDg0N2Y1ZDUzM2U3OWYwNWMzNDYiCiAgICB9CiAgfQp9;bB3CbtQLILMKfHn5WRFmOrCj5jGckhbkIFR9hVmH+XMw6wXLVkIM2MCJDkI6x2DIoQDnvLTWRiAkKLGfQEsH/SSeCD5TlkLhhO8xRo8DURnEFfCK7p7iPW7ghhUq6x3gWnb9tVhzPzA7OrFI0973g4g16RK+k+wEs0nnYwjge8GPZJ1SXFqlAXPfSEHUWrnTDgs3W8tENpCxFAf5NwY3ZgcuJ6u0DgFo0inA0FMxitB/mMfT2DKcRbIKr58T+fteVPSeawX3HAyaGybx2S54N3kq/v8P8LkKvPJAx6cmd5aJLbYgoVF314KFKXAKHmxiW0Js2qm6HJhp4tE8+ZPoxE17WEe30TzjQTiSjnCa0Xdte1N/kJz01Z0g/TnQH9m3B4RLJmaUrqSrXHy70wtfztNJW2qdBdMA5DgLxsYxN+8Bfzr8jZS8Kgiq+BLOaTopVSIF8dxjtMuFY7NOq5Q1yi8aGWpInliuRFU/NjjcSQTsRiD6pfE7miSIIUVIAhwY0bJe4UGsGdSEE3cHGHwzEisT8ScRF5FsEMRUYjZqlO0C1JTnNZpZbb0HAEGauaASrzdab4AGykCUmy71EZY98YAjx9N7RE0wNxGJPSujU74aLrpE72MH51njJvg4+Kzw+NSUu/Eed62x/ASbPdhR3aGfIZaPhCBrKVmkHModq2U=
      - stop
      - modifyblock <player.location.sub[0,2,0]> end_gateway
      - adjustblock <player.location.sub[0,2,0]> age:-90000000
      - adjustblock <player.location.sub[0,2,0]> exit_portal:<player.location.add[0,10,0]>
      - adjustblock <player.location.sub[0,2,0]> is_exact_teleport:true
      - stop
      - spawn phantom[size=5] <player.location> save:giantdragon
      - define bigassmf <entry[giantdragon].spawned_entity>
      - mount <player>|<[bigassmf]>
      - wait 5t
      - while <player.is_inside_vehicle>:
        - adjust <[bigassmf]> is_aware:false
        - adjust <[bigassmf]> velocity:<player.velocity.mul[0.9].add[<player.eye_location.direction.vector.normalize.mul[1]>]>
        - look <[bigassmf]> yaw:<player.eye_location.yaw> pitch:<player.eye_location.pitch.mul[-0.2]>
        - attack <[bigassmf]> cancel
        - wait 1t
      - adjust <[bigassmf]> velocity:<[bigassmf].velocity.mul[3]>
      - wait 5t
      - explode <[bigassmf].location> power:2 source:<player>
      - wait 3t
      - remove <[bigassmf]>

minosbeams:
  debug: false
  definitions: setloc
  type: task
  script:
  - spawn ender_dragon <[setloc]> save:beams
  - define minosdeath <entry[beams].spawned_entity>
  - kill <[minosdeath]>
  #- while <[minosdeath].is_spawned>:
    #- teleport <[minosdeath]> <[setloc]>
    #- run madeinheaven def:<player>

bulletgrid:
  debug: false
  definitions: setloc|xwidth|yheight|zdepth|scaley|scalex|scalez
  type: task
  script:
  - repeat <[xwidth]> as:xcord:
    - repeat <[yheight]> as:ycord:
      - repeat <[zdepth]> as:zcord:
        - spawn snowball[gravity=false] <[setloc].add[<[xcord].sub[<[xwidth].div[2]>].mul[<[scalex]>]>,<[ycord].sub[<[yheight].div[2]>].mul[<[scaley]>]>,<[zcord].sub[<[zdepth].div[2]>].mul[<[scalez]>]>]>

phantomrider:
  debug: false
  definitions: playersel
  type: task
  script:
  - spawn phantom[size=5] <[playersel].location> save:giantdragon
  - define bigassmf <entry[giantdragon].spawned_entity>
  - mount <[playersel]>|<[bigassmf]>
  - wait 5t
  - while <[playersel].is_inside_vehicle>:
    - adjust <[bigassmf]> is_aware:false
    #- adjust <[bigassmf]> velocity:<[playersel].velocity.mul[0.9].add[<[playersel].eye_location.direction.vector.normalize.mul[1]>]>
    - fly <[bigassmf]> controller:<[playersel]>
    - look <[bigassmf]> yaw:<[playersel].eye_location.yaw> pitch:<[playersel].eye_location.pitch.mul[-0.2]>
    - attack <[bigassmf]> cancel
    - wait 1t
  - adjust <[bigassmf]> velocity:<[bigassmf].velocity.mul[3]>
  - wait 5t
  - explode <[bigassmf].location> power:2 source:<[playersel]>
  - wait 3t
  - remove <[bigassmf]>

madeinheaven:
  debug: false
  type: task
  definitions: pucci
  script:
  - title targets:<player> "title:<&d><&l>KILLER" fade_in:0t stay:5s
  - wait 8t
  - title targets:<player> "title:<&d><&l>KILLER QUEEN" fade_in:0t stay:5s
  - wait 8t
  - title targets:<player> "title:<&d><&l>KILLER QUEEN" "subtitle:<&5><&o>HAS" fade_in:0t stay:5s
  - wait 2t
  - title targets:<player> "title:<&d><&l>KILLER QUEEN" "subtitle:<&5><&o>HAS ALREADY" fade_in:0t stay:5s
  - wait 2t
  - title targets:<player> "title:<&d><&l>KILLER QUEEN" "subtitle:<&5><&o>HAS ALREADY TOUCHED" fade_in:0t stay:5s
  - wait 2t
  - title targets:<player> "title:<&d><&l>KILLER QUEEN" "subtitle:<&5><&o>HAS ALREADY TOUCHED THAT" fade_in:0t stay:5s
  - wait 2t
  - title targets:<player> "title:<&d><&l>KILLER QUEEN" "subtitle:<&5><&o>HAS ALREADY TOUCHED THAT CHAT" fade_in:0t stay:5s
  - wait 2t
  - title targets:<player> "title:<&d><&l>KILLER QUEEN" "subtitle:<&5><&o>HAS ALREADY TOUCHED THAT CHAT COMMAND!" fade_in:0t stay:5s
  - wait 20t
  - explode <player.location> power:3
  - kill <player>
