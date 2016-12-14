FactoryGirl.define do

  factory :user, aliases: [:author] do
    name      "foo"
    email     { "#{name}@bar.com"}
    password  "foobar"
  end

  factory :secret do
    title "this is my secret"
    body  "this is the secret body"
    author
  end

end
