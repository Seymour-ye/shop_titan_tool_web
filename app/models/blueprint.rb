class Blueprint < ApplicationRecord

    def name
        if I18n.locale == :zh
            self.name_zh
        else
            self.name_en
        end
    end
end
