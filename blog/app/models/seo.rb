class Seo < ApplicationRecord
  belongs_to :seoable, polymorphic: true

  DEFAULT_TITLE = 'Superblog'
  DEFAULT_DESCRIPTION = 'Main Description'
  DEFAULT_ROBOTS = 'all'
end
