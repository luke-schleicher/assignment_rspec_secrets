require 'rails_helper'

# - authentication (before_action methods)
# - verifying redirects or renders after an action
# - verifying flashes are set
# - verifying cookies or sessions
# - verify status codes
# - verify whether changes to db has worked

# providing params and verb/controller action
# examine returned response

describe UsersController do

  context 'post#create' do

    context 'with correct input' do

      let (:correct_input) { attributes_for(:user) }

      it 'creates a new user' do
        expect{
          submit_user(correct_input)
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

      # check there's no redirect

    end

  end

  context 'User authorization' do

    let(:user) { create(:user) }
    let(:user_2) { create(:user, email: 'foo2@bar.com') }

    before do
      log_in(user)
    end

    context 'patch#update' do

      let(:updated_name) { 'bar' }

      it 'can update their own profile' do
        update_user(user, updated_name)
        user.reload
        expect(user.name).to eq(updated_name)
      end

      it 'cannot update another profile' do
        update_user(user_2, updated_name)
        expect(response).to redirect_to root_url
      end

    end

    context 'delete#destroy' do

      it 'can delete their own profile' do
        expect{
          process :destroy, params: { id: user.id }
        }.to change(User, :count).by(-1)
      end

      it 'cannot delete another profile' do
        user_2
        expect{
          process :destroy, params: { id: user_2.id }
        }.to change(User, :count).by(0)
      end

    end

  end

end
