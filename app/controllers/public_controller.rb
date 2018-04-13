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

  def affiliate_locator
    @affiliates = Affiliate.where(hide_info_on_locator: false)
  end
end
