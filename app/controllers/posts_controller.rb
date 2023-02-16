class PostsController < ApplicationController
  include Sift
  include ApplicationHelper
  before_action :set_post, only: %i[ show edit update destroy increment_flag ]

  filter_on :with_text, type: :scope
  filter_on :with_category, type: :scope
  # GET /posts or /posts.json
  def index
    if params.has_key?(:filters) && (params[:filters].has_key?(:with_category) || params[:filters].has_key?(:with_filter_category)) 
      if params[:filters].has_key?(:with_category)
        approved_posts = Category.find(params[:filters][:with_category]).posts.approved.timeline
      else
        approved_posts = Category.find(params[:filters][:with_filter_category]).posts.approved.timeline
      end
    else 
      approved_posts = Post.approved.timeline
    end
    if params[:created_at].present? && params[:sort].nil?
      approved_posts = approved_posts.order({ created_at: :asc })
    end
    if params.has_key?(:sort) && params[:sort] == 'desc'
      approved_posts = approved_posts.desc
      approved_posts = params[:created_at].present? ? approved_posts.order({ created_at: :desc }) : approved_posts.desc
    else
      approved_posts = approved_posts.asc
      approved_posts = params[:created_at].present? ? approved_posts.order({ created_at: :asc }) : approved_posts.asc
    end
    if params[:tag].present?
      approved_posts = approved_posts.includes(:tags).where(tags: {id: params[:tag]})
    end
    if params[:start_date].present? && params[:end_date].present?
      approved_posts = approved_posts.where('date >= ? AND date <= ?', params[:start_date].to_date, params[:end_date].to_date)
    end

    if params.has_key?(:sort) && params[:sort] == 'desc'
      approved_posts = approved_posts.desc
    else
      approved_posts = approved_posts.asc
    end
    approved_posts = filtrate(approved_posts)
    @happened_today = Post.happened_today
    @pagy, @posts = pagy(approved_posts)
    @categories = Category.all
    @tags = Tag.all

    if params[:filters]
      @search_text = params[:filters][:with_text]
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post.views = @post.views + 1
    @post.save
    @related_posts = @post.relatedPosts
  end

  # GET /posts/new
  def new
    @post = Post.new
    @reference = @post.references.build

  end

  # GET /posts/1/edit
  def edit
    @reference = @post.references.last
  end

  def increment_flag
    @post.increment!(:flag)
    @post.save
  end
  def remove_attachment_posts
    @post = Post.find_by_id(params[:id]) #ActiveStorage::Blob.find_signed(params[:id])
    @post.picture.purge_later if params[:type] == "picture"
    @post.gallery_photoes.purge_later if params[:type] == "gallery"
    redirect_back(fallback_location: root_path)
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    if authenticate_admin_role
      @post.status = "approved"
      @post.user = current_user
    else
      @post.status = "pending"
    end
    respond_to do |format|
      if verify_recaptcha && @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:subject_ar, :subject_en, :description_ar, :description_en, :timestamp, :date, :flag, :status, :views, :hide_day, :hide_month, :picture, :video_url,:book, :gallery_photoes => [], :category_ids => [], references_attributes: [:id, :reference_url, :_destroy])
    end
end
