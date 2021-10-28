class DiscountVerifier < ApplicationService
  def initialize(age:)
    @age = age
  end

  def call
    if age >= 40
      'Verified'
    else
      'Not verified'
    end
  end

  private

  attr_reader :age
end
