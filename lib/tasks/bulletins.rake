namespace :bulletins do
  desc "TODO"
  task delete_old_bulletins: :environment do
    Bulletin.where(['created_at < ?', 30.days.ago]).destroy_all
  end
end
