require 'json'

class Api::Titles::Create
  prepend SimpleCommand
  attr_writer :errors

  def initialize(api_body)
    @titles_list = JSON.parse(api_body)
    @errors = []
  end

  def call
    creation
  end

  private

  def creation
    response = []
    @titles_list.each do |title|
      current_title = Title.new(
        title_number: title['title_number'],
        value: title['value'],
        due_date: title['due_date'],
        cnpj_assignor: title['cnpj_assignor'],
        cnpj_drawee: title['cnpj_drawee']
      )

      if current_title.valid?
        response << current_title 
        current_title.save
      else
        @errors << { title: title,
                     errors: current_title.errors.full_messages }
      end
    end

    @errors.blank? ? response.as_json(only: [:title_number, :value,
                                             :due_date, :cnpj_assignor, :cnpj_drawee]) : @error
  end
end
