class ApplicationController < ActionController::API
  include Authenticable
  include Paginable
end
