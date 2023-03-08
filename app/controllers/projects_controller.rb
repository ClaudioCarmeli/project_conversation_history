class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[ show edit update destroy ]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        redirect_to project_url(@project), notice: "Project was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        redirect_to project_url(@project), notice: "Project was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: "Project was successfully destroyed."
  end

  private
    def set_project
      @project = Project.find(params[:id])
      @comments = Comment.find_by(project_id: @project.id)
    end

    def project_params
      params.require(:project).permit(:name, :title, :description, :user_id, :status)
    end
end
