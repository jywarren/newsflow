gem "httparty"
require "httparty"

class Googlenews
  include HTTParty
  base_uri 'news.google.com'
  format :xml
  
  def self.international(num = 20)
    stories = []
    languages = ["es_ar","au","nl_be","fr_be","en_bw","pt-BR_br","ca","fr_ca","cs_cz","es_cl","es_co","es_cu","de","es","es_us","en_et","fr","en_gh","in","en_ie","en_il","it","en_ke","hu_hu","en_my","es_mx","en_na","nl_nl","nz","en_ng","no_no","de_at","en_pk","es_pe","en_ph","pl_pl","pt-PT_pt","de_ch","fr_sn","en_sg","en_za","fr_ch","sv_se","en_tz","tr_tr","uk","us","en_ug","es_ve","vi_vn","en_zw","el_gr"]
    languages.each do |lang|
      options = { :query => { :num => num, :output => 'rss', :ned => lang } }
      features = self.get('/news', options)
      items = features['rss']['channel']['item']
      items.each do |item|
        begin
          item['places'] = Placemaker.places(item['description'])
          stories << item
        rescue
          puts 'Failed to placemake... '+item['description']
        end
      end
    end
    stories
  end
  
  def self.items(num = 10)
    options = { :query => { :num => num, :output => 'rss' } }
    features = self.get('/news', options)
    items = features['rss']['channel']['item']
    items.each do |item|
      begin
        item['places'] = Placemaker.places(item['description'])
        puts "found "+item['places'].length.to_s+" places"
      rescue
        puts 'Failed to placemake... '+item['description']
      end
    end
  end
  
  def self.extract_topic(item)
    # ncl=duPfj30A5WoxBHMupoOtlciO1jY1M&amp;
    item['description'].match(/ncl=([a-zA-Z0-9]+)&amp;/)[1]
  end

  def self.topic(item,num = 10)
    options = { :query => { :num => num, :output => 'rss', :ncl => self.extract_topic(item) } }
    features = self.get('/news/more', options)
    items = features['rss']['channel']['item']
    items.each do |item|
      begin
        item['places'] = Placemaker.places(item['description'])
      rescue
        puts 'Failed to placemake... '+item['description']
      end
    end
  end

  # store in database (unused)
  # def self.story(item)
    # item['category']
    # item['title']
    # item['guid']
    # item['description']
    # item['link']
    # item['pubDate']

    # t.string :category, :default => ''
    # t.string :title, :default => ''
    # t.string :guid, :default => ''
    # t.text :description, :default => ''
    # t.string :link, :default => ''
  # end

end