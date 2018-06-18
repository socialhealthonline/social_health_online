class UserDecorator < ApplicationDecorator
  delegate_all
  include Draper::LazyHelpers

  def user_pending?(f)
    params = { include_blank: false, class: "form-control custom-select #{object.errors[:user_status].present?  ? 'is-invalid' : nil}" }
    if object.pending?
      params.merge!(disabled: true)
      f.select(:user_status, ['Pending'], {}, params)
    else
      f.select(:user_status, ['activated', 'disabled'], {}, params)
    end
  end

  def user_manager?
    if user.manager?
      'Yes'
    else
      'No'
    end
  end

  def profile_name
    if object.hidden_field.name
      h.content_tag :p, "Name: #{ object&.display_name }"
    else
      h.content_tag :p, "Name: #{ object&.name }"
    end
  end

  def profile_email
    h.content_tag :p, "Email: #{ object&.email }" unless object.hidden_field.email
  end

  def profile_phone
    h.content_tag :p, "Phone: #{ object&.phone }" unless object.hidden_field.phone
  end

  def profile_address
    h.content_tag :p, "Address: #{ object&.address }" unless object.hidden_field.address
  end

  def profile_city
    h.content_tag :p, "City: #{ object&.city }" unless object.hidden_field.city
  end

  def profile_state
    h.content_tag :p, "State: #{ object&.state }" unless object.hidden_field.state
  end

  def profile_zip
    h.content_tag :p, "ZIP: #{ object&.zip }" unless object.hidden_field.zip
  end

  def profile_time_zone
    h.content_tag :p, "Time Zone: #{ object&.time_zone }" unless object.hidden_field.time_zone
  end

  def profile_birthdate
    h.content_tag :p, "Birthdate: #{ object&.birthdate }" unless object.hidden_field.birthdate
  end

  def profile_gender
    h.content_tag :p, "Gender: #{ object&.gender }" unless object.hidden_field.gender
  end

  def profile_ethnicity
    h.content_tag :p, "Ethnicity: #{ object&.ethnicity }" unless object.hidden_field.ethnicity
  end

  def profile_relationship_status
    h.content_tag :p, "Relationship Status: #{ object&.relationship_status }" if object.relationship_status && !object.relationship_status&.empty?
  end

  def profile_education_level
    h.content_tag :p, "Education Level: #{ object&.education_level }" if object.education_level && !object.education_level&.empty?
  end

  def profile_occupation
    h.content_tag :p, "Occupation: #{ object&.occupation }" if object.occupation && !object.occupation&.empty?
  end

  def profile_languages
    h.content_tag :p, "Languages: #{ object&.languages }" if object.languages && !object.languages&.empty?
  end

  def profile_hobbies
    h.content_tag :p, truncate("Hobbies: #{object&.hobbies}", length: 40) if object.hobbies && !object.hobbies&.empty?
  end

  def profile_pet_peeves
    h.content_tag :p, truncate("Pet Peeves: #{object&.pet_peeves}", length: 40) if object.pet_peeves && !object.pet_peeves&.empty?
  end

  def profile_bio
    h.content_tag :p, truncate("Bio: #{object&.bio}", length: 40) if object.bio && !object.bio&.empty?
  end
end
