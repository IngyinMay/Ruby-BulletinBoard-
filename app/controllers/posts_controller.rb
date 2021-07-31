class PostsController < ApplicationController
  add_breadcrumb "Post List", :posts_path
  before_action :authorized?

  # function : index
  # @return [<Type>] <posts>
  def index
    @posts = PostService.getAllPosts(current_user)
  end

  # function : show
  # show post
  # param : post_id
  # @return [<Type>] <post>
  def show
    add_breadcrumb "Post Detail", :post_path
    @post = PostService.getPostById(params[:id])
  end

  # function : new
  # show create post
  # @return [<Type>] <post>
  def new
    add_breadcrumb "Create Post", :new_post_posts_path
    @post = Post.new
    # logger.info(@post)
  end

  # function : create
  # param : post_params
  # create post
  # @return redirect
  def new_post
    params[:post][:created_by] ||= current_user.id
    @post = Post.new(post_params)
    @is_save_post = PostService.createPost(@post)
    if @is_save_post
      redirect_to posts_path
    else
      render :new
    end
  end

  # function : edit
  # param : post_id
  # show edit post
  # @return [<Type>] <post>
  def edit
    add_breadcrumb "Post Detail", :post_path
    add_breadcrumb "Edit Post", :edit_post_path
    @post = PostService.getPostById(params[:id])
  end

  # function : update
  # param : post_id, post_params
  # @return [<Type>] redirect
  def update
    @post = PostService.getPostById(params[:id])
    params[:post][:updated_by] = current_user.id
    @is_post_update = PostService.updatePost(@post, post_params)
    if @is_post_update
      redirect_to @post
    else
      render :edit
    end
  end

  # function : destory
  # delete post
  # param : post_id
  # @return [<Type>] redirect
  def destroy
    @post = PostService.getPostById(params[:id])
    PostService.destroyPost(@post)
    redirect_to root_path
  end

  # function filter
  # filter posts
  # param : filter_by
  # @return [<Type>] <posts>
  def filter
    @filter_by = params[:filter_by]
    @user_id = current_user.id
    @posts = PostService.filter(@filter_by, @user_id)
    @last_filter_by = @filter_by
    render :index
  end

  # function :search
  # search posts
  # @return [<Type>] <posts>
  def search
    @search_keyword = params[:search_keyword]
    @posts = PostService.search(@search_keyword)
    @last_search_keyword = @search_keyword
    render :index
  end

  # function download_csv
  # download post csv
  #
  # @return [<Type>] <csv>
  def download_csv
    @posts = PostService.getAllPosts(current_user)
    @posts = @posts.reorder('id ASC')
    respond_to do |format|
      format.html
      format.csv { send_data @posts.to_csv,  :filename => "Post List.csv" }
    end
  end

  # functino upload_csv
  # show csv upload page
  # @return [<Type>] <description>
  def upload_csv
    add_breadcrumb "CSV Upload", :upload_csv_posts_path
  end

  # function csv_format
  # download csv format for upload
  # @return [<Type>] <description>
  def csv_format
    @post = Post.new
    respond_to do |format|
      format.html
      format.csv { send_data @post.csv_format,  :filename => "CSV Format.csv" }
    end
  end

  # function :import_csv
  # create posts by csv
  # @return [<Type>] <redirect>
  def import_csv
    if (params[:file].nil?)
      redirect_to upload_csv_posts_path, notice: Messages::REQUIRE_FILE_VALIDATION
    elsif !File.extname(params[:file]).eql?(".csv")
      redirect_to upload_csv_posts_path, notice: Messages::WRONG_FILE_TYPE
    else
      error_msg = PostsHelper.check_header(Constants::POST_CSV_FORMAT_HEADER,params[:file])
      if error_msg.present?
        redirect_to upload_csv_posts_path, notice: error_msg
      else
          result = Post.import(params[:file], current_user.id)
          if (result == true)
            redirect_to posts_path, notice: Messages::UPLOAD_SUCCESSFUL
          else 
            redirect_to upload_csv_posts_path, notice: result
          end
      end
    end
  end

  private
  # set post parameters
  # @return [<Type>] <description>
  def post_params
    params.require(:post).permit(:title, :description, :public_flag, :created_by, :updated_by)
  end
end





# tags[0][exhibition_item_choice_id]