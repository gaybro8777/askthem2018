class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def index
    @questions = Question.sorted_by_votes
  end

  def new
    if !user_signed_in?
      flash.notice = "please create an account before submitting a question"
      flash[:redirect_to] = new_question_path
      redirect_to new_user_registration_path
      return
    end

    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_path
    else
      render 'new'
    end
  end

  private

  def question_params
    params.require(:question).permit(:contest_id, :body)
  end
end
