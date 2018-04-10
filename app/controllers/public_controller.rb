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
    @news = News.all
  end

end
