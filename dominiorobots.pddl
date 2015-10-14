(define (domain ROBOTS)
(:requirements :typing)

(:types robot area arm human furniture - object
        room hall - area
        cupboard cofee - furniture
)

(:constants empty cup cofee - state)

(:predicates (at ?r - robot ?x - area)
             (cupboard_at ?r - room)
             (cofee_at ?r - room)
             (human_at ?r - room)

             (allowed ?r - robot ?a - area)
             (near ?x - area ?y - area)
     
             (have_arm ?r - robot ?a - arm)
             (arm_state ?a - arm ?e - state)
             

)

(:action move_room
    :parameters ( ?r - robot ?y - area)
    :precondition (and (at ?r ?x) (near ?x ?y) (allowed ?r ?y))
    :effect (and (not (at ?r ?x)) (at ?r ?y))
)

(:action pick_cup
    :parameters (?r -robot)
    :precondition (and (at ?r ?h) (cupboard_at ?r) (have_arm ?r ?a) (arm_state ?a empty))
    :effect(and (not (arm_state ?a empty)) (arm_state ?a cup))
)

(:action fill_cup
    :parameters (?r -robot)
    :precondition (and (at ?r ?h) (cofee_at ?r) (have_arm ?r ?a) ((arm_state ?a cup))
    :effect(and (not ((arm_state ?a cup)) (arm_state ?a cofee))
)

(:action give_human
    :parameters (?r -robot)
    :precondition (and (at ?r ?h) (human_at ?r) (have_arm ?r ?a) (arm_state ?a cofee))
    :effect(and (not (arm_state ?a cofee)) (arm_state ?a empty))
)

(:action give_robot_cup
    :parameters (?r1 - robot ?r2 - robot)
    :precondition (and (at ?r1 ?h) (at ?r2 ?h) (have_arm ?r1 ?a1) (have_arm ?r2 ?a2) (arm_state ?a1 cup) (arm_state ?a2 empty))
    :effect(and (not (arm_state ?a1 cup)) (arm_state ?a1 empty) (not (arm_state ?a1 empty)) (arm_state ?a2 cup))
)

(:action give_robot_cofee
    :parameters (?r1 - robot ?r2 - robot)
    :precondition (and (at ?r1 ?h) (at ?r2 ?h) (have_arm ?r1 ?a1) (have_arm ?r2 ?a2) (arm_state ?a1 cofee) (arm_state ?a2 empty))
    :effect(and (not (arm_state ?a1 cofee)) (arm_state ?a1 empty) (not (arm_state ?a1 empty)) (arm_state ?a2 cofee))
)



)


