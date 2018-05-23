require 'rails_helper'

def visit_page_and_show_event(event)
  visit dashboard_path
  expect(page).to have_content event.title
end

def visit_page_and_not_show_event(event)
  visit dashboard_path
  expect(page).to_not have_content event.title
end