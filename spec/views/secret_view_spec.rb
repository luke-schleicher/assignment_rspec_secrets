require 'rails_helper'

describe "secrets/index.html.erb" do

  let(:secret) { create(:secret) }

  let(:render_with_layout) { render template: 'secrets/index', layout: 'layouts/application' }

  before do
    @secrets = [secret]
  end

  context 'when not logged in' do

    before do
      def view.signed_in_user?
        false
      end

      def view.current_user
        nil
      end
    end

    it 'a visitor cannot see the author of the secrets' do
      render
      expect(rendered).to_not match(secret.author.name)
    end

    it 'the visitor sees a login link' do
      render_with_layout
      expect(rendered).to match("Login")
    end

  end

  context 'when logged in' do

    before do

      log_in(secret.author)

      def view.signed_in_user?
        true
      end

      @current_user = secret.author

      def view.current_user
        @current_user
      end

    end

    it 'a user can see the secret authors' do
      render
      expect(rendered).to match(secret.author.name)
    end

    it 'the user sees a logout link' do
      render_with_layout
      expect(rendered).to match("Logout")
    end

  end

end