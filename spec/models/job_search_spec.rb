require 'spec_helper'

describe JobSearch do
  before do
    @user = Factory(:user)
    @job_search = Factory(:job_search)
  end
  context 'relationships' do
    it 'belongs to user' do
      @job_search.respond_to?(:users).should be_true
    end
    it 'has many job searches user' do
      @job_search.respond_to?(:job_searches_users).should be_true
    end
  end
  
  context "search direct employers" do
    
    pending "it should start a direct employers call and save each job"
    
  end
  
  
  
end
