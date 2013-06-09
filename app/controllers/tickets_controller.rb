class TicketsController < ApplicationController
  before_filter :require_login,     only: [:index, :edit, :update]

  def index
    @tickets = Ticket.paginate(page: params[:page]).search(params[:search])
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
      if current_admin
        @id = current_admin.id
      end

      params[:ticket][:admin_id] = @id
      if @ticket.update_attributes(params[:ticket])
        flash[:success] = 'Ticket was successfully updated.'
        redirect_to @ticket
      else
        render 'edit'
      end
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    # Check if there are records in Database and depending on results
    # create unique reference for a ticket
    # @ticket_check = Ticket.first

    # if @ticket_check.blank?
    #   @unique_reference = 'AAA-000001'
    # else
    #   @unique_reference = next_reference(Ticket.last.unique_reference)
    # end

    params[:ticket][:unique_reference] = rand(999999)

    @ticket = Ticket.new(params[:ticket])
      if @ticket.save
        # Send confirmation email
        TicketConfirmationMailer.ticket_submittion(@ticket).deliver
        redirect_to @ticket
        flash[:success] = "Ticket was successfully created!"
      else
        render 'new'
      end
  end

  def filter
    @tickets = Ticket.paginate(page: params[:page]).where("status = ?", params[:condition])
    render 'index'
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

  def require_login
    unless current_admin
      redirect_to root_path
    end
  end
end
