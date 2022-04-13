require 'rails_helper'

RSpec.describe Title, type: :model do
  let(:title) { create :title }

  describe 'validations' do
    it 'validate presence of title number' do
      title = Title.new(title_number: nil)
      expect(title).to_not be_valid
    end

    it 'validate presence of value' do
      title = Title.new(value: nil)
      expect(title).to_not be_valid
    end

    it 'validate presence of due date' do
      title = Title.new(due_date: nil)
      expect(title).to_not be_valid
    end

    it 'validate presence of cnpj assignor' do
      title = Title.new(cnpj_assignor: nil)
      expect(title).to_not be_valid
    end

    it 'validate presence of cnpj drawee' do
      title = Title.new(cnpj_drawee: nil)
      expect(title).to_not be_valid
    end

    it "title_number with format correct" do
      title.title_number = "123456"
      expect(title).to be_valid
    end

    it "value field with correct format" do
      title.value = 1000
      expect(title).to be_valid
    end

    it "due_date with format correct and more than today" do
      title.due_date = '2050-01-01'
      expect(title).to be_valid
    end

    it "cnpj_assignor field with correct format" do
      title.cnpj_assignor = Faker::CNPJ.pretty
      expect(title).to be_valid
    end

    it "cnpj_drawee field with correct format" do
      title.cnpj_drawee = Faker::CNPJ.pretty
      expect(title).to be_valid
    end
    
    it "title_number with format incorrect" do
      title.title_number = "123456?"
      expect(title).to_not be_valid
    end

    it "value less than or equal to zero" do
      title.value = 0
      expect(title).to_not be_valid
    end

    it "due_date with format incorrect" do
      title.due_date = "2050/12/22"
      expect(title).to_not be_valid
    end

    it "due_date with date date less than or equal today" do
      title.due_date = Date.today
      expect(title).to_not be_valid
    end

    it "cnpj_assignor field with incorrect format" do
      title.cnpj_assignor = Faker::CNPJ.pretty + "1"
      expect(title).to_not be_valid
    end

    it "cnpj_drawee field with incorrect format" do
      title.cnpj_drawee = Faker::CNPJ.pretty + "1"
      expect(title).to_not be_valid
    end
  end
end