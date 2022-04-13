class TitlesController < ApplicationController
  prepend SimpleCommand

  def show
    @status_code_success = :ok
    @status_code_error = :bad_request
    @service = Api::Titles::Show.call(api_params[:cnpj_assignor],
                                      api_params[:cnpj_drawee],
                                      api_params[:initial_date_range],
                                      api_params[:final_date_range],
                                      api_params[:have_criticism],
                                      api_params[:title_number])
      
    render_service
  end

  def create
    @status_code_success = :created
    @status_code_error = :unprocessable_entity
    @service = Api::Titles::Create.call(api_body)

    render_service
  end

  def render_service
    if @service.success?
      render json: { data: @service.result }, status: @status_code_success
    else
      render json: { errors: @service.errors }, status: @status_code_error
    end
  end
  
  def api_params
    params.permit(:cnpj_assignor, :cnpj_drawee, :initial_date_range,
                  :final_date_range, :have_criticism, :title_number)
  end

  def api_body
    request.raw_post
  end
end