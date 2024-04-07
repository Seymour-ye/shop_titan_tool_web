# Set Up
1. Rails projects use `sqlite` by default, change it to `postgres` by setting:
```
$ rails new app_name --database=postgresql 
```
2. Database setup
```
$ rake db:setup
```

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

# Duration (ActiveSupport::Duration)
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

# Simple Calendar & Ice Cube 
1. Simple Calendar is a gem for calendars showing events, examples could be found in `app/views/calendars/show.html.erb`
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