ouroboros:
  type: item
  material: paper
  mechanisms:
    custom_model_data: 13375401
  display name: <element[Ouroboros].color_gradient[from=#FF0000;to=#40FF00]>
  lore:
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <element[It just seems to repeat itself cyclically forever].color_gradient[from=#800000;to=#208000]>
  - <&7>
  - <element[COMMUNITY].color[#587030].bold>

ouroborostriggers:
  type: world
  debug: false
  events:
    on player dies priority:-9999:
    - if <context.entity.inventory.contains_any[ouroboros]>:
      - determine cancelled passively
      - flag <context.entity> blanklastloc:<context.entity.location>
      - wait 1t
      - teleport <context.entity> <location[0,67,0,deathplane]>
      - itemcooldown paper duration:6s
      - flag <context.entity> blankused expire:6s
      - playsound sound:ENTITY_ENDER_DRAGON_GROWL pitch:0 volume:2 at:<context.entity.eye_location>
      - cast <context.entity> blindness duration:9999s amplifier:0 no_icon hide_particles no_ambient
      - wait 3s
      - title targets:<context.entity> "title:<element[WELCOME BACK].bold.color_gradient[from=#FF0000;to=#40FF00]>" fade_in:0t fade:out:10t stay:5t
      - playsound sound:entity_wither_spawn pitch:0 at:<context.entity.eye_location> volume:2
      - teleport <context.entity> <context.entity.flag[blanklastloc]>
      - flag <context.entity> blanklastloc:!
      - cast <context.entity> blindness duration:2s amplifier:1 no_icon hide_particles no_ambient
      - cast <context.entity> poison duration:3s amplifier:1 no_icon hide_particles no_ambient
      - playsound sound:ENTITY_ENDER_DRAGON_HURT pitch:0 volume:2 at:<context.entity.eye_location>