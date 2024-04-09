namespace :data_collected do

  url = Rails.root.join('lib', 'data_imports', 'data_collected.xlsx')
  xlsx = Roo::Excelx.new(url.to_s)

  desc "import flashquests from data_collected and insert into database"
  task flash_quest: :environment do
    @sheet = xlsx.sheet("FlashQuests")
    (2..@sheet.last_row).each do |i|
      @row = i 
      day_of_month = cell_val('a')
      unlock_merchant_level = cell_val('b')
      name = cell_val('c')
      rewards = cell_val('d')
      reward_icon = cell_val('e')

      FlashQuest.create(day_of_month: day_of_month,
                    unlock_merchant_level: unlock_merchant_level,
                    name: name,
                    rewards: rewards,
                    reward_icon: reward_icon)
    end
  end

  desc "import monthly events from data_collected and insert into database"
  task monthly_events: :environment do
    @sheet = xlsx.sheet("MonthlyEvents")
    (2..@sheet.last_row).each do |i|
      @row = i 
      category = cell_val('a')
      start_time = cell_val('b')
      duration = (ChronicDuration.parse(cell_val('c')) - 1.day).to_i + 1
      recurrence_rule = IceCube::Rule.daily(28).to_yaml 
      icon_url = cell_val('e')
      

      RecursiveEvent.create(category: category,
                    start_time: start_time,
                    duration: duration,
                    icon_url: icon_url,
                    recurrence: recurrence_rule)
    end
  end

  desc "import content pass from data_collected and insert into database"
  task content_pass: :environment do
    @sheet = xlsx.sheet("ContentPass")
    (2..@sheet.last_row).each do |i|
      @row = i 
      category = "content_pass"
      name = cell_val('a')
      start_time = cell_val('b')
      end_time = cell_val('c')
      icon_url = cell_val('d')

      Event.create(name: name,
                  category: category,
                  start_time: start_time,
                  end_time: end_time,
                  icon_url: icon_url)
    end
  end

end
