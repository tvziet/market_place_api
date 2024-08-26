class ApiDocsController < ApplicationController
  def index
    file_path = Rails.public_path.join('dist/index.html')

    render plain: File.read(file_path), content_type: 'text/html'
  end
end
