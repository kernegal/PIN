(define (domain ROBOTS)
(:requirements :typing)

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

(:action move_room
    :parameters ( ?r - robot ?y - area ?x - area)
    :precondition (and 
                (at ?r ?x) 
				(or (near ?x ?y) 
					(near ?y ?x)) 
				(allowed ?r ?y))
    :effect(and 
                (not (at ?r ?x)) 
				(at ?r ?y))
)

(:action pick_cup
    :parameters (?r -robot ?h - area ?a - arm)
    :precondition (and 
                    (at ?r ?h) 
					(cupboard_at ?h) 
					(have_arm ?r ?a) 
					(arm_state ?a empty))
    :effect(and 
                (not (arm_state ?a empty)) 
				(arm_state ?a cup))
)

(:action fill_cup
    :parameters (?r -robot ?h - area ?a - arm)
    :precondition (and 
                    (at ?r ?h) 
					(coffee_at ?h) 
					(have_arm ?r ?a) 
					(arm_state ?a cup))
    :effect(and 
                (not (arm_state ?a cup)) 
				(arm_state ?a coffee))
)

(:action give_human
    :parameters (?r -robot ?h - area ?a - arm ?u - human)
    :precondition (and 
                    (at ?r ?h) 
					(human_at ?u ?h) 
					(have_arm ?r ?a) 
					(arm_state ?a coffee))
    :effect(and (not 
                (arm_state ?a coffee)) 
				(arm_state ?a empty) 
				(human_has_coffee ?u))
)

(:action give_robot_cup
    :parameters (?r1 - robot ?r2 - robot ?h - area ?a1 - arm ?a2 - arm)
    :precondition (and 
                    (not (= ?r1 ?r2))
                    (at ?r1 ?h) 
					(at ?r2 ?h) 
					(have_arm ?r1 ?a1) 
					(have_arm ?r2 ?a2) 
					(arm_state ?a1 cup) 
					(arm_state ?a2 empty))
    :effect(and 
                (not (arm_state ?a1 cup)) 
				(arm_state ?a1 empty) 
				(not (arm_state ?a1 empty)) 
				(arm_state ?a2 cup))
)

(:action give_robot_coffee
    :parameters (?r1 - robot ?r2 - robot ?h - area ?a1 - arm ?a2 - arm)
    :precondition (and 
                    (not (= ?r1 ?r2))
                    (at ?r1 ?h) 
					(at ?r2 ?h) 
					(have_arm ?r1 ?a1) 
					(have_arm ?r2 ?a2) 
					(arm_state ?a1 coffee) 
					(arm_state ?a2 empty))
    :effect(and 
                (not (arm_state ?a1 coffee)) 
				(arm_state ?a1 empty) 
				(not (arm_state ?a1 empty)) 
				(arm_state ?a2 coffee))
)



)


