class PublicController < ApplicationController

  def index
  end

  def about
  end

  def join
  end

  def service
  end

  def membership
  end

  def pricing
  end

  def news
    @news = News.order('updated_at desc').page(params[:page])
  end

end
