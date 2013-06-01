class TicketConfirmationMailer < ActionMailer::Base
  default from: "issuetrackingsupersystem@gmail.com"

  def ticket_submittion(ticket)
    @ticket = ticket
    @ticket_url  = "http://localhost:3000/tickets/#{@ticket.unique_reference}"
    mail(:to => "#{ticket.name} <#{ticket.email}>", 
        :subject => "Ticket #{@ticket.unique_reference} has been created!")
  end

  def ticket_updated(ticket, comment)
    @ticket = ticket
    @comment = comment
    @ticket_url  = "http://localhost:3000/tickets/#{@ticket.unique_reference}"
    mail(:to => "#{ticket.name} <#{ticket.email}>", 
        :subject => "There is new reply in your ticket #{@ticket.unique_reference}")
  end
end
