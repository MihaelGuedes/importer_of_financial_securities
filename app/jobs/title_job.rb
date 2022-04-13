require 'rest-client'
require 'json'

class TitleJob < ApplicationJob
  queue_as :default

  def perform(title)
    create_criticism(title)
  end

  def create_criticism(title)
    title = title
    protests = protests_validation(title.cnpj_assignor, title.cnpj_drawee)
    register = registered_title_validation(title.title_number)
    
    unless protests['assignor'].blank? && protests['drawee'].blank? && register == 'nao_registrado'
      TitleCriticism.find_or_create_by(
        assignors_protests: protests['assignor'],
        drawees_protests: protests['drawee'],
        status: register,
        title_id: title&.id
      )
    end
  end

  def protests_validation(cnpj_assignor, cnpj_drawee)
    protests_validation_url = "https://6e3v4cnk5i.execute-api.us-east-1.amazonaws.com/default/validatorProtestoFake?cnpj="

    begin
      result = {}
      result['assignor'] = JSON.parse((RestClient.get protests_validation_url + cnpj_assignor).body)
      result['drawee'] = JSON.parse((RestClient.get protests_validation_url + cnpj_drawee).body)
      result
    rescue => e
      manual_validation(cnpj_assignor, cnpj_drawee)
    end
  end

  def registered_title_validation(title_number)
    registered_title_validation_url = "https://rgshxukw2a.execute-api.us-east-1.amazonaws.com/default/validadorRegistroTituloFake?numero_titulo="

    begin
      JSON.parse((RestClient.get registered_title_validation_url + title_number).body)["status"]
    rescue => e
      [1,3,5,7,9].include?(title_number.to_s[0]) ? "nao_registrado" :  "registrado"
    end
  end

  def manual_validation(cnpj_assignor, cnpj_drawee)
    data = {}
    data['assignor'] = [1,3,5,7,9].include?(cnpj_assignor.to_s[0]) ? generate_protest : []
    data['drawee'] = [1,3,5,7,9].include?(cnpj_drawee.to_s[0]) ? generate_protest : []

    data
  end

  def generate_protest
    [
      {
        "tabeliao": "Tabelião #{Faker::Number.number(digits: 2)}",
        "valor": Faker::Number.number(digits: 5),
        "data": Faker::Date.forward(days: 23)
      }
    ]
  end
end
