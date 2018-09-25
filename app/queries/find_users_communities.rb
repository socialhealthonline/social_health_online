class FindUsersCommunities
  attr_reader :initial_scope

  def initialize(initial_scope, show_init_scope:)
    @initial_scope = initial_scope
    @show_init_scope = show_init_scope
  end

  def call(params)
    scoped = filter_by_state(initial_scope, params[:state])
    scoped = filter_by_city(scoped, params[:city])
    scoped = filter_by_zip(scoped, params[:zip])
    scoped = filter_by_display_name(scoped, params[:display_name])
    scoped = filter_by_name(scoped, params[:name])
    scoped = filter_by_group(scoped, params[:group])
    scoped = filter_by_interest_types(scoped, params[:interest_types])
    scoped = paginate(scoped, params[:page])
    @show_init_scope = true if params[:state]
    @show_init_scope ? scoped : []
  end

  private

    def filter_by_state(scoped, state = nil)
      state ? scoped.where(state: state) : scoped
    end

    def filter_by_city(scoped, city = nil)
      city ? scoped.where(city: city) : scoped
    end

    def filter_by_zip(scoped, zip = nil)
      zip ? scoped.where(zip: zip) : scoped
    end

    def filter_by_display_name(scoped, display_name = nil)
      display_name ? scoped.where(display_name: display_name) : scoped
    end

    def filter_by_name(scoped, name = nil)
      name ? scoped.where(name: name) : scoped
    end

    def filter_by_group(scoped, group = nil)
      group ? scoped.where(group: group) : scoped
    end

    def filter_by_interest_types(scoped, interest_types = nil)
      interest_types ? scoped.where(interest_types: interest_types) : scoped
    end

    def paginate(scoped, page_number = 0)
      scoped.page(page_number).per(25)
    end
end
