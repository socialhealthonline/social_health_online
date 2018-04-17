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

  def affiliates
    state = params[:state]
    city = params[:city]
    zip = params[:zip]

    state = state.downcase.strip if state
    city = city.downcase.strip if city
    zip = zip.strip if zip

    affiliates = Affiliate.where(hide_info_on_locator: false)

    if city && state
      where('name LIKE ?', "%#{search}%")

      affiliates = affiliates.where(["lower(state) LIKE :state AND lower(city) LIKE :city", {state: "%#{state}%", city: "%#{city}%"}])
    elsif city
      affiliates = affiliates.where(["lower(city) LIKE :city", {city: "%#{city}%"}])
    elsif state
      affiliates = affiliates.where(["lower(state) LIKE :state", {state: "%#{state}%"}])
    elsif zip
      affiliates = affiliates.where(zip: zip)
    end

    render json: affiliates, each_serializer: AffiliatesForLocatorSerializer
  end
end
