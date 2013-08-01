Adding a new semester:
-generate model for "course"
-add a migration of course_id for dossier.
-do the associations
-make the seeds

Attributes of a course
:subject, :season, :seats,  #add migration when used => :tuition


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


<% @thinner.each do |dossier| %>

    <!-- wraps one -->
    <div class="thinner-wrap user-profile"> 
      
      <!-- pic and tagline below -->
      <div class="row-fluid header">
        <div class="span6" style="padding:20px;float:left;">
          
          <!-- fancybox magic -->
          <a class="fancybox" data-href="<%= dossier_path(dossier.id, :layout => "false") %>" href="#">
            <img src="http://placekitten.com/100/100" class="avatar img-circle">
          </a>

          <h3 class="name"><%= name(dossier.user) %></h3>
          <span class="area">From <%= dossier.city %></span>
          <div class="area">
            <em><%= one_hundred_forty_chars(dossier.tagline)%></em>
          </div>
        </div>
          <!-- checkboxes below -->
          <div id="pad-wrapper" class="form-page span4" style="position:relative;right:0px; float:right;">
            <div class="row-fluid form-wrapper">
              <%= form_tag thinner_decision_path(dossier.id), method:"post" do %>
                <div class="span10"><%= dossier.semester %> in New York City?</div>
                  <div class="checker span1">
                    <span>
                      <input type="checkbox">
                    </span>
                  </div>
                </div>
                <div class="span12">
                    <%= submit_tag "Reject Now", :class => "btn btn-danger"%>
                    <%= submit_tag "Review Further", :class => "btn btn-primary"%>
                </div>
              <% end %>

          </div>
      </div>

      <!-- biography below -->
      <div class="span12">
            <h3>Flatiron Purpose</h3>
            <p class="span11" style="padding:40px; margin:20px;"><%= four_hundred_twenty_chars(dossier.purpose)%></p>
      </div>

      <!-- submit tags below -->
      <%= form_tag thinner_decision_path(dossier.id), method:"post" do %>
        <div class="span12" style="margin-bottom:60px;">
            <%= submit_tag "Reject Now", :class => "btn btn-danger span6"%>
            <%= submit_tag "Review Further", :class => "btn btn-primary span6"%>
        </div>

      <% end %>
    </div>

<% end %>
</div>