require 'spec_helper'

describe JobSearchesUser do
  before do
    @user = Factory(:user)
    @job_search = Factory(:job_searches)
  end
  context 'relationships' do
    it 'belongs to user' do
      @job_search.respond_to?(:user).should be_true
    end
    it 'has many job searches user' do
      @job_search.respond_to?(:job_searches_user).should be_true
    end
  end
end
