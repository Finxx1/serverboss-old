# thanks Annuit Coeptis#0657 on discord for this
particle_ring:
    debug: false
    type: procedure
    definitions: center|points|radius
    script:
        - define degrees <element[360].div[<[points]>]>
        - define radians <util.list_numbers_to[<[points]>].parse[mul[<[degrees]>].to_radians]>
        - define x_values <[radians].parse[cos.mul[<[radius]>].add[<[center].x>]]>
        - define z_values <[radians].parse[sin.mul[<[radius]>].add[<[center].z>]]>
        - repeat <[points]>:
            - define particle_locations:->:<[center].with_x[<[x_values].get[<[value]>]>].with_z[<[z_values].get[<[value]>]>]>
        - determine <[particle_locations]>
