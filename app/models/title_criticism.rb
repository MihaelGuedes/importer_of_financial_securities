class TitleCriticism < ApplicationRecord
  serialize :assignors_protests, Array
  serialize :drawees_protests, Array
end
