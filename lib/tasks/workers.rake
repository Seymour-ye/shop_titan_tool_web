namespace :workers do
  desc "import the workers information from google spreadsheet and insert them to blueprints table"
  url = "https://docs.google.com/spreadsheets/d/1WLa7X8h3O0-aGKxeAlCL7bnN8-FhGd3t7pz2RCzSg8c/export?format=xlsx"
  xls = Roo::Spreadsheet.open(url, extension: :xlsx)

  task import_worker: :environment do
    @sheet = xls.sheet('Workers')
    (2..@sheet.last_row).each do |row|
      @row = row 
      name = cell_val('b')
      worker_category = cell_val('a')
      unlock_merchant_level = cell_val('c')
      gold_cost = cell_val('e')
      gem_cost = cell_val('f')
      Worker.create(name: name, worker_category: worker_category,
                    unlock_merchant_level: unlock_merchant_level,
                    gold_cost: gold_cost, gem_cost: gem_cost)
    end
  end

  desc "import worker levels information from google spreadsheet and insert into database"
  task import_worker_levels: :environment do 
    @sheet = xls.sheet('Worker Levels')
    (2..@sheet.last_row).each do |row|
      @row = row
      worker_level = cell_val('a')
      xp_needed = cell_val('b')
      crafting_speed_bonus = cell_val('c')

      WorkerLevel.create(worker_level: worker_level,
                         xp_needed: xp_needed,
                         crafting_speed_bonus: crafting_speed_bonus)
    end
  end

end
