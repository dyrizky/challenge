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
  
  def complate
    @tasks = Task.find(params[:id])
    @tasks.is_complate = (@tasks.is_complate+1%2) 
    @tasks.save!
    render json: {success: true, data: @tasks}.to_json, status: 200
  end

  def abc
  end
end
