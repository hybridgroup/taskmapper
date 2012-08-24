require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# This can also act as an example test or test skeleton for your provider.
# Just replace the Dummy in @project_class and @ticket_class
# Also, remember to mock or stub any API calls
describe TaskMapper do
  let(:tm) { TaskMapper.new(:dummy, {}) }
  context "Creating a TaskMapper instance" do 
    describe :new do 
      subject { tm }
      it { should be_an_instance_of TaskMapper }
      it { should be_a_kind_of TaskMapper::Provider::Dummy }
    end

    describe :providers_operations do 
      subject { tm.providers_operations }
      it { should be_an_instance_of Hash }

      describe "Accesing one provider operations" do 
        subject { tm.providers_operations[:kanbanpad] }
        it { should be_an_instance_of Hash }

        describe "Accesing a provider projects supported operations" do 
          let(:kanbanpad_operations) { tm.providers_operations[:kanbanpad] }
          subject { kanbanpad_operations[:projects] } 
          it { should be_an_instance_of Array }
          it { should include :search }
        end
      end
    end
  end

end
