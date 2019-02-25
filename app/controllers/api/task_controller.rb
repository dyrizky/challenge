class Api::TaskController < AdminController
  before_action :authenticate_user!
  def index
    if(params[:limit]!="-1")
      @tasks = Task.offset(params[:page]).limit(params[:limit]).order(params[:order])
    else 
      @tasks = Task.offset(params[:page]).order(params[:order])
    end
    @count_tasks = Task.count
    render json: {success: true, data: @tasks, length:@count_tasks}.to_json, status: 200
  end
  
  def yeah
  end

  def abc
  end
end
