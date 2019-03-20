class ValidationRequestsController < ApplicationController
  #before_action :set_request, only: :show

  # GET /validation_requests
  #def index
  #  @requests = ValidationRequest.all
  #  json_response(@requests)
  #end

  # POST /validation_requests
  def create
    @request = ValidationRequest.create

    current_second_requests_number = ValidationRequest.where("created_at >= ?", DateTime.now - 1.second).count
    response = {:message => {message: "Validation Request denied: At most 5 api requests per second are allowed!"}, :code => :method_not_allowed}

    if current_second_requests_number < 5
      response =  email_exists() ? validate_email() : {:message => {message: "Bad Request... No email to validate!"}, :code => :bad_request}
    end

    json_response(response[:message], response[:code])
  end

  # GET /validation_requests/:id
  #def show
  #  json_response(@request)
  #end

  private

  def email_exists
    return (params[:email] != nil and !params[:email].blank?)
  end

  #def set_request
  #  @request = ValidationRequest.find(params[:id])
  #end
end
