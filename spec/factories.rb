FactoryGirl.define do
  factory :user do
    sequence(:first_name)  { |n| "FirstName #{n}" }
    sequence(:last_name)  { |n| "LastName #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
    factory :reviewer do
    end

    factory :reviewed do
    end
  end

  factory :lesson do
    title "Lorem ipsum"
    content "Lorem ipsum"
    price 50
    user
  end

  factory :category do
    name "Math"
  end

  factory :review do
    content "Lorem ipsum"
    reviewer
    reviewed
    rating 4
  end

  factory :scholarship do
    sequence(:degree)  { |n| "Degree #{n}" }
    sequence(:field)  { |n| "Field #{n}" }
    user
    school
    start_date "1995-09-08"
    end_date "2003-02-09"
  end
  factory :school do
    sequence(:name)  { |n| "Ecole #{n}" }
    sequence(:city)  { |n| "Ville #{n}" }
    sequence(:country)  { |n| "Country #{n}" }
  end
  factory :position do
    sequence(:city)  { |n| "Ville #{n}" }
    sequence(:country)  { |n| "Country #{n}" }
    user
    company
    start_date "1995-09-08"
    end_date "2003-02-09"
  end
  factory :company do
    sequence(:name)  { |n| "Company #{n}" }
  end
  factory :speaking do
    user
    language
  end
  factory :language do
    sequence(:name)  { |n| "Language #{n}" }
  end
end