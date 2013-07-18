#Themes
--how do you have a custom background for the new user page?
----set it to root, make a new resource, then re-reference it? (nooo)
----wait for ashley.

1. Integrate Index Page
2. Integrate Form Page
3. 

#Things to Do

1. Comments
2. Emailer
3. Themes

# Comments
1. Where does it belong?
- Dossier model
-- bc when dossier being passed btwn flatiron teachers, comments are on the dossier.

1st Draft:
migration for dossier
to add t.text :comment

2nd Draft:
migration for comment

dossier_id:integer
content:text
#user_id add this later.



# Things to Do

## dashboard

random icebox idea: see the applicants on a map

users should have an admin_notes text_area where adam can write what he thinks about them, which can later be searched. maybe a "favorites" / "bookmark" / "star" feature

- admin dashboard
    - filter by...
        - location
        - gender?
        - status
    - search for applicants
    - sort applicants by...
        - name
        - last_dossier.created_at
        - number of dossiers

1. sort by status (esp. reviewed)
--try to find through User class
----make join table btwn user and status class
----

User.where(status.state == "reviewed")

User.where(:name => "Alex Au")

UserStatus.where(:status_id => "3") #where 3=="reviewed"

Status.where(:state =>"reviewed").collect{|status| status.user}

User.all_in_review # method we could write

User.all.keep_if{|user| user.statuses.last.state == "reviewed"} # should work?

User.all.keep_if{|user| user.statuses.any?{|status| status.state == "reviewed" }}

