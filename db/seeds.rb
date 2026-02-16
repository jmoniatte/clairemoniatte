Page.find_or_create_by!(slug: "home") do |p|
  p.title = "Home"
  p.body = "Welcome to Claire Moniatte's website."
end

Page.find_or_create_by!(slug: "contact") do |p|
  p.title = "Contact"
  p.body = "Get in touch."
end
