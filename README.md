- add password field to new dossier
- dossier#show 
    - hide comments from applicant
    - make sections collapsible
    - remove permissions to see /dossiers and /dossiers/:id except their own

- add icons to stat nav
- add nav to top bar
- add borders or seperators to thinner
- merge thinner and application layouts
- fix needs_interview route, restful
- double login button on login page
- name and email shouldn't show up on dossier#new when the person is logged in already


## cancan 

**hello**

## Scratch pad

```ruby
<%= form_tag dossiers_path, :method => "get" do %>
  <%= select_tag "sort_by", "<option>user</option><option>date</option>".html_safe %>
  <%= submit_tag "Sort now!", :class => "btn" %>
  <%= link_to "filters", dossiers_filter_by_path("all"), :class => "btn" %>
<% end %>
```

#PERMISSIONS

##Plan by Alex

cloned Avi's repo for ex: https://github.com/aviflombaum/mixtapeapp

It has 3 parts:

1. Adds a model - a join table between the user and the item with multiple permissions. In our case, user and dossier.

2. Adds migration - for the join table model, it has 2 foreign ids, plus a permissions column.

3. Defines the Permission levels - the join model has a set permission method, followed by different levels of permissions, with a constant at the top defining the persmission levels by integers.

4. Defines current_user_can? (action, object) method in the application controller, which is called appropriately in other controllers to restrict access.

##Plan 2 by Alex

watched 192 Authorization with CanCan RAILSCASTS. Much simpler:

1. Install Gemfile
2. Ability Model - defines users by role
3. Restrict views - "can ?"
4. Restrict controllers - "unauhtorizable", "load_and_authorize_resource" - finds restful object and appropriately authorizes it. (if you can only read, then you cannot update) [optional :nested=> :article] to load comment thru article.