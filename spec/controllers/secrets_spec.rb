require 'rails_helper'

describe SecretsController do

  describe 'post#create' do

    let (:user) { create(:user) }

    before { log_in(user) }

    context 'with valid input' do

      it 'creates a secret'

      it 'redirects to the secret show page'

      it 'sets flash notice'

    end

    context 'with invalid input' do

      it 'does not create secret'

    end

  end

  describe 'delete#destroy' do

    let (:user) { create(:user) }
    let (:user_2) { create(:user) }

    before { log_in(user) }

    context 'users own secret' do

      it 'deletes secret'

    end

    context 'another users secret' do

      it
    end

  end

  describe 'patch#update' do

    let (:user) { create(:user) }
    let (:user_2) { create(:user) }

    before { log_in(user) }

    context 'users own secret' do

    end

    context 'another users secret' do

    end

  end



end
