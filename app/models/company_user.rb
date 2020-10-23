# frozen_string_literal: true

class CompanyUser < ApplicationRecord
  belongs_to :company
  belongs_to :user
  validates :user_id, uniqueness: { scope: [:company_id] }
end
