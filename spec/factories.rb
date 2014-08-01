FactoryGirl.define do
  factory :job do
    title   'key grip'
    company 'showcase cinemas'
    industry 1
    date_applied Date.today
    in_consideration true
  end
end
