# Set Up
1. Rails projects use `sqlite` by default, change it to `postgres` by setting:
```
$ rails new app_name --database=postgresql 
```
2. Database setup
```
$ rake db:setup
```
### DEBUG =====> `<% binding.b %>`

# PostgreSQL
Access the `psql console` by
```
$ psql
```
If faild, try restart postgres
```
$ brew services restart postgresql
```
If database could not be found, try
```
psql postgres
```

# Roo (import data) 
Check https://github.com/roo-rb/roo for more details.
1. add gem `roo` to Gemfile and install
```
$ bundle add roo
```
2. for google spreadsheets, add gem `roo-google`
```
$ bundle add roo-google
```
3. Generate task for import data
```
$ rails g task task_name import
```
4. Google spreadsheet URL 
```
url = "https://docs.google.com/spreadsheets/d/file_code/export?format=xlsx"
xls = Roo::Spreadsheet.open(url, extension: :xlsx)
```
## Working with sheet
1. Access to the file
```
xls.sheet['sheetname'].row(row_number)
xls.sheet[sheetindex].column(col_number)
```
where `sheetname` is provided as a string, `sheetindex` starts from `0` to `sheet_number - 1`
2. Set default sheet
```
xls.default_sheet = xls.sheets.last
xls.default_sheet = xls.sheets[-1]
xls.default_sheet = 'sheet_name'
```
3. Accessing to Cells
```
sheet.cell(1,1)
sheet.cell('A',1)
sheet.cell(1,'A')
sheet.a1

sheet.cell(1,'A',sheet.sheets[1])     # Access the second sheet's top-left cell.
```
4. Accessing rows and columns
```
sheet.row(row_number)           # starting from 1
sheet.column(column_number)     # starting from 1
```
5. Getting sheet info: index of first & last row & column
```
sheet.first_row(sheet.sheets[0])
sheet.last_row
sheet.first_column
sheet.last_column
```
6. Useful methods
```
xlsx.excelx_type(3, 'C')
# => :numeric_or_formula

xlsx.cell(3, 'C')
# => 600000383.0

xlsx.excelx_value(row,col)
# => '600000383'

xlsx.formatted_value(row,col)
# => '0600000383'
```
### Iterate through data
1. Sheets
```
ods.each_with_pagename do |name, sheet|
  p sheet.row(1)
end
```
2. Rows
```
xlsx.each_row do |row|
  ...
end
```

# Duration 
## ActiveSupport::Duration
1. Create a new duration
```
dur = ActiveSupport::Duration.build(num_of_seconds)
```
2. Access to the duration information
```
dur.parts           #=> A hash
dur.parts[:hours]
dur.parts[:minutes]
dur.parts[:seconds]
```
## ChronicDuration
1. add the gem
```
$ bundle add chronic_curation
```
2. parse the string
```
>> time_string = "10 mins"
>> seconds = ChronicDuration.parse(time_string)
=> 600
```

# Hash Processing
1. Define hash
```
>   resources = {wood: 5}
=>  {:wood=>5}
>   resources = {'iron': 5}
=>  {:iron=>5}
>   resource['wood'] = 3
=>  {:iron=>5, "wood"=>3}
>   resource[:wood] = 3
=>  {:iron=>5, "wood"=>3, :wood=> 3}
```
2. Check if a key in hash
```
>   resources.key?(:iron)
=>  true
>   resources.key?('iron')
=>  false
>   resources.key?(:wood)
=>  true
>   resources.key?('wood')
=>  true
```
3. Hash keys
```
>> resource = {}
>> resource['wood'] = 3
>> resource
=> {"wood"=>3}
>> resource['iron'.to_sym] = 5
>> resource
=> {"wood"=>3, :iron=>5}
```


# Simple Calendar & Ice Cube 
1. Simple Calendar is a gem for calendars showing events, examples could be found in `app/views/calendars/index.html.erb`
2. Ice Cube is a gem for handling recursive events, examples could be found in `lib/tasks/events`
3. Events duration should be set as `n+1` in case 1-day event won't showing in the occurrence day and the day after, for example:
```
duration = 3.days + 1     # 4-day event
```
4. To customize calendar, modify files in `app/views/simple_calendar/` after running
```
rails g simple_calendar:views
```
5. Set Time Zone
If want to set the time zone globally, set the following in `config/application.rb`:
```
config.time_zone = 'Central Time (US & Canada)'
```

# i18n
1. Set up
```
$ bundle add rails-i18n
```
then in `config/application.rb` set
```
config.i18n.available_locales = [:en, :zh]
config.i18n.default_locale = :en
```
2. Now files in `config/locales/` will work, translations should be stored here, if any other position is using for 
storing language file, should add the following in `config/application.rb`
```
I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]       # adding 'project_root/lib/locale/*.yml'
```
3. Use `i18n` in views, like in `_navigation.html.erb`
4. Local in URL: `localhost:3000/en/calendar`
set default url options and make sure locale is updated before each action, in `controllers/application_controller.rb`:
```
before_action :set_locale

private

def set_locale
  I18n.locale = params[:locale] || I18n.default_locale
end

def default_url_options
    { locale: I18n.locale }
end
```
and add `scope` in `config/routes.rb`, remember to deal with the special case: home page:
```
scope ":locale" do 
    get '/calendar', to: 'calendar#index'
    ...
    resources :blueprints
    root to: "static_pages#home", as: :localized_root
end 
root to: redirect("/#{I18n.locale}", status: 302)
```
Use `localized_root_path` instead of `root_path`.

