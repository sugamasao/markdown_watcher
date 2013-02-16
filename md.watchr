require 'redcarpet'
require 'fileutils'

def render_html(html_data)
<<HTML
<html>
  <head>
    <meta charset='utf-8'>
    <link href="../css/bootstrap.min.css" media="screen" rel="stylesheet" type="text/css" />
  </head>
  <body>
    <div class="container">
      #{html_data}
    </div>
  </body>
</html>
HTML
end

def render_markdown(text)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
  markdown.render(text)
end

def generate_path(target)
  html_path = target.sub('md', 'html').sub(/\.md\z/, '.html')
  html_directory = File.dirname(html_path)
  FileUtils.mkdir_p(html_directory) unless File.directory?(html_directory)

  html_path
end

def markdown2html(md_path, html_path)
  markdown_data = render_markdown(File.read(md_path))
  html_data     = render_html(markdown_data)
  File.write(html_path, html_data)
end

watch('md/(.*)\.md') do |md|
  begin
    html_path = generate_path(md[0])
    markdown2html(md[0], html_path)
    puts "[#{Time.now}] INFO generate file => #{html_path} (src:#{md[0]})"
  rescue => e
    puts "[#{Time.now}] ERROR message => #{e.message} backtrace => #{e.backtrace}"
  end
end

