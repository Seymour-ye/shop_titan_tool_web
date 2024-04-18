class Event < ApplicationRecord
    def img_url
        "#{self.icon_url}.png"
    end
end
