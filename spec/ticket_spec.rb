require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# This can also act as an example test or test skeleton for your provider.
# Just replace the Dummy in @project_class and @ticket_class
# Also, remember to mock or stub any API calls
describe "Tickets" do
  let(:tm) { TaskMapper.new(:dummy, {}) }
  let(:project_class) { TaskMapper::Provider::Dummy::Project }
  let(:ticket_class) { TaskMapper::Provider::Dummy::Ticket }
  let(:project) { tm.projects.first }

  describe "#tickets" do
    context "without arguments" do
      let(:tickets) { project.tickets }

      it "returns an array of tickets" do
        expect(tickets).to be_an Array
        expect(tickets.first).to be_a ticket_class
      end
    end

    context "with an array of IDs" do
      let(:tickets) { project.tickets([999]) }
      let(:ticket) { tickets.first }

      it "returns an array of all matching tickets" do
        expect(tickets).to be_a Array
        expect(ticket).to be_a ticket_class
        expect(ticket.id).to eq 999
      end
    end

    context "with a hash containing in ID" do
      let(:tickets) { project.tickets(:id => 999) }
      let(:ticket) { tickets.first }

      it "returns an array of all matching tickets" do
        expect(tickets).to be_a Array
        expect(ticket).to be_a ticket_class
        expect(ticket.id).to eq 999
      end
    end
  end

  describe "#ticket" do
    context "without arguments" do
      it "returns the ticket class" do
        expect(project.ticket).to eq ticket_class
      end
    end

    context "with an ID" do
      let(:ticket) { project.ticket(888) }

      it "returns the requested ticket" do
        expect(ticket).to be_a ticket_class
        expect(ticket.id).to eq 888
      end
    end

    context "with an hash containing an ID" do
      let(:ticket) { project.ticket(:id => 888) }

      it "returns the requested ticket" do
        expect(ticket).to be_a ticket_class
        expect(ticket.id).to eq 888
      end
    end
  end
end
