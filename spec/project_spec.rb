require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# This can also act as an example test or test skeleton for your provider.
# Just replace the Dummy in @project_class and @ticket_class
# Also, remember to mock or stub any API calls
describe "Projects" do
  let(:tm) { TaskMapper.new(:dummy, {}) }
  let(:project_class) { TaskMapper::Provider::Dummy::Project }

  describe "with a connection to a provider" do
    describe "#projects" do
      context "without arguments" do
        let(:projects) { tm.projects }

        it "is an array" do
          expect(projects).to be_an Array
        end

        it "contains projects" do
          expect(projects.first).to be_a project_class
          expect(projects.last).to be_a project_class
        end
      end

      context "with an ID argument" do
        let(:project) { tm.projects(555) }

        it "returns the requested project" do
          expect(project).to be_a project_class
          expect(project.id).to eq 555
        end
      end

      context "with an array of IDs" do
        let(:projects) { tm.projects([555]) }

        it "returns an array of projects" do
          expect(projects).to be_an Array
        end

        it "returns the requested projects" do
          expect(projects.first).to be_a project_class
          expect(projects.first.id).to eq 555
        end
      end

      context "with a hash" do
        let(:projects) { tm.projects(:id => 555) }

        it "returns an array of projects" do
          expect(projects).to be_an Array
        end

        it "returns the requested projects" do
          expect(projects.first).to be_a project_class
          expect(projects.first.id).to eq 555
        end
      end

      describe "#first" do
        let(:project) { tm.projects.first }

        it "returns the requested project" do
          expect(project.description).to_not be_nil
          expect(project.description).to eq "Mock!-ing Bird"
        end
      end
    end

    describe "#project" do
      context "without arguments" do
        let(:project) { tm.project }
        let(:first) { project.first }
        let(:last) { project.last }

        it "returns the project class" do
          expect(project).to eq project_class
        end

        it "contains the default items" do
          expect(first.description).to eq "Mock!-ing Bird"
          expect(last.description).to eq "Mock!-ing Bird"
        end
      end

      context "with a hash" do
        let(:project) { tm.project(:name => "Whack whack what?") }

        it "returns the requested project" do
          expect(project).to be_a project_class
          expect(project.name).to eq "Whack whack what?"
        end
      end

      describe "#find" do
        let(:project) { tm.project.find(:first, :description => "Shocking Dirb") }

        it "returns the requested project" do
          expect(project).to be_a project_class
          expect(project.description).to eq "Shocking Dirb"
        end
      end

      describe "#new" do
        let(:project) { tm.project.new(default_info) }

        it "returns a new project" do
          expect(project).to be_a project_class
          expect(project.name).to eq "Tiket Name  c"
        end

        it "persists the new project" do
          expect(project.save).to be_true
        end
      end

      describe "#create" do
        let(:project) { tm.project.create(default_info) }

        it "returns a new project" do
          expect(project).to be_a project_class
          expect(project.name).to eq "Tiket Name  c"
        end
      end
    end
  end

  def default_info
    {
      :id => 777,
      :name => "Tiket Name  c",
      :description => "that c thinks the k is trying to steal it's identity"
    }
  end
end
