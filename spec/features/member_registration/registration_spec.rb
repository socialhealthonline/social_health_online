require 'rails_helper'

RSpec.describe 'Explore Communities' do
  describe 'Member Registration', js: true do
    context 'Successfully' do
      let(:service) { CreateManagerAndSubscriptionService.new(nil,
                                                              payment_method: nil,
                                                              manager_name: nil,
                                                              manager_email: nil,
                                                              stripe_token: nil) }

      before do
        visit new_members_registration_path
        allow_any_instance_of(MembersRegistrationController).to receive(:verify_recaptcha).and_return(true)
        allow_any_instance_of(CreateManagerAndSubscriptionService).to receive(:call).and_return(service)
      end

      it 'Visitor visit register page' do
        expect(page).to have_content('Member Registration')
      end

      it 'Visitor register new user' do
        fill_in 'member_name', with: 'Test Member Name'
        fill_in 'member_address', with: 'Test Member Address'
        fill_in 'member_city', with: 'Test City'
        fill_in 'member_zip', with: '55555'
        fill_in 'member_phone', with: '0123456789'
        fill_in 'member_url', with: 'example.com'
        fill_in 'member_contact_name', with: 'Test Member Contact Name'
        fill_in 'member_contact_email', with: 'example@gmail.com'
        fill_in 'member_contact_phone', with: '0123456789'
        fill_in 'member_contact_phone_extension', with: '0123456789'
        fill_in 'account_manager_name', with: 'Test Account Manager Name'
        fill_in 'account_manager_email', with: 'example_manager@gmail.com'
        fill_in 'member_service_capacity', with: 5
        fill_stripe_elements(4242424242424242)
        check 'termsCheckBox'
        page.execute_script('thenCapchaIsSubmited()')
        click_button 'Submit'
        expect(page).to have_content('Success!')
      end
    end

    context 'Unsuccessfully' do
      before do
        visit new_members_registration_path
      end

      it 'Visitor do not register new user' do
        fill_in 'member_name', with: 'Test Member Name'
        fill_in 'member_address', with: 'Test Member Address'
        fill_in 'member_city', with: 'Test City'
        fill_in 'member_zip', with: '55555'
        fill_in 'member_phone', with: '0123456789'
        fill_in 'member_url', with: 'example.com'
        fill_in 'member_contact_name', with: 'Test Member Contact Name'
        fill_in 'member_contact_email', with: 'example@gmail.com'
        fill_in 'member_contact_phone', with: '0123456789'
        fill_in 'member_contact_phone_extension', with: '0123456789'
        fill_in 'account_manager_name', with: 'Test Account Manager Name'
        fill_in 'account_manager_email', with: 'example_manager@gmail.com'
        fill_in 'member_service_capacity', with: 5
        fill_stripe_elements(4242424242424242)
        check 'termsCheckBox'
        page.execute_script('thenCapchaIsSubmited()')
        click_button 'Submit'
        expect(page).to have_content('Please correct the errors to continue.')
      end
    end
  end
end
