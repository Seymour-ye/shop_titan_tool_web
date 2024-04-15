namespace :general do
    desc "Run blueprints:import and blueprints:zh_update tasks"
    task :initialize_database do
      Rake::Task["db:reset"].invoke
      Rake::Task["components:import"].invoke
      Rake::Task["blueprints:import"].invoke
      Rake::Task["blueprints:zh_update"].invoke
      Rake::Task["data_collected:flash_quest"].invoke
      Rake::Task["data_collected:monthly_events"].invoke
      Rake::Task["data_collected:content_pass"].invoke
      Rake::Task["quests:import"].invoke
      Rake::Task["workers:import_worker"].invoke
      Rake::Task["workers:import_worker_levels"].invoke
      Rake::Task["events:flash_quest_recur_events"].invoke
      Rake::Task["events:import_from_recur_events"].invoke
  end
end
