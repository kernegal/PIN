(define (problem ROBOTS-1)
(:domain ROBOTS)
(:objects 
    R1 R2 - robot A11 A12 A21 A22 - arm
    ROOM1 ROOM2 ROOM3 ROOM4 - room HALL - hall
    H1 H2 H3 - human
 )
(:init 
    (at R1 ROOM1) (at R2 ROOM3)
    (have_arm R1 A11) (have_arm R1 A12)
    (have_arm R2 A21) (have_arm R2 A22)

    (arm_state A11 empty) (arm_state A12 empty)
    (arm_state A21 empty) (arm_state A22 empty)

    (allowed R1 ROOM1) (allowed R1 ROOM2) (allowed R1 HALL)
    (allowed R2 ROOM4) (allowed R2 ROOM3) (allowed R2 HALL)

    (near ROOM1 ROOM2) (near HALL ROOM1) (near HALL ROOM2) 
    (near ROOM3 ROOM4) (near HALL ROOM4) (near HALL ROOM3)

    (cupboard_at ROOM3)
    (coffee_at ROOM1)

    (human_at H1 ROOM2) (human_at H2 ROOM3) (human_at H3 ROOM4)
)
(:goal (and (human_has_coffee H1) (human_has_coffee H2) (human_has_coffee H3)))
)
