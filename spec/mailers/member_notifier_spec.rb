require "rails_helper"

RSpec.describe MemberNotifierMailer, type: :mailer do
  describe 'charge_reminder' do
    let(:member) { create(:member, account_start_date: Time.now + 305.days, account_end_date: Time.now + 1.year, period: 'Annual', suspended: false ) }
    let(:mail) { MemberNotifierMailer.charge_reminder(member) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Subscription - Social Health Online')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([member.contact_email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['support@socialhealthonline.com'])
    end
  end
end
