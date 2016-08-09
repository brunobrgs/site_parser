class ExtractContent
  include Sidekiq::Worker

  def perform(site_id)
    site = Site.find(site_id)

    page = Mechanize.new.get(site.url)

    text = page.search('h1', 'h2', 'h3').map(&:text)
    links = page.links.map(&:href)

    site.content = (text + links).flatten.compact
    site.processed = true
    site.save!
  end
end
