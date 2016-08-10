class ProjectsController < ApplicationController

	def index
	  @projects = Project.all.order("created_at desc")
	  @project = Project.new
	end

	def new
	  @project = Project.new
	end

	def create
	  project = Project.create(project_params)
	  redirect_to projects_path
	end

	def show
	  accepts_nested_attributes_for :palettes, :colors
	  @project = Project.find_by(id: params[:id])
	  unless @project
	    render json: {error: "The project you are looking for doesn't seem to exist"},
	    status: 404
	    return
	  end
	end

	def update
	  @project = Project.find_by(id: params[:id])
	  @palette = @project.palette
	  unless @project
	    render json: {error: "Project missing, sorry"},
	    status: 404
	    return
	  end
	  @project.update(project_params)
	  @project.update_palette(palette_params)
	  render json: project
	end

	def destroy
	  project = Project.find_by(id: params[:id])
	  unless project
	    render json: {error: "project not found"},
	    status: 404
	    return
	  end
	  project.destroy
	  redirect_to projects_path
	end

	private
	def project_params
		params.require(:project).permit(:name, description:, category:)
	end

end
