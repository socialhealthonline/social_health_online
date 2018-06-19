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

    def paginate(scoped, page_number = 0)
      scoped.page(page_number).per(20)
    end
end
