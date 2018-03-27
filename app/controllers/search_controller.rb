class SearchController < ApplicationController
  def index
    result = ContestSearch.search(params[:q]).limit(4)
    hash_results = result.map {|r| {id: r.id, text: r.name} }
    render json: { "results": hash_results }
  end
end
