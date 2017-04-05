###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:

def find_and_preserve(input = nil, tags = haml_buffer.options[:preserve], &block)
  return find_and_preserve(capture_haml(&block), input || tags) if block
  re = /<(#{tags.map(&Regexp.method(:escape)).join('|')})([^>]*)>(.*?)(<\/\1>)/im
  input.to_s.gsub(re) do |s|
    s =~ re # Can't rely on $1, etc. existing since Rails' SafeBuffer#gsub is incompatible
    "<#{$1}#{$2}>#{preserve($3)}</#{$1}>"
  end
end
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration
activate :sprockets

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
