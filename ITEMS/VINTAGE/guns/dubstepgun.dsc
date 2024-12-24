dubstepgun:
  type: item
  material: iron_horse_armor
  display name: <element[Dubstep Gun].color_gradient[from=#008080;to=#80FF80]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374319
  lore:
  - <element[yoi sfx].color_gradient[from=#004040;to=#408040]>
  - <&7>
  - <element[VINTAGE].color[#404878].bold>

dubstepguntriggers:
  type: world
  events:
    on player right clicks block with:dubstepgun:
    - if !<player.has_flag[dubstepcharge]>:
      - flag <player> dubstepcharge:5
    - if <player.has_flag[dubstepcooldown]>:
      - stop
    - flag <player> dubstepcooldown expire:<player.flag[dubstepcharge].mul[4]>t
    - itemcooldown iron_horse_armor duration:<player.flag[dubstepcharge].mul[4]>t
    - define lookvec <player.eye_location.direction.vector.normalize>
    - define aimtarg <player.eye_location.ray_trace[range=<player.flag[dubstepcharge].mul[2]>;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.5]>
    - define posline <player.eye_location.points_between[<[aimtarg]>].distance[0.5]>
    - playsound <player.eye_location> sound:custom.yoi pitch:2 volume:2 custom
    - playsound <player.eye_location> sound:custom.yoi pitch:1 volume:2 custom
    - playsound <player.eye_location> sound:custom.yoi pitch:0 volume:2 custom
    - foreach <[posline]>:
      - playeffect at:<[value]> effect:note quantity:3 offset:1 visibility:100 velocity:<location[0,0,0].random_offset[0.5]>
      - if <[loop_index].mod[7]> == 4:
        - define valvec <[value].with_pitch[<player.eye_location.pitch>].with_yaw[<player.eye_location.yaw>]>
        - repeat 20 as:spinangle:
          - define xoff <[spinangle].sin.mul[<[loop_index].mul[0.1]>]>
          - define yoff <[spinangle].cos.mul[<[loop_index].mul[0.1]>]>
          - playeffect at:<[valvec].up[<[yoff]>].right[<[xoff]>]> effect:soul_fire_flame quantity:2 offset:0.2 visibility:100 velocity:<location[0,0,0].random_offset[0.1]>
      - define hittarg <[value].find.living_entities.within[<[loop_index].mul[0.1].add[1]>].exclude[<player>]||0>
      - foreach <[hittarg]> as:hitdet:
        - hurt <[hitdet]> amount:<player.flag[dubstepcharge].mul[0.75].add[1]>
        - adjust <[hitdet]> velocity:<[hitdet].velocity.add[<[lookvec].mul[<player.flag[dubstepcharge].mul[0.1]>]>]>
    - playsound <player.location> sound:entity_lightning_bolt_impact pitch:0 volume:2
    - playsound <player.location> sound:entity_lightning_bolt_thunder pitch:0 volume:2
    on player left clicks block with:dubstepgun:
    - determine cancelled passively
    - if !<player.is_sneaking>:
      - if <player.flag[dubstepcharge]> < 11:
        - flag <player> dubstepcharge:<player.flag[dubstepcharge].add[1]>
        - title "title:<element[+ <player.flag[dubstepcharge]> +].color[#80FF80].bold>" "subtitle:" fade_in:0 stay:10t targets:<player>
        - playsound <player.location> sound:block_note_block_pling pitch:2 volume:2
    - else:
      - if <player.flag[dubstepcharge]> > 1:
        - flag <player> dubstepcharge:<player.flag[dubstepcharge].sub[1]>
        - title "title:<element[- <player.flag[dubstepcharge]> -].color[#008080].bold>" "subtitle:" fade_in:0 stay:10t targets:<player>
        - playsound <player.location> sound:block_note_block_pling pitch:1 volume:2