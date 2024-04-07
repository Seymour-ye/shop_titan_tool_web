namespace :quests do
  desc "import the quests from google spreadsheet and insert them to blueprints table"
  task import: :environment do
    url = "https://docs.google.com/spreadsheets/d/1WLa7X8h3O0-aGKxeAlCL7bnN8-FhGd3t7pz2RCzSg8c/export?format=xlsx"
    xls = Roo::Spreadsheet.open(url, extension: :xlsx)
    @sheet = xls.sheet('Quests')
    @row = 1
    while @row <= @sheet.last_row 
      if @sheet.row(@row).all?(&:nil?) #empty line
        @row += 1
      #region header
      elsif cell_val('e') == nil 
        region = cell_val('b')
        max_party_size = cell_val('h')
        reward_type = @sheet.cell(@row+1, 'h').split('/')
        unlock_cost_gold = (cell_val('k') ? cell_val('k') : 0)
        unlock_cost_gem = (@sheet.cell(@row+1, 'k') == '---' ? 0 : @sheet.cell(@row+1, 'k'))
        unlock_level_merchant = (cell_val('n') ? cell_val('n') : 0)
        @row += 3
      # entry
      else
        difficulty = cell_val('b')
        target = (cell_val('c') ? cell_val('c') : "component" )
        min_power = (cell_val('d') ? cell_val('d') : 0 )
        quest_time = ChronicDuration.parse(cell_val('f'))
        rest_time = ChronicDuration.parse(cell_val('g'))
        heal_time = ChronicDuration.parse(cell_val('h'))

        r = cell_val('l').split[0]
        min_item = r.split('-')[0]
        max_item = r.split('-')[1]

        monster_health = cell_val('m')
        monster_dmg = cell_val('n')
        monster_aoe = cell_val('o')

        barrier_health = cell_val('q')

        bar_des = cell_val('p')
        bar_des = bar_des.split(',') if bar_des

        comp1 = component_string_parse(cell_val('i'))
        comp2 = component_string_parse(cell_val('j'))
        comp3 = component_string_parse(cell_val('k'))

        if target == "Boss" 
          barrier_type = bar_des
          components = {}
          components[comp1[0]] = {min_amount: comp1[1],
                            max_amount: comp1[2]} if comp1
          components[comp2[0]] = {min_amount: comp2[1],
                            max_amount: comp2[2]} if comp2
          components[comp3[0]] = {min_amount: comp3[1],
                            max_amount: comp3[2]} if comp3
          Quest.create(region: region, reward_type: reward_type,
                      max_party_size: max_party_size,
                      unlock_cost_gem: unlock_cost_gem,
                      unlock_cost_gold: unlock_cost_gold,
                      unlock_level_merchant: unlock_level_merchant,
                      difficulty: difficulty, target: target,
                      min_power: min_power, quest_time: quest_time,
                      rest_time: rest_time, heal_time: heal_time,
                      components: components, min_item: min_item,
                      max_item: max_item, monster_aoe: monster_aoe,
                      monster_dmg: monster_dmg, monster_health:monster_health,
                      barrier_health: barrier_health, barrier_type: barrier_type)
        else
          bar_des = [nil, nil, nil] if !bar_des
          components = {}
          components[comp1[0]] = {min_amount: comp1[1],
                            max_amount: comp1[2]} if comp1
          barrier_type = bar_des[0]
          Quest.create(region: region, reward_type: reward_type,
                      max_party_size: max_party_size,
                      unlock_cost_gem: unlock_cost_gem,
                      unlock_cost_gold: unlock_cost_gold,
                      unlock_level_merchant: unlock_level_merchant,
                      difficulty: difficulty, target: target,
                      min_power: min_power, quest_time: quest_time,
                      rest_time: rest_time, heal_time: heal_time,
                      components: components, min_item: min_item,
                      max_item: max_item, monster_aoe: monster_aoe,
                      monster_dmg: monster_dmg, monster_health:monster_health,
                      barrier_health: barrier_health, barrier_type: barrier_type)

          components = {}
          components[comp2[0]] = {min_amount: comp2[1],
                            max_amount: comp2[2]} if comp2
          barrier_type = bar_des[1]
          if !components.empty?
            Quest.create(region: region, reward_type: reward_type,
                          max_party_size: max_party_size,
                          unlock_cost_gem: unlock_cost_gem,
                          unlock_cost_gold: unlock_cost_gold,
                          unlock_level_merchant: unlock_level_merchant,
                          difficulty: difficulty, target: target,
                          min_power: min_power, quest_time: quest_time,
                          rest_time: rest_time, heal_time: heal_time,
                          components: components, min_item: min_item,
                          max_item: max_item, monster_aoe: monster_aoe,
                          monster_dmg: monster_dmg, monster_health:monster_health,
                          barrier_health: barrier_health, barrier_type: barrier_type)
          end 
          components = {}
          components[comp3[0]] = {min_amount: comp3[1],
                            max_amount: comp3[2]} if comp3
          barrier_type = bar_des[2]
          if !components.empty?
            Quest.create(region: region, reward_type: reward_type,
                        max_party_size: max_party_size,
                        unlock_cost_gem: unlock_cost_gem,
                        unlock_cost_gold: unlock_cost_gold,
                        unlock_level_merchant: unlock_level_merchant,
                        difficulty: difficulty, target: target,
                        min_power: min_power, quest_time: quest_time,
                        rest_time: rest_time, heal_time: heal_time,
                        components: components, min_item: min_item,
                        max_item: max_item, monster_aoe: monster_aoe,
                        monster_dmg: monster_dmg, monster_health:monster_health,
                        barrier_health: barrier_health, barrier_type: barrier_type)
          end 
        end
        @row += 1
      end
    end
  end

  def component_string_parse(s)
    return nil if !s
    des = s.split
    amount = des[0].split('-')
    min_amount = amount[0]
    max_amount = amount[1]
    comp_name = des[1..].join(' ')
    return [comp_name, min_amount, max_amount]
  end

  def cell_val(col)
    @sheet.cell(@row,col) unless @sheet.cell(@row,col) == '---'
  end
end
