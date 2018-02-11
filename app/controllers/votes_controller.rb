class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    begin
      Vote.create! :user_id => current_user.id, :question_id => params[:question_id]
    #silently fail if someone double votes
    rescue ActiveRecord::RecordNotUnique
    end
    redirect_to questions_path
  end
end
