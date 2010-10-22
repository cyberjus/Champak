module ViewsHelper
  
  def sort_option(sort_name, sort_id)
    selected = (sort_id.to_s == params[:sort]) ? ' list_refine_sort_option_active' : '';
    link_to sort_name, params.merge(:sort => sort_id), :class=> "list_refine_sort_option#{selected}"
  end
  
  def filter_by_category(coupons)
    unless coupons.nil?
      categories = coupons.collect{ |c| c.category.nil? ? nil : [c.category.name, c.category.id] }.compact.uniq.sort.insert(0, ['-----------', '']).insert(0, ['  Category  ', ''])
      select_tag "filter_category", options_for_select(categories)
    end
  end
  
  def filter_by_town(coupons)
    unless coupons.nil?
      towns = coupons.collect{ |c| [c.business.town, c.business.town] }.uniq.sort.insert(0, ['-----------', '']).insert(0, [' Town  ', ''])
      select_tag "filter_town", options_for_select(towns)
    end
  end
  
  def select_distance(selected)
    select_tag "select_distance", options_for_select(["5","10","15","30","50"], selected) 
  end
  
end
