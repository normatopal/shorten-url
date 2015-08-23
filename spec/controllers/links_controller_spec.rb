require 'rails_helper'

describe LinksController do

  describe "GET #new" do

    it "assigns a new link to @link" do
        get :new
        expect(assigns(:link)).to be_a_new(Link)
    end

    it "renders the :new template" do
        get :new
        expect(response).to render_template :new
    end

  end

  describe 'POST #create' do

    context "with valid params" do
       it "saves the new link in the database" do
           expect{ post :create, link: attributes_for(:link) }.to change(Link, :count).by(1)
       end

       it "renders the shorten template" do
         post :create, link: attributes_for(:link)
         expect(response).to render_template :shorten
         expect(assigns(:new_link)).to be_a_new(Link)
       end

       it "stores link in session" do
         post :create, link: attributes_for(:link)
         expect(session[:recently_shortenerd]).to include(assigns(:link))
       end
    end

    context "with invalid params" do
      it "does not save the new contact in the database" do
        expect{ post :create, link: attributes_for(:invalid_link) }.to change(Link, :count).by(0)
      end

      it "renders the :new template" do
        post :create, link: attributes_for(:invalid_link)
        expect(response).to render_template :new
      end
    end

  end

  describe 'GET #redirect_to_url' do

    context "with valid short url" do
        it "redirects to long url" do
          link = create(:link)
          get :redirect_to_url, short_url: link.short_url
          expect(response).to redirect_to link.long_url
        end

        it "increases clicks count" do
          link = create(:link)
          get :redirect_to_url, short_url: link.short_url
          expect(link.reload.clicks_count).to eq 1
        end
    end

  end

end