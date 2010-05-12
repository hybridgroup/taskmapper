require 'octopi'

module TicketMasterMod
  module Github
    class Ticket < TicketMasterMod::Ticket
      include Octopi

      def self.create(title, body)
      end

      def self.find(id)
      end

      def self.update(id, status)
      end

      def close(ticket, options = {})
        authenticated_with :login => "sirupsen", :password => "yP4K9q1DbT8" do
          repo = Octopi::Repository.find(ticket.project.owner, ticket.project.name)

          issues = repo.open_issue :title => "Sample",
            :body => "This issue is a test!"

          puts issue.number
        end
      end

      def self.delete(id, message)
      end
    end

    class Project < TicketMasterMod::Project
      def self.create(title)
      end

      def self.find(query, options = {})
        repo = Octopi::Repository.find(options[:user], query)

        TicketMaster::Project.new({
          :name => repo.name,
          :owner => repo.owner,
          # :id  => ??,
          :description => repo.description,
          # :created_at => ??,
          # :updated_at => ??,
          :url => repo.url,
          :private => repo.private,

          :system => "github",
          :authentication => options[:authentication],
        })
      end

      def self.tickets(project)
        repo = Octopi::Repository.find(project.owner, project.name)

        # @todo: Does it also return an array when there's only one
        # issue?
        issues = []
        repo.issues.each do |issue|
          issues << TicketMaster::Ticket.new({
              :name => issue.title,
              :id => issue.number,
              :status => issue.state,
              :body => issue.body,
              
              :created_at => issue.created_at,
              :updated_at => issue.updated_at,
              :closed_at => issue.closed_at,

              :votes => issue.votes,
              :creator => issue.user,

              :system => "github",
              :project => project,
          })
        end
        issues
      end

      def self.delete(id, message)
      end
    end
  end
end
