# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :code, :original_title, presence: true
end
