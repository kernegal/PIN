(define (problem ROBOTS-1)
(:domain ROBOTS)
(:objects 
    R1 R2 R3 - robot A11 A12 A21 A22 A31 A32 - arm
    ROOM1 ROOM2 ROOM3 ROOM4 - room HALL - hall
    H1 H2 - human
 )
(:init 
	(= (distance ROOM1 ROOM2) 50)
	(= (distance ROOM1 HALL) 50)
	(= (distance ROOM2 ROOM1) 50)
	(= (distance ROOM2 HALL) 50)
	(= (distance HALL ROOM1) 50)
	(= (distance HALL ROOM2) 50)
	(= (distance HALL ROOM3) 50)
	(= (distance HALL ROOM4) 50)
	(= (distance ROOM3 ROOM4) 50)
	(= (distance ROOM3 HALL) 50)
	(= (distance ROOM4 ROOM3) 50)
	(= (distance ROOM4 HALL) 50)

	(= (speed R1) 20)
	(= (speed R2) 30)
	(= (speed R3) 50)

	(= (weightCoffee empty) 0)
	(= (weightCoffee cup) 1)
	(= (weightCoffee coffee) 2)

    (at R1 ROOM1) (at R2 ROOM3) (at R3 ROOM2)
    (have_arm R1 A11) (have_arm R1 A12)
    (have_arm R2 A21) (have_arm R2 A22)
    (have_arm R3 A31) (have_arm R3 A32)

    (arm_state A11 empty) (arm_state A12 empty)
    (arm_state A21 empty) (arm_state A22 empty)
    (arm_state A31 empty) (arm_state A32 empty)

    (allowed R1 ROOM1) (allowed R1 ROOM2) (allowed R1 HALL)
    (allowed R2 ROOM4) (allowed R2 ROOM3) (allowed R2 HALL)
    (allowed R3 ROOM3) (allowed R3 ROOM2) (allowed R3 HALL)

    (near ROOM1 ROOM2) (near HALL ROOM1) (near HALL ROOM2) 
    (near ROOM3 ROOM4) (near HALL ROOM4) (near HALL ROOM3)

    (cupboard_at ROOM3)
    (coffee_at ROOM1)

    (human_at H1 ROOM2) (human_at H2 ROOM3)
)
(:goal (and (human_has_coffee H1) (human_has_coffee H2)))
)
