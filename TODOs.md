# TODOs

(first of all, this should be in trello; acknowledged.)

## sidebar for logged in applicants

- link to prework
- link to flatironschool.com
- link to @flatironschool

## new dossier form when already logged in

should hide the new user stuff

## seeds

- currently take a full minute to run. surely there's a way to make it more efficient?

## thinner indexholder

Do:
Logic for checking if they are in NYC.
Grab more than one student
Add padding to div class user-profile, or margin to div class content
Show the view for more than one student
Link the reject and Review Further to the correct actions

## misc

- do a big find and replace to remove trailing white space?
- add password field to new dossier
- allow possibility of other_links containing multiple links. split on newline
- add borders or seperators to thinner

* * *

Some scratchpad stuff:

Course Topic permissions

can :manage, Topic, :course_id => user.teaching_course_ids

## user-facing analytics

when you log in, we want to tell you the average time spent in this status

steps:

- check what status they're at
- look up all dossier_statuses of the same type
- reject all the ones that are STILL in that type

eg:

- they're in "new"
- find all dossier_statuses with status = "new"
- check that statuses's dossieR_id
- find the next dossier_status with that same idea
- IF there is another, it might still be there, in which case discount it
- 



* * *

new table:

id | status       | avg_time_in | count | course_id
1  | new          | 75          | 2     |
2  | needs_review | 0           | 0     |

Steps:
create table.
a model... and it's called, "avg_time"

association check!

After enter a state, find the created_at for the dossier_status
Then, find the dossier_status[-2]'s created_at
Then calculate the time between statuses

or
before entering a state, find the Time.now
Then, find the current dossier status' created_at time
Calcualte the time between Time.now and created_at time.


cache this data daily




