require 'spec_helper'

describe "Search task comments" do
  let(:tm) do
    TaskMapper.new :in_memory, :user => 'mark', :password => 'twain'
  end

  context "Given the learn_ukulele" do
    let(:learn_ukulele) { tm.project! :name => 'Leard to play ukulele' }

    context "And 'learn ukulele' have the 'buy ukulele' task" do
      let(:buy_ukulele) do
        learn_ukulele.create_task :title      =>  "Buy Ukulele",
                                  :requestor  =>  "Me", :status => :open
      end

      context "And 'buy ukulele' have the following comments" do
        before do
          buy_ukulele.create_comment  :body => 'Researching ukuleles best price',
                                      :author => 'Omar'

          buy_ukulele.create_comment  :body => 'Found a good deal in X store',
                                      :author => 'Omar'

          buy_ukulele.create_comment  :body => 'Found a cheaper one in Y store',
                                      :author => 'Omar'
        end

        context "When a retrieve all 'buy ukulele' comments" do
          let(:comments) { buy_ukulele.comments }
          
          subject { comments }

          its(:count) { should == 3 }

          describe :second do
            subject { comments[1] }
            its(:id)      { should == 2 }
            its(:body)    { should == 'Found a good deal in X store' }
            its(:author)  { should == 'Omar' }
          end
        end
      end
    end
  end
end
