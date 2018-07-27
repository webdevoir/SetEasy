if Rails.env.production?

  PDFKit.configure do |config|
    config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
    config.default_options = {
    # print_media_type: true,
    # page_size: 'A4',

    # margin_top: '0cm',
    # margin_right: '0cm',
    # margin_left: '0cm',
    # margin_bottom: '0cm',

    footer_right: 'Page [page] of [toPage]'

  
  }
  end

end