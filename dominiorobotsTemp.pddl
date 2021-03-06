(define (domain ROBOTS)
(:requirements :typing :durative-actions)

(:types robot area arm human - object
        room hall - area
)

(:constants empty cup coffee - state)

(:predicates (at ?r - robot ?x - area)
             (cupboard_at ?r - area)
             (coffee_at ?r - area)
             (human_at ?h - human ?r - area)
             (human_has_coffee ?h - human )

             (allowed ?r - robot ?a - area)
             (near ?x - area ?y - area)
     
             (have_arm ?r - robot ?a - arm)
             (arm_state ?a - arm ?e - state)
             

)

(:functions (distance ?a1 - area ?a2 - area)
			(speed ?r - robot)
			(weightCoffee ?s - state)

)

(:durative-action move_room
    :parameters ( ?r - robot ?y - area ?x - area)
    :duration (= ?duration (/ (distance ?y ?x) (speed ?r)))
    :condition (and 
                (at start (at ?r ?x)) 
                (over all (or (near ?x ?y) (near ?y ?x))) 
                (over all (allowed ?r ?y)))
    :effect (and 
                (at start (not (at ?r ?x))) 
                (at end (at ?r ?y)))
)

(:durative-action pick_cup
    :parameters (?r - robot ?h - area ?a - arm )
    :duration (= ?duration 2)
	:condition (and 
                (over all (at ?r ?h)) 
                (over all (cupboard_at ?h)) 
                (over all (have_arm ?r ?a)) 
                (at start (arm_state ?a empty)))
    :effect (and 
                (at start (not (arm_state ?a empty))) 
                (at end (arm_state ?a cup)))
)

(:durative-action fill_cup
    :parameters (?r -robot ?h - area ?a - arm)
    :duration (= ?duration 2)
	:condition (and 
                (over all (at ?r ?h)) 
                (over all (coffee_at ?h)) 
                (over all (have_arm ?r ?a)) 
                (at start (arm_state ?a cup)))
    :effect (and 
                (at start (not (arm_state ?a cup))) 
                (at end (arm_state ?a coffee)))
)

(:durative-action give_human
    :parameters (?r -robot ?u - human ?a - arm ?h - area)
    :duration (= ?duration (weightCoffee coffee))
	:condition (and 
                (over all (at ?r ?h)) 
                (over all (human_at ?u ?h)) 
                (over all (have_arm ?r ?a)) 
                (at start (arm_state ?a coffee)))
    :effect (and 
                (at start (not (arm_state ?a coffee))) 
                (at end (arm_state ?a empty)) 
                (at end (human_has_coffee ?u)))
)

(:durative-action give_robot_cup
    :parameters (?r1 - robot ?r2 - robot ?h - area ?a1 - arm ?a2 - arm)
    :duration (= ?duration (weightCoffee cup))
	:condition (and 
                (over all (not (= ?r1 ?r2)))
                (over all (at ?r1 ?h)) 
                (over all (at ?r2 ?h)) 
                (over all (have_arm ?r1 ?a1)) 
                (over all (have_arm ?r2 ?a2)) 
                (at start (arm_state ?a1 cup)) 
                (at start (arm_state ?a2 empty)))
    :effect (and 
                (at start (not (arm_state ?a1 cup))) 
                (at end (arm_state ?a1 empty)) 
                (at start (not (arm_state ?a1 empty))) 
                (at end (arm_state ?a2 cup)))
)

(:durative-action give_robot_coffee
    :parameters (?r1 - robot ?r2 - robot  ?h - area ?a1 - arm ?a2 - arm)
    :duration (= ?duration (weightCoffee coffee))
	:condition (and 
                (over all (not (= ?r1 ?r2)))
                (over all (at ?r1 ?h)) 
                (over all (at ?r2 ?h)) 
                (over all (have_arm ?r1 ?a1)) 
                (over all (have_arm ?r2 ?a2)) 
                (at start (arm_state ?a1 coffee)) 
                (at start (arm_state ?a2 empty)))
    :effect (and 
                (at start (not (arm_state ?a1 coffee))) 
                (at end (arm_state ?a1 empty)) 
                (at start (not (arm_state ?a1 empty))) 
                (at end (arm_state ?a2 coffee)))
)

)