5. Set locale by browser preference
Step4 will redirect `localhost:3000` to `localhost:3000/default_locale`, if want locale set by users' preference,
in `app/controllers/application_controller.rb`, change:
```
before_action :set_locale

private

def set_locale
  I18n.locale = params[:locale] || I18n.default_locale
end
```
to 
```
around_action :switch_locale

private

def switch_locale(&action)
  logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
  locale = extract_locale_from_accept_language_header
  logger.debug "* Locale set to '#{locale}'"
  I18n.with_locale(locale, &action)
end

def extract_locale_from_accept_language_header
  request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
end
```
**Note**: keep the `default_url_options` method, otherwise routes will not work properly.

# Deploying
1. Login
```
$ fly auth login
```
2. Launch a new app on fly.io
```
$ fly launch
```
3. Deploying updates
```
$ fly deploy
```
4. Useful commands
```
$ fly apps restart        # restart the app
$ fly ssh console         # access to the console
$ fly apps open           # open the root path of deployed app in browser
```


# Problems
## Whitespace above Navigation bar
### Description
With the structure
```
<html>
  <head>
    ...
  </head>
  <body>
    <%= render 'layouts/navigation' %>
    <%= yield %>
  </body>
</html>
```
There appears white-space above the nav-bar, inside `html` but outside of `body', wasn't able to remove by
```
html, body {
  margin: 0;
  padding: 0;
}
```
Same problem in Chrome and Safari.
### Solving
None of answers found online helped, so asked chatGPT for a CSS reset code to reset all browser defaults, deleting each tag a time to locate.
```
/* Reset default browser styles */
html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed,
figure, figcaption, footer, header, hgroup,
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
  margin: 0;
  padding: 0;
  border: 0;
  font-size: 100%;
  font: inherit;
  vertical-align: baseline;
}

/* HTML5 display-role reset for older browsers */
article, aside, details, figcaption, figure,
footer, header, hgroup, menu, nav, section {
  display: block;
}

body {
  line-height: 1;
}

ol, ul {
  list-style: none;
}

blockquote, q {
  quotes: none;
}

blockquote:before, blockquote:after,
q:before, q:after {
  content: '';
  content: none;
}

table {
  border-collapse: collapse;
  border-spacing: 0;
}

```

### Result
reset `ul` margin since
```
/*  user agent stylesheet */
ul {
    display: block;
    list-style-type: disc;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 40px;
    unicode-bidi: isolate;
}
```

## Switching Locale
### Description
`locale` is set in url options and scoped in form of `localhost:3000/en/blueprints` and will set defaultly by browser default, while adding button for users to switch locale, it failed to do so since `params[:locale]` will set back to the `locale` value before this action since the url becomes `localhost:3000/en/blueprints?locale=zh`.
### Solving
1. With `localhost:3000/en/blueprints?locale=zh`, I think `params[:locale]` is correctly passed by `params`, but since with this url, there are **2 locale values** passed, and `params[:locale]` is replaced by `en` after getting `zh` as its value.
2. Console logs showing my assumption is correct, when the button is clicked, `params[:locale]` is set to `zh`, and then replaced by `en` due to locale settings.
3. With William's help, I decided to handle locale changes with session, which is reasonable: When a user visits the first time, `locale` will be set to user's browser default, once the user click on switching language button, `locale` is set to `session`.
### Solution
1. If locale handled by session, `locale` in url will not work anymore, then scoping could be removed. 
2. URL of ALL pages would remain the same with different locales.
3. Removed locale scope and `localized_root_path` in `routes.rb`
4. Changed Path to `localized_root_path` to `root_path`.
5. Removed `default_url_options` in `application_controller.rb`
6. Should move switch locale button to nav bar.

## Header preload
### Description
Got this warning message:
> The resource http://localhost:3000/assets/application-eda55435df3b9385974c23342a8ac80ac010272673a829df638338aed54fe933.css was preloaded using link preload but not used within a few seconds from the window's load event. Please make sure it has an appropriate as value and it is preloaded intentionally.
### Solution
As mentioned in [this link](https://stackoverflow.com/questions/72753525), this should be only about performance, adding the following in `development.rb` will solve this problem:
```
config.action_view.preload_links_header = false
```
**Note:** It works for now and might be needed in production as well, but don't know what will be affected yet.

## Assets Precompile
### Description
While trying to solve the fly.io asset problem, I tried to ran
``` 
$ rails assets:precompile
```
and this result in local asset changes won't apply unless I compile again
### Solve
As mentioned in [this link](https://stackoverflow.com/questions/12762939), rails will access to `public/assets` if exists.
### Solution
Remove contents in `public/assets` will solve this problem, which could be done by
```
$ rake tmp:cache:clear
```

# TODO LIST
- component filter: pre-crafts
- sort by: 
  - Worker Level: options: workers
  - Event: favor, airship power
  - Operating: value, merchant_xp 
- deloy the app on fly.io
- blueprint view in index
- display correct info about each blueprint in `_blueprint`
- display all information about each blueprint in `blueprint#show`
- Calendar: Boss Quest Refresh Count Down

## Done
- draft models for data import
- import from google spreadsheet (blueprints, ....)
- header navigation bar
- remove white-space above nav bar
- add a calendar for events 
- add flash quests for calendar testing
- set up i18n
- test i18n with flash quest
- set up i18n related configurations
- set locale by browser preference
- navigation bar showing current page
- finished Calendar translation
- bug-fix: locale keep setting to browser default
- basic filter added
- Calendar name of the month showing the next month(bug fixed: using month as index so skipped index 0 in translation list)
- add task for import monthly events and content pass
- Calendar: finished
- js event listener not loaded until refresh (bug fixed: turbo load)
- basic filter added
- filter: select all & select none features
- filter: resource selection
- filter: stick on top, minor css changes
- filter: test on resource filtering (bugfix: must_have ||=>&&)
- add a switch/button for language change
  - remove locale scope
- filter: components selection

