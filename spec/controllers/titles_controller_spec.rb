require 'rails_helper'

RSpec.describe TitlesController, type: :controller do
  let(:title) { create(:title) }
  body_title_valid = [{ "title_number": "205154", "value": 200.0, "due_date": "2050-04-04", "cnpj_assignor": "31.201.274/0001-72", "cnpj_drawee": "87.865.863/0001-00" }]
  body_title_invalid = [{ "title_number": "205154?", "value": 200.0, "due_date": "2020-04-04", "cnpj_assignor": "31.201.274/0001-72", "cnpj_drawee": "87.865.863/0001-00" }]


  describe "POST /create" do
    it 'a successful response create' do
      
      post :create, body: body_title_valid.to_json, format: :json
      
      expect(response).to be_successful
      expect(response).to have_http_status(:created)
    end

    it "a failed create request due to invalid fields" do
      post :create, body: body_title_invalid.to_json, format: :json

      expect(response).to_not be_successful
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /show' do
    it "a successfull response with cnpj_assignor" do
      get :show, params: { cnpj_assignor: "31.201.274/0001-72" }, as: :json

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end

    it 'a successful request with initial_date_range filter' do
      get :show, params: { cnpj_assignor: title.cnpj_assignor, cnpj_drawee: title.title_number }, as: :json

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
    
    it 'confirmated titles fields' do
      get :show, params: { cnpj_assignor: title.cnpj_assignor }, as: :json
      parsed_body = response.parsed_body

      expect(parsed_body['data'].first.keys).to eq(['title_number', 'value',
                                                      'due_date', 'cnpj_assignor', 'cnpj_drawee'])
    end

    it 'a failed response without cnpj_assignor field' do
      get :show, params: { }, as: :json

      expect(response).to_not be_successful
      expect(response).to have_http_status(:bad_request)
      expect(response.parsed_body).to eq({"errors"=>{"message"=>"field cnpj_assignor required."}})
    end

    it 'a successful request with have_criticism filter' do
      get :show, params: { cnpj_assignor: title.cnpj_assignor, have_criticism: 'true' }, as: :json
      parsed_body = response.parsed_body

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end

    it 'a successful request with title_number filter' do
      get :show, params: { cnpj_assignor: title.cnpj_assignor, have_criticism: 300 }, as: :json
      parsed_body = response.parsed_body

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end

    it 'a successful request with initial_date_range filter' do
      get :show, params: { cnpj_assignor: title.cnpj_assignor, initial_date_range: Date.today }, as: :json
      parsed_body = response.parsed_body

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end

    it 'a successful request with final_date_range filter' do
      get :show, params: { cnpj_assignor: title.cnpj_assignor, final_date_range: (Date.today + 1.week) }, as: :json
      parsed_body = response.parsed_body

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end