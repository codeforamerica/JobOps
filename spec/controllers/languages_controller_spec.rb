require 'spec_helper'

describe LanguagesController do
  stub_user_moc_save
  login_user

  describe "#index" do
    it "should render the index template" do
      get :index
        response.should render_template("languages/index")
      end
    end

    describe "#show and #edit" do
      before do
        Factory(:language)
        @language = Language.find(:first)
      end

      it "should render the show template" do
        get :show, :id => @language
        response.should render_template("languages/show")
      end

      describe "edit action should render edit template" do
        it "should be successful" do
          get :edit, :id => @language
          response.should render_template("languages/edit")
        end
      end
  end

  describe '#create' do
    before do
      post :create, :language => FactoryGirl.attributes_for(:language)
      @language = Language.find(:first)
      @response = response
    end

    it "should create a Language" do
      Language.all.size.should == 1
    end

    it "should redirect to that language" do
      @response.should redirect_to(@language)
    end
  end

  describe '#update' do
    before do
      @language = Factory(:language)
      put :update, :id => @language.id, :language => { :language => "JavaScript" }
    end

    it "should update the language name" do
      @language.reload.language.should == "JavaScript"
    end
  end

  describe '#destroy' do
    before do
      @language = Factory(:language)
      @language_count = Language.all.size
      delete :destroy, :id => @language.id
    end

    it "should destroy a language" do
      Language.all.size.should == @language_count - 1
      expect{@language.reload}.to raise_error ActiveRecord::RecordNotFound
    end

    it "should redirect to the languages_url" do
      @langauge.should redirect_to(languages_url)
    end
  end
end
