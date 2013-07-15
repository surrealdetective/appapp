Things to Do

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