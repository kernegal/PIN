(define (domain ROBOTS)
(:requirements :typing :durative-actions :fluents)

(:types robot area arm human charger - object
        room hall - area
)

(:constants empty cup coffee - state)

(:predicates (at ?r - robot ?x - area)
             (cupboard_at ?r - area)
             (coffee_at ?r - area)
             (human_at ?h - human ?r - area)
             (human_has_coffee ?h - human)

             (allowed ?r - robot ?a - area)
             (near ?x - area ?y - area)
     
             (have_arm ?r - robot ?a - arm)
             (arm_state ?a - arm ?e - state)

			 (charger_at ?r - area)
             

)

(:functions (distance ?a1 - area ?a2 - area)
			(speed ?r - robot)
			(weightCoffee ?s - state)
			(energy ?r - robot)
			(capacity ?r - robot)
			(recharge-rate ?r - robot)
			(energy-consum ?r - robot)
			(total-energy-used)

)

(:durative-action move_room
    :parameters ( ?r - robot ?y - area ?x - area)
    :duration (= ?duration (/ (distance ?y ?x) (speed ?r)))
    :condition (and 
				(at start (at ?r ?x)) 
				(over all (or (near ?x ?y) (near ?y ?x))) 
				(over all (allowed ?r ?y))
				(at start (>= (energy ?r) (* (distance ?y ?x) (energy-consum ?r))))
				)
    :effect (and 
				(at start (not (at ?r ?x))) 
				(at end (at ?r ?y))
				(at end (increase total-energy-used (* (distance ?y ?x) (energy-consum ?r))))
				(at end (decrease (energy ?r) (* (distance ?y ?x) (energy-consum ?r))))
				)
)

(:durative-action pick_cup
    :parameters (?r - robot ?h - area ?a - arm )
    :duration (= ?duration 2)
	:condition (and 
				(over all (at ?r ?h)) 
				(over all (cupboard_at ?h)) 
				(over all (have_arm ?r ?a)) 
				(at start (arm_state ?a empty))
				(at start (>= (energy ?r) (/ (energy-consum ?r) 2)))
				)
    :effect (and 
				(at start (not (arm_state ?a empty))) 
				(at end (arm_state ?a cup))
				(at end (increase total-energy-used (/ (energy-consum ?r) 2)))
				(at end (decrease (energy ?r) (/ (energy-consum ?r) 2)))
				)
)

(:durative-action fill_cup
    :parameters (?r -robot ?h - area ?a - arm)
    :duration (= ?duration 2)
	:condition (and 
				(over all (at ?r ?h)) 
				(over all (coffee_at ?h)) 
				(over all (have_arm ?r ?a)) 
				(at start (arm_state ?a cup))
				(at start (>= (energy ?r) (/ (energy-consum ?r) 2)))
				)
    :effect (and 
				(at start (not (arm_state ?a cup))) 
				(at end (arm_state ?a coffee))
				(at end (increase total-energy-used (/ (energy-consum ?r) 2)))
				(at end (decrease (energy ?r) (/ (energy-consum ?r) 2)))
				)
)

(:durative-action give_human
    :parameters (?r -robot ?u - human ?a - arm ?h - area)
    :duration (= ?duration (weightCoffee coffee))
	:condition (and 
				(over all (at ?r ?h)) 
				(over all (human_at ?u ?h)) 
				(over all (have_arm ?r ?a)) 
				(at start (arm_state ?a coffee))
				(at start (>= (energy ?r) (/ (energy-consum ?r) 2)))
				)
    :effect (and 
				(at start (not (arm_state ?a coffee))) 
				(at end (arm_state ?a empty)) 
				(at end (human_has_coffee ?u))
				(at end (increase total-energy-used (/ (energy-consum ?r) 2)))
				(at end (decrease (energy ?r) (/ (energy-consum ?r) 2)))
				)
)

(:durative-action give_robot_cup
    :parameters (?r1 - robot ?r2 - robot ?h - area ?a1 - arm ?a2 - arm)
    :duration (= ?duration (weightCoffee cup))
	:condition (and 
				(over all (at ?r1 ?h)) 
				(over all (at ?r2 ?h)) 
				(over all (have_arm ?r1 ?a1)) 
				(over all (have_arm ?r2 ?a2)) 
				(at start (arm_state ?a1 cup)) 
				(at start (arm_state ?a2 empty))
				(at start (>= (energy ?r1) (/ (energy-consum ?r1) 2)))
				(at start (>= (energy ?r2) (/ (energy-consum ?r2) 2)))
				)
    :effect (and 
				(at start (not (arm_state ?a1 cup))) 
				(at end (arm_state ?a1 empty)) 
				(at start (not (arm_state ?a1 empty))) 
				(at end (arm_state ?a2 cup))
				(at end (increase total-energy-used (+ (/ (energy-consum ?r1) 2) (/ (energy-consum ?r2) 2))))
				(at end (decrease (energy ?r1) (/ (energy-consum ?r1) 2)))
				(at end (decrease (energy ?r2) (/ (energy-consum ?r2) 2)))
				)
)

(:durative-action give_robot_coffee
    :parameters (?r1 - robot ?r2 - robot  ?h - area ?a1 - arm ?a2 - arm)
    :duration (= ?duration (weightCoffee coffee))
	:condition (and 
				(over all (at ?r1 ?h)) 
				(over all (at ?r2 ?h)) 
				(over all (have_arm ?r1 ?a1)) 
				(over all (have_arm ?r2 ?a2)) 
				(at start (arm_state ?a1 coffee)) 
				(at start (arm_state ?a2 empty))
				(at start (>= (energy ?r1) (/ (energy-consum ?r1) 2)))
				(at start (>= (energy ?r2) (/ (energy-consum ?r2) 2)))
				)
    :effect (and 
				(at start (not (arm_state ?a1 coffee))) 
				(at end (arm_state ?a1 empty)) 
				(at start (not (arm_state ?a1 empty))) 
				(at end (arm_state ?a2 coffee))
				(at end (increase total-energy-used (+ (/ (energy-consum ?r1) 2) (/ (energy-consum ?r2) 2))))
				(at end (decrease (energy ?r1) (/ (energy-consum ?r1) 2)))
				(at end (decrease (energy ?r2) (/ (energy-consum ?r2) 2)))
				)
)

(:durative-action recharge
	:parameters (?r - robot ?h - area)
	:duration (= ?duration (/ (- (capacity ?r) (energy ?r)) (recharge-rate ?r)))
	:condition (and
				;;(at start (< (energy ?r) (/ (capacity ?r) 2)))
				(over all (at ?r ?h))
				(over all (charger_at ?h))
				)
	:effect (at end (assign (energy ?r) (capacity ?r)))				
)

)

