class Scene <ActiveRecord::Base
    validates_uniqueness_of :order, scope: :project_id, conditions: -> {where.not(order: nil)}
    belongs_to :project
end