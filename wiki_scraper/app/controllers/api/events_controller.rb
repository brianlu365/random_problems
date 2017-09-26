class Api::EventsController < ApplicationController
  def event_summary
    validate_date
    events = Event.on_date(params[:date])
    if events.present?
      data = events
      status = 'cached'
    else
      data = WikiScraper.new.perform(params[:date])
      status = 'working'
    end
    render json: {status: status, data: data}
  end

  def event_dates
    dates = Event.select(:event_date).distinct.pluck(:event_date)
    render json: dates
  end

  def check_jobs
    ids = params[:ids].split
    puts
    ids.each do |id|
      if Sidekiq::Status::working? id
        render json: {status: 'working'} and return
      end
    end
    data = Event.where(job_id: ids)

    render json: {status: 'cached', data: data}
  end

  private
  def validate_date
    date = Date.parse params[:date]
    if date < Date.parse('2000-01-01')
      render json: {error: 'invalid date'} and return
    end
  end
end