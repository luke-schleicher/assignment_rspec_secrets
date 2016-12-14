require 'rails_helper'

# - authentication (before_action methods)
# - verifying redirects or renders after an action
# - verifying flashes are set
# - verifying cookies or sessions
# - verify status codes
# - verify whether changes to db has worked

# providing params and verb/controller action
# examine returned response

describe UsersController, type: :request do

  context 'post#create' do

    context 'with correct input' do

      let (:correct_input) { attributes_for(:user) }

      it 'creates a new user' do
        expect{
          submit_user(correct_input)
          # process :create Rails 4
          # post users_url Rails 5
        }.to change(User, :count).by(1)
      end

      it 'redirects us to the new user show page' do
        submit_user(correct_input)
        saved_user = User.last
        expect(response).to redirect_to user_path(saved_user)
      end

      it 'sets a flash notice' do
        submit_user(correct_input)
        expect(flash[:notice]).to be_present
      end
    end

    context 'with incorrect input' do

      let (:incorrect_input) { attributes_for(:user, name: '') }

      it "doesn't create a user" do
        expect { submit_user(incorrect_input) }.to change(User, :count).by(0)
      end

      # HOW TO CHECK FLASH ERROR?
      # it 'sets a flash error' do
      #   submit_user(incorrect_input)
      #   expect(errors.messages).to be_present
      # end

    end

  end

  context 'User authorization' do

    let(:user) { create(:user) }
    let(:user_2) { create(:user, email: 'foo2@bar.com') }

    before do
      user
      # log_in(user)
      binding.pry
      session[:user_id] = user.id
    end

    context 'patch#update' do

      let(:updated_name) { 'bar' }

      it 'can update their own profile' do
        patch user_url, params: { id: user.id, user: attributes_for(:user, name: updated_name) }
        user.reload
        expect(user.name).to eq(updated_name)
      end

      it 'cannot update another profile'

    end

    context 'delete#destroy' do

      it 'can update their own profile'

      it 'cannot update another profile'

    end

  end

end
