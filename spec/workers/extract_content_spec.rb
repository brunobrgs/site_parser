require 'rails_helper'

RSpec.describe ExtractContent do
  describe '.perform' do
    let(:site) { double(:site, id: 1, url: 'http://www.google.com') }
    let(:mechanize) { double(:mechanize) }
    let(:page) { double(:page) }
    let(:result) { described_class.new.perform(site.id) }

    before do
      allow(Site).to receive(:find).with(1).and_return(site)
      allow(Mechanize).to receive(:new).and_return(mechanize)
      allow(mechanize).to receive(:get).with(site.url).and_return(page)
      allow(page).to receive(:search).with('h1', 'h2', 'h3').and_return([])
      allow(page).to receive(:links).and_return([])
      allow(site).to receive(:content=)
      allow(site).to receive(:processed=).with(true)
      allow(site).to receive(:save!)
    end

    it 'search the site' do
      result
      expect(Site).to have_received(:find).with(1)
    end

    it 'creates a new instance of Mechanize, with the site url' do
      result
      expect(Mechanize).to have_received(:new)
    end

    it 'searchs for h1, h2 and h3' do
      result
      expect(page).to have_received(:search).with('h1', 'h2', 'h3')
    end

    it 'searchs for links' do
      result
      expect(page).to have_received(:links)
    end

    context 'when find content' do
      before do
        allow(page).to receive(:search).with('h1', 'h2', 'h3').
          and_return([double(text: 'Hello World'), double(text: 'Header')])
        allow(page).to receive(:links).
          and_return([double(href: 'http://rubyonrails.org/')])
      end

      it 'add the site content' do
        result
        expect(site).to have_received(:content=).
          with(['Hello World', 'Header', 'http://rubyonrails.org/'])
      end
    end

    it 'marks as processed' do
      result
      expect(site).to have_received(:processed=).with(true)
    end

    it 'saves the site' do
      result
      expect(site).to have_received(:save!)
    end
  end
end
