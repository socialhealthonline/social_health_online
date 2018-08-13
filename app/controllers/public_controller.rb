class PublicController < ApplicationController
  def index
  end

  def about
  end

  def careers
  end

  def join
  end

  def service
  end

  def service_highlights
  end

  def service_screenshots
  end

  def participation
    take_graph_data
  end

  def pricing
  end

  def support
  end

  def privacy
  end

  def affiliate_agreement
  end

  def terms
  end

  def saas_agreement
  end

  def faq
  end

  def news
    @news = News.order('updated_at desc').page(params[:page])
  end

  def affiliate_locator
  end

  def member_locator
  end

  def affiliates
    state = params[:state]
    city = params[:city]
    zip = params[:zip]

    state = state.downcase.strip if state
    city = city.downcase.strip if city
    zip = zip.strip if zip

    affiliates = Affiliate.where(hide_info_on_locator: false).order("name asc")

    if city && state
      #where('name LIKE ?', "%#{search}%")

      affiliates = affiliates.where(["lower(state) LIKE :state AND lower(city) LIKE :city", {state: "%#{state}%", city: "%#{city}%"}])
    elsif city
      affiliates = affiliates.where(["lower(city) LIKE :city", {city: "%#{city}%"}])
    elsif state
      affiliates = affiliates.where(["lower(state) LIKE :state", {state: "%#{state}%"}])
    elsif zip
      affiliates = affiliates.where(zip: zip)
    end

    render json: affiliates, each_serializer: AffiliateForLocatorSerializer
  end

  def members
    state = params[:state]
    city = params[:city]
    zip = params[:zip]

    state = state.downcase.strip if state
    city = city.downcase.strip if city
    zip = zip.strip if zip

    members = Member.where(hide_info_on_locator: false)

    if city && state
      #where('name LIKE ?', "%#{search}%")

      members = members.where(["lower(state) LIKE :state AND lower(city) LIKE :city", {state: "%#{state}%", city: "%#{city}%"}])
    elsif city
      members = members.where(["lower(city) LIKE :city", {city: "%#{city}%"}])
    elsif state
      members = members.where(["lower(state) LIKE :state", {state: "%#{state}%"}])
    elsif zip
      members = members.where(zip: zip)
    end

    render json: members, each_serializer: MemberForLocatorSerializer
  end

  private

  def take_graph_data
    gon.members_in_states = Member.where.not(public_member: true).group(:state).count
    gon.affiliates_in_states = Affiliate.group(:state).count
  end
end
