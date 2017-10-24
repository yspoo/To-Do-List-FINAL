class TasklistsController < ApplicationController

  def index
    @tasklists = Tasklist.all
    @tasklist = Tasklist.new
  end

  def new
    @tasklist = Tasklist.new
  end

  def show
    @tasklist = Tasklist.find(params[:id])
    # params[:id] is referencing to the id of the specific @tasklist. 
    # The default id is with reference to the the class specified in the controller on top.
    # (which is linked to the model)
    @tasks = @tasklist.tasks.all
    @task = @tasklist.tasks.build
  end

  def create
    @tasklist = Tasklist.new(tasklist_params)
    if @tasklist.save
      flash[:notice] = "Successfully created!"
      redirect_to tasklists_path
    else
      @tasklists = Tasklist.all
      render :index
    end
  end

  def update
    @tasklist = Tasklist.find(params[:id])
    # finding the specific tasklist and assigning it to @tasklist.
    if @tasklist.update(tasklist_params)
      redirect_to tasklists_path
    else
      render :edit
    end
  end

  def edit
    @tasklist = Tasklist.find(params[:id])
    # finding the specific tasklist and assigning it to @tasklist.
  end

  def destroy
    @tasklist = Tasklist.find(params[:id])
    @tasklist.destroy
    redirect_to tasklists_path
  end

  private
  def tasklist_params
    params.require(:tasklist).permit(:name)
  end

end
