class Console::NewsController < ConsoleController
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @news = News.order("#{sort_column} #{sort_direction}").page(params[:page])
  end

  def show; end

  def new
    @news = News.new
  end

  def edit; end

  def create
    @news = News.new(news_params)

    if @news.save
      redirect_to console_news_path(@news), success: 'News was successfully created.'
    else
      flash.now[:error] = 'Please correct the errors to continue.'
      render :new
    end
  end

  def update
    if @news.update(news_params)
      redirect_to console_news_path(@news), success: 'News was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @news.destroy
    redirect_to console_news_index_path, success: 'News was successfully deleted.'
  end

  private

    def set_news
      @news = News.find(params[:id])
    end

    def news_params
      params.require(:news).permit(:title, :body)
    end

    def sort_column
      %w[title body created_at].include?(params[:column]) ? params[:column] : 'created_at'
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end
end
