class GroupsController < ApplicationController
  def index
    @groups = Group.all
    @book = Book.new
  end

  def show
    @group = Group.find(params[:id])
    @book = Book.new
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path, notice: "You have created group successfully."
    else
      @groups = Group.all
      render 'index'
    end
  end

  def edit
    @group = Group.find(paramss[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path, notice: "You have updated group successfully."
    else
      render 'edit'
    end
  end

  private
  def group_params
     params.require(:group).permit(:name, :introduction, :group_image, :owner_id)
  end

end
