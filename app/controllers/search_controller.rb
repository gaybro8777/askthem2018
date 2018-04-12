class SearchController < ApplicationController
  def index
    result = SearchTerm.search(params[:q]).limit(4)
    hash_results = result.map {|r| {id: r.id, text: r.display_text} }
    render json: { "results": hash_results }
  end
end
