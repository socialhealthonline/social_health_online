class ConversationsController < ApplicationController
  before_action :require_authentication

  def new
    gon.recipient_id = params[:recipient_id]
  end

  def create
    recipients = User.where(id: conversation_params[:recipients], user_status: :enabled)
    authenticated_user.send_message(recipients, conversation_params[:body], conversation_params[:subject])
    flash[:success] = 'Your message was successfully sent!'
    redirect_to mailbox_inbox_path
  end

  def show
    @receipts = conversation.receipts_for(authenticated_user).order(:created_at)
    conversation.mark_as_read(authenticated_user)
  end

  def reply
    authenticated_user.reply_to_conversation(conversation, message_params[:body], nil, false)
    conversation.recipients.reject { |r| r.eql? authenticated_user }.each { |r| conversation.untrash(r) }
    flash[:success] = 'Your reply was successfully sent!'
    redirect_to conversation_path(conversation)
  end

  def trash
    conversation.move_to_trash(authenticated_user)
    redirect_to mailbox_inbox_path
  end

  def untrash
    conversation.untrash(authenticated_user)
    redirect_to mailbox_inbox_path
  end

  def mark_as_deleted
    mailbox.trash.each do |conversation|
      conversation.opt_out(authenticated_user)
      conversation.mark_as_deleted(authenticated_user)
    end
    redirect_to mailbox_inbox_path
  end

  private

  def conversation_params
    params.require(:conversation).permit(:subject, :body, recipients:[])
  end

  def message_params
    params.require(:message).permit(:body, :subject)
  end
end
