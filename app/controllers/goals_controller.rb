class GoalsController < ApplicationController
  def index
    @goals = Goal.all
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      redirect_to goals_path
    else
      render :new
    end
  end

  def show
    @goal = Goal.find_by(id: params[:id])
    redirect_to goals_path if @goal.nil?
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    
    def goal_params
      params.require(:goal).permit(:content, :limit)
    end
end
