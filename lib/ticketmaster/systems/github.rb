require 'octopi'

module TicketMaster
  module Github
    class Ticket < TicketMaster::Ticket
      def self.create(title, body)
      end

      def self.find(id)
      end

      def self.update(id, status)
      end

      def self.close(id)
        
      end

      def self.delete(id, message)
      end
    end

    class Project < TicketMaster::Project
      def self.create(title)
      end

      def self.find(query, options = {})
        repo = Octopi::Repository.find(options[:user], query)

        TicketMaster::Project.new(repo.name, {
          :owner => repo.owner,
          # :id  => ??,
          :description => repo.description,
          # :created_at => ??,
          # :updated_at => ??,
          :url => repo.url,
          :private => repo.private
        })
      end

      def self.tickets(project)
        repo = Octopi::Repository.find(project.owner, project.name)

        issues = []
        repo.issues.each do |issue|
          issues << TicketMaster::Ticket.new(issue.title, {
              :id => issue.number,
              :status => issue.state,
              :body => issue.body,
              
              :created_at => issue.created_at,
              :updated_at => issue.updated_at,
              :closed_at => issue.closed_at,

              :votes => issue.votes,
              :creator => issue.user,
          })
        end
        issues
      end

      def self.update(id, options = {})
      end

      def self.delete(id, message)
      end
    end
  end
end
