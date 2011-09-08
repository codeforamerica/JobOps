require 'spec_helper'

describe TrainingsController do

  stub_user_moc_save
  login_user

  describe "#index" do
    it "should render the index template" do
      get :index
        response.should render_template("trainings/index")
      end
    end

    describe "#show and #edit" do
      before do
        Factory(:training)
        @training = Training.find(:first)
      end

      it "should render the show template" do
        get :show, :id => @training
        response.should render_template("trainings/show")
      end

      describe "edit action should render edit template" do
        it "should be successful" do
          get :edit, :id => @training
          response.should render_template("trainings/edit")
        end
      end
  end

  describe '#create' do
    before do
      post :create, :trainings => Factory.attributes_for(:training)
      @training = Training.find(:first)
      @response = response
    end

    it "should create a Certification" do
      Training.all.size.should == 1
    end

    it "should redirect to that certifications" do
      @response.should redirect_to(@training)
    end
  end

  describe '#update' do
    before do
      @training = Factory(:training)
      put :update, :id => @training.id, :training => { :training => "Ruby on Rails" }
    end

    it "should update the training name" do
      @training.reload.training.should == "Ruby on Rails"
    end
  end

  describe '#destroy' do
    before do
      @training = Factory(:training)
      @training_count = Training.all.size
      delete :destroy, :id => @training.id
    end

    it "should destroy a training" do
      Training.all.size.should == @training_count - 1
      expect{@training.reload}.to raise_error ActiveRecord::RecordNotFound
    end

    it "should redirect to the trainings_url" do
      @training.should redirect_to(trainings_url)
    end
  end
end
