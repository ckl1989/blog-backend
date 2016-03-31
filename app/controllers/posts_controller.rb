class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  # GET /posts.json
	def index
	  render json: { posts: Post.all, comments: Comment.all }, methods: :comment_ids
	end

  # GET /posts/1
  # GET /posts/1.json
	def show
	  render json: { post: @post, comments: @post.comments }, methods: :comment_ids
	end

  # POST /posts
  # POST /posts.json
	def create
	  @post = Post.new(post_params)
	  if @post.save
		render json: { post: @post, comments: @post.comments }, methods: :comment_ids, status: :created, localtion: @post
	  else
		render json: @post.errors, status: :unprocessable_entity
	  end
	end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy

    head :no_content
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
