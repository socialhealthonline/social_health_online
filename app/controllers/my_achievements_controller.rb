class MyAchievementsController < ApplicationController
before_action :require_authentication

  def index
    @social_event_Logs = SocialEventLog.where(user_id: authenticated_user.id)

    next_level = 10
    level = @social_event_Logs.size / next_level
    @level = level.floor
    @progress = (@social_event_Logs.size.modulo(next_level).round(2)) * next_level
  end
end
