class CommentsController < ApplicationController
  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.create(params[:comment])
    
    if @comment.save
      if @comment.admin_id
        # TicketConfirmationMailer.ticket_updated(@ticket, @comment).deliver
        @ticket.update_attributes(status: 'Waiting for Customer', admin_id: @comment.admin_id)
      else
        @ticket.update_attributes(status: 'Waiting for Staff Response')
      end
      redirect_to ticket_path(@ticket)
    end
  end
end
