class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post,only:[:show, :edit, :update, :destroy, :like, :unlike] 
	before_action :owned_post, only: [:edit, :update, :destroy]
	
	def index
		@posts = Post.paginate(page: params[:page],per_page: 5).order('created_at DESC')	
	end

	def new
		@post = current_user.posts.build
	end

	def create
   		@post = current_user.posts.build(post_params)

    	if @post.save
      		
      		redirect_to root_path
    	else
      		
      		render :new
    	end
    	
  	end

	def show
		@post = Post.find(params[:id])
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
    	if @post.update(post_params)
      
    		redirect_to posts_path
    	else
      	
      		render :edit
    	end
  	end

  	def destroy
    	@post.destroy
    
    	redirect_to root_path
  	end
  	

  	def like
  		if @post.liked_by current_user
  			respond_to do |format|
  				format.html{ redirect_to :back }
  				format.js
  			end
  		end
  	end
  	def unlike
  		if @post.unliked_by current_user
  			respond_to do |format|
  				format.html{ redirect_to :back }
  				format.js
  			end
  		end
  	end


	private
	def post_params
		params.require(:post).permit(:image, :caption)
	end

	def set_post
		@post = Post.find(params[:id])
	end

	def owned_post  
	  unless current_user == @post.user
	    flash[:alert] = "You are not own!"
	    redirect_to root_path
	  end
	end
end
