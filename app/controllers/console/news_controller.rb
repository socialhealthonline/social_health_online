class Console::NewsController < ConsoleController
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  def index
    @news = News.all
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
    redirect_to console_news_index_path, success: 'News was successfully destroyed.'
  end

  private

    def set_news
      @news = News.find(params[:id])
    end

    def news_params
      params.require(:news).permit(:title, :body)
    end
end
