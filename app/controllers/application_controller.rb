class ApplicationController < ActionController::API
  include Authenticable
  include Paginable
  include ResponseHandler
end
