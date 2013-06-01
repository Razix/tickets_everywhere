require 'spec_helper'

describe Ticket do

  before { @ticket = Ticket.new(name: "Customer name", 
                                email: "customer@email.com", 
                                issue: "everything looks bad", 
                                subject: "help me", 
                                description: "Please... I'll describe everything",
                                status: "Waiting for Staff Response", 
                                unique_reference: "AAA-000001") }

  subject { @ticket }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:issue) }
  it { should respond_to(:subject) }
  it { should respond_to(:description) }
  it { should respond_to(:status) }
  it { should respond_to(:unique_reference) }

  it { should be_valid }

  describe "when name is not present" do
    before { @ticket.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @ticket.email = "" }
    it { should_not be_valid }
  end

  describe "when subject is not present" do
    before { @ticket.subject = " " }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @ticket.description = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @ticket.name = "a" * 31 }
    it { should_not be_valid }
  end

  describe "when subject is too long" do
    before { @ticket.subject = "a" * 71 }
    it { should_not be_valid }
  end

  describe "when description is too short" do
    before { @ticket.description = "a" * 29 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      email_address = %w[custo,.er@test.com my_email@email,com
                        customer@super_mail.com emails@dot+com
                        customer.email.com my@email@email.com]
      email_address.each do |invalid_address|
        @ticket.email = invalid_address
        @ticket.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      email_address = %w[customer@test.com i_am_customer@test.me
                        this-is-customer@ticket.net my.ticket@ticket.com]
      email_address.each do |valid_address|
        @ticket.email = valid_address
        @ticket.should be_valid
      end      
    end
  end
end
