(define (problem ROBOTS-1)
(:domain ROBOTS)
(:objects 
    R1 - robot A11 A12 - arm
    ROOM1 ROOM2 ROOM3 ROOM4 - room HALL - hall
    H1 H2 - human
 )
(:init 
    (at R1 ROOM1)
    (have_arm R1 A11) (have_arm R1 A12)


    (arm_state A11 empty) (arm_state A12 empty)

    (allowed R1 ROOM1) (allowed R1 ROOM2) (allowed R1 HALL)
    (allowed R1 ROOM3) (allowed R1 ROOM4) 

    (near ROOM1 ROOM2) (near HALL ROOM1) (near HALL ROOM2) 
    (near ROOM3 ROOM4) (near HALL ROOM4) (near HALL ROOM3)

    (cupboard_at ROOM3)
    (coffee_at ROOM1)

    (human_at H1 ROOM2) (human_at H2 ROOM3)
)
(:goal (and (human_has_coffee H1) (human_has_coffee H2)))
)
