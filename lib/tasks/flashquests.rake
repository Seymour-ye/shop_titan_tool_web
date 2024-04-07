namespace :flashquests do
  desc "import flashquests from data_collected and insert into database"
  task import: :environment do
    url = Rails.root.join('lib', 'data_imports', 'data_collected.xlsx')
    xlsx = Roo::Excelx.new(url.to_s)
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

end
