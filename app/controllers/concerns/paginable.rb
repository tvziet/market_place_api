module Paginable
  protected

  def current_page
    (params[:page] || 1).to_i
  end

  def per_page
    (params[:per_page] || 20).to_i
  end

  def get_links_serializer_options(path, collection)
    return {} unless collection

    {
      links: {
        first: send(path, page: 1),
        last: send(path, page: collection.total_pages),
        prev: send(path, page: params[:page].to_i == 1 ? nil : collection.prev_page),
        next: send(path, page: params[:page].to_i == collection.total_pages ? nil : collection.next_page)
      }
    }
  end
end
