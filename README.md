# theming

## What I did (max):

- added better_errors gem at everyone's recommendation on piazza (run bundle install to make sure you have it)
- added `/vendor/assets/font` to the asset path in `/config/environments/development.rb`
- restructured the vendor assets
    - removed redundant assets. kept the scss over css because they're more readable
    - edited many of the vendor files wherever they referenced other files. they all had relative paths but the asset pipeline flattens much of that and breaks references
- added vendor javascripts to the `application.js` manifest file
- added a `title` helper method to `/app/helpers/application_helper.rb` to return a different title depending on context (right now it always returns the same title, but we can use this now)
- removed body tags from all views except the global layout. there were some pages with multiple body tags
- added `@body_classes` to the body class. this lets us set that global variable string to whatever we want in a controller and know that it will affect the body's class. an example is "login-bg", a class we want the body to have in one context, but not all
- created a second global layout called "dashboard" and made the dossiers controller default to it. having two global layouts makes sense to me but maybe with different names or something. this layout has a navbar by default. left the generic navbar from the demo

* * *

## misc ideas

- see the applicants on a map
- search
- favorite / bookmark / star applicants
    - could fit into a workflow

* * *

# prior theming notes

- how do you have a custom background for the new user page?
    - set it to root, make a new resource, then re-reference it? (nooo)
    - wait for ashley.

1. Integrate Index Page
2. Integrate Form Page