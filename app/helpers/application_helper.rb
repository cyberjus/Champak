module ApplicationHelper
  
  def title
    base_title = "Champak"
    if @title.nil?
      base_title
    else
      "#{base_title} - #{@title}"
    end 
  end
  
  def menu_item(name)
    image_tag("menu_#{name}.png", { :size=>'134x53', :alt => name.humanize })
  end
  
  def select_by_category
    categories = Category.find(:all, :order => 'name').collect { |c| [c.name, c.name] }.insert(0,"")
    select_tag "select_category", options_for_select(categories)
  end
  
  def select_by_town
    towns = Business.find(:all, { :select => 'DISTINCT town', :order=> 'town' }).collect { |c| [c.town, c.town] }.insert(0,"")
    select_tag "select_town", options_for_select(towns) 
  end
  
  def url_escape(url)
    URI.escape(url.sub('%',' percent').sub('/', '%25').tr(' ', '-'))
  end
  
  def total_savings
    @total_savings ||= Savings.first()
  end

  
end
