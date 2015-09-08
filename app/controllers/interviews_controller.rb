class InterviewsController < ApplicationController
  api :GET, '/api/jobs/:id/candidates/:id/interviews', 'Return list of interviews'
  def index
    if logged(params)
      @interviews = Interview.where(candidate_id: params[:candidate_id])
    else
      render_response('You are not logged', 400_001)
    end
  end

  api :GET, '/api/jobs/:id/candidates/:id/interviews/:id', 'Return an interview'
  def show
    if logged(params)
      @interview = Interview.find(params[:id])
    else
      render_response('You are not logged', 400_001)
    end
  end

  api :POST, '/api/jobs/:id/candidates/:id/interviews', 'Create an interview'
  def create
    if logged(params)
      @interview = Interview.create!(interview_params)
    else
      render_response('You are not logged', 400_001)
    end
  end

  api :DELETE, '/api/jobs/:id/candidates/:id/interviews/:id', 'Delete an interview'
  def destroy
    if logged(params)
      @interview = Interview.find(params[:id])
      @interview.delete
    else
      render_response('You are not logged', 400_001)
    end
  end

  private

  def interview_params
    params.require(:interview).permit(:candidate_id, :user_id, :status)
  end

  def logged(params)
    if Key.where(consumer_key: params[:consumer_key], secret_key: params[:secret_key]) == []
      return false
    else
      return true
    end
  end
end
