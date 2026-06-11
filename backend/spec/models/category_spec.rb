require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "validations" do
    it "is valid with a unique name" do
      category = Category.new(name: "Transport")
      expect(category).to be_valid
    end

    it "is invalid without a name" do
      category = Category.new(name: nil)
      expect(category).not_to be_valid
      expect(category.errors[:name]).to include("can't be blank")
    end

    it "is invalid with a blank name" do
      category = Category.new(name: "")
      expect(category).not_to be_valid
    end

    it "is invalid with a duplicate name (case-sensitive)" do
      Category.create!(name: "Food")
      duplicate = Category.new(name: "Food")
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:name]).to be_present
    end

    it "is invalid with a duplicate name (case-insensitive)" do
      Category.create!(name: "Food")
      duplicate = Category.new(name: "food")
      expect(duplicate).not_to be_valid
    end
  end

  describe "associations" do
    it "has many expenses" do
      association = Category.reflect_on_association(:expenses)
      expect(association.macro).to eq(:has_many)
    end

    it "destroys associated expenses when deleted" do
      category = Category.create!(name: "Food")
      Expense.create!(description: "Lunch", amount: 10.0, date: Date.today, category: category)

      expect { category.destroy }.to change(Expense, :count).by(-1)
    end
  end
end
