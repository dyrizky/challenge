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
    if(@tasks.is_complate == 1)
      @tasks.is_complate = 0
    else
      @tasks.is_complate = 1
    end
    @tasks.save!
    render json: {success: true, data: @tasks}.to_json, status: 200
  end

  def previous
    if(params[:limit]!="-1")
      @tasks = Task.offset(params[:page]).limit(params[:limit]).order(params[:order]).where('due_date < ?', DateTime.now.to_date)
    else 
      @tasks = Task.offset(params[:page]).order(params[:order]).where('due_date < ?', DateTime.now.to_date)
    end
    @count_tasks = Task.count
    render json: {success: true, data: @tasks, length:@count_tasks}.to_json, status: 200
  end
  def task_now
    # if(params[:limit]!="-1")
      # @tasks = Task.offset(params[:page]).limit(params[:limit]).order(params[:order]).where('due_date < ?', DateTime.now.to_date)
    # else 
      @tasks = Task.where('due_date = ?', DateTime.now.to_date)
    # end
    # @count_tasks = Task.count
    render json: {success: true, data: @tasks, length:@count_tasks}.to_json, status: 200
  end
  def store
    @task = Task.new
    @task.task = params[:task]
    @task.task_desc = params[:task_desc]
    @task.due_date = params[:due_date]
    @task.prioriti = params[:prioriti]
    @task.is_complate = 0
    @task.save!
    render json: {success: true, data: @tasks, length:@task}.to_json, status: 200
  end
end
