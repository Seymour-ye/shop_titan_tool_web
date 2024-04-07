namespace :components do
  desc "import the components from google spreadsheet and insert them to blueprints table"
  task import: :environment do
    url = "https://docs.google.com/spreadsheets/d/1WLa7X8h3O0-aGKxeAlCL7bnN8-FhGd3t7pz2RCzSg8c/export?format=xlsx"
    xls = Roo::Spreadsheet.open(url, extension: :xlsx)
    @sheet = xls.sheet('Quest Components')
    (2..@sheet.last_row).each do |row|
      @row = row 
      name = cell_val('a')
      tier = cell_val('b')
      value = cell_val('c')
      get_from = cell_val('d')
      Component.create( name: name,
                        category: 'component',
                        tier: tier,
                        value: value,
                        get_from: get_from)
    end
  end
end

