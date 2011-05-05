class FeedbacksController < ApplicationController
  before_filter :get_request

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback =  @request.feedbacks.build(params[:feedback])
    @feedback.person_id = current_user.person.id
    if @feedback.save
      redirect_to dashboard_path, :notice => "Successfully created feedback."
    else
      render :action => 'new'
    end
  end

  def edit
    @feedback = Feedback.find(params[:id])
  end

  def update
    @feedback = Feedback.find(params[:id])
    if @feedback.update_attributes(params[:feedback])
      redirect_to dashboard_path, :notice  => "Successfully updated feedback."
    else
      render :action => 'edit'
    end
  end
  
  protected
  
  def get_request
    @request = ItemRequest.find_by_id(params[:request_id])
    redirect_to dashboard_path unless @request
  end
end