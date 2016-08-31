class ProjectsController < ApplicationController
	before_action :find_project, only: [:show,:edit,:update,:destroy]
	has_scope :by_category, type: :array

	def index
	  @projects = apply_scopes(Project).all
	  @project = Project.new
	end

	def new
	  @project = Project.new
	end

	def create
	  @project = Project.new project_params
		if @project.save
			redirect_to @project, notice:"Everything went allright, no need to worry"
		else
			render 'new', notice: "Oh no, How could we Screw up?!"
		end
	end

	def show
	  @project = Project.find(params[:id])
	  unless @project
		render json: {error: "The project you are looking for doesn't seem to exist"},
		status: 404
		return
	  end
	end

	def update
		if @project.update project_params
			redirect_to @project, notice: "we have an update working"
		else
			render 'edit'
		end
	end

	def destroy
	  @project.destroy
	  redirect_to projects_path
	end

	private

	def find_project
		@project = Project.find_by(params[:id])
	end

	def project_params
		params.require(:project).permit(:name, :description, :link, :category, :photo)
	end

end
