require 'unfuddler'

module TicketMasterMod
  module Unfuddle
    class Ticket
      def self.create(ticket)
        Unfuddler.authenticate(ticket.project.authentication.to_hash)
        project = Unfuddler::Project.find(ticket.project.name)

        ticket = ticket.to_hash.select do |key, value|
          [:summary, :priority, :description].include?(key.to_sym)
        end
        ticket["priority"] = ticket["priority"].to_s

        project.ticket.create(ticket)
      end

      def self.save(ticket)
        Unfuddler.authenticate(ticket.project.authentication.to_hash)
        project = Unfuddler::Project.find(ticket.project.name)
        unfuddle_ticket = project.tickets(:number => ticket.id).first # First because it always returns an array

        # DRY this up!
        status = right_status(ticket.status)
        unfuddle_ticket.status = status if status
        unfuddle_ticket.description = ticket.description
        unfuddle_ticket.summary = ticket.summary

        unfuddle_ticket.save
      end

      def self.close(ticket, resolution)
        Unfuddler.authenticate(ticket.project.authentication.to_hash)
        project = Unfuddler::Project.find(ticket.project.name)
        ticket = project.tickets(:number => ticket.id).first # First because it always returns an array
        ticket.close!(resolution)
      end

      private
        def self.right_status(status)
          case status
          when :in_progress
            "accepted"
          when :resolved
            "resolved"
          when :reopen
            "reopen"
          else
            nil
          end
        end
    end

    class Project
      def self.find(query, options = {})
        Unfuddler.authenticate(options[:authentication].to_hash)
        projects = Unfuddler::Project.find
        formatted_projects = []

        projects.each do |project|
          formatted_projects << TicketMasterMod::Project.new({
            :name => project.short_name,
            :description => project.description,
            :system => "unfuddle",
            :authentication => options[:authentication],
            :id => project.id,
          })
        end

        formatted_projects
      end

      def self.tickets(project_instance)
        Unfuddler.authenticate(project_instance.authentication.to_hash)
        project = Unfuddler::Project.find("testproject")
        formatted_tickets = []

        unless project.tickets.empty?
          project.tickets.each do |ticket|
            formatted_tickets << TicketMasterMod::Ticket.new({
              :summary => ticket.summary,
              :id => ticket.number,
              :status => ticket.status,
              :description => ticket.description,

              :resolution => ticket.resolution,
              :resolution_description => ticket.resolution_description,

              :created_at => ticket.created_at,

              :system => "unfuddle",
              :ticket => ticket,
              :project => project_instance
            })
          end
          return formatted_tickets
        end

        []
      end
    end
  end
end
