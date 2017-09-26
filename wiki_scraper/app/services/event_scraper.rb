class EventScraper
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(date, url)
    detail = get_event_detail(url)
    event = Event.new
    event.img_url = detail[:img_url]
    event.page_url = url
    event.title = detail[:title]
    event.description = detail[:description]
    event.event_date = date
    event.job_id = self.jid
    event.save!
  end

  def get_event_detail(url)
    page = Nokogiri::HTML(HTTP.get(url).to_s)
    title = page.at_css('h1[id="firstHeading"]').text
    img_url = page.at_css('div[id="mw-content-text"]').at_css('img')['src']
    ary = []
    toc = page.at_css('div[id="toc"]')
    last_el = toc&.previous
    while last_el&.name == 'p' || last_el&.name == 'text'
      ary << last_el.text
      last_el = last_el.previous
    end
    ary.delete("\n")
    description = ary.reverse.join("\n")
    {title: title, img_url: img_url, description: description}
  end
end