thebible:
  type: item
  material: book
  display name: <element[The Bible].color_gradient[from=#FFFF80;to=#503010]>
  mechanisms:
    unbreakable: true
    hides: all
    custom_model_data: 13374261
  lore:
  - <element[Clean edition!].color_gradient[from=#808040;to=#281808]>
  - 
  - <element[COLLECTOR'S].color[#800000].bold>

thebibletriggers:
  type: world
  debug: false
  events:
    on player right clicks block with:thebible:
    - determine cancelled passively
    - if <player.has_flag[strikecooldown]>:
      - stop
    - flag <player> strikecooldown expire:5t
    - itemcooldown book duration:5t
    - define aimtarg <player.eye_location.ray_trace[range=100;return=precise;default=air;nonsolids=false;entities=*;ignore=<player>;raysize=0.5]>
    - flag <player> strikelocation:<[aimtarg]> expire:10s
    - define currentplace <player.flag[strikelocation]>
    - define plookpos <player.eye_location.pitch>
    - define ylookpos <player.eye_location.yaw>
    - run prayerlight def:<player>|<[aimtarg]>|<[currentplace]>
    #- waituntil <player.eye_location.pitch> < <[plookpos].sub[45].max[-90]> && <player.eye_location.yaw> > <[ylookpos].add[180].sub[5].mod[360].sub[180]> && <player.eye_location.yaw> < <[ylookpos].add[180].add[5].mod[360].sub[180]> max:4s
    #- if !(<player.eye_location.pitch> > <[plookpos].sub[45].max[-90]> && <player.eye_location.yaw> > <[ylookpos].add[180].sub[5].mod[360].sub[180]> && <player.eye_location.yaw> < <[ylookpos].add[180].add[5].mod[360].sub[180]>):
    #  - stop
    #- announce "<player.eye_location.pitch> < <[plookpos].sub[45].max[-90]>"
    #- announce "<[ylookpos].add[180].add[5].mod[360].sub[180]> > <player.eye_location.yaw> > <[ylookpos].add[180].sub[5].mod[360].sub[180]>"
    #- waituntil <player.eye_location.pitch> > <[plookpos].add[45].min[90]> && <player.eye_location.yaw> > <[ylookpos].add[180].sub[5].mod[360].sub[180]> && <player.eye_location.yaw> < <[ylookpos].add[180].add[5].mod[360].sub[180]> max:4s
    #- if !(<player.eye_location.pitch> > <[plookpos].add[45].min[90]> && <player.eye_location.yaw> > <[ylookpos].add[180].sub[5].mod[360].sub[180]> && <player.eye_location.yaw> < <[ylookpos].add[180].add[5].mod[360].sub[180]>):
    #  - stop
    #- announce DOWN
    
    on player left clicks block with:thebible:
    - determine cancelled passively
    - if <player.has_flag[strikecooldown]>:
      - stop
    - if !<player.has_flag[strikelocation]>:
      - stop
    - flag <player> strikecooldown expire:15s
    - itemcooldown book duration:15s
    - define strikingplace <player.flag[strikelocation]>
    - flag <player> strikelocation:!
    - strike <[strikingplace]>
    - foreach <proc[particle_ring].context[<[strikingplace]>|4|2]>:
      - wait 1t
      - strike <[value]>
    - repeat 3:
      - foreach <proc[particle_ring].context[<[strikingplace]>|8|<[value].mul[2].add[2]>]> as:place:
        - wait 1t
        - strike <[place]>

prayerlight:
  type: task
  debug: false
  definitions: prayer|aimtarg|currentloc
  script:
  - while <[prayer].has_flag[strikelocation]>:
    - playeffect at:<[aimtarg]> effect:end_rod offset:0.5 quantity:5 visibility:100
    - wait 1t
    - if <[loop_index]> > 200:
      - while stop
    - if <[currentloc]> != <[prayer].flag[strikelocation]>:
      - while stop