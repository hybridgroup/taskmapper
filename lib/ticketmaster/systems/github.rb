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

      def self.close!(ticket, options = {})
        authenticated_with :login => options[:username], :token => options[:token] do
          repo = Octopi::Repository.find(ticket.project[:owner], ticket.project[:name])

          right_issue = nil
          repo.issues.each do |issue|
            if issue.number = ticket.id
              right_issue = issue
              break
            end
          end

          right_issue.close
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

        TicketMaster::Project.new(repo.name, {
          :owner => repo.owner,
          # :id  => ??,
          :description => repo.description,
          # :created_at => ??,
          # :updated_at => ??,
          :url => repo.url,
          :private => repo.private,

          :system => "github",
          :username => options[:username],
          :token => options[:token],
        })
      end

      def self.tickets(project)
        repo = Octopi::Repository.find(project.owner, project.name)

        # @todo: Does it also return an array when there's only one
        # issue?
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

              :system => "github",
              :project => repo,
          })
        end
        issues
      end

      def self.delete(id, message)
      end
    end
  end
end
