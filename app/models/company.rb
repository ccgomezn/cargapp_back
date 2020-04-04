# frozen_string_literal: true

class Company < ApplicationRecord
  belongs_to :load_type
  belongs_to :user
  has_many :company_users, dependent: :destroy
  has_one_attached :image
  validates :identify, uniqueness: true
  validates :identify, :name, :company_type, :load_type_id, presence: true
  validates :user_id, uniqueness: { scope: %i[name identify] }
  validates :name, uniqueness: { scope: %i[user_id] }
  before_create :build_create
  def build_create
    self.active ||= false
  end
end
