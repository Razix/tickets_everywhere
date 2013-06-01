class TicketsController < ApplicationController

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    # Check if there are records in Database and depending on results
    # create unique reference for a ticket
    @ticket_check = Ticket.first

    if @ticket_check.blank?
      @unique_reference = 'AAA-000001'
    else
      @unique_reference = next_reference(Ticket.last.unique_reference)
    end

    params[:ticket][:unique_reference] = @unique_reference

    @ticket = Ticket.new(params[:ticket])
    respond_to do |format|
      if @ticket.save
        # Send confirmation email
        TicketConfirmationMailer.ticket_submittion(@ticket).deliver
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Makes unique reference increase starting with AAA-000001 till ZZZ-999999
  def next_reference(reference, limit = 6, seperator = '-')
    if reference[/[0-9]+\z/] == ?9 * limit
      "#{reference[/\A[a-z]+/i].next}#{seperator}#{?0 * (limit - 1)}1"
    else
      reference.next
    end
  end
end