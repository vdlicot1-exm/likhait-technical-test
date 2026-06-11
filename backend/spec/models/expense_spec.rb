require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:category) { Category.create!(name: "Food") }

  describe "validations" do
    it "is valid with all required attributes" do
      expense = Expense.new(description: "Lunch", amount: 50.0, date: Date.today, category: category)
      expect(expense).to be_valid
    end

    it "is invalid without a description" do
      expense = Expense.new(description: nil, amount: 50.0, date: Date.today, category: category)
      expect(expense).not_to be_valid
      expect(expense.errors[:description]).to include("can't be blank")
    end

    it "is invalid with a blank description" do
      expense = Expense.new(description: "", amount: 50.0, date: Date.today, category: category)
      expect(expense).not_to be_valid
    end

    it "is invalid without an amount" do
      expense = Expense.new(description: "Lunch", amount: nil, date: Date.today, category: category)
      expect(expense).not_to be_valid
      expect(expense.errors[:amount]).to be_present
    end

    it "is invalid with a negative amount" do
      expense = Expense.new(description: "Lunch", amount: -10.0, date: Date.today, category: category)
      expect(expense).not_to be_valid
      expect(expense.errors[:amount]).to include("must be greater than 0")
    end

    it "is invalid with a zero amount" do
      expense = Expense.new(description: "Lunch", amount: 0, date: Date.today, category: category)
      expect(expense).not_to be_valid
    end

    it "is invalid without a date" do
      expense = Expense.new(description: "Lunch", amount: 50.0, date: nil, category: category)
      expect(expense).not_to be_valid
      expect(expense.errors[:date]).to be_present
    end

    it "is invalid without a category" do
      expense = Expense.new(description: "Lunch", amount: 50.0, date: Date.today, category: nil)
      expect(expense).not_to be_valid
    end
    it "is invalid with a future date" do
      expense = Expense.new(description: "Lunch", amount: 50.0, date: Date.tomorrow, category: category)
      expect(expense).not_to be_valid
      expect(expense.errors[:date]).to include("cannot be in the future")
    end

    it "is valid with today's date" do
      expense = Expense.new(description: "Lunch", amount: 50.0, date: Date.today, category: category)
      expect(expense).to be_valid
    end

    it "is valid with a past date" do
      expense = Expense.new(description: "Lunch", amount: 50.0, date: Date.today - 7, category: category)
      expect(expense).to be_valid
    end
  end

  describe "associations" do
    it "belongs to a category" do
      association = Expense.reflect_on_association(:category)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
