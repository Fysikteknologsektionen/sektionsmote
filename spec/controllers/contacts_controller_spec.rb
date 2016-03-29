require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  allow_user_to [:index, :show, :mail], Contact

  describe 'GET #index' do
    it 'succeeds and assigns contacts' do
      create(:contact, name: 'B')
      create(:contact, name: 'A')
      create(:contact, name: 'C')

      get :index

      response.should be_success
      assigns(:contacts).map(&:name).should eq(['A', 'B', 'C'])
    end
  end

  describe 'GET #show' do
    it 'succeeds' do
      contact = create(:contact)
      get :show, id: contact.to_param

      response.should be_success
      assigns(:contact).should eq(contact)
    end
  end

  describe 'POST #mail' do
    it 'valid params' do
      contact = create(:contact)
      attributes = { name: 'David',
                     email: 'david@google.com',
                     message: 'Jag vill prova kontaktformuläret' }
      post :mail, id: contact.to_param, contact_message: attributes

      assigns(:contact).should eq(contact)
      response.should redirect_to(contact_path(contact))
    end

    it 'invalid params' do
      contact = create(:contact)
      attributes = { name: 'David',
                     email: 'inte_en_epost',
                     message: 'Jag vill prova kontaktformuläret' }
      post :mail, id: contact.to_param, contact_message: attributes

      assigns(:contact).should eq(contact)
      response.status.should eq(422)
      response.should render_template(:show)
    end
  end
end
