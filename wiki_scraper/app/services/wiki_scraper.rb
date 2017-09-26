class WikiScraper
  include Sidekiq::Worker

  def perform(date)
    date = Date.parse(date)
    urls = get_event_urls_on(date)
    job_ids = []
    urls.each do |u|
      job_ids << ::EventScraper.perform_async(date.to_s, u)
    end
    job_ids
  end

  def get_event_urls_on(date)
    url = "https://en.wikipedia.org/wiki/Portal:Current_events/#{date.strftime("%B_%Y")}"

    page = Nokogiri::HTML(HTTP.get(url).to_s)

    date_id = date.strftime('%Y_%B_%d')
    date_div = page.css("div[id=\"#{date_id}\"]").first
    dtable = date_div.next_element

    urls = []
    dtable.css('li').each do |e|
      urls << 'https://en.wikipedia.org' + e.css('a').first['href']
    end
    urls
  end
end