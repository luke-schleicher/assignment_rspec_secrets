FactoryGirl.define do

  factory :user do
    name      "foo"
    email     { "#{name}@bar.com"}
    password  "foobar"
  end

end
