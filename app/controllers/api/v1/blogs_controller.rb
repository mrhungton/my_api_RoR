class Api::V1::BlogsController < ApplicationController
  load_and_authorize_resource class: "Blog"

  before_action :check_login
  before_action :set_blog, only: [:show, :update, :destroy, :publish, :unpublish, :like, :unlike]
  # before_action :check_owner, only: [:update, :destroy]

  # GET /blogs
  def list
    @blogs = Blog.page(current_page).per(per_page)

    @blogs = @blogs.search(params)
    
    # check authorized (user)
    if can? :list_published, Blog
      @blogs = @blogs.search(params).published
    end

    render json: @blogs
  end

  # GET /blogs/1
  def show
    render json: Blog.find(params[:id])
  end

  # POST /blogs
  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      render json: @blog, status: :created
    else
      render json: {error: @blog.errors}, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /blogs/1
  def update
    if @blog.update(blog_params)
      render json: @blog, status: :ok
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  # DELETE /blogs/1
  def destroy
    @blog.destroy
    head 204
  end

  # PUT /blogs/1/publish
  def publish
    @blog.publish
    render json: @blog, status: :ok, messages: 'published'
  end

  # PUT /blogs/1/publish
  def unpublish
    @blog.unpublish
    render json: @blog, status: :ok, messages: 'unpublished'
  end

  # PUT /blogs/1/like
  def like
    @blog.like(current_user)
    render json: @blog, status: :ok, messages: 'liked'
  end

  # PUT /blogs/1/unlike
  def unlike
    @blog.unlike(current_user)
    render json: @blog, status: :ok, messages: 'unliked'
  end


  private

  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  # def check_owner
  #   head :forbidden unless @blog.user_id == current_user&.id
  # end
end
