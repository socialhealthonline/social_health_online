module MailboxHelper
  def unread_messages_count
    mailbox.inbox(unread: true).count(:id)
  end

  def time_in_cst(date)
    date.blank? ? nil : date.in_time_zone('Central America').strftime('%A, %b %d, %Y at %I:%M%p')
  end
end
