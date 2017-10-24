class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]
  before_action :own_item, only: [:show, :edit, :update, :destroy]


  def index
    if user_signed_in?
      @tasks = Task.where(:user_id => current_user.id).order("created_at DESC")
    end
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    #new(task_params) so that we can access the columns input in database.
    if @task.save
    # if @task was able to be saved:
      redirect_to tasks_path
    # can use "redirect_to root_path"
    else
      render 'new'
    end
  end

  def show;end

  def edit
  end

  def update
    if @task.update(task_params)
    #update(task_params) so that we can access the columns input in database.
      redirect_to task_path(@task)
      #task_path(@task) because we must specify which exact task of all the tasks.
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    # if item was destroyed then the show page will be destroyed as well,
    # thus we'll need to redirect to another page.
    redirect_to tasks_path
  end

  def complete
    @task = Task.find(params[:id])
    @task.update_attribute(:completed_at, Time.now)
    # will update the completed_at value which will initially have a nil value until
    # it is completed and it will update it with the current time. Time.now is an datetime object.
    redirect_to root_path
  end


  private

  def task_params
  # go to params hash, get the "task" key, permit the values of "title" and "description"
    params.require(:task).permit(:title, :description)
  end

  def find_task
  # find the specific task by its ID using the "ID" key in params hash.
    @task = Task.find(params[:id])
  end

  def own_item
    unless current_user == @task.user
    flash[:alert] = "Sorry, you cannot view this item."
    redirect_to root_path
  end

  end


end
