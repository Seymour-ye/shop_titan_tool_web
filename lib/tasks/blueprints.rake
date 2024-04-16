namespace :blueprints do
  desc "import the blueprints from google spreadsheet and insert them to blueprints table"
  task import: :environment do
    url = "https://docs.google.com/spreadsheets/d/1WLa7X8h3O0-aGKxeAlCL7bnN8-FhGd3t7pz2RCzSg8c/export?format=xlsx"
    xls = Roo::Spreadsheet.open(url, extension: :xlsx)
    @sheet = xls.sheet('Blueprints')
    (2..@sheet.last_row).each do |row|
      @row = row
      name_en = cell_val('a')

      category = cell_val('b')
      if category == "Enchantment"
        if name_en.include?("Spirit")
          category = "spirit"
        else 
          category = "element"
        end
      else 
        category = category.downcase.split.join('_')
      end

      unlock_prerequisite = cell_val('c')
      research_scrolls = cell_val('d')
      antique_tokens = cell_val('e')
      tier = cell_val('f')
      value = cell_val('g')
      crafting_time = cell_val('h')
      merchant_xp = cell_val('k')
      worker_xp = cell_val('m')
      fusion_xp = cell_val('n')
      favor = cell_val('o')
      airship_power = cell_val('p')

      workers = {}
      worker = cell_val('r')
      workers[worker] = cell_val('s')
      worker = cell_val('t')
      workers[worker] = cell_val('u') if worker #if worker != nil
      worker = cell_val('v')
      workers[worker] = cell_val('w') if worker

      iron = cell_val('y')
      wood = cell_val('z')
      leather = cell_val('aa')
      herbs = cell_val('ab')
      steel = cell_val('ac')
      ironwood = cell_val('ad')
      fabric = cell_val('ae')
      oil = cell_val('af')
      jewels = cell_val('ah')
      ether = cell_val('ag')
      essence = cell_val('ai')

      components = {}
      component = cell_val('ak')
      quality = cell_val('al')
      amount = cell_val('am')
      components[component] = {quality: quality, amount: amount} if component
      component = cell_val('an')
      quality = cell_val('ao')
      amount = cell_val('ap')
      components[component] = {quality: quality, amount: amount} if component

      attack = cell_val('ar')
      defence = cell_val('as')
      health = cell_val('at')
      evasion = cell_val('au')
      critical_hit_chance = cell_val('av')

      elemental_affinity = cell_val('ax')
      spirit_affinity = cell_val('ay')

      Blueprint.create(name_en: name_en, category: category, 
                        unlock_prerequisite: unlock_prerequisite, 
                        research_scrolls: research_scrolls,
                        antique_tokens: antique_tokens,
                        tier: tier, value: value,
                        crafting_time: crafting_time,
                        merchant_xp: merchant_xp, worker_xp: worker_xp,
                        fusion_xp: fusion_xp, favor: favor, 
                        airship_power: airship_power,
                        workers: workers,
                        iron: iron, wood: wood, leather: leather,
                        herbs: herbs, steel: steel, ironwood: ironwood,
                        fabric: fabric, oil: oil, jewels: jewels,
                        ether: ether, essence: essence, 
                        components: components,
                        attack: attack, defence: defence, health: health,
                        evasion: evasion, 
                        critical_hit_chance: critical_hit_chance,
                        elemental_affinity: elemental_affinity,
                        spirit_affinity: spirit_affinity)
    end
  end

  desc "update the chinese translation and energy relevant attribute from xlsx and insert them to blueprints table"
  task zh_update: :environment do 
    url = Rails.root.join('lib', 'data_imports', 'zh_update.xlsx')
    xlsx = Roo::Excelx.new(url.to_s)
    @sheet = xlsx.sheet("制造蓝图")
    (2..@sheet.last_row).each do |row|
      @row = row
      name_en = cell_val('d')
      blueprint = Blueprint.find_by(name_en: name_en)
      if blueprint 
        blueprint.update(blueprint_id: cell_val('c'))
        blueprint.update(name_zh: cell_val('b'))
        blueprint.update(surcharge_energy: cell_val('bt'))
        blueprint.update(discount_energy: cell_val('bs'))
        blueprint.update(suggest_energy: cell_val('bu'))
        blueprint.update(speedup_energy: cell_val('bv'))
        blueprint.update(released_date: cell_val('g'))
      end
    end
  end

  desc "update the components information"
  task component_update: :environment do 
    Blueprint.all.each do |blueprint|
      old_comp = blueprint.components 
      new_comp = {}
      old_comp.each do |comp_name, comp_attr|
        comp = Component.find_by(name: comp_name)
        precraft = Blueprint.find_by(name_en: comp_name)
        if comp
          new_comp[comp.component_id] = comp_attr
        elsif precraft
          if precraft.category == 'runestone' || precraft.category == 'moonstone'
            new_comp['stone'] = comp_attr
            new_comp['stone'][:id] = precraft.blueprint_id
          else 
            new_comp['precraft'] = comp_attr 
            new_comp['precraft'][:id] = precraft.blueprint_id
          end 
        end
      end
      blueprint.update_attribute(:components, new_comp)
    end
  end

  def cell_val(col)
    @sheet.cell(@row,col) unless @sheet.cell(@row,col) == '---'
  end
end
