class Parameter < ApplicationRecord
  belongs_to :user
  belongs_to :cargapp_model
  validates :name, :code, uniqueness: true
  validates :name, :code, :value, :user_id, presence: true
  validates :cargapp_model_id, uniqueness: { scope: [:value] }

  before_create :default_values
  def default_values
    self.active ||= false
  end

end
