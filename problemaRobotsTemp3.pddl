(define (problem ROBOTS-3)
(:domain ROBOTS)
(:objects 
    R1 - robot A11 A12 - arm
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

	(= (weightCoffee empty) 0)
	(= (weightCoffee cup) 1)
	(= (weightCoffee coffee) 2)

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
(:metric minimize (total-time))
)
