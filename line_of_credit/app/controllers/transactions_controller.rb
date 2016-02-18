class TransactionsController < ApplicationController
  APR_PERCENT = 35
  CREDIT_LIMIT = 5000
  def new
    @transactions = Transaction.all.order(:day_number)
    @transaction = Transaction.new
    @next_closing_day = Transaction.next_closing_day
    @principal = Transaction.principal_on_day(@next_closing_day)
    @interest = Transaction.interest_on_day(@next_closing_day, APR_PERCENT)
  end

  def create
    @transaction = Transaction.new transaction_params
    if transaction_params[:transaction_type] == 'payment'
      @transaction.change_amount = -1 * @transaction.change_amount
    end

    if @transaction.valid? and within_credit_limit?
      @transaction.save!
      flash[:notice] = "New transaction added."
    end

    redirect_to :root

  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy!
    flash[:notice] = "Transaction removed."
    redirect_to :root
  end

  private
  def within_credit_limit?
    if Transaction.all.sum(:change_amount) + @transaction.change_amount <= CREDIT_LIMIT
      true
    else
      flash[:alert] = "Can not exceed credit limit of #{CREDIT_LIMIT}!"
      false
    end
  end
  

  def transaction_params
    params.require(:transaction).permit(:day_number, :transaction_type, :change_amount)
  end
end
