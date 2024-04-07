namespace :events do
    desc "import events for 5 years from recursive events"
    task import_from_recur_events: :environment do
      RecursiveEvent.all.each do |rec_event|
        event_schedule = IceCube::Schedule.new(rec_event.start_time)
        event_schedule.add_recurrence_rule(IceCube::Rule.from_yaml(rec_event.recurrence))
        event_schedule.occurrences(Time.zone.now + 5.years.next).each do |occurence_time|
          Event.create(name: rec_event.name, 
                    category: rec_event.category,
                    start_time: occurence_time, 
                    end_time: occurence_time + rec_event.duration,
                    icon_url: rec_event.icon_url)
        end
      end
    end
  
    task flash_quest_recur_events: :environment do 
      FlashQuest.all.each do |flashquest|
        category = "flash_quest"
        name = "Lv.#{flashquest.unlock_merchant_level}"
        start_time = 1.year.ago
        recurrence_rule = IceCube::Rule.monthly.day_of_month(flashquest.day_of_month).to_yaml
        icon_url = flashquest.reward_icon
        RecursiveEvent.create(name: name,
                              category: category,
                              start_time: start_time,
                              duration: 1,
                              icon_url: icon_url,
                              recurrence: recurrence_rule)
      end
    end
  end