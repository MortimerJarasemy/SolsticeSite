class PostsController < ApplicationController

		def index
		  @posts = Post.all.order("created_at desc")
		  @post = Post.new
		end

		def new
		  @post = Post.new
		end

		def create
		  @post = Post.new post_params
		 	if @post.save
			  	redirect_to @post, notice:"Everything went allright, no need to worry"
			else
				render 'new', notice: "Oh no, How could we Screw up?!"
			end
		end

		def show
		  @post = Post.find_by(id: params[:id])
		  unless @post
		    render json: {error: "The post you are looking for doesn't seem to exist"},
		    status: 404
		    return
		  end
		end

		def update
		  @post = Post.find_by(id: params[:id])
		  @post = @post.article
		  unless @post
		    render json: {error: "Post missing, sorry"},
		    status: 404
		    return
		  end
		  @post.update(post_params)
		  render json: post
		end

		def destroy
		  post = Post.find_by(id: params[:id])
		  unless post
		    render json: {error: "post not found"},
		    status: 404
		    return
		  end
		  post.destroy
		  redirect_to post_path
		end

		private

		def post_params
			params.require(:post).permit(:title, :content, :theme)
		end

end
