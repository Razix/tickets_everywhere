require 'spec_helper'

describe "Ticket pages" do

  subject { page }

  describe "root page" do
    before { visit root_path }

    it { should have_selector('h1',    text: 'Please submit your request') }
  end

  describe "submit ticket" do

    before { visit root_path }

    let(:submit) { "Submit request" }

    describe "with invalid information" do
      it "should not create a ticket" do
        expect { click_button submit }.not_to change(Ticket, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('h1', text: 'Please submit your request') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "New user"
        fill_in "Email",        with: "new@user.com"
        fill_in "Subject",     with: "Important subject"
        fill_in "Description", with: "#{'a'*31}"
      end

    describe "after saving the user" do
        before { click_button submit }
        let(:ticket) { Ticket.find_by_email('new@user.com') }

        it { should have_content('Ticket was successfully created') }
      end

      it "should create a user" do
        expect { click_button submit }.to change(Ticket, :count).by(1)
      end
    end
  end
end
