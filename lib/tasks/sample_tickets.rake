namespace :db do
  desc "Fill database with sample tickets"
  task populate: :environment do
    Ticket.create!(name: "Sample customer",
                 email: "sample@customer.com",
                 subject: "Sample subject",
                 description: "#{'a'*31}",
                 issue: "general",
                 status: "Waiting for Staff Response",
                 unique_reference: "AAA-000001")
    151.times do |n|
      name  = Faker::Name.name
      email = "sample-#{n+1}@customer.com"
      subject  = "Sample subject"
      description = "#{'a'*31}"
      issue  = "general"
      status  = "Waiting for Staff Response"
      unique_reference  = Faker::PhoneNumber.phone_number
      Ticket.create!(name: name,
                   email: email,
                   subject: subject,
                   description: description,
                   issue: issue,
                   status: status,
                   unique_reference: unique_reference)
    end
  end
end
