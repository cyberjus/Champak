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
    towns = Business.find(:all, { :select => 'DISTINCT UPPER(town) as town', :order=> 'town' }).collect { |c| [c.town.titleize, c.town.titleize] }.insert(0,"")
    select_tag "select_town", options_for_select(towns) 
  end
  
  def url_escape(url)
    URI.escape(url.sub('%',' percent').sub('/', '%25').tr(' ', '-'))
  end
  
  def total_savings
    @total_savings ||= Savings.first()
  end
  
  def coupon_link(coupon)
    "/#{url_escape(coupon.business.name)}-Coupons/#{url_escape(coupon.short_description)}/#{coupon.id}/"
  end
  
  def side_hot_coupons
    sql = "SELECT coupons.*, businesses.name  FROM (SELECT coupons.* FROM coupons ORDER BY prints DESC LIMIT 10) as coupons JOIN businesses ON businesses.id = coupons.business_id WHERE coupons.valid_until >= CURRENT_DATE ORDER BY RANDOM() LIMIT 3"
    Coupon.find_by_sql(sql)
  end
  
  def base_url
    "http://#{request.host_with_port}"
  end
  
end
