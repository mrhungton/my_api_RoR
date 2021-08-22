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
    if can? :published_list, Blog
      @blogs = @blogs.search(params).published
    end

    options = {
      include: [:user],
      # links: {
      #   first: api_v1_blogs_path(page: 1),
      #   last: api_v1_blogs_path(page: @blogs.total_pages),
      #   prev: api_v1_blogs_path(page: @blogs.prev_page),
      #   next: api_v1_blogs_path(page: @blogs.next_page),
      # }
    }

    render json: BlogSerializer.new(@blogs, options).serializable_hash
  end

  # GET /blogs (featured blogs - with the most likes)
  def featured_list
    @blogs = Blog.published.featured(params[:top]).page(current_page).per(per_page)
    
    options = {include: [:user]}
    
    render json: BlogSerializer.new(@blogs, options).serializable_hash
  end

  # GET /blogs/1
  def show
    options = {include: [:user]}
    render json: BlogSerializer.new(@blog, options).serializable_hash
  end

  # POST /blogs
  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      render json: BlogSerializer.new(@blog).serializable_hash, status: :created
    else
      render json: {error: @blog.errors}, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /blogs/1
  def update
    if @blog.update(blog_params)
      render json: BlogSerializer.new(@blog).serializable_hash, status: :ok
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  # DELETE /blogs/1
  def destroy
    @blog.destroy
    render json: {messages: 'Deleted the blog'}, status: :ok
  end

  # PUT /blogs/1/publish
  def publish
    @blog.publish
    render json: { messages: "Published the post: #{@blog.title} (##{@blog.id})" }, status: :ok
  end

  # PUT /blogs/1/publish
  def unpublish
    @blog.unpublish
    render json: { messages: "Un-published the post: #{@blog.title} (##{@blog.id})" }, status: :ok
  end

  # PUT /blogs/1/like
  def like
    @blog.like(current_user)
    render json: { messages: "Liked the post: #{@blog.title} (##{@blog.id})" }, status: :ok
  end

  # PUT /blogs/1/unlike
  def unlike
    @blog.unlike(current_user)
    render json: { messages: "Un-liked the post: #{@blog.title} (##{@blog.id})" }, status: :ok
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
